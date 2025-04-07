import '../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class Register implements UseCase<String, RegisterParams> {
  final AuthRepository repository;

  Register(this.repository);

  @override
  Future<String> call(RegisterParams params) {
    return repository.register(params.email, params.password);
  }
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({required this.email, required this.password});
}