/// Компонент формы ввода имени, пароля и номера телефона пользователя.
library user_login;

import 'dart:async';
import 'dart:convert';
import 'dart:html';

/// angular и core содержат основные аннотации, провайдеры и директивы Angular
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';

/// Material design angular компоненты.
import 'package:angular_components/angular_components.dart';

/// ReactiveX позволит более удобным способом подписываться и фильтровать события
/// приходящие с сервера по протоколу websocket.
import 'package:rxdart/rxdart.dart';

// Сервисы LKO
import 'package:web_lko/client/services/socket.dart';
import 'package:web_lko/client/services/authentication.dart';

/// Сразу после ввода данных компонент с помощью сервиса AuthenticationService
/// получает AD токен и после регистрируется на socket сервере lko.
/// Данные для аутентификации пользователя сохраняются в localStorage компонентом
/// AuthenticationService.
/// В провайдерах компонента не указываются AuthenticationService и SocketService,
/// но они должны быть указаны в том компоненте в котором используется UserLoginComponent.
/// Это нужно для того что бы экземпляры AuthenticationService и SocketService
/// для всех компонентов приложения были одни и теже.
@Component(

    /// Селектор по которому в родительском компоненте UserLoginComponent
    /// определяется место для отображения разметки компонента.
    selector: 'user-login',
    // указывается путь до файла html разметки компонента
    templateUrl: 'user_login.html',
    // указываются пути до файлов css стилей компонента
    styleUrls: const ['user_login_theme.css'],
    // директивы angular material комопнентов
    directives: const [materialDirectives, formDirectives, NgIf],

    /// Провайдеры material компонентов. К примеру сервис определяющий положение
    /// всплывающего окна.
    providers: const [materialProviders])

/// Для того, что бы сразу после того как компонент и его свойства получат
/// значения и будут готовы к отображению, используется один из Lifecycle Hooks -
/// ngOnInit (https://webdev.dartlang.org/angular/guide/lifecycle-hooks).
class UserLoginComponent implements OnInit {
  // Изначально форма ввода имени, пароля и номера телефона не отображается
  bool showForm = false, showError = false;

  // Сервисы LKO
  AuthenticationService authenticationService;
  SocketService socketService;

  Router router; // Роутер приложения

  String userName,
      userPassword,
      userPhone; // Данные пользователя полученные из формы

  /// Конструктор компонента. Экземпляры сервисов AuthenticationService и SocketService
  /// уже должны быть созданы.
  UserLoginComponent(
      this.authenticationService, this.socketService, this.router);

  /// Функция вызывается после проверки имя и пароля пользователя.
  /// Функция отображает форму и предупреждение если имя и пароль
  /// пользователя оказались не верны, или закрывает форму.
  Future _checkIsUserAuthorized(bool isAuthorized) async {
    if (isAuthorized == true) {
      showForm = false;
      // Если пользователь авторизован, должна быть открыта страница с таблицей
      router.navigate(['Table']);
    } else {
      _updatePropertiesValue(); // Обновление данных имени и пароля пользователя
      showError = true; // Отображение блока с предупреждением
      showForm = true; // Отображние формы
    }
  }

  /// Функция обновляет свойства компонента и значения в разметке формы
  /// данными пользователя из localStorage.
  Future<Null> _updatePropertiesValue() async {
    if (window.localStorage['authData'] != null &&
        window.localStorage['user'] != null) {
      // Если данные в localStorage есть, их нужно отобразить в форме.
      Map authData =
          JSON.decode(window.localStorage['authData']) as Map; // Имя и пароль
      Map userData =
          JSON.decode(window.localStorage['user']) as Map; // Номер телефона

      // Если структура с именем и паролем пользователя не пустая, то данные нужно использовать.
      if (authData.isNotEmpty) {
        userName = authData['user'];
        userPassword = authData['password'];
        userPhone = userData['phone'];
      }
    }
  }

  /// Перед тем как отображать окно формы ввода имени, пароля и номера телефона
  /// нужно проверить данные в localStorage. Если они там есть, то получить AD токен.
  /// И только в случае не успеха отобразить форму.
  Future ngOnInit() async {
    // Подписка на события с сервера
    Observable socketEvens = new Observable(socketService.data);

    // Событие успешной регистрации клиента
    socketEvens
        // Отбираются только те события где в подписи указано "Client registered"
        .where((Map data) => data['Message'] == "Client registered")
        // Подписка на отобранные события
        .listen((Map data) {
      _checkIsUserAuthorized(true);
    });

    // Событие сообщающее о том что клиент не был зарегистрирован
    socketEvens
        .where((Map data) => data['Message'] == "Client can\'t be registered")
        .listen((Map data) {
      _checkIsUserAuthorized(false);
    });

    bool isNameAndPasswordAvailable = false;

    /// Если имя и пароль пользователя есть в localStorage их можно использовать
    /// для отправки запроса для получения токена.
    if (window.localStorage['authData'] != null) {
      Map authData = JSON.decode(window.localStorage['authData']) as Map;

      if (authData['user'] != '' && authData['password'] != '')
        isNameAndPasswordAvailable = true;
    }

    // Отправка запроса получения токена
    if (isNameAndPasswordAvailable == true) {
      await _updatePropertiesValue();
      await authenticationService.authenticateUser(
          user: userName, password: userPassword);
    } else {
      // Данный имени и пароля в localStorage нет, нужно отобразить форму.
      await _updatePropertiesValue();
      showForm = true;
    }
  }

  Future<Null> authenticate() async {
    // Если кнопку получилось нажать, значит все данные заполнены
    showError = false;
    showForm = false;

    /// Но всегда будет не лишним проверить номер телефона
    /// (в будущем может понадобиться метод проверяющий формат номера).
    if (userPhone == null || userPhone.isEmpty) {
      // Если номер телефона не корректен, нужно отобразить форму
      _checkIsUserAuthorized(false);
      return;
    }

    // Номер телефона помещяется в localStorage
    window.localStorage['user'] =
        JSON.encode({'name': userName, 'phone': userPhone});
    // Получение AD токена, и в случае не верных данных форма будет отображена снова.
    authenticationService.authenticateUser(
        user: userName, password: userPassword);
  }
}
