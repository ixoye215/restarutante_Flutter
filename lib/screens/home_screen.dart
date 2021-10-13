
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantes/components/rounded_button.dart';
import 'package:restaurantes/constants.dart';
import 'package:restaurantes/services/auth_service.dart';

// import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${usuario.nombre}",
          style: TextStyle(
            color: kPrimaryLightColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed:(){
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          }, 
          icon: Icon(Icons.exit_to_app, color: kPrimaryLightColor,)
        ),

      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox( height: size.height*0.03,),
            RoundedButton(
              text: "BUSCAR RESTAURANTES", 
              press: () async{
                // Position position = await _determinePosition();
                // print(position.latitude);
              }
            ),
          ],
        ),
      )
    );
  }


  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     await Geolocator.openLocationSettings();
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
        
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
    
  //   if (permission == LocationPermission.deniedForever) {
      
  //     return Future.error(
  //       'Location permissions are permanently denied, we cannot request permissions.');
  //   } 
  //   return await Geolocator.getCurrentPosition();
  // }
}