import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/config.dart';
import 'signup_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static Route<void> route(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const SignUpPage(),
    );
  }

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
    _ecName = TextEditingController();
    _ecEmail = TextEditingController();
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
                    child: BlocListener<SignUpBloc, SignUpState>(
                      listener: (context, state) {
                        if (state is Failed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Email já cadastrado',
                              ),
                            ),
                          );
                        }

                        if (state is Loaded) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.home,
                            arguments: state.user,
                            (_) => false,
                          );
                        }
                      },
                      child: BlocBuilder<SignUpBloc, SignUpState>(
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
                                              .read<SignUpBloc>()
                                              .add(Submit(
                                                name: _ecName.text,
                                                email: _ecEmail.text,
                                                password: _ecPassword.text,
                                              )),
                                          child: const SizedBox(
                                            child: Text(
                                              'CADASTRAR',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Text(
                                    'Já tem cadastro?',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Entrar',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    onPressed: () => Navigator.of(context)
                                        .pushReplacementNamed(AppRoutes.signIn),
                                  ),
                                ],
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
