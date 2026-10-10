import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

enum DrawerMode {
  overlay, // mobile / tablet
  fixed, // desktop
}

class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper({
    super.key,
    this.actions,
    this.leading,
    this.title,
    this.floatingActionButtonLocation,
    this.bottomNav,
    this.onPressed,
    this.floatingButtonpadding,
    this.buttonIcon,
    this.buttonColor,
    this.mini,
    required this.body,
    required this.showBottomNav,
    required this.showFloatingButton,
    required this.hasAppbar,
    this.bgColor,
    this.appBarBgColor,
    this.bottom,
    this.resizeToAvoidBottomInset = false,
    this.elevation,
    this.toolBarHeight,
    this.showDrawer = true,
    this.showBell = true,
    this.subtitle,
    this.buttonLabel,
    this.drawerMode = DrawerMode.overlay,
    this.fixedDrawerWidth = 280,
  });

  final Widget? body;

  /// doc/05 §9 DP-6.
  final bool showBell;
  final String? subtitle;
  final String? buttonLabel;
  final Widget? leading;
  final Widget? title;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final bool showBottomNav;
  final bool hasAppbar;
  final bool showFloatingButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNav;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? floatingButtonpadding;
  final Widget? buttonIcon;
  final Color? buttonColor;
  final bool? mini;
  final bool? resizeToAvoidBottomInset;
  final Color? bgColor;
  final Color? appBarBgColor;
  final double? elevation;
  final double? toolBarHeight;
  final bool? showDrawer;
  final DrawerMode drawerMode;
  final double fixedDrawerWidth;

  /// Signed in, with the app-wide notifications: some widget tests pump a
  /// page without them.
  static bool _signedIn(BuildContext context) {
    try {
      context.read<NotificationsBloc>();
      return context.read<AuthenticationBloc>().state.status ==
          AuthenticationStatus.authenticated;
    } on ProviderNotFoundException {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    log('scalfold wrapper $showDrawer');
    final scaffoldBody = SafeArea(top: false, child: body!);
    // The design's labelled button (doc/05 §9.3).
    final label = buttonLabel;
    final labelledFab = label == null
        ? null
        : FloatingActionButton.extended(
            onPressed: onPressed,
            backgroundColor: buttonColor ?? customColors.primary,
            foregroundColor: customColors.onPrimary,
            elevation: 4,
            highlightElevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PlotwatchTheme.cardRadius),
            ),
            icon: buttonIcon ?? const Icon(Icons.add_rounded),
            label: Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: customColors.onPrimary,
                fontSize: 15,
              ),
            ),
          );
    final buildFab = Padding(
      padding: floatingButtonpadding ?? const EdgeInsets.only(top: 65.0),
      child: FloatingActionButton(
        mini: mini ?? true,
        backgroundColor:
            buttonColor ?? customColors.secondary.withValues(alpha: .7),
        shape: CircleBorder(
          side: BorderSide(color: buttonColor ?? customColors.secondary),
        ),
        onPressed: onPressed,
        child:
            buttonIcon ??
            Icon(Icons.add, size: 30, color: customColors.background),
      ),
    );
    return Scaffold(
      backgroundColor: bgColor ?? customColors.ground,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: hasAppbar
          ? AppBar(
              shadowColor: Colors.transparent,
              elevation: elevation,
              centerTitle: false,
              automaticallyImplyLeading: false,
              leadingWidth: 56,
              bottom: bottom,

              leading: leading,

              actions: [
                if (showBell && _signedIn(context)) const NotificationBell(),
                ...?actions,
                const SizedBox(width: 8),
              ],
              toolbarHeight: toolBarHeight ?? 64,
              backgroundColor: appBarBgColor,
              // The title with its muted line under it (doc/05 §9.3).
              title: subtitle == null
                  ? title
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ?title,
                        Text(
                          subtitle!,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
              titleSpacing: leading == null ? 20 : 4,
              // title of appbar
            )
          : null,
      body: scaffoldBody,
      floatingActionButton: showFloatingButton
          ? (labelledFab ?? buildFab)
          : null,
      drawer: drawerMode == DrawerMode.overlay && showDrawer == true
          ? AppDrawer(parentContext: context)
          : null,
    );
  }
}
