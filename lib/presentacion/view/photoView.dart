import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba/core/separator.dart';
import 'package:prueba/presentacion/viewModel/photoViewModel.dart';

class PhotoView extends StatelessWidget {
  
  const PhotoView({super.key});

  @override
  Widget build(BuildContext context) { 
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<PhotoViewModel>().init(context);
    }); 

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<PhotoViewModel>(
        builder: (context, viewModel, child){
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await viewModel.onSave(context);
                }, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Guarda')
                  ],
                )),
              SizedBoxH10(),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.types.length,
                  itemBuilder: (context, index) {         
                    var row = viewModel.types[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Foto ${index + 1} - ${row.name}'),
                            IconButton(
                              onPressed: () async {
                                await viewModel.takePhoto(context, index, row.uuid );
                              }, 
                              icon: Icon(Icons.camera_alt_rounded))
                          ],
                        ),
                        
                        viewModel.imageFiles[index] != null
                                ? Image.file(viewModel.imageFiles[index]!, height: 200, fit: BoxFit.cover)
                                : Image(
                                    image: AssetImage('assets/image/desconocido.png'), 
                                    height: 200, 
                                    fit: BoxFit.cover),
                        
                      ]
                    );
                  }))
            ]
          );
        },)
    );
  }
}