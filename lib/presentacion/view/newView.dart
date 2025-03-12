import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba/domain/entities/position.dart';
import 'package:prueba/domain/enums/app_Enums.dart';
import 'package:prueba/presentacion/viewModel/newViewModel.dart';

class NewView extends StatelessWidget {
  final Positions model;
  
  const NewView({ super.key, required this.model });

  @override
  Widget build(BuildContext context) {
    print('---------- NewView');

    WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<NewViewModel>().position = model;
        context.read<NewViewModel>().init();
    });


    return SingleChildScrollView(
      child: Padding(
      padding: EdgeInsets.all(15),
      child: Consumer<NewViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                maxLength: 20,
                controller: viewModel.name_controller,
                decoration: InputDecoration(
                  hintText: 'Nombre'
                ),
                onChanged: (value) => { 
                  viewModel.onSaved(CiaType.name, value)
                }
              ),
              TextField(
                maxLength: 11,
                controller: viewModel.ruc_controller,
                decoration: InputDecoration(
                  hintText: 'Ruc'
                ),
                onChanged: (value) => { 
                  viewModel.onSaved(CiaType.ruc, value)
                }
              ),
              TextField(
                enabled: false,
                controller: viewModel.latitude_controller,
                decoration: InputDecoration(
                  hintText: 'Latitud'
                ),
                onChanged: (value) => {
                  viewModel.onSaved(CiaType.latitud, value)
                }
              ),
              TextField(
                enabled: false,
                controller: viewModel.longitude_controller,
                decoration: InputDecoration(
                  hintText: 'Longitude'
                ),
                onChanged: (value) => {
                  viewModel.onSaved(CiaType.longitud, value)
                }
              ),
              Text('Comentario'),
              TextField(
                maxLength: 60,
                controller: viewModel.comment_controller,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: ''
                ),
                onChanged: (value) => {
                  viewModel.onSaved(CiaType.comment, value)
                }
              )
            ],
          );
        },) 
    ),
    );
  }
}