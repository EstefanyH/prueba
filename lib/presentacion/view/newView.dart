import 'package:flutter/material.dart';

class NewView extends StatelessWidget {
  
  const NewView({super.key});

  @override
  Widget build(BuildContext context) {
    print('---------- NewView');

    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Nombre'
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Ruc'
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Latitud'
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Longitus'
            ),
          ),
          Text('Comentario'),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: ''
            ),
          )
        ],
      ),);
  }
}