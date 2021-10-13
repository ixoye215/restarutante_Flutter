import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantes/services/auth_service.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context), 
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Center(
            child: Text('Espere....'),
          );
        },
      ),
    );
  }

  Future checkLoginState( BuildContext context) async{
    final authService = Provider.of<AuthService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if(autenticado){
      Navigator.pushReplacementNamed(context, 'home');
    }else{
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}