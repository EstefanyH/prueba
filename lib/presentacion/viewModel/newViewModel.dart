import 'package:flutter/foundation.dart';
import 'package:prueba/core/baseViewModel.dart';
import 'package:prueba/domain/repository/new.repository.dart';

class NewViewModel extends BaseViewModel with ChangeNotifier {
  final NewRepository repository;
  
  NewViewModel({required this.repository});

}