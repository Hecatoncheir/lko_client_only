library table_row;

import 'dart:async';
import 'dart:convert';
import 'dart:html';

/// Material design angular компоненты.
/// Из компонентов используется: material-button для номеров телефонов клиентов
/// и действия "Перенести" для переноса задачи.
import 'package:angular_components/angular_components.dart';

/// angular2 и core содержат основные аннотации, провайдеры и директивы Angular
import 'package:angular/angular.dart';

import 'package:angular_forms/angular_forms.dart';

/// ReactiveX позволит более удобным способом подписываться и фильтровать события
/// приходящие с сервера по протоколу websocket.
import 'package:rxdart/rxdart.dart';

/// Содержит сервис для отправки и получения сообщений по протоколу websocket
import 'package:web_lko/client/services.dart';

@Component(
    selector: 'tasks-of-type-for-day',
    templateUrl: 'tasks_of_type_for_day.html',
    styleUrls: const [
      'tasks_of_type_for_day.css'
    ],
    directives: const [
      NgIf,
      NgFor,
      NgClass,
      formDirectives,
      materialDirectives
    ],
    providers: const [
      materialProviders
    ])
class TasksOfTypeForDayComponent implements OnInit, OnChanges {
  // Свойство для управления отображением всплывающего окна
  bool showTaskUpdateDialog = false;

  // Свойство для управления отображением всплывающего окна
  bool showTaskCancelDialog = false;

  /// Комментарии при переносе задачи
  String taskUpdateComment;

  /// Выбранная задача для переноса/закрытия
  String selectedTask;

  // Номер выбранной задачи для звонка
  @Input()
  String taskNumberForPhoneCalling;

  final _taskNumberForPhoneCallingChange =
      new StreamController<String>.broadcast();
  @Output()
  Stream<String> get taskNumberForPhoneCallingChange =>
      _taskNumberForPhoneCallingChange.stream;

  /// Номер выбранного телефона для звонка
  @Input()
  String callingNumber;

  final _callingNumberChange = new StreamController<String>.broadcast();
  @Output()
  Stream<String> get callingNumberChange => _callingNumberChange.stream;

  Observable _events;
  SocketService socket;

  @Input()
  List<Map<String, dynamic>> tasks;

  @Input()
  String direction;

  @Input()
  String type;

  //    {
  //      'taskNumber': {
  //        'status': {
  //          'update-in-progress': bool,
  //          'cancel-in-progress': bool,
  //          'update-error': bool,
  //          'cancel-error': bool,
  //          'disabled': bool,
  //        },
  //        'phones': {
  //          'phoneNumber': {
  //          'disabled': bool,
  //          'call-start': bool,
  //          'call-error': bool,
  //          'call-in-progress': bool,
  //          }
  //        }
  //      }
  //    }
  Map<String, dynamic> classes = new Map<String, dynamic>();

  TasksOfTypeForDayComponent(this.socket);

  /// При изменениях значений в атрибуте нужно проводить проверку и менять
  /// стилевые классы елементов.
  void ngOnChanges(Map<String, SimpleChange> changes) {
    List<Map<String, dynamic>> tasksData = changes['tasks']?.currentValue;
    if (tasksData != null && classes.isEmpty) setClassesForTasks(tasksData);

    String clientNumberForCalling = changes['callingNumber']?.currentValue;
    if (taskNumberForPhoneCalling != null && clientNumberForCalling != null)
      lockButtons(
          taskNumber: taskNumberForPhoneCalling,
          phoneNumber: clientNumberForCalling);
  }

  /// При инициализации компонента нужно подписаться на события сокета
  void ngOnInit() {
    subscribeOnEvents(socket.data);
  }

  /// Формирование классов для элементов задач
  void setClassesForTasks(List<Map<String, dynamic>> tasksData) {
    for (Map<String, dynamic> task in tasksData) {
      String taskNumber = task['_tasknumber'];
      classes[taskNumber] = new Map<String, Map<String, dynamic>>();
      classes[taskNumber]['phones'] = new Map<String, Map<String, dynamic>>();

      for (Map<String, String> phone in task['_phonenumbers']) {
        String phoneNumber = phone['_phonenumber'];
        classes[taskNumber]['phones'][phoneNumber] = new Map<String, bool>();
        classes[taskNumber]['phones'][phoneNumber]['call-start'] = false;
        classes[taskNumber]['phones'][phoneNumber]['call-error'] = false;
        classes[taskNumber]['phones'][phoneNumber]['disabled'] = false;
        classes[taskNumber]['phones'][phoneNumber]['call-in-progress'] = false;
      }

      classes[taskNumber]['status'] = new Map<String, bool>();
      classes[taskNumber]['status']['update-in-progress'] = false;
      classes[taskNumber]['status']['update-error'] = false;
      classes[taskNumber]['status']['cancel-in-progress'] = false;
      classes[taskNumber]['status']['cancel-error'] = false;
      classes[taskNumber]['status']['disabled'] = false;
    }
  }

  void subscribeOnEvents(Stream events) {
    _events =
        new Observable(events); // Создается объект для отслеживания событий

    /// Подписка на события о начале разговора.
    /// Выбранный номер телефона подсвечивается.
    _events
        .where((Map data) => data['Message'] == 'Call start')
        .listen(markInProgressCallPhoneNumber);

    /// Подписка только на события сообщающих о том что звонок не может быть совершен.
    /// Возможно был указан не корректный номер.
    /// Выводится информация об этом.
    Observable callError =
        _events.where((Map data) => data['Message'] == 'Call can\'t begin');

    /// Подписка только на события сообщающих о том что звонок не может быть совершен.
    /// Заблокированные для нажатия номера телефонов должны быть разблокированы.
    callError.listen(unlockButtons);
    callError.listen(highlightAnIncorrectPhoneNumber);

    /// Подписка на события о конце разговора.
    /// Заблокированные для нажатия номера телефонов разблокировываются.
    Observable callFinish =
        _events.where((Map data) => data['Message'] == 'Call finish');

    callFinish.listen(unlockButtons);

    /// Подписка на события о получении АСУП события о том что время
    /// задачи должно быть перенесено.
    _events
        .where((Map data) => data['Message'] == 'Time of task changed')
        .listen(taskTimeUpdated);

    /// Подписка на события о получении АСУП события о том что время
    /// задачи должно быть перенесено.
    _events
        .where(
            (Map data) => data['Message'] == 'Time of task can\'t be changed')
        .listen(taskTimeNotUpdated);

    /// Подписка на события о получении АСУП события о том что
    /// задача выполнена.
    _events
        .where((Map data) => data['Message'] == 'Task canceled')
        .listen(taskCanceled);

    /// Подписка на события о получении АСУП события о том что время
    /// задачи должно быть перенесено.
    _events
        .where((Map data) => data['Message'] == 'Task can\'t be canceled')
        .listen(taskNotCanceled);
  }

  /// Все номера телефона должны быть заблокированы для того, что бы по ним
  /// нельзя было запрашивать дозвон.
  /// Вызывается при отправки запроса звонока.
  Future<Null> lockButtons({String taskNumber, String phoneNumber}) async {
    for (String taskId in classes.keys) {
      Map<String, Map<String, bool>> phones = classes[taskId]['phones'];
      for (String phone in phones.keys) {
        if (taskId == taskNumber && phone == phoneNumber) continue;
        phones[phone]['disabled'] = true;
      }
    }
  }

  /// Все номера телефона должны быть разблокированы для того, что бы по ним
  /// снова можно было запрашивать дозвон.
  /// Вызывается при окончании разговора, когда уже был заказан звонок
  /// голосовой платформы ранее.
  Future<Null> unlockButtons(Map data) async {
    callingNumber = null;
    classes.forEach((String taskId, Map<String, dynamic> details) {
      classes[taskId]['status']['disabled'] = false;

      Map<String, Map<String, bool>> phones = classes[taskId]['phones'];
      phones.forEach((String phoneNumber, Map<String, bool> phone) {
        classes[taskId]['phones'][phoneNumber]['call-in-progress'] = false;
        classes[taskId]['phones'][phoneNumber]['call-error'] = false;
        classes[taskId]['phones'][phoneNumber]['disabled'] = false;
      });
    });
  }

  /// Если до номера телефона дозвониться не удасться,
  /// его нужно выделить цветом. Уведомить пользователя.
  /// Для каждого дня недели есть таблица для каждой строки этой
  /// таблицы создан отдельный tbody с идентификатором задачи. В каждой задаче есть
  /// номера телефона которые указаны в качестве атрибута у тега кнопки номера телефона.
  /// Здесь выбирается элемент tbody определенной задачи, выбирается кнопка с номером
  /// телефона клиента в этой задаче и добавляется класс call-error который подсветит
  /// номер телефона по которому дозвониться не удалось красным цветом.
  Future<Null> highlightAnIncorrectPhoneNumber(Map data) async {
    String taskId = data['Details']['taskId'];
    String clientPhoneNumber = data['Details']['customerTelephoneNumber'];

    if (classes.containsKey(taskId) &&
        classes[taskId]['phones'].keys.contains(clientPhoneNumber)) {
      classes[taskId]['phones'][clientPhoneNumber]['call-error'] = true;
    }
  }

  /// Перед отправкой запроса голосовой платформе нужны данные пользователя
  /// (его номер телефона) которые хранятся в localStorage устройства.
  Future<dynamic> getUserData(String fieldName) async {
    /// Проверка localStorage на наличие данных пользователя
    if (!window.localStorage.containsKey('user')) return null;

    /// Если данные есть их нужно получить и раздекодить из json в Map
    Map userData = JSON.decode(window.localStorage['user']) as Map;

    /// Если что-то не так, то возможно запрашиваемое поле в данных отсутствует,
    /// вызывается ошибка.
    if (userData[fieldName] == null || userData[fieldName] == "") {
      throw new ArgumentError("Field in UserData: $fieldName is empty");
    }

    /// Возвращается значение поля структуры user из localStorage
    return userData[fieldName];
  }

  /// При нажатии на кнопку с номером телефона, создается событие которое отправляется
  /// на сервер по протоколу websocket.
  /// Параметры назначаются из разметки компонента, где вызывается этот метод.
  Future<Null> callRequest(
      Event event, String clientPhoneNumber, String taskId) async {
    /// Если кнопка уже отключена это означает что какая-то кнопка уже включена,
    /// значит звонок уже в процессе и новый запрашивать у платформы еще нельзя.
    Element callButton = event.target;
    if (callButton.parent.parent.classes.contains('disabled')) return;

    String userPhone;

    try {
      /// Получение номера телефона который был введен пользователем в форме
      /// авторизации при первом входе в приложение.
      userPhone = await getUserData('phone');
    } catch (err) {
      print(err);
    }

    _taskNumberForPhoneCallingChange.add(taskId);

    callingNumber = clientPhoneNumber;
    _callingNumberChange.add(callingNumber);

    /// Отправка события на сервер о том что нужно дозвониться до обоих
    /// номеров телефонов. В первую очередь голосовая платформа будет
    /// дозваниваться на номер указанный в поле userTelephoneNumber, затем
    /// customerTelephoneNumber.
    socket.write('Need to make a call to customer', {
      'apiVersion': 'v1.0',
      'taskId':
          taskId, // номер задачи из которой получен номер телефона клиента
      'userTelephoneNumber': userPhone,
      'customerTelephoneNumber': clientPhoneNumber
    });

    /// Сперва делаются не доступными для нажатия все кнопки с номерами телефонов.
    /// Затем помечается кнопка с номером телефона по которому был запрошен дозвон.
    classes[taskId]['phones'][clientPhoneNumber]['call-in-progress'] = true;
  }

  /// Структура которая приходит с сервера:
  /// {"Message": "", "Details": {
  ///    'apiVersion': 'v1.0',
  ///    'taskId':
  ///         taskId, // номер задачи
  ///    'userTelephoneNumber': // номер телефона пользователя,
  ///    'customerTelephoneNumber': // номер телефона клиента
  ///   }
  /// }
  ///
  /// Для каждого дня недели создана таблица для каждой строки этой
  /// таблицы создан отдельный tbody с идентификатором задачи.
  /// В каждой задаче есть номера телефона которые указаны в качестве
  /// атрибута у тега кнопки номера телефона. Выбирается tbody задачи,
  /// у tbody задачи выбирается кнопка номера телефона по атрибуту
  /// client-phone-number в котором указан номер телефона клиента для этой задачи.
  Future<Null> markInProgressCallPhoneNumber(Map data) async {
    String taskId = data['Details']['taskId'];
    String phoneNumber = data['Details']['customerTelephoneNumber'];
    if (classes.containsKey(taskId))
      classes[taskId]['phones'][phoneNumber]['call-start'] = true;
  }

  /// При нажатии на кнопку "Перенести", на сервер отправляется событие о том,
  /// что задача должна быть перенесена на другое время.
  Future<Null> updateTask(String taskId, String comment) async {
    if (classes.containsKey(taskId))
      classes[taskId]['status']['update-in-progress'] = true;

    // Отправка события на сервер
    socket.write('Task must be updated',
        {"apiVersion": "v1.0", "taskId": taskId, "comment": comment});
  }

  /// Когда время задачи перенести не удалось, нужно
  /// изменить цвет кнопки. Уведомить пользователя.
  /// К примеру сервер АСУП не нашел у себя такой задачи.
  /// Возможно за это время пока техник на неё смотрел она была удалена. И тогда lko
  /// при запросе получит в ответ не "Ок" статус. Тогда нужно найти tbody определённой
  /// задачи для которой был отправлен запрос, выбрать внутри этого элемента кнопку с
  /// классом "task-time-change-button", удалить класс который уведомляет о том что
  /// событие в процессе ("task-update-in-progress") и добавить класс
  /// "task-update-error" который подсветит кнопку красным.
  Future<Null> taskTimeNotUpdated(Map data) async {
    String taskId = data['Details']['taskId'];
    if (classes.containsKey(taskId)) {
      classes[taskId]['status']['update-in-progress'] = false;
      classes[taskId]['status']['update-error'] = true;
    }
  }

  /// Когда время задачи перенесено успешно, от сервера приходит
  /// уведомление. Нужно разблокировать кнопку переноса задачи и
  /// убрать material-progress.
  Future<Null> taskTimeUpdated(Map data) async {
    String taskId = data['Details']['taskId'];
    if (classes.containsKey(taskId))
      classes[taskId]['status']['update-in-progress'] = false;
  }

  /// При нажатии на кнопку "Выполнить", на сервер отправляется событие о том,
  /// что задача должна быть выполнена.
  Future<Null> cancelTask(String taskId) async {
    if (classes.containsKey(taskId))
      classes[taskId]['status']['cancel-in-progress'] = true;

    // Отправка события на сервер
    socket.write(
        'Task must be canceled', {"apiVersion": "v1.0", "taskId": taskId});
  }

  /// Событие о не удачном выполнении задачи
  Future<Null> taskNotCanceled(Map data) async {
    String taskId = data['Details']['taskId'];

    if (classes.containsKey(taskId)) {
      classes[taskId]['status']['cancel-in-progress'] = false;
      classes[taskId]['status']['cancel-error'] = true;
    }
  }

  /// Когда время задачи перенесено успешно, от сервера приходит
  /// уведомление. Нужно разблокировать кнопку переноса задачи и
  /// убрать material-progress.
  Future<Null> taskCanceled(Map data) async {
    String taskId = data['Details']['taskId'];
    if (classes.containsKey(taskId))
      classes[taskId]['status']['cancel-in-progress'] = false;

    Element task = querySelector('[task="$taskId"]');
    task?.remove();
  }
}
