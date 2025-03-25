import 'package:cleanarchitecture/core/network/network_info.dart';
import 'package:cleanarchitecture/core/network/network_info_impl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/data/datasources/user_remote_datasource.dart';
import 'features/data/datasources/user_remote_datasource_impl.dart';
import 'features/domain/repositories/user_repository.dart';
import 'features/domain/repositories/user_repository_impl.dart';
import 'features/domain/usecases/get_all_users.dart';
import 'features/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Network
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Bloc
  sl.registerFactory(() => UserBloc(sl()));

  // Usecase
  sl.registerLazySingleton(() => GetAllUsers(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl(), sl()));

  // Data Source
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()), // ⬅️ inject client
  );
}