// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TemplateGenerator
// **************************************************************************

// ignore_for_file: cancel_subscriptions,constant_identifier_names,duplicate_import,non_constant_identifier_names,library_prefixes,UNUSED_IMPORT,UNUSED_SHOWN_NAME
import 'navigation_bar.dart';
export 'navigation_bar.dart';
import 'dart:html';
import 'package:angular/angular.dart';
import '../../../utils/browser/dom_service/dom_service.dart';
// Required for initReflector().
import 'package:angular/src/di/reflector.dart' as _ngRef;
import '../../../utils/browser/dom_service/dom_service.template.dart' as _ref0;
import 'package:angular/angular.template.dart' as _ref1;

var _visited = false;
void initReflector() {
  if (_visited) {
    return;
  }
  _visited = true;
  _ref0.initReflector();
  _ref1.initReflector();
  _ngRef.registerFactory(
    NaviBarDirective,
    (HtmlElement p0, DomService p1) => new NaviBarDirective(p0, p1),
  );
  _ngRef.registerDependencies(
    NaviBarDirective,
    const [
      const [
        HtmlElement,
      ],
      const [
        DomService,
        const _ngRef.Optional(),
      ],
    ],
  );
}
