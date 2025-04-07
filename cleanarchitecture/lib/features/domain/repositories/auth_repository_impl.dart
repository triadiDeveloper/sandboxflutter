import '../../data/datasources/auth_remote_datasource.dart';
import '../../../core/error/failures.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> login(String email, String password) async {
    try {
      return await remoteDataSource.login(email, password);
    } catch (_) {
      throw ServerFailure('Gagal login');
    }
  }

  @override
  Future<String> register(String email, String password) async {
    try {
      return await remoteDataSource.register(email, password);
    } catch (_) {
      throw ServerFailure('Gagal register');
    }
  }
}