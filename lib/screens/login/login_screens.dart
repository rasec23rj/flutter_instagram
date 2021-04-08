import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/repository/auth/auth_repository.dart';
import 'package:flutter_instagram/screens/login/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: Duration(seconds: 0),
      pageBuilder: (context, __, ___) => BlocProvider<LoginCubit>(
          create: (_) =>
              LoginCubit(authRepository: context.read<AuthRepository>()),
          child: LoginScreen()),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
          print('BlocConsumer ${state.status}');
          if (state.status == LoginStatus.error) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('context'),
              ),
            );
          }
        }, builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Flutter Instagram',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Email',
                                prefixIcon: Icon(Icons.email)),
                            onChanged: (value) =>
                                context.read<LoginCubit>().emailChanged(value),
                            validator: (value) => !value.contains('@')
                                ? 'O email é obrigatorio e deve conter @'
                                : null,
                          ),
                          const SizedBox(height: 12.0),
                          TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'Senha',
                                  prefixIcon: Icon(Icons.vpn_key)),
                              onChanged: (value) => context
                                  .read<LoginCubit>()
                                  .passwordChanged(value),
                              // ignore: missing_return
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'O senha é obrigatorio';
                                }
                                if (value.length < 6) {
                                  return 'O tamanho minimo e de 6';
                                }
                              }),
                          const SizedBox(
                            height: 28.0,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              print('save ${state.status}');
                              _submitForm(context,
                                  state.status == LoginStatus.submitting);
                            },
                            icon: Icon(Icons.save),
                            label: Text('Login'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => {},
                            icon: Icon(Icons.add_box_sharp),
                            label: Text('Criar Conta'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _submitForm(BuildContext context, isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<LoginCubit>().logInWithCredentials();
    }
  }
}
