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
        RepositoryProvider(create: (_) => ProjectRepository()),
        RepositoryProvider(create: (_) => MembershipRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              authRepository: context.read<AuthRepository>(),
            )..add(const AuthenticationEvent.started()),
          ),
          BlocProvider(
            create: (context) {
              final bloc = ProfileBloc(
                profileRepository: context.read<ProfileRepository>(),
              );
              // Signed in from a restored session: load the profile now
              // (the listener below only sees later changes).
              if (context.read<AuthenticationBloc>().state.status ==
                  AuthenticationStatus.authenticated) {
                bloc.add(const ProfileEvent.fetchMe());
              }
              return bloc;
            },
          ),
        ],
        // The profile follows the session; coordinated here so no BLoC
        // calls another (_standards/02).
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            final profileBloc = context.read<ProfileBloc>();
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                profileBloc.add(const ProfileEvent.fetchMe());
              case AuthenticationStatus.unauthenticated:
                profileBloc.add(const ProfileEvent.reset());
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: Provider<RouteManager>(
            lazy: true,
            create: (context) =>
                RouteManager(context.read<AuthenticationBloc>()),
            child: const ApplicationView(),
          ),
        ),
      ),
    );
  }
}
