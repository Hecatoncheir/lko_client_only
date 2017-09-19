// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TemplateGenerator
// **************************************************************************

// ignore_for_file: cancel_subscriptions,constant_identifier_names,duplicate_import,non_constant_identifier_names,library_prefixes,UNUSED_IMPORT,UNUSED_SHOWN_NAME
import 'tooltip_target.dart';
export 'tooltip_target.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import '../../../laminate/popup/popup.dart';
import '../../../model/action/delayed_action.dart';
import '../../../utils/angular/reference/reference.dart';
import '../../../utils/browser/events/events.dart';
import './tooltip_controller.dart';
import 'tooltip_source.dart' show tooltipShowDelay;
// Required for initReflector().
import 'package:angular/src/di/reflector.dart' as _ngRef;
import '../../../laminate/popup/popup.template.dart' as _ref0;
import '../../../model/action/delayed_action.template.dart' as _ref1;
import '../../../utils/angular/reference/reference.template.dart' as _ref2;
import '../../../utils/browser/events/events.template.dart' as _ref3;
import './tooltip_controller.template.dart' as _ref4;
import 'package:angular/angular.template.dart' as _ref5;
import 'tooltip_source.template.dart' as _ref6;

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
    MaterialTooltipTargetDirective,
    (DomPopupSourceFactory p0, ViewContainerRef p1, ElementRef p2, ChangeDetectorRef p3) => new MaterialTooltipTargetDirective(p0, p1, p2, p3),
  );
  _ngRef.registerDependencies(
    MaterialTooltipTargetDirective,
    const [
      const [
        DomPopupSourceFactory,
      ],
      const [
        ViewContainerRef,
      ],
      const [
        ElementRef,
      ],
      const [
        ChangeDetectorRef,
      ],
    ],
  );

  _ngRef.registerFactory(
    ClickableTooltipTargetDirective,
    (DomPopupSourceFactory p0, ViewContainerRef p1, ElementRef p2, ChangeDetectorRef p3) => new ClickableTooltipTargetDirective(p0, p1, p2, p3),
  );
  _ngRef.registerDependencies(
    ClickableTooltipTargetDirective,
    const [
      const [
        DomPopupSourceFactory,
      ],
      const [
        ViewContainerRef,
      ],
      const [
        ElementRef,
      ],
      const [
        ChangeDetectorRef,
      ],
    ],
  );
}
