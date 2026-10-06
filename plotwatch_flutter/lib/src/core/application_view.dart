import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

// import 'theme/app_theme.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({super.key});

  @override
  State<ApplicationView> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  GoRouter? _router;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // LocalizationService.setAppLocalizations(AppLocalizations.of(context)!);

    _router = context.read<RouteManager>().router;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      FlutterNativeSplash.remove();

      final double scaleFactor = MediaQuery.of(context).textScaler.scale(1);

      // Limit the scale between 1.0 and 1.2
      final double limitedScaleFactor =
          scaleFactor < 1.0 ? 1.0 : (scaleFactor > 1.2 ? 1.2 : scaleFactor);

      return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              limitedScaleFactor,
            ),
          ),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            // The app language follows the profile (decision M1-6).
            buildWhen: (previous, current) =>
                previous.appLocale != current.appLocale,
            builder: (context, profileState) => MaterialApp.router(
            onGenerateTitle: (context) {
              // Set the localization in the service when the app starts
              LocalizationService.setAppLocalizations(
                  AppLocalizations.of(context)!);
              return AppLocalizations.of(context)!.appTitle;
            },
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: _router,
            theme: PlotwatchTheme.light(customColors),
            locale: profileState.appLocale,

            debugShowCheckedModeBanner: false,
          )));
    });

    // LocalizationWrapper(child: HomePage());
  }
}
