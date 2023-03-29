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

  static Route route(RouteSettings settings) {
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
        body: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    user.organization.alias.isNotEmpty
                        ? user.organization.alias
                        : user.organization.name,
                  ),
                ),
              )
            ];
          },
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
              child: grid(context),
            ),
          ),
        ),
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
                onTap: () => context.read<HomeBloc>().add(HomeSignOutEvent()),
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

  GridView grid(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(2.0),
      crossAxisCount: 2,
      children: [
        Card(
          child: ListTile(
            onTap: () => Navigator.of(context)
                .pushNamed(
                  AppRoutes.organization,
                  arguments: user,
                )
                .then((organization) =>
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.home,
                      arguments: user.copyWith(
                        organization: organization as OrganizationModel?,
                      ),
                      (_) => false,
                    )),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Empresa',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text('Cadastrar ou alterar dados da empresa'),
            ),
          ),
        ),
        Card(
          child: ListTile(
            enabled: user.organization.name.isNotEmpty,
            onTap: user.organization.name.isEmpty
                ? null
                : () => Navigator.of(context).pushNamed(AppRoutes.coa),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Plano de Contas',
                style: user.organization.name.isEmpty
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black38)
                    : Theme.of(context).textTheme.titleLarge,
              ),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text('Visualizar a estrutura do plano de contas'),
            ),
          ),
        ),
        Card(
          child: ListTile(
            enabled: user.name.isNotEmpty,
            onTap: user.organization.name.isEmpty
                ? null
                : () => Navigator.of(context).pushNamed(
                      AppRoutes.operation,
                      arguments: user,
                    ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Lançamentos Contábeis',
                style: user.organization.name.isEmpty
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black38)
                    : Theme.of(context).textTheme.titleLarge,
              ),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text('Registrar um novo lançamento contábil'),
            ),
          ),
        ),
        Card(
          child: ListTile(
            enabled: user.name.isNotEmpty,
            onTap: user.organization.name.isEmpty
                ? null
                : () => Navigator.of(context).pushNamed(
                      AppRoutes.journal,
                      arguments: user.organization,
                    ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Livro Diário',
                style: user.organization.name.isEmpty
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black38)
                    : Theme.of(context).textTheme.titleLarge,
              ),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text('Listar todos os lançamentos contábeis'),
            ),
          ),
        ),
        Card(
          child: ListTile(
            enabled: user.name.isNotEmpty,
            onTap: user.organization.name.isEmpty
                ? null
                : () => Navigator.of(context).pushNamed(
                      AppRoutes.balanceSheet,
                      arguments: user.organization,
                    ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Balanço Patrimonial',
                style: user.organization.name.isEmpty
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black38)
                    : Theme.of(context).textTheme.titleLarge,
              ),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text('Visualizar o balanço patrimonial (BP)'),
            ),
          ),
        ),
        Card(
          child: ListTile(
            enabled: user.name.isNotEmpty,
            onTap: user.organization.name.isEmpty
                ? null
                : () => Navigator.of(context).pushNamed(
                      AppRoutes.incomeStatement,
                      arguments: user.organization,
                    ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Demonstração de Resultado',
                style: user.organization.name.isEmpty
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black38)
                    : Theme.of(context).textTheme.titleLarge,
              ),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                  'Visualizar a demonstração de resultado do exercício (DRE)'),
            ),
          ),
        ),
      ],
    );
  }

  Column tokenbtn(BuildContext context) {
    return Column(
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
    );
  }
}
