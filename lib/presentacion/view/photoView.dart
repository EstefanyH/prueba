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
          Text('Etiqueta foto 1'),
          Align(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage('assets/image/desconocido.png'),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),),
          ElevatedButton(
            onPressed: () {}, 
            child: Row(
              children: [
                Text('Tomar foto')
              ],
          )),
          
          SizedBoxH30(),
          Text('Etiqueta foto 2'),
          Align(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage('assets/image/desconocido.png'),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),),
          ElevatedButton(
            onPressed: () {}, 
            child: Row(
              children: [
                Text('Tomar foto')
              ],
          )),
        ]
      ),
    );
  }
}