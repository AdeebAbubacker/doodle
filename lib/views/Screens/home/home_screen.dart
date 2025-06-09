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
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  User user = state.users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
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
