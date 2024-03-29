// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TemplateGenerator
// **************************************************************************

// ignore_for_file: cancel_subscriptions,constant_identifier_names,duplicate_import,non_constant_identifier_names,library_prefixes,UNUSED_IMPORT,UNUSED_SHOWN_NAME
import 'module.dart';
export 'module.dart';
import 'dart:html';
import 'package:angular/angular.dart';
import '../../css/acux/zindexer.dart';
import '../../utils/angular/imperative_view/imperative_view.dart';
import '../../utils/angular/managed_zone/angular_2.dart';
import '../../utils/browser/dom_service/angular_2.dart';
import '../../utils/browser/window/module.dart';
import '../ruler/dom_ruler.dart';
import 'src/overlay_service.dart';
import 'src/render/overlay_dom_render_service.dart';
import 'src/render/overlay_style_config.dart';
// Required for initReflector().
import 'package:angular/src/di/reflector.dart' as _ngRef;
import '../../css/acux/zindexer.template.dart' as _ref0;
import '../../utils/angular/imperative_view/imperative_view.template.dart' as _ref1;
import '../../utils/angular/managed_zone/angular_2.template.dart' as _ref2;
import '../../utils/browser/dom_service/angular_2.template.dart' as _ref3;
import '../../utils/browser/window/module.template.dart' as _ref4;
import '../ruler/dom_ruler.template.dart' as _ref5;
import 'package:angular/angular.template.dart' as _ref6;
import 'src/overlay_service.template.dart' as _ref7;
import 'src/render/overlay_dom_render_service.template.dart' as _ref8;
import 'src/render/overlay_dom_render_service.template.dart' as _ref9;
import 'src/render/overlay_style_config.template.dart' as _ref10;

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
    getDefaultContainer,
    getDefaultContainer,
  );
  _ngRef.registerDependencies(
    getDefaultContainer,
    const [
      const [
        const _ngRef.Inject(const _ngRef.OpaqueToken(r'overlayContainerName')),
      ],
      const [
        const _ngRef.Inject(const _ngRef.OpaqueToken(r'overlayContainerParent')),
      ],
      const [
        const _ngRef.Inject(const _ngRef.OpaqueToken(r'overlayContainer')),
        const _ngRef.SkipSelf(),
        const _ngRef.Optional(),
      ],
    ],
  );

  _ngRef.registerFactory(
    getDefaultContainerName,
    getDefaultContainerName,
  );
  _ngRef.registerDependencies(
    getDefaultContainerName,
    const [
      const [
        const _ngRef.Inject(const _ngRef.OpaqueToken(r'overlayContainerName')),
        const _ngRef.SkipSelf(),
        const _ngRef.Optional(),
      ],
    ],
  );

  _ngRef.registerFactory(
    getDebugContainer,
    getDebugContainer,
  );
  _ngRef.registerDependencies(
    getDebugContainer,
    const [
      const [
        const _ngRef.Inject(const _ngRef.OpaqueToken(r'overlayContainerName')),
      ],
      const [
        const _ngRef.Inject(const _ngRef.OpaqueToken(r'overlayContainerParent')),
      ],
    ],
  );

  _ngRef.registerFactory(
    getOverlayContainerParent,
    getOverlayContainerParent,
  );
  _ngRef.registerDependencies(
    getOverlayContainerParent,
    const [
      const [
        Document,
      ],
      const [
        const _ngRef.Inject(const _ngRef.OpaqueToken(r'overlayContainerParent')),
        const _ngRef.SkipSelf(),
        const _ngRef.Optional(),
      ],
    ],
  );
}
