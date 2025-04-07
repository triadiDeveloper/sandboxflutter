import '../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class Login implements UseCase<String, LoginParams> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<String> call(LoginParams params) {
    return repository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
