import 'package:flutter/foundation.dart';
import 'package:prueba/core/baseViewModel.dart';
import 'package:prueba/domain/repository/photo.repository.dart';

class PhotoViewModel extends BaseViewModel with ChangeNotifier {
  final PhotoRepository repository;

  PhotoViewModel({required this.repository});

}