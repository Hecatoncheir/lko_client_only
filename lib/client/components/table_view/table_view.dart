library table_view;

import 'dart:async';
import 'dart:html';
//import 'dart:convert';

/// Material design angular компоненты.
/// Из компонентов используется: material-button для номеров телефонов клиентов
/// и действия "Перенести" для переноса задачи.
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';

/// angular и core содержат основные аннотации, провайдеры и директивы Angular
import 'package:angular/angular.dart';

/// ReactiveX позволит более удобным способом подписываться и фильтровать события
/// приходящие с сервера по протоколу websocket.
import 'package:rxdart/rxdart.dart';

/// Содержит сервис для отправки и получения сообщений по протоколу websocket
import 'package:web_lko/client/services.dart';

import 'package:web_lko/client/components.dart';

/// Основные данные компонента.
/// Здесь не указывается SocketService как провайдер, в расчёте на то, что
/// компонент TableView будет включен в компонент в котором SocketService уже
/// будет сконструирован. Если указать SocketService в провайдерах этого компонента,
/// то будет создан новый SocketService который подключится к серверу но не будет
/// зарегистрирован. И сервер отправлять в него события не станет.
@Component(
    selector: 'table-view',
    templateUrl: 'table_view.html',
    styleUrls: const [
      'table_view.css'
    ],

    /// Основные директивы NgIf, NgFor включены в одном из директив materialDirectives.
    /// Если их не указывать вовсе то в разметке шаблона их использовать не удасться.
    directives: const [
      NgIf,
      NgFor,
      NgForm,
      materialDirectives,
      TasksOfTypeForDayComponent
    ],
    providers: const [
      materialProviders
    ])
class TableViewComponent implements OnInit, DoCheck {
  Observable _events;
  SocketService socket;

  /// Размер экрана устройства: small / middle
  String screenSize;

  // Свойство для отображения material-progress компонент во время получения задач
  bool showRequestInProgress = true;

  /// В этом порядке будет осуществляться рендер строк в таблице
  List<String> typesOfTasks = const ['УТРО', 'ДЕНЬ', 'ДОП', 'АВАРИЯ'];

  /// Данные для таблицы
  Map<String, dynamic> tableData = new Map();

  /// Выбранный номер задачи для которой был выбран номер телефона для звонка.
  String taskNumberForPhoneCalling;

  /// Выбранный номер телефона для звонка.
  /// Для того что бы блокировать кнопки дозвона не только на определенную дату
  /// но и для всех задачь с другими датами.
  String _clientNumberForCallingOldValue;
  String clientNumberForCalling;

  /// SocketService на момент создания этого компонента уже должен быть сконструирован.
  /// В случаи если этого сделано не будет и SocketService не будет указан как провайдер
  /// для этого компонента, то сборка приложения будет прервана с ошибкой.
  TableViewComponent(this.socket);

  /// При выборе номера телефона где-то в компоненте задач на один день
  /// нужно передать этот номер телефона в остальные дни с задачами в которых
  /// номера телефона нужно заблокировать.
  void ngDoCheck() {
    if (clientNumberForCalling != _clientNumberForCallingOldValue) {
      _clientNumberForCallingOldValue = clientNumberForCalling;
    } else {
      clientNumberForCalling = null;
    }
  }

  /// Сразу после того как компонент будет готов к отображению,
  /// необходимо получить данные для таблицы с сервера.
  void ngOnInit() {
    subscribeOnEvents(socket.data);
    fetchDataForTable();
    checkScreenWidth();
    detectingWidthOfWindow();
  }

  /// Для обеспечения реакции компонента на события, на них нужно подписать
  /// обработчики.
  void subscribeOnEvents(Stream events) {
    _events =
        new Observable(events); // Создается объект для отслеживания событий

    /// Подписка только на события получения готовых данных для таблицы
    _events
        .where((Map data) => data['Message'] == 'Data for table ready')
        .listen(renderDataInTable);
  }

  Future<Null> checkScreenWidth() async {
    if (window.innerWidth < 601) {
      screenSize = 'small';
    } else {
      screenSize = 'middle';
    }
  }

  // При смене размера экрана нужно тобразить или скрыть пустые строки в таблице
  Future<Null> detectingWidthOfWindow() async {
    window.onResize.listen((event) => checkScreenWidth());
  }

  /// Отправка события на сервер для получения данных для таблицы
  Future<Null> fetchDataForTable() async {
    socket.write("Need data for table", {'apiVersion': 'v1.0'});
  }

  /// После того как событие с данными для таблицы пришло с сервера
  /// необходимо эти данные отобразить в таблице.
  Future<Null> renderDataInTable(Map data) async {
    tableData = data['Details']['tableData'];

    /// После того как задачи были получены компонент material-progress
    /// должен быть убран.
    showRequestInProgress = false;
    checkScreenWidth();
  }
}
