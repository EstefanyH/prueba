import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba/core/widgets/titlebanner.dart';
import 'package:prueba/domain/entities/position.dart'; 
import 'package:prueba/presentacion/view/newView.dart';
import 'package:prueba/presentacion/view/photoView.dart';
import 'package:prueba/presentacion/viewModel/restaurantViewModel.dart';

class RestaurantView extends StatelessWidget {
  final Positions model;

  const RestaurantView({super.key, required this.model});
  
  @override
  Widget build(BuildContext context) {
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<RestaurantViewModel>().init();
    }); 

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('GeoRest'),
        actions: [ ],),
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
                      viewModel.onSelectionToggle(index);
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
                  child: viewModel.selectedIndex == 0 ? 
                    NewView(model: model) : PhotoView() ,                  
                )
              ],
            ),);
        },)
    );
  }
}