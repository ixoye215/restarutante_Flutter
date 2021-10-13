import 'package:flutter/material.dart';

import '../constants.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  final bool login;
  final Function()? press;
  const AlreadyHaveAnAccount({
    Key? key, 
    this.login = true, 
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "No tienes una Cuenta?" : "Ya tengo una cuenta",
          style: TextStyle( color: kPrimaryColor),
        ),
        SizedBox(width: 10.0,),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Registrate" : "Incia Sesion",
            style: TextStyle( color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
