import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba/config/router/routerManager.dart';
import 'package:prueba/presentacion/viewModel/homeViewModel.dart';
import 'package:prueba/presentacion/viewModel/restaurantviewmodel.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => sl<HomeViewModel>()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => RestaurantViewModel()),
      ],
      child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoRest',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: Routermanager.home,
      onGenerateRoute: Routermanager.onGenerationRoute,
    );
  }
}