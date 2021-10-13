import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:restaurantes/components/already_have_account.dart';
import 'package:restaurantes/components/mostrar_alerta.dart';
import 'package:restaurantes/components/rounded_button.dart';
import 'package:restaurantes/components/rounded_input_field.dart';
import 'package:restaurantes/components/rounded_password_field.dart';
import 'package:restaurantes/screens/login_screen.dart';
import 'package:restaurantes/services/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox( height: size.height*0.03,),
                Text(
                  'REGISTRO',
                  style: TextStyle( fontWeight: FontWeight.bold),
                ),
                SizedBox( height: size.height*0.03,),
                SvgPicture.asset(
                  "assets/register.svg",
                  height: size.height*0.32,
                ),
                SizedBox( height: size.height*0.03,),
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
  final nombreCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);
    return Container(
      child: Column(
        children: [
          RoundedInputField(
            hintText: "Escribe tu Nombre", 
            textController: nombreCtrl,
          ),
          RoundedInputField(
            hintText: "Escribe tu email", 
            textController: emailCtrl,
          ),
          RoundedPasswordField(
            textController: passCtrl,
          ),
          RoundedButton(
            text: "REGISTRAR", 
            press: authService.autenticado ? null : ()async{
              
              final registroOk = await authService.register(nombreCtrl.text.trim(),emailCtrl.text.trim(), passCtrl.text.trim());

              if (registroOk == true) {
                Navigator.pushReplacementNamed(context, 'home');
              }else{
                mostrarAlerta(context, 'Registro Incorrecto', registroOk);
              }
            }
          ),
          SizedBox( height: size.height*0.03,),
          AlreadyHaveAnAccount(
            login: false,
            press: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
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