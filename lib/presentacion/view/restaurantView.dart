import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:prueba/core/widgets/titlebanner.dart';
import 'package:prueba/presentacion/view/newView.dart';
import 'package:prueba/presentacion/view/photoView.dart';
import 'package:prueba/presentacion/viewModel/restaurantviewmodel.dart';

class RestaurantView extends StatelessWidget {
  const RestaurantView({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    late int _index = 0;

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('GeoRest'),
        actions: [
          IconButton(
            onPressed: () => {}, 
            icon: Icon(Icons.save))
        ],),
      body: Consumer<RestaurantViewModel>(
        builder: (context, viewModel, child){
          return Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                TitleBanner(text: 'Restaurante'),
                ToggleButtons(
                  isSelected: [viewModel.selectedIndex == 0, viewModel.selectedIndex == 1],
                  onPressed: (index) async { 
                      _index = index;
                      await viewModel.onSelectionToggle(index);
                  },
                  children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Datos'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Fotos'),
                      ),
                    ],
                ),
                Expanded(
                  child: viewModel.selectedIndex == 0 ? NewView() : PhotoView() ,                  
                )
              ],
            ),);
        },)
    );
  }
}