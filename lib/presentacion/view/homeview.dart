import 'package:flutter/material.dart';
import 'package:prueba/commom/css/fontstyle.dart';
import 'package:prueba/config/router/routerManager.dart';
import 'package:prueba/core/widgets/titlebanner.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeoRest'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, Routermanager.restaurant);
            }, 
            icon: Icon(Icons.store))
        ],),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleBanner(text: 'Home'),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Total: 5', style: style16Wblack,),
              Text('Pendiente: 8', style: style16Wblack,),
            ],
          ),
          const Text('Lista de restaurante', style: style22wblack,),
          ElevatedButton(
            onPressed: () => {}, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Descargar tipos de fotos')
              ],))
        ],
      ),)
    );
  }
  
}