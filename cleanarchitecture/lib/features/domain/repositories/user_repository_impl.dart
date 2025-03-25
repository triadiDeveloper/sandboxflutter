import 'package:cleanarchitecture/core/error/failures.dart';
import 'package:cleanarchitecture/core/network/network_info.dart';
import 'package:dartz/dartz.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getUsersFromApi();
        return Right(result);
      } catch (e) {
        return Left(ServerFailure("Gagal mengambil data"));
      }
    } else {
      return Left(CacheFailure("Tidak ada koneksi internet"));
    }
  }
}
