import 'package:flutter/material.dart';
import 'package:prueba/core/util/callback.dart';

void showModalCamera(BuildContext context, {required EventInterface eventInterface}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Seleccionar imagen",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.blue),
                title: Text("Tomar foto"),
                onTap: () {
                    eventInterface.onItemSelected(context, 0, '');
                }
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.green),
                title: Text("Seleccionar de galería"),
                onTap: () {
                    eventInterface.onItemSelected(context, 0, '');
                  } ,
              ),
            ],
          ),
        );
      },
    );
  }