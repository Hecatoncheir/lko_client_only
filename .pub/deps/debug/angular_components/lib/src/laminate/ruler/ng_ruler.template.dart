// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TemplateGenerator
// **************************************************************************

// ignore_for_file: cancel_subscriptions,constant_identifier_names,duplicate_import,non_constant_identifier_names,library_prefixes,UNUSED_IMPORT,UNUSED_SHOWN_NAME
import 'ng_ruler.dart';
export 'ng_ruler.dart';
import 'dart:async';
import 'dart:math';
import 'package:angular/angular.dart' hide Visibility;
import '../enums/position.dart';
import '../enums/visibility.dart';
import './dom_ruler.dart';
import 'src/ruler_interface.dart';
// Required for initReflector().
import 'package:angular/src/di/reflector.dart' as _ngRef;
import '../enums/position.template.dart' as _ref0;
import '../enums/visibility.template.dart' as _ref1;
import './dom_ruler.template.dart' as _ref2;
import 'package:angular/angular.template.dart' as _ref3;
import 'src/ruler_interface.template.dart' as _ref4;

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
  _ngRef.registerFactory(
    NgRuler,
    (DomRuler p0) => new NgRuler(p0),
  );
  _ngRef.registerDependencies(
    NgRuler,
    const [
      const [
        DomRuler,
      ],
    ],
  );
}
