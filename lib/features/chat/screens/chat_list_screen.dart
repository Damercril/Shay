import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';
import '../../professional/models/professional.dart';
import '../services/chat_service.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late ChatService _chatService;
  bool _isLoading = true;
  Map<String, int> _unreadCounts = {};

  @override
  void initState() {
    super.initState();
    _initChatService();
  }

  Future<void> _initChatService() async {
    _chatService = await ChatService.init();
    await _updateUnreadCounts();
  }

  Future<void> _updateUnreadCounts() async {
    if (!mounted) return;
    
    final List<Professional> professionals = Professional.getDummyProfessionals();
    final Map<String, int> counts = {};
    
    for (final professional in professionals) {
      final messages = await _chatService.getMessages(professional.id);
      counts[professional.id] = messages.where((msg) => !msg.isMe && !msg.read).length;
    }

    setState(() {
      _unreadCounts = counts;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Professional> professionals = Professional.getDummyProfessionals();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: professionals.length,
              itemBuilder: (context, index) {
                final professional = professionals[index];
                final unreadCount = _unreadCounts[professional.id] ?? 0;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(professional.profileImage),
                  ),
                  title: Text(
                    professional.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  subtitle: Text(
                    professional.title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (unreadCount > 0)
                        Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            unreadCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      SizedBox(width: 8.w),
                      if (professional.isOnline)
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          professional: professional,
                        ),
                      ),
                    );
                    _updateUnreadCounts();
                  },
                );
              },
            ),
    );
  }
}
