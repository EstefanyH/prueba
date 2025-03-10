import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba/core/separator.dart';
import 'package:prueba/presentacion/viewModel/photoViewModel.dart';

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
                    onPressed: () => {}, 
                    icon: Icon(Icons.camera_alt_rounded))
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('assets/image/desconocido.png'),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),),
              
              SizedBoxH30(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Etiqueta foto 2'),
                  IconButton(
                    onPressed: () => {}, 
                    icon: Icon(Icons.camera_alt_rounded))
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('assets/image/desconocido.png'),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),)
            ]
          );
        },)
    );
  }
}