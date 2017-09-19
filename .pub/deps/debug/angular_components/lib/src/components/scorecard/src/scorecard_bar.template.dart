// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TemplateGenerator
// **************************************************************************

// ignore_for_file: cancel_subscriptions,constant_identifier_names,duplicate_import,non_constant_identifier_names,library_prefixes,UNUSED_IMPORT,UNUSED_SHOWN_NAME
import 'scorecard_bar.dart';
export 'scorecard_bar.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import '../../../utils/browser/dom_service/angular_2.dart';
import '../../../utils/disposer/disposer.dart';
import '../../annotations/rtl_annotation.dart';
// Required for initReflector().
import 'package:angular/src/di/reflector.dart' as _ngRef;
import '../../../utils/browser/dom_service/angular_2.template.dart' as _ref0;
import '../../../utils/disposer/disposer.template.dart' as _ref1;
import '../../annotations/rtl_annotation.template.dart' as _ref2;
import 'package:angular/angular.template.dart' as _ref3;

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
  _ngRef.registerFactory(
    ScorecardBarDirective,
    (DomService p0, ElementRef p1, bool p2) => new ScorecardBarDirective(p0, p1, p2),
  );
  _ngRef.registerDependencies(
    ScorecardBarDirective,
    const [
      const [
        DomService,
      ],
      const [
        ElementRef,
      ],
      const [
        const _ngRef.Inject(const _ngRef.OpaqueToken(r'isRtl')),
        const _ngRef.Optional(),
      ],
    ],
  );
}
