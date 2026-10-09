import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The weather on site, in a progress update (UPD-01, doc/04e M5-9 b).
extension WeatherX on Weather {
  String label(AppLocalizations l10n) => switch (this) {
    Weather.sunny => l10n.weatherSunny,
    Weather.cloudy => l10n.weatherCloudy,
    Weather.rain => l10n.weatherRain,
    Weather.storm => l10n.weatherStorm,
  };

  IconData get icon => switch (this) {
    Weather.sunny => Icons.wb_sunny_outlined,
    Weather.cloudy => Icons.cloud_outlined,
    Weather.rain => Icons.water_drop_outlined,
    Weather.storm => Icons.thunderstorm_outlined,
  };
}
