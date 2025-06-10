import 'package:doodle/core/const/text_styles.dart';
import 'package:doodle/core/di/injection.dart';
import 'package:doodle/core/services/api_service.dart';
import 'package:doodle/core/view_model/user/user_cubit.dart';
import 'package:doodle/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(getIt<ApiService>())..fetchUsers(2),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text(
            'Welcome 👋',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green.shade600,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              tooltip: 'Logout',
              onPressed: () => _logout(context),
            )
          ],
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UserNoInternet) {
              return RefreshIndicator(
                backgroundColor: Colors.white,
                color: Colors.green,
                onRefresh: () async {
                  context.read<UserCubit>().fetchUsers(2);
                },
                child: ListView(
                  physics:
                      const AlwaysScrollableScrollPhysics(), 
                  children: const [
                    SizedBox(height: 100),
                    Center(child: Text("No Internet")),
                  ],
                ),
              );
            }

            if (state is UserLoaded) {
              return RefreshIndicator(
                backgroundColor: Colors.white,
                color: Colors.green,
                onRefresh: () async {
                  context.read<UserCubit>().fetchUsers(2);
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.users.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final user = state.users.data?[index] ?? "N/A";
                    return _UserCard(user: user as User);
                  },
                ),
              );
            }

            if (state is UserError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 60),
                    const SizedBox(height: 12),
                    const Text(
                      'Oops! Something went wrong.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => context.read<UserCubit>().fetchUsers(2),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                    )
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final User user;

  const _UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final fullName = '${user.firstName ?? ''} ${user.lastName ?? ''}';
    final email = user.email ?? '';
    final avatar = user.avatar ?? '';

    return Card(
      elevation: 4,
      color: Colors.white, // White card on light gray scaffold
      shadowColor: Colors.black.withOpacity(0.5),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: avatar.isNotEmpty ? NetworkImage(avatar) : null,
          child: avatar.isEmpty
              ? const Icon(Icons.person, color: Colors.white)
              : null,
        ),
        title: Text(
          fullName,
          style: AppTextStyles.blackW600S16,
        ),
        subtitle: Text(
          email,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
