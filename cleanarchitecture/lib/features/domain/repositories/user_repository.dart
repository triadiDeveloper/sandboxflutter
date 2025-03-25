import 'package:cleanarchitecture/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getAllUsers(); // ✅ Sesuai dengan implementasi
}
