// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TemplateGenerator
// **************************************************************************

// ignore_for_file: cancel_subscriptions,constant_identifier_names,duplicate_import,non_constant_identifier_names,library_prefixes,UNUSED_IMPORT,UNUSED_SHOWN_NAME
import 'dom_popup_source.dart';
export 'dom_popup_source.dart';
import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:angular/angular.dart';
import '../../../components/annotations/rtl_annotation.dart';
import '../../enums/alignment.dart';
import '../../ruler/dom_ruler.dart';
import './popup_source.dart';
// Required for initReflector().
import 'package:angular/src/di/reflector.dart' as _ngRef;
import '../../../components/annotations/rtl_annotation.template.dart' as _ref0;
import '../../enums/alignment.template.dart' as _ref1;
import '../../ruler/dom_ruler.template.dart' as _ref2;
import './popup_source.template.dart' as _ref3;
import 'package:angular/angular.template.dart' as _ref4;

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
    DomPopupSourceFactory,
    (Window p0, DomRuler p1) => new DomPopupSourceFactory(p0, p1),
  );
  _ngRef.registerDependencies(
    DomPopupSourceFactory,
    const [
      const [
        Window,
      ],
      const [
        DomRuler,
      ],
    ],
  );
}
