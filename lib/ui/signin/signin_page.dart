import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/config.dart';
import 'signin_bloc.dart';
import 'signin_event.dart';
import 'signin_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const SignInPage(),
    );
  }

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _ecEmail;
  late TextEditingController _ecPassword;
  late bool _hidePassword;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    _ecEmail = TextEditingController();
    _ecPassword = TextEditingController();
    _hidePassword = true;
  }

  @override
  void dispose() {
    _ecEmail.dispose();
    _ecPassword.dispose();

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
                    child: SvgPicture.asset(AppAssets.signInImage),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Form(
                    key: _formKey,
                    child: BlocListener<SignInBloc, SignInState>(
                      listener: (context, state) {
                        if (state is Failed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Credenciais inválidas'),
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
                      child: BlocBuilder<SignInBloc, SignInState>(
                        builder: (context, state) {
                          return Column(
                            children: [
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
                                  keyboardType: TextInputType.visiblePassword,
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
                                  validator: (text) =>
                                      text == null || text.trim().isEmpty
                                          ? 'Campo obrigatório'
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
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<SignInBloc>()
                                                  .add(SignInSubmitEvent(
                                                    email: _ecEmail.text,
                                                    password: _ecPassword.text,
                                                  ));
                                            }
                                          },
                                          child: const Text(
                                            'ENTRAR',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Text(
                                    'Ainda não tem cadastro?',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Cadastre-se',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    onPressed: () => Navigator.of(context)
                                        .pushReplacementNamed(AppRoutes.signUp),
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
