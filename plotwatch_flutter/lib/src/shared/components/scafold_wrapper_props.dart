import 'package:flutter/material.dart';

class ScaffoldWrapperProps {
  final Widget? leading;
  final Widget? title;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNav;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? floatingButtonPadding;
  final Widget? buttonIcon;
  final Color? buttonColor;
  final bool? mini;
  final bool resizeToAvoidBottomInset;
  final bool showBottomNav;
  final bool showFloatingButton;
  final bool hasAppbar;
  final Color? appBarBgColor;
  final Color? bgColor;
  final double? elevation;
  final double? toolBarHeight;
  final bool? showDrawer;

  /// The notification bell, on every signed-in page (doc/05 §9 DP-6).
  final bool showBell;

  /// A muted line under the title, e.g. "New house · Owner · Active"
  /// (doc/05 §9.3).
  final String? subtitle;

  /// Turns the floating button into the design's labelled one
  /// ("+ New project").
  final String? buttonLabel;

  const ScaffoldWrapperProps({
    this.leading,
    this.title,
    this.bottom,
    this.actions,
    this.floatingActionButtonLocation,
    this.bottomNav,
    this.onPressed,
    this.floatingButtonPadding,
    this.buttonIcon,
    this.buttonColor,
    this.mini,
    this.resizeToAvoidBottomInset = false,
    this.showBottomNav = false,
    this.showFloatingButton = false,
    this.hasAppbar = true,
    this.appBarBgColor,
    this.bgColor,
    this.elevation,
    this.toolBarHeight,
    // The kit's drawer is empty in Plotwatch: on wide screens it left a blank
    // 280 px column on every page (doc/05 §9).
    this.showDrawer = false,
    this.showBell = true,
    this.subtitle,
    this.buttonLabel,
  });
}
