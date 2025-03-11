import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:prueba/commom/css/fontstyle.dart';
import 'package:prueba/config/router/routerManager.dart';
import 'package:prueba/core/separator.dart';
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
                  onPressed: () async {
                    await viewModel.onDownloadType(context);
                  }, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Descargar tipos de fotos')
                    ],)),
                  SizedBoxH10(),
                  Expanded(
                    child: viewModel.latitude == 0.0 && viewModel.longitude == 0.0
                        ? Center(child: CircularProgressIndicator())
                        : FlutterMap(
                            options: MapOptions(
                              initialCenter: viewModel.markerPosition, // Centrado en la ubicación actual
                              initialZoom: 15.0, // Zoom adecuado para la ubicación
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                subdomains: ['a', 'b', 'c'],),
                              MarkerLayer(markers:  [
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: viewModel.markerPosition,
                                    child:  Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                ],),
                            ],
                          ),
                  )
              ],
          ),);
        })
    );
  }
  
}