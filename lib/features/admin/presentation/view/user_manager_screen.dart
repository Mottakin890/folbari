import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_event.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_state.dart';

class UserManagerScreen extends StatefulWidget {
  const UserManagerScreen({super.key});

  @override
  State<UserManagerScreen> createState() => _UserManagerScreenState();
}

class _UserManagerScreenState extends State<UserManagerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(LoadAllUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: AppColors.cFFA451,
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state.status == AdminStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
                  child: user.avatarUrl == null ? const Icon(Icons.person) : null,
                ),
                title: Text(user.name ?? 'No Name'),
                subtitle: Text(user.email),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') {
                      context.read<AdminBloc>().add(AdminDeleteUser(user.id));
                    } else if (value == 'admin' || value == 'user') {
                      context.read<AdminBloc>().add(AdminUpdateUserRole(user.id, value));
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: user.role == 'admin' ? 'user' : 'admin',
                      child: Text('Make ${user.role == 'admin' ? 'User' : 'Admin'}'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete User', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
