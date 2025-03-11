import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:prueba/core/services/apiService.dart';
import 'package:prueba/core/services/camera_service.dart';
import 'package:prueba/core/services/permission_service.dart';
import 'package:prueba/data/database/cia.dao.dart';
import 'package:prueba/data/database/databaseHelper.dart';
import 'package:prueba/data/database/photo.dao.dart';
import 'package:prueba/data/database/type_photo.dao.dart';
import 'package:prueba/data/repositories/home.repository.impl.dart';
import 'package:prueba/data/repositories/new.repository.impl.dart';
import 'package:prueba/data/repositories/photo.repository.impl.dart';
import 'package:prueba/data/repositories/restaurant.repository.impl.dart';
import 'package:prueba/core/services/shared_preferences_service.dart';
import 'package:prueba/data/source/home.datasource.dart';
import 'package:prueba/data/source/new.datasource.dart';
import 'package:prueba/data/source/photo.datasource.dart';
import 'package:prueba/data/source/restaurant.datasource.dart';
import 'package:prueba/domain/repository/home.repository.dart';
import 'package:prueba/domain/repository/new.repository.dart';
import 'package:prueba/domain/repository/photo.repository.dart';
import 'package:prueba/domain/repository/restaurant.repository.dart';
import 'package:prueba/presentacion/viewModel/homeViewModel.dart';
import 'package:prueba/presentacion/viewModel/newViewModel.dart';
import 'package:prueba/presentacion/viewModel/photoViewModel.dart';
import 'package:prueba/presentacion/viewModel/restaurantViewModel.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  //sl.reset(); 
  final sharedPreferencesService = SharedPreferencesService();
  final db = DatabaseHelper();

  await sharedPreferencesService.init();
  sl.registerSingleton<SharedPreferencesService>(sharedPreferencesService);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => ApiService(sl()));
  sl.registerLazySingleton<DatabaseHelper>(() => db);
  
  sl.registerLazySingleton(() => PermissionService());
  sl.registerLazySingleton(() => CameraService());


  sl.registerLazySingleton<CiaDao>(() => CiaDao(sl.get()));
  sl.registerLazySingleton<PhotoDao>(() => PhotoDao(sl.get()));
  sl.registerLazySingleton<TypePhotoDao>(() => TypePhotoDao(sl.get()));

  sl.registerLazySingleton<HomeDatasource>(() => HomeDatasourceImpl(dao: sl.get(), type: sl.get(), api: sl.get()));
  sl.registerLazySingleton<RestaurantDatasource>(() => RestaurantDatasourceImpl(dao: sl.get()));
  sl.registerLazySingleton<NewDatasource>(() => NewDatasourceImpl());
  sl.registerLazySingleton<PhotoDatasource>(() => PhotoDatasourceImpl(api: sl.get()));

  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(datasource: sl.get()));
  sl.registerLazySingleton<RestaurantRepository>(() => RestaurantRepositoryImpl(datasource: sl.get<RestaurantDatasource>()));
  sl.registerLazySingleton<NewRepository>(() => NewRepositoryImpl(datasource: sl.get(), shared: sl.get()));
  sl.registerLazySingleton<PhotoRepository>(() => PhotoRepositoryImpl(datasource: sl.get(), dao: sl.get(), shared: sl.get()));
  
  sl.registerFactory<HomeViewModel>(() => HomeViewModel(repository: sl.get<HomeRepository>()));
  sl.registerFactory<RestaurantViewModel>(() => RestaurantViewModel(repository: sl.get<RestaurantRepository>()));
  sl.registerFactory<NewViewModel>(() => NewViewModel(repository: sl.get<NewRepository>()));
  sl.registerFactory<PhotoViewModel>(() => PhotoViewModel(repository: sl.get<PhotoRepository>()));
}