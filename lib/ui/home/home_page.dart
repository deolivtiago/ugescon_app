import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import '../../data/models/models.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  final UserModel user;

  const HomePage({
    required this.user,
    super.key,
  });

  static Route<void> route(RouteSettings settings) {
    final user = settings.arguments == null
        ? UserModel.empty()
        : settings.arguments as UserModel;

    return MaterialPageRoute(
      settings: settings,
      builder: (_) => HomePage(user: user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is Failed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }

              if (state is Loaded) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.signIn,
                  (_) => false,
                );
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(user.id),
                      Text(user.name),
                      Text(user.email),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    child: ElevatedButton(
                      child: const Text('TOKEN'),
                      onPressed: () async {
                        SharedPreferences.getInstance().then((pref) {
                          final token = pref.getString('access_token');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(token ?? 'no token')),
                          );
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(title: const Text('Home')),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Olá, ${user.name.split(' ')[0]}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    )),
              ),
              ListTile(
                title: const Text('Perfil'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(
                    AppRoutes.profile,
                    arguments: user,
                  );
                },
              ),
              ListTile(
                title: const Text('Sair'),
                onTap: () => context.read<HomeBloc>().add(SignOut()),
              ),
              ListTile(
                title: Text(
                  user.id,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
