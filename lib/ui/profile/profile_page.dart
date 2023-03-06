import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/config.dart';
import '../../data/models/models.dart';
import 'profile_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfilePage extends StatefulWidget {
  final UserModel user;

  const ProfilePage({
    required this.user,
    super.key,
  });

  static Route<void> route(RouteSettings settings) {
    final user = settings.arguments == null
        ? UserModel.empty()
        : settings.arguments as UserModel;

    return MaterialPageRoute(
      settings: settings,
      builder: (_) => ProfilePage(user: user),
    );
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _ecName;
  late TextEditingController _ecEmail;
  late TextEditingController _ecPassword;
  late TextEditingController _ecPasswordConfirmation;
  late bool _hidePassword;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    _ecName = TextEditingController(text: widget.user.name);
    _ecEmail = TextEditingController(text: widget.user.email);
    _ecPassword = TextEditingController();
    _ecPasswordConfirmation = TextEditingController();
    _hidePassword = true;
  }

  @override
  void dispose() {
    _ecName.dispose();
    _ecEmail.dispose();
    _ecPassword.dispose();
    _ecPasswordConfirmation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Alerta de Exclusão'),
                    content: Text(
                        'Todas as informações do usuário `${widget.user.name}` serão excluídas permanentemente. Deseja continuar?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Não'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Sim'),
                      ),
                    ],
                  ),
                ).then((isConfirmed) {
                  if (isConfirmed ?? false) {
                    context.read<ProfileBloc>().add(Delete(user: widget.user));
                  }
                });
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    height: 128,
                    width: 128,
                    child: SvgPicture.asset(AppAssets.signUpImage),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Form(
                    key: _formKey,
                    child: BlocListener<ProfileBloc, ProfileState>(
                      listener: (context, state) {
                        if (state is Failed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Erro ao alterar usuário'),
                            ),
                          );
                        }

                        if (state is Loaded) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.home,
                            arguments: state.user,
                            (route) => false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: ListTile(
                                leading: Icon(
                                  Icons.check_box_rounded,
                                  color: Colors.green,
                                ),
                                title: Text(
                                  'Usuário alterado com sucesso',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }

                        if (state is Deleted) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.signIn,
                            (_) => false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: ListTile(
                                leading: Icon(
                                  Icons.check_box_rounded,
                                  color: Colors.green,
                                ),
                                title: Text(
                                  'Usuário excluído com sucesso',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  readOnly: state is Loading ? true : false,
                                  controller: _ecName,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    labelText: 'Nome',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (text) {
                                    if (text == null || text.trim().isEmpty) {
                                      return 'Campo obrigatório';
                                    }

                                    if (text.trim().length < 2) {
                                      return 'O nome deve conter ao menos 2 caracteres';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  readOnly: state is Loading ? true : false,
                                  controller: _ecEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    labelText: 'Email',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (text) {
                                    if (text == null || text.trim().isEmpty) {
                                      return 'Campo obrigatório';
                                    }

                                    if (!RegExp(r'.+@.+')
                                        .hasMatch(text.trim())) {
                                      return 'Email inválido';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  readOnly: state is Loading ? true : false,
                                  controller: _ecPassword,
                                  obscureText: _hidePassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      onPressed: () => setState(() {
                                        _hidePassword = !_hidePassword;
                                      }),
                                      icon: _hidePassword
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                    labelText: 'Senha',
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: (text) {
                                    if (text == null || text.trim().isEmpty) {
                                      return 'Campo obrigatório';
                                    }

                                    if (text.trim().length < 6) {
                                      return 'A senha deve conter ao menos 6 caracteres';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  readOnly: state is Loading ? true : false,
                                  controller: _ecPasswordConfirmation,
                                  obscureText: _hidePassword,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      onPressed: () => setState(() {
                                        _hidePassword = !_hidePassword;
                                      }),
                                      icon: _hidePassword
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                    labelText: 'Confirmação de Senha',
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: (text) => text != _ecPassword.text
                                      ? 'As senhas devem ser iguais'
                                      : null,
                                ),
                              ),
                              state is Loading
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 56,
                                        child: const ElevatedButton(
                                          onPressed: null,
                                          child: SizedBox(
                                            height: 28,
                                            width: 28,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 56,
                                        child: ElevatedButton(
                                          onPressed: () => context
                                              .read<ProfileBloc>()
                                              .add(
                                                Submit(
                                                  user: widget.user,
                                                  name: _ecName.text,
                                                  email: _ecEmail.text,
                                                  password: _ecPassword.text,
                                                ),
                                              ),
                                          child: const SizedBox(
                                            child: Text(
                                              'ALTERAR',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
