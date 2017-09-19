// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TemplateGenerator
// **************************************************************************

// ignore_for_file: cancel_subscriptions,constant_identifier_names,duplicate_import,non_constant_identifier_names,library_prefixes,UNUSED_IMPORT,UNUSED_SHOWN_NAME
import 'popup_source_directive.dart';
export 'popup_source_directive.dart';
import 'dart:async';
import 'dart:math';
import 'package:angular/angular.dart';
import '../../../utils/angular/reference/reference.dart';
import '../../enums/alignment.dart';
import './dom_popup_source.dart';
import './popup_source.dart';
// Required for initReflector().
import 'package:angular/src/di/reflector.dart' as _ngRef;
import '../../../utils/angular/reference/reference.template.dart' as _ref0;
import '../../enums/alignment.template.dart' as _ref1;
import './dom_popup_source.template.dart' as _ref2;
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
    PopupSourceDirective,
    (DomPopupSourceFactory p0, ElementRef p1, ReferenceDirective p2) => new PopupSourceDirective(p0, p1, p2),
  );
  _ngRef.registerDependencies(
    PopupSourceDirective,
    const [
      const [
        DomPopupSourceFactory,
      ],
      const [
        ElementRef,
      ],
      const [
        ReferenceDirective,
        const _ngRef.Optional(),
      ],
    ],
  );
}
