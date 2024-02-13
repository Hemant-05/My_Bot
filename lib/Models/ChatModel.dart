class ChatModel {
  final bool isMe;
  final String message;

  ChatModel({
    required this.isMe,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        'isMe': isMe,
        'message': message,
      };

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        isMe: json['isMe'] as bool,
        message: json['message'] as String,
      );
}
