import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_message.dart';

class ChatService {
  static const String _messagesKey = 'chat_messages';
  final SharedPreferences _prefs;

  ChatService(this._prefs);

  static Future<ChatService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return ChatService(prefs);
  }

  Future<List<ChatMessage>> getMessages(String professionalId) async {
    final String? messagesJson = _prefs.getString(_getKey(professionalId));
    if (messagesJson == null) return [];

    final List<dynamic> messagesList = jsonDecode(messagesJson);
    return messagesList
        .map((json) => ChatMessage.fromJson(json))
        .where((message) => message.professionalId == professionalId)
        .toList();
  }

  Future<void> addMessage(ChatMessage message) async {
    final messages = await getMessages(message.professionalId);
    messages.add(message);
    await _saveMessages(message.professionalId, messages);
  }

  Future<void> markMessagesAsRead(String professionalId) async {
    final messages = await getMessages(professionalId);
    for (var message in messages) {
      if (!message.isMe && !message.read) {
        final updatedMessage = message.copyWith(read: true);
        await _updateMessage(updatedMessage);
      }
    }
  }

  Future<int> getUnreadMessagesCount() async {
    final messages = await _getAllMessages();
    return messages.where((msg) => !msg.isMe && !msg.read).length;
  }

  Future<void> _updateMessage(ChatMessage message) async {
    final prefs = await SharedPreferences.getInstance();
    final messages = await _getAllMessages();
    final index = messages.indexWhere((m) => 
      m.professionalId == message.professionalId && 
      m.time == message.time && 
      m.text == message.text
    );
    if (index != -1) {
      messages[index] = message;
      await prefs.setString('chat_messages', jsonEncode(messages.map((m) => m.toJson()).toList()));
    }
  }

  Future<List<ChatMessage>> _getAllMessages() async {
    final allKeys = _prefs.getKeys().where((key) => key.startsWith(_messagesKey));
    List<ChatMessage> allMessages = [];

    for (final key in allKeys) {
      final String? messagesJson = _prefs.getString(key);
      if (messagesJson != null) {
        final List<dynamic> messagesList = jsonDecode(messagesJson);
        allMessages.addAll(messagesList.map((json) => ChatMessage.fromJson(json)));
      }
    }

    return allMessages;
  }

  Future<void> _saveMessages(String professionalId, List<ChatMessage> messages) async {
    final messagesJson = messages.map((msg) => msg.toJson()).toList();
    await _prefs.setString(_getKey(professionalId), jsonEncode(messagesJson));
  }

  String _getKey(String professionalId) => '${_messagesKey}_$professionalId';
}
