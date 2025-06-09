import 'package:doodle/core/di/injection.dart';
import 'package:doodle/core/services/api_service.dart';
import 'package:doodle/core/view_model/user/user_cubit.dart';
import 'package:doodle/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(getIt<ApiService>())..fetchUsers(),
      child: Scaffold(
        appBar: AppBar(title: Text('Users')),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is UserLoaded) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  User user = state.users[index];
                  final avatar = user.avatar ?? '';
                  final firstName = user.firstName ?? 'No First';
                  final lastName = user.lastName ?? 'Name';
                  final email = user.email ?? 'No email available';
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          (avatar.isNotEmpty)
                              ? NetworkImage(avatar)
                              : null, // Use null if no image
                      child:
                          (avatar.isEmpty)
                              ? const Icon(Icons.person, color: Colors.white)
                              : null, // Show icon only if no avatar
                    ),
                    title: Text('$firstName $lastName'),
                    subtitle: Text(email),
                  );
                },
              );
            }
            if (state is UserError) {
              return Center(child: Text('Failed to fetch users'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
