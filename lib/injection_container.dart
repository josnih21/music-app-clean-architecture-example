import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app_clean_architecture/core/network/network_info.dart';
import 'package:music_app_clean_architecture/features/album_search/data/datasources/album_local_data_source.dart';
import 'package:music_app_clean_architecture/features/album_search/data/datasources/album_remote_data_source.dart';
import 'package:music_app_clean_architecture/features/album_search/data/repositories/album_repository_impl.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/repositories/album_repository.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/usecases/get_album.dart';
import 'package:music_app_clean_architecture/features/album_search/presentation/bloc/album_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features - album_search
  // Bloc
  serviceLocator.registerFactory(() => AlbumBloc(getAlbum: serviceLocator()));

  //UseCases
  serviceLocator.registerLazySingleton(() => GetAlbumUseCase(serviceLocator()));

  //Respository
  serviceLocator.registerLazySingleton<AlbumRepository>(() => AlbumRepositoryImpl(
      localDataSource: serviceLocator(), networkInfo: serviceLocator(), remoteDataSource: serviceLocator()));

  //Data sources
  serviceLocator
      .registerLazySingleton<AlbumRemoteDataSource>(() => AlbumRemoteDataSourceImpl(client: serviceLocator()));
  serviceLocator
      .registerLazySingleton<AlbumLocalDataSource>(() => AlbumLocalDataSourceImpl(sharedPreferences: serviceLocator()));

  //! Core
  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(serviceLocator()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => DataConnectionChecker());
}
