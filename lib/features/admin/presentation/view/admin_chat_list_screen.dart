import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_event.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_state.dart';
import 'package:folbari/features/chat/presentation/view/chat_screen.dart';

class AdminChatListScreen extends StatefulWidget {
  const AdminChatListScreen({super.key});

  @override
  State<AdminChatListScreen> createState() => _AdminChatListScreenState();
}

class _AdminChatListScreenState extends State<AdminChatListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(LoadAllUsers()); // Re-using user list for now
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Messages'),
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
              if (user.role == 'admin') return const SizedBox.shrink();

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
                  child: user.avatarUrl == null ? const Icon(Icons.person) : null,
                ),
                title: Text(user.name ?? 'Unknown User'),
                subtitle: const Text('Tap to view conversation'),
                onTap: () {
                  // In a real app, we'd pass the userId to a specialized AdminChatScreen
                  // For now, we'll assume ChatScreen can be adapted or we create AdminChatScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(receiverId: user.id, receiverName: user.name ?? 'User'),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
