import 'package:flutter/material.dart';

import 'package:restaurantes/screens/login_screen.dart';
import 'package:restaurantes/screens/register_screen.dart';
import 'package:restaurantes/screens/home_screen.dart';
import 'package:restaurantes/screens/loading_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {

  'login'      : (_) => LoginScreen(),
  'register'   : (_) => RegisterScreen(),
  'home'       : (_) => HomeScreen(),
  'loading'    : (_) => LoadingScreen(),

};