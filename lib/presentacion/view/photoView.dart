import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba/core/separator.dart';
import 'package:prueba/presentacion/viewModel/photoViewModel.dart';

class PhotoView extends StatelessWidget {
  
  const PhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    print('---------- PhotoView');
  
    return SingleChildScrollView(
      child: Padding(
      padding: EdgeInsets.all(15),
      child: Consumer<PhotoViewModel>(
        builder: (context, viewModel, child){
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Etiqueta foto 1 - Frontal'),
                  IconButton(
                    onPressed: () async {
                       await viewModel.takePhoto(context);
                       //await viewModel.onShowOpenModal(context, PhotoSide.front);
                    }, 
                    icon: Icon(Icons.camera_alt_rounded))
                ],
              ),
              
              viewModel.imageFile != null
                      ? Image.file(viewModel.imageFile!, height: 200, fit: BoxFit.cover)
                      : Image(
                          image: AssetImage('assets/image/desconocido.png'), 
                          height: 200, 
                          fit: BoxFit.cover),
                          
              SizedBoxH10(),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.onSave(context);
                }, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Guarda')
                  ],
                ))
            ]
          );
        },)
    ),
    );
  }
}