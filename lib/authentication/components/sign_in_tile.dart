import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/shared/shared.dart';

class SignInTile extends StatefulWidget{
  @override
  _SignInTileState createState() => _SignInTileState();
}

class _SignInTileState extends State<SignInTile>{
  
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();//No type here due to it breaking the validation

  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    super.initState();
    authenticationBloc = context.bloc<AuthenticationBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      cubit: authenticationBloc,
      listener: (BuildContext context, AuthenticationState state) {
        if (state is NoAuthentication) {
          if (!state.wasPreviouslyLoggedIn){//Only show the message if the user was not previouslly logged in
            Scaffold.of(context).showSnackBar(const SnackBar(
              content: Text("Failed to login", style: TextStyle(color: Colors.red)),
              duration: Duration(seconds: 5),
            ));
          }
        }

        if (state is Authenticated){
          usernameController.clear();
          passwordController.clear();
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        builder: (BuildContext context, AuthenticationState state) {
          if (state is Authenticated) {
            return Center(
              child: Column(
                children: [
                  Text("Hello ${state.user.email.value}", style: const TextStyle(fontSize: 20)),
                  Button(
                    buttonText: 'Sign Out',
                    onPressed: () {
                      authenticationBloc.add(const SignOutEvent());
                    },
                  )
                ],
              ),
            );
          }
          if (state is AuthenticationLoading) {
            return const Center(
              child: CircularProgressIndicator()
            );
          }
          return _getSignInPage();
        },
      ),
    );
  }

  Widget _getSignInPage() {
    return Form(
      key: _formKey,
      child: Column(
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
          Button(
            buttonText: 'Sign In',
            onPressed: () {
              if (_formKey.currentState.validate()){
                authenticationBloc.add(RequestAuthenticationEvent(
                  Email(usernameController.text),
                  Password(passwordController.text)
                ));
              }
            },
          )
        ],
      ),
    );
  }
}