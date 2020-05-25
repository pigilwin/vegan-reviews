import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/shared/shared.dart';

class SignInTile extends StatefulWidget{
  @override
  _SignInTileState createState() => _SignInTileState();
}

class _SignInTileState extends State<SignInTile>{
  
  final TextEditingController controller = TextEditingController();

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
              controller: controller,
              validator: (String value) {
                if (value.isEmpty) {
                  return "A value must be supplied";
                }
                if (int.tryParse(value) == null) {
                  return "Only numbers can be supplied";
                }
                return null;
              },
              keyboardType: TextInputType.phone,
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
        authenticationBloc.add(RequestAuthenticationEvent(PhoneNumber(controller.text)));
      },
      animationDuration: const Duration(seconds: 5),
      label: const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 20))
    );
  }
}