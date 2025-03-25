import 'package:cleanarchitecture/core/network/network_info_impl.dart';
import 'package:cleanarchitecture/features/data/datasources/user_remote_datasource_impl.dart';
import 'package:cleanarchitecture/features/domain/repositories/user_repository_impl.dart';
import 'package:cleanarchitecture/features/domain/usecases/get_all_users.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../bloc/user_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc(
        GetAllUsers(
          UserRepositoryImpl(
            UserRemoteDataSourceImpl(client: http.Client()),
            NetworkInfoImpl(Connectivity()),
          ),
        ),
      )..add(LoadUsers()),
      child: Scaffold(
        backgroundColor: Colors.purple.shade50,
        appBar: AppBar(
          title: const Text('👥 Daftar Pengguna', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari nama pengguna...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.deepPurple),
                    );
                  }

                  if (state is UserLoaded) {
                    final filteredUsers = state.users.where((user) {
                      return user.name.toLowerCase().contains(searchQuery);
                    }).toList();

                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: filteredUsers.length,
                      itemBuilder: (_, i) {
                        final user = filteredUsers[i];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              child: Text(
                                user.name.substring(0, 1),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              user.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text('ID: ${user.id}'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UserDetailPage(userName: user.name),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }

                  if (state is UserError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetailPage extends StatelessWidget {
  final String userName;

  const UserDetailPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Detail pengguna: $userName',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}