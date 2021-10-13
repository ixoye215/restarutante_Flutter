import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:restaurantes/components/already_have_account.dart';
import 'package:restaurantes/components/mostrar_alerta.dart';
import 'package:restaurantes/components/rounded_button.dart';
import 'package:restaurantes/components/rounded_input_field.dart';
import 'package:restaurantes/components/rounded_password_field.dart';
import 'package:restaurantes/screens/register_screen.dart';
import 'package:restaurantes/services/auth_service.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height*0.05,),
                Text(
                  'LOGIN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: size.height*0.03,),
                SvgPicture.asset(
                  "assets/login_main2.svg",
                  height: size.height*0.27,
                ),
                SizedBox(height: size.height*0.03,),
                _Form(),
                
              ],
            ),
          ),
        ),
        
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key,
  }) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);
    return Container(
      child: Column(
        children: [
          RoundedInputField(
            hintText: "Escribe tu Email", 
            textController: emailCtrl,
          ),
          RoundedPasswordField(
            textController: passCtrl,
          ),
          SizedBox(height: size.height*0.03,),
          RoundedButton(
            text: "LOGIN", 
            press: authService.autenticado ? null :() async{
              FocusScope.of(context).unfocus();
              final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

              if (loginOk) {
                Navigator.pushReplacementNamed(context, 'home');
              }else{
                mostrarAlerta(context, 'Login Incorrecto', 'Revise su Credenciales');
              }
            }
          ),
          SizedBox(height: size.height*0.03,),
          AlreadyHaveAnAccount(
            press: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return RegisterScreen();
                  }
                )
              );
            },
          )
        ],
      ),
    );
  }
}