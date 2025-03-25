import 'package:cleanarchitecture/core/error/failures.dart';
import 'package:cleanarchitecture/core/usecases/usecase.dart';
import 'package:cleanarchitecture/features/domain/entities/user.dart';
import 'package:cleanarchitecture/features/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllUsers extends UseCase<Either<Failure, List<User>>, NoParams> {
  final UserRepository repository;

  GetAllUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) {
    return repository.getAllUsers();
  }
}