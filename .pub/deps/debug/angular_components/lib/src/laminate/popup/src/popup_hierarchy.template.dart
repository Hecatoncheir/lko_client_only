// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TemplateGenerator
// **************************************************************************

// ignore_for_file: cancel_subscriptions,constant_identifier_names,duplicate_import,non_constant_identifier_names,library_prefixes,UNUSED_IMPORT,UNUSED_SHOWN_NAME
import 'popup_hierarchy.dart';
export 'popup_hierarchy.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import '../../../utils/browser/events/events.dart' as events;
// Required for initReflector().
import 'package:angular/src/di/reflector.dart' as _ngRef;
import '../../../utils/browser/events/events.template.dart' as _ref0;
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
    PopupHierarchy,
    () => new PopupHierarchy(),
  );
}
