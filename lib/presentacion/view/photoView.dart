import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:prueba/core/separator.dart';
import 'package:prueba/presentacion/viewModel/photoViewModel.dart';

import '../../domain/enums/app_Enums.dart';

class PhotoView extends StatelessWidget {
  
  const PhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    print('---------- PhotoView');
  
    return Padding(
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
                  Text('Etiqueta foto 1'),
                  IconButton(
                    onPressed: () async {
                       viewModel.onShowOpenModal(context, PhotoType.camera);
                    }, 
                    icon: Icon(Icons.camera_alt_rounded))
                ],
              ),
               viewModel.image1File != null
                      ? Image.file(File(viewModel.image1File!.path), height: 200, fit: BoxFit.cover)
                      : Image(
                          image: AssetImage('assets/image/desconocido.png'), 
                          height: 200, 
                          fit: BoxFit.cover),
                   
              SizedBoxH30(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Etiqueta foto 2'),
                  IconButton(
                    onPressed: () async {
                       await viewModel.onShowOpenModal(context, PhotoType.gallery);
                    }, 
                    icon: Icon(Icons.camera_alt_rounded))
                ],
              ),
              viewModel.image2File != null
                      ? Image.file(File(viewModel.image2File!.path), height: 200, fit: BoxFit.cover)
                      : Image(
                          image: AssetImage('assets/image/desconocido.png'), 
                          height: 200, 
                          fit: BoxFit.cover),
                   
              ElevatedButton(
                onPressed: () async {
                  await viewModel.onSave(context);
                }, 
                child: Text('Guarda'))
            ]
          );
        },)
    );
  }
}