// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TemplateGenerator
// **************************************************************************

// ignore_for_file: cancel_subscriptions,constant_identifier_names,duplicate_import,non_constant_identifier_names,library_prefixes,UNUSED_IMPORT,UNUSED_SHOWN_NAME
import 'overlay_dom_render_service.dart';
export 'overlay_dom_render_service.dart';
import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart' hide Visibility;
import '../../../../css/acux/zindexer.dart';
import '../../../../utils/angular/imperative_view/imperative_view.dart';
import '../../../../utils/browser/dom_service/dom_service.dart';
import '../../../enums/visibility.dart';
import '../../../portal/portal.dart';
import '../../../ruler/dom_ruler.dart';
import '../overlay_state.dart';
import './overlay_style_config.dart';
// Required for initReflector().
import 'package:angular/src/di/reflector.dart' as _ngRef;
import '../../../../css/acux/zindexer.template.dart' as _ref0;
import '../../../../utils/angular/imperative_view/imperative_view.template.dart' as _ref1;
import '../../../../utils/browser/dom_service/dom_service.template.dart' as _ref2;
import '../../../enums/visibility.template.dart' as _ref3;
import '../../../portal/portal.template.dart' as _ref4;
import '../../../ruler/dom_ruler.template.dart' as _ref5;
import '../overlay_state.template.dart' as _ref6;
import './overlay_style_config.template.dart' as _ref7;
import 'package:angular/angular.template.dart' as _ref8;

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
  _ngRef.registerFactory(
    OverlayDomRenderService,
    (OverlayStyleConfig p0, HtmlElement p1, String p2, DomRuler p3, DomService p4, AcxImperativeViewUtils p5, bool p6, bool p7, ZIndexer p8) => new OverlayDomRenderService(p0, p1, p2, p3, p4, p5, p6, p7, p8),
  );
  _ngRef.registerDependencies(
    OverlayDomRenderService,
    const [
      const [
        OverlayStyleConfig,
      ],
      const [
        const _ngRef.Inject(const _ngRef.OpaqueToken(r'overlayContainer')),
      ],
      const [
        const _ngRef.Inject(const _ngRef.OpaqueToken(r'overlayContainerName')),
      ],
      const [
        DomRuler,
      ],
      const [
        DomService,
      ],
      const [
        AcxImperativeViewUtils,
      ],
      const [
        const _ngRef.Inject(const _ngRef.OpaqueToken(r'overlaySyncDom')),
      ],
      const [
        const _ngRef.Inject(const _ngRef.OpaqueToken(r'overlayRepositionLoop')),
      ],
      const [
        ZIndexer,
      ],
    ],
  );
}
