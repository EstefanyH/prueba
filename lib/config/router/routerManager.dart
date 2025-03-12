
import 'package:flutter/material.dart';
import 'package:prueba/data/model/position.model.dart';
import 'package:prueba/presentacion/view/homeView.dart';
import 'package:prueba/presentacion/view/restaurantView.dart';

class Routermanager {
  static const String home = '/';
  static const String restaurant = '/restaurantView';

  static Route<dynamic> onGenerationRoute(RouteSettings settings) {
 
    switch(settings.name){
      case home:
        return MaterialPageRoute(builder: (_) => const  HomeView());
      case restaurant:
        final args = settings.arguments as Map<String, dynamic>;
        final model = PositionsModel.fromJson(args);
        print('enviar');
        print(model);
        return MaterialPageRoute(builder: (_) =>  RestaurantView(model: model));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Ruta no encontrada')),
          ),
        );
        //throw Exception('No route found');
    }
   }
}