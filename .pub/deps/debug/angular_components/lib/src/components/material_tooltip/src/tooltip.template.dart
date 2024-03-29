// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TemplateGenerator
// **************************************************************************

// ignore_for_file: cancel_subscriptions,constant_identifier_names,duplicate_import,non_constant_identifier_names,library_prefixes,UNUSED_IMPORT,UNUSED_SHOWN_NAME
import 'tooltip.dart';
export 'tooltip.dart';
import 'dart:html' as html;
import 'package:angular/angular.dart';
import '../../../laminate/enums/alignment.dart';
import '../../../laminate/popup/popup.dart' show DomPopupSourceFactory;
import '../../../model/action/delayed_action.dart';
import '../../../utils/browser/feature_detector/feature_detector.dart';
import '../../../utils/disposer/disposer.dart';
import '../module.dart';
import 'ink_tooltip.dart';
import 'tooltip_controller.dart';
import 'tooltip_source.dart' show tooltipShowDelay;
import 'tooltip_target.dart';
// Required for initReflector().
import 'package:angular/src/di/reflector.dart' as _ngRef;
import '../../../laminate/enums/alignment.template.dart' as _ref0;
import '../../../laminate/popup/popup.template.dart' as _ref1;
import '../../../model/action/delayed_action.template.dart' as _ref2;
import '../../../utils/browser/feature_detector/feature_detector.template.dart' as _ref3;
import '../../../utils/disposer/disposer.template.dart' as _ref4;
import '../module.template.dart' as _ref5;
import 'ink_tooltip.template.dart' as _ref6;
import 'package:angular/angular.template.dart' as _ref7;
import 'tooltip_controller.template.dart' as _ref8;
import 'tooltip_source.template.dart' as _ref9;
import 'tooltip_target.template.dart' as _ref10;

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
  _ref7.initReflector();
  _ref8.initReflector();
  _ref9.initReflector();
  _ref10.initReflector();
  _ngRef.registerFactory(
    MaterialTooltipDirective,
    (DomPopupSourceFactory p0, ViewContainerRef p1, ElementRef p2, SlowComponentLoader p3, ChangeDetectorRef p4, html.Window p5) => new MaterialTooltipDirective(p0, p1, p2, p3, p4, p5),
  );
  _ngRef.registerDependencies(
    MaterialTooltipDirective,
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
        SlowComponentLoader,
      ],
      const [
        ChangeDetectorRef,
      ],
      const [
        html.Window,
      ],
    ],
  );
}
