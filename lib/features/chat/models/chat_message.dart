class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime time;
  final String professionalId;
  final bool read;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    required this.professionalId,
    this.read = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isMe': isMe,
      'time': time.toIso8601String(),
      'professionalId': professionalId,
      'read': read,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'] as String,
      isMe: json['isMe'] as bool,
      time: DateTime.parse(json['time'] as String),
      professionalId: json['professionalId'] as String,
      read: json['read'] as bool? ?? false,
    );
  }

  ChatMessage copyWith({
    String? text,
    bool? isMe,
    DateTime? time,
    String? professionalId,
    bool? read,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      isMe: isMe ?? this.isMe,
      time: time ?? this.time,
      professionalId: professionalId ?? this.professionalId,
      read: read ?? this.read,
    );
  }
}
