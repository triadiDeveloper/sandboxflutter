// # Base class untuk semua usecase

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

// Gunakan ini jika usecase tidak membutuhkan parameter
class NoParams {}