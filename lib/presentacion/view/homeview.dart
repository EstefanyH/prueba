import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba/commom/css/fontstyle.dart';
import 'package:prueba/config/router/routerManager.dart';
import 'package:prueba/core/widgets/titlebanner.dart';
import 'package:prueba/presentacion/viewModel/homeViewModel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<HomeViewModel>().init();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('GeoRest'),
        actions: [
          IconButton(
            onPressed: () async {
              context.read<HomeViewModel>().init();
            }, 
            icon: Icon(Icons.update)),
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, Routermanager.restaurant);
            }, 
            icon: Icon(Icons.store))
        ],),
      backgroundColor: Colors.white,
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child){
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleBanner(text: 'Home'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Total: ${viewModel.totRegister}', style: style16Wblack,),
                    Text('Pendiente: ${viewModel.totPending}', style: style16Wblack,),
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
          ),);
        })
    );
  }
  
}