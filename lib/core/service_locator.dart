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

Future<void> setupServiceLocator() async {
  //sl.reset(); 

  final db = DatabaseHelper();

  sl.registerLazySingleton<DatabaseHelper>(() => db);
  //await sl.isReady<DatabaseHelper>(); 

  sl.registerLazySingleton<CiaDao>(() => CiaDao(sl.get()));
  sl.registerLazySingleton<PhotoDao>(() => PhotoDao(sl.get()));

  sl.registerLazySingleton<HomeDatasource>(() => HomeDatasourceImpl(dao: sl.get()));
  sl.registerLazySingleton<RestaurantDatasource>(() => RestaurantDatasourceImpl());

  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(datasource: sl.get()));
  sl.registerLazySingleton<RestaurantRepository>(() => RestaurantRepositoryImpl(datasource: sl.get()));
  
  sl.registerFactory<HomeViewModel>(() => HomeViewModel(repository: sl.get<HomeRepository>()));
  sl.registerFactory<RestaurantViewModel>(() => RestaurantViewModel(repository: sl.get<RestaurantRepository>()));

  //sl.registerFactory(() => HomeViewModel(repository: sl.get<HomeRepository>()));
  //sl.registerFactory(() => RestaurantViewModel(repository: sl.get<RestaurantRepository>()));
  
}