import 'package:flutter/material.dart';
import 'package:restaurantes/components/text_field_container.dart';


import '../constants.dart';
class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController textController;
  
  const RoundedInputField({
    Key? key, 
    required this.hintText, 
    this.icon = Icons.person, 
    required this.textController, 
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: textController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: this.hintText,
          border: InputBorder.none
        ),
      ),
    );
  }
}