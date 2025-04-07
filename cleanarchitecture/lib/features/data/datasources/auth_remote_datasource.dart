// lib/features/data/datasources/auth_remote_datasource.dart
import 'package:cleanarchitecture/core/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AuthRemoteDataSource {
  Future<String> login(String email, String password);
  Future<String> register(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<String> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('${AppConstants.baseUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded['token']; // "QpwL5tke4Pnpja7X4"
    } else {
      throw Exception('Login gagal. Periksa email/password.');
    }
  }

  @override
  Future<String> register(String email, String password) async {
    final response = await client.post(
      Uri.parse('${AppConstants.baseUrl}/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decoded = json.decode(response.body);
      return decoded['token']; // "QpwL5tke4Pnpja7X4"
    } else {
      throw Exception('Register gagal. Periksa data yang kamu input.');
    }
  }
}