
import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

class AdaptiveWhiteProgressIndicator extends StatelessWidget {
  const AdaptiveWhiteProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: customColors.background),
      ),
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
