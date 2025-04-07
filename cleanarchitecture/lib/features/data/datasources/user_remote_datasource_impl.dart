import 'dart:convert';
import 'package:cleanarchitecture/core/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'user_remote_datasource.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getUsersFromApi() async {
    final response = await client.get(
      Uri.parse('${AppConstants.baseUrl}/users'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List users = decoded['data'];
      return users.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
