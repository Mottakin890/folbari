import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/core/dimensions/spacings.dart';
import 'package:folbari/core/theme/app_colors.dart';
import 'package:folbari/core/theme/app_text_styles.dart';
import 'package:folbari/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:folbari/features/chat/presentation/bloc/chat_state.dart';
import 'package:folbari/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:folbari/features/chat/presentation/widgets/chat_input_area.dart';
import 'package:folbari/features/chat/presentation/bloc/chat_event.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  final String? receiverId;
  final String? receiverName;
  const ChatScreen({super.key, this.receiverId, this.receiverName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessages(targetUserId: widget.receiverId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.cFFFFFF,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.cFFA451.withValues(alpha: 0.1),
              child: Icon(Icons.headset_mic_rounded, color: AppColors.cFFA451, size: 18.sp),
            ),
            Spacing.horizontal(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.receiverName ?? 'Support Center', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                Text('Online', style: TextStyle(fontSize: 10.sp, color: AppColors.c4CAF50, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocSelector<ChatBloc, ChatState, List<ChatMessage>>(
              selector: (state) => state.messages,
              builder: (context, messages) {
                return ListView.builder(
                  padding: REdgeInsets.all(20),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return ChatBubble(
                      message: msg.text,
                      isMe: msg.isMe,
                      time: '${msg.time.hour}:${msg.time.minute.toString().padLeft(2, '0')} AM',
                    );
                  },
                );
              },
            ),
          ),
          ChatInputArea(targetUserId: widget.receiverId),
        ],
      ),
    );
  }
}
