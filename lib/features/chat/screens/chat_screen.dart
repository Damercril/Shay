import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';
import '../../professional/models/professional.dart';
import '../models/chat_message.dart';
import '../services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  final Professional professional;

  const ChatScreen({
    super.key,
    required this.professional,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  late ChatService _chatService;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initChatService();
  }

  Future<void> _initChatService() async {
    _chatService = await ChatService.init();
    final messages = await _chatService.getMessages(widget.professional.id);
    await _chatService.markMessagesAsRead(widget.professional.id);
    if (mounted) {
      setState(() {
        _messages = messages;
        _isLoading = false;
      });
    }
    if (_messages.isEmpty) {
      _addDemoMessages();
    }
  }

  void _addDemoMessages() async {
    final demoMessages = [
      ChatMessage(
        text: 'Bonjour, je souhaiterais prendre rendez-vous pour une prestation.',
        isMe: true,
        time: DateTime.now().subtract(const Duration(days: 1)),
        professionalId: widget.professional.id,
        read: true,
      ),
      ChatMessage(
        text: 'Bonjour ! Bien sûr, je suis disponible cette semaine. Quel jour vous conviendrait le mieux ?',
        isMe: false,
        time: DateTime.now().subtract(const Duration(days: 1)),
        professionalId: widget.professional.id,
        read: true,
      ),
    ];

    for (var message in demoMessages) {
      await _chatService.addMessage(message);
    }

    if (mounted) {
      setState(() {
        _messages = demoMessages;
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final message = ChatMessage(
      text: _messageController.text,
      isMe: true,
      time: DateTime.now(),
      professionalId: widget.professional.id,
    );

    await _chatService.addMessage(message);

    if (mounted) {
      setState(() {
        _messages.add(message);
      });
    }

    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays == 0) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Hier';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.professional.profileImage),
              radius: 20.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.professional.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.professional.isOnline ? 'En ligne' : 'Hors ligne',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: widget.professional.isOnline ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Align(
                        alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: 8.h,
                            left: message.isMe ? 64.w : 0,
                            right: message.isMe ? 0 : 64.w,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: message.isMe ? AppTheme.primaryColor : Colors.grey[200],
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.text,
                                style: TextStyle(
                                  color: message.isMe ? Colors.white : Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                _formatTime(message.time),
                                style: TextStyle(
                                  color: message.isMe ? Colors.white70 : Colors.grey,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Écrivez votre message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.r),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                          ),
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      IconButton(
                        onPressed: _sendMessage,
                        icon: Icon(
                          Icons.send,
                          color: AppTheme.primaryColor,
                          size: 24.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
