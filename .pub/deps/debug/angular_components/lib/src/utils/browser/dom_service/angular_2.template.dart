// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TemplateGenerator
// **************************************************************************

// ignore_for_file: cancel_subscriptions,constant_identifier_names,duplicate_import,non_constant_identifier_names,library_prefixes,UNUSED_IMPORT,UNUSED_SHOWN_NAME
import 'angular_2.dart';
export 'angular_2.dart';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/experimental.dart';
import '../../angular/managed_zone/interface.dart';
import '../../disposer/disposer.dart';
import './dom_service.dart';
import './dom_service_webdriver_testability.dart';
// Required for initReflector().
import 'package:angular/src/di/reflector.dart' as _ngRef;
import '../../angular/managed_zone/interface.template.dart' as _ref0;
import '../../disposer/disposer.template.dart' as _ref1;
import './dom_service.template.dart' as _ref2;
import './dom_service.template.dart' as _ref3;
import './dom_service_webdriver_testability.template.dart' as _ref4;
import 'package:angular/angular.template.dart' as _ref5;
import 'package:angular/experimental.template.dart' as _ref6;

var _visited = false;
void initReflector() {
  if (_visited) {
    return;
  }
  _visited = true;
  _ref0.initReflector();
  _ref1.initReflector();
  _ref2.initReflector();
  _ref3.initReflector();
  _ref4.initReflector();
  _ref5.initReflector();
  _ref6.initReflector();
  _ngRef.registerFactory(
    createDomService,
    createDomService,
  );
  _ngRef.registerDependencies(
    createDomService,
    const [
      const [
        DomService,
        const _ngRef.SkipSelf(),
        const _ngRef.Optional(),
      ],
      const [
        Disposer,
        const _ngRef.Optional(),
      ],
      const [
        ManagedZone,
      ],
      const [
        Window,
      ],
    ],
  );
}
