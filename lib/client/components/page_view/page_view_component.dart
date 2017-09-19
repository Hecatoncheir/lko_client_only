library page_view_component;

/// В angular.dart экспортируются основные библиотеки Angular.
/// Становится доступным использоваение таких аннотаций как: @Component, @Directive
import 'package:angular/angular.dart';

/// Нужны директивы RouterOutlet и RouterLink. Первый позволяет в разметке
/// компонента отображать только тот компонент который указан для определённого
/// IRI. Второй может быть полезен для определения пути который указан в браузере.
/// Становится доступной аннотация @RouterConfig.
import 'package:angular_router/angular_router.dart';

// Сервис для приема и передачи сообщений по websocket протоколу
import 'package:web_lko/client/services/socket.dart';
// Сервис для получения AD токена, и регистрации сокета на сервере
import 'package:web_lko/client/services/authentication.dart';

/// Компонент формы ввода имени пользователя, пароля и номера телефона
/// на который будет дозваниваться VP в первую очередь.
import 'package:web_lko/client/components/user_login/user_login.dart';

/// Компонент отображения таблицы с данными о номерах телефонах и адресами клиентов
import 'package:web_lko/client/components/table_view/table_view.dart';

/// В аннотации @Component описываются основные параметры компонента
@Component(
    // Тег по которому будет определён компонент в разметке (<page-view></page-view>)
    selector: 'page-view',
    // Путь до файла разметки компонента
    templateUrl: 'page_view_component.html',

    /// Директивы которые задействованы компонентом.
    /// Комопненты и есть директивы только с html разметкой.
    /// Здесь указаны директивы роутера, т.к. в разметке компонента используется
    /// RouterOutlet для отображения нужного компонента для открытого браузером IRI.
    /// И директивы компонентов UserLoginComponent, TableViewComponent.
    directives: const [
      ROUTER_DIRECTIVES,
      UserLoginComponent,
      TableViewComponent
    ],

    /// Провайдеры которые не учавствуют в работе с разметкой напрямую.
    /// Но их используют компоненты и директивы для своей работы.
    /// Здесь указан провайдер AuthenticationService, но самим компонентом PageView
    /// им не используется. Его использует компонент UserLoginComponent,
    /// который PageView как раз задействован. Указав AuthenticationService здесь, он будет
    /// создан один раз. И при создании компонента UserLoginComponent указывать
    /// AuthenticationService уже будет не нужно. UserLoginComponent получит тот
    /// же объект AuthenticationService который будет доступен всем компонентам
    /// задействованными в компоненте PageView.
    providers: const [
      ROUTER_PROVIDERS,
      SocketService,
      AuthenticationService,

      /// LocationStrategy это провайдер содержащий в себе логику работы с
      /// адресной строкой браузера и стрелками перемещения по страницам вперед назад.
      /// HashLocationStrategy содержит методы для работы с IRI
      /// начинающимся с "#": localhost:8008/#auth, localhost:8008/#table.
      /// Такие iri обрабатываются приложением позволяя не отправлять запросов
      /// на сервер в отличии от: localhost:8008/auth, localhost:8008/table - эти
      /// запросы будут обработаны сервером и если таких страниц не будет
      /// найдено сервер вернет 404 ошибку и приложение не запустится.
      const Provider(LocationStrategy, useClass: HashLocationStrategy)
    ])

/// Конфигурация роутера. Здесь задаются основные данные о путях IRI и компонентах
/// которые будут отображены в разметке при переходе по этим путям.
@RouteConfig(const [
  const Route(

      /// Когда в строке браузера будет открыт путь: localhost:8008/#/auth
      /// внутри тегов <router-outlet></router-outlet> будет отображена
      /// разметка UserLoginComponent компонента.
      path: '/auth',
      name: 'Auth',
      useAsDefault: true,
      component: UserLoginComponent),
  const Route(path: '/table', name: 'Table', component: TableViewComponent)
])

/// Класс компонента реализует интерфейс OnInit. Для того что бы вызывать метод
/// ngOnInit сразу после того как все значия компонента будут проинициализированы
/// (Lifecycle Hooks).
class PageViewComponent implements OnInit {
  SocketService socketService;
  Router router;

  /// Механизм зависимостей сам разберется какие экземпляры объектов требуются
  /// в конструкторе, их достаточно только указать.
  PageViewComponent(this.socketService, this.router);

  /// userAsDefault в настройках роутера будет отображать разметку
  /// UserLoginComponent только в случае если не будет задан другой
  /// существующий адрес. Например: #/table - определён. Если будет указан этот
  /// путь то пользователь не увидит формы авторизации. Ему отобразится
  /// разметка TableViewComponent.
  /// Необходимо принудительно открывать форму авторизации по какому бы пути не было
  /// открыто приложение.
  ngOnInit() {
    router.navigate(['Auth']);
  }
}
