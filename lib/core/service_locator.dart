import 'package:get_it/get_it.dart';
import 'package:prueba/data/database/cia.dao.dart';
import 'package:prueba/data/database/databaseHelper.dart';
import 'package:prueba/data/database/photo.dao.dart';
import 'package:prueba/data/repositories/home.repository.impl.dart';
import 'package:prueba/data/repositories/restaurant.repository.impl.dart';
import 'package:prueba/data/source/home.datasource.dart';
import 'package:prueba/data/source/restaurant.datasource.dart';
import 'package:prueba/domain/repository/home.repository.dart';
import 'package:prueba/domain/repository/restaurant.repository.dart';
import 'package:prueba/presentacion/viewModel/homeViewModel.dart';
import 'package:prueba/presentacion/viewModel/restaurantViewModel.dart';

final sl = GetIt.instance;

void setupServiceLocator() async {
  sl.reset(); 

  final db = DatabaseHelper();

  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  sl.registerLazySingleton<CiaDao>(() => CiaDao(sl()));
  sl.registerLazySingleton<PhotoDao>(() => PhotoDao(sl()));

  sl.registerLazySingleton<HomeDatasource>(() => HomeDatasourceImpl());
  sl.registerLazySingleton<RestaurantDatasource>(() => RestaurantDatasourceImpl());


  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(datasource: sl()));
  sl.registerLazySingleton<RestaurantRepository>(() => RestaurantRepositoryImpl(datasource: sl()));


  sl.registerFactory(() => HomeViewModel(repository: sl<HomeRepository>()));
  sl.registerFactory(() => RestaurantViewModel(repository: sl<RestaurantRepository>()));
  
}