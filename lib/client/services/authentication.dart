library authentication_service;

import 'dart:async';
import 'dart:convert';
import 'dart:html';

// Пакет для разбора данных в configuration.yaml
import 'package:yaml/yaml.dart';

// Основные директивый и аннотации Angular
import 'package:angular/angular.dart';

// Socket сервис LKO
import 'package:web_lko/client/services/socket.dart';

/// Для того что бы injector мог отыскать запрашиваемый в компонентах и сервисах провайдер,
/// этот сервис нужно пометить аннотацией @Injectable. Так же injector поздаботится об
/// указанных зависимостях этого сервиса.
/// Экземпляр SocketService должен быть уже создан, т.к. он нужен для работы этому сервису.
@Injectable()
class AuthenticationService {
  SocketService socket;

  Map configuraion;
  String apiVersion = 'v1.0'; // версия api

  // Путь по которому нужно обращаться к серверу lko за токеном
  String authPath = 'user/auth/token';

  // Конструкторо. Injector позаботится о зависимостях.
  AuthenticationService(this.socket) {
    /// При переподключении к серверу, токен на сервере был удален.
    /// Нужно удалить его с клиента и авторизовать клиент заново.
    socket.data.listen((Map data) {
      if (data['Message'] == "Client reconnected to server") {
        removeToken();
        authenticateUser();
      }
    });
  }

  /// Удаление токена, при разрыве соединения
  Future<Null> removeToken() async {
    try {
      Map authData = JSON.decode(window.localStorage['authData']);
      authData.remove('token');
      window.localStorage['authData'] = JSON.encode(authData);
    } catch (err) {
      print(err);
    }
  }

  /// Проверка полей пользователя в localStorage на наличия токена.
  /// Если токен есть, вернет существующий токен.
  /// Если токена нет вернется пустая строка.
  String getSavedToken() {
    if (window.localStorage.containsKey('authData')) {
      Map userData = JSON.decode(window.localStorage['authData']);

      if (userData.containsKey("token") &&
          userData['token'] != null &&
          (userData['token'] as String).isNotEmpty) return userData['token'];
    }
    return '';
  }

  // Функция получения данных из configuraion.yaml
  Future<Null> _setUpConfiguration() async {
    String protocol = window.location.protocol;
    String host =
        window.location.host.replaceAll(":${window.location.port}", '');
    int port = int.parse(window.location.port);

    String configFile = await HttpRequest
        .getString('$protocol//$host:$port/configuration.yaml');

    configuraion = loadYaml(configFile);
  }

  /// После проверки localStorage будет получен токен. Затем токен
  /// будет сохранен в localStorage.
  Future<String> getLKOToken({String user, String password}) async {
    if (configuraion == null) await _setUpConfiguration();

    String token;

    String protocol = configuraion['production']['http']['protocol'];
    String ip;

    if (configuraion['production']['http']['ip'] != null) {
      ip = configuraion['production']['http']['ip'];
    } else {
      ip = window.location.hostname;
    }

    String port = configuraion['production']['http']['port'].toString();

    /// Формирование IRI для отправки запроса
    String iri = "$protocol://$ip:$port/api/$apiVersion/$authPath";

    try {
      /// Кодирование данных имени пользователя и пароля сперва в байты, затем в BASE64
      List<int> authBase = UTF8.encode("$user:$password");
      String authBaseEncodedDetails = BASE64.encode(authBase);

      /// При обращении к сформированному IRI в заголовке указывается Authentication поле
      /// со значением указывающим тип базовой авторизации и с закодированными в BASE64 данными.
      HttpRequest request = await HttpRequest.request(iri,
          method: "GET",
          requestHeaders: {'Authorization': 'Basic $authBaseEncodedDetails'});

      /// В ответ приходит json с сообщешием о результате авторизации.
      /// Если авторизация не удалась возвращается пустая строка. Токен получен не был.
      Map data = JSON.decode(request.response);
      if (data['Message'] == "Authentication unsuccessful") return '';

      /// Если все прошло успешно и токен был получен его нужно сохранить в localStorage
      token = data['Details']['token'];

      String decodedUser = UTF8.decode(BASE64.decode(data['Details']['user']));

      window.localStorage['authData'] = JSON.encode({
        'user': decodedUser,
        'password': password,
        'token': data['Details']['token']
      });

      // Полученный от сервера LKO авторизационный токе возвращается как результат функции
      return token;
    } catch (error) {
      print(error);
      return '';
    }
  }

  /// Будет возвращен ADтокен полученный с сервера
  Future<String> getToken({String user, String password}) async {
    return await getLKOToken(user: user, password: password);
  }

  /// После получения токена будет отправлен запрос о регистрации клиента
  /// на socket сервере LKO.
  Future<Null> authenticateUser({String user, String password}) async {
    if (user == null || password == null) {
      if (window.localStorage.containsKey('authData')) {
        Map userData = JSON.decode(window.localStorage['authData']);
        user = userData['user'];
        password = userData['password'];
      }
    }

    String token = await getToken(user: user, password: password);
    // Отправка запроса о регистрации клиента socket серверу LKO
    socket.write(
        'Client must be registered', {'apiVersion': 'v1.0', 'token': token});
  }
}
