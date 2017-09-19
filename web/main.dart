library web_client_lko;

import 'package:angular/angular.dart';
import 'package:web_lko/client/components/page_view/page_view_component.dart';

/// Обозначается точка входа для транформера
/// https://github.com/dart-lang/angular/wiki/Transformer#entry_points
void main() {
  // Указывается основной root компонент приложения
  bootstrap(PageViewComponent);
}
