import 'package:flutter/material.dart';
import 'package:restaurantes/components/text_field_container.dart';


import '../constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final TextEditingController textController;
  const RoundedPasswordField({
    Key? key, 
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: textController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          border: InputBorder.none
        ),
      )
    );
  }
}