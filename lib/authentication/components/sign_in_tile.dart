import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';

class SignInTile extends StatefulWidget{
  @override
  _SignInTileState createState() => _SignInTileState();
}

class _SignInTileState extends State<SignInTile>{
  
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    super.initState();
    authenticationBloc = context.bloc<AuthenticationBloc>();
  }

  @override
  Widget build(BuildContext context) {
    if (authenticationBloc.state is NoAuthentication) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: usernameController,
              validator: (String value) {
                if (value.isEmpty) {
                  return "A Email must be supplied";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email'
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: passwordController,
              validator: (String value) {
                if (value.isEmpty) {
                  return "A password must be supplied";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,
            ),
          ),
          _signInButton(context)
        ],
      );
    }
    return Text("Foo");
  }

  Widget _signInButton(BuildContext context) {
    return RaisedButton.icon(
      color: Theme.of(context).primaryColor,
      icon: const Icon(Icons.arrow_forward, color: Colors.white),
      onPressed: () {
        authenticationBloc.add(RequestAuthenticationEvent(
          Username(usernameController.text),
          Password(passwordController.text)
        ));
      },
      animationDuration: const Duration(seconds: 5),
      label: const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 20))
    );
  }
}