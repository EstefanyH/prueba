import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba/config/router/routerManager.dart';
import 'package:prueba/core/service_locator.dart';
import 'package:prueba/presentacion/viewModel/homeViewModel.dart';
import 'package:prueba/presentacion/viewModel/newViewModel.dart';
import 'package:prueba/presentacion/viewModel/photoViewModel.dart';
import 'package:prueba/presentacion/viewModel/restaurantViewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<HomeViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<RestaurantViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<NewViewModel>()),
        ChangeNotifierProvider(create: (_) => sl<PhotoViewModel>()),
      ],
      child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'GeoRest',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: Routermanager.home,
      onGenerateRoute: Routermanager.onGenerationRoute,
    );
  }

}