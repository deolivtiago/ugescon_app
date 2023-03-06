import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/config.dart';
import 'data/repositories/repositories.dart';
import 'ui/home/home.dart';
import 'ui/profile/profile.dart';
import 'ui/signin/signin.dart';
import 'ui/signup/signup.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<CacheRepository>(
          create: (context) => CacheRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(
            cacheRepository: context.read<CacheRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(
              authRepository: context.read<AuthRepository>(),
              cacheRepository: context.read<CacheRepository>(),
            ),
          ),
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(
              authRepository: context.read<AuthRepository>(),
              cacheRepository: context.read<CacheRepository>(),
            ),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              cacheRepository: context.read<CacheRepository>(),
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              userRepository: context.read<UserRepository>(),
              cacheRepository: context.read<CacheRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'μGesCon',
          theme: AppTheme.light,
          initialRoute: AppRoutes.signIn,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}
