import 'package:app_theme_kit/app_theme_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotwatch_flutter/src/core/core.dart';
import 'package:plotwatch_flutter/src/features/features.dart';
import 'package:plotwatch_flutter/src/shared/components/gap.dart';
import 'package:plotwatch_flutter/src/shared/extensions/context_extensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FractionallySizedBox(
          widthFactor: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.count,
                style: context.textTheme.bodyLarge,
              ),
              const Gap.vertical(height: AppSpacing.sm),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Text(
                    '${state.value}',
                    style: context.textTheme.headlineLarge,
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<HomeBloc>().add(HomeEvent.increment()),
          child: const Icon(Icons.add),
        ));
  }
}
