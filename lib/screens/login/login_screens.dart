import 'dart:ui';

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: Duration(seconds: 0),
      pageBuilder: (_, __, ___) => LoginScreen(),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
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
                            onChanged: (value) => print(value),
                            validator: (value) => !value.contains('@')
                                ? 'O email é obrigatorio'
                                : null,
                          ),
                          const SizedBox(height: 12.0),
                          TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Senha',
                                  prefixIcon: Icon(Icons.vpn_key)),
                              onChanged: (value) => print(value),
                              validator: (value) {
                                value.isEmpty ? 'O senha é obrigatorio' : null;
                                value.length < 6
                                    ? ' O tamanho minimo e de 6'
                                    : null;
                              }),
                          const SizedBox(
                            height: 28.0,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.save),
                            label: Text('Login'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
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
          ),
        ));
  }
}
