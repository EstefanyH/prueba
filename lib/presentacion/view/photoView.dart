import 'package:flutter/material.dart';
import 'package:prueba/core/separator.dart';

class PhotoView extends StatelessWidget {
  
  const PhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    print('---------- PhotoView');
  
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
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
      ),
    );
  }
}