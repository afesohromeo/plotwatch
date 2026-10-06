import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';


/// App-wide repositories, the session BLoC, and the router built on it.
class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => ProfileRepository()),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authRepository: context.read<AuthRepository>(),
        )..add(const AuthenticationEvent.started()),
        child: Provider<RouteManager>(
          lazy: true,
          create: (context) =>
              RouteManager(context.read<AuthenticationBloc>()),
          child: const ApplicationView(),
        ),
      ),
    );
  }
}
