import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurantes/constants.dart';
import 'package:restaurantes/routes/routes.dart';
import 'package:restaurantes/services/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurantes',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white
        ),
        initialRoute: 'login',
        routes: appRoutes,
      ),
    );
  }
}