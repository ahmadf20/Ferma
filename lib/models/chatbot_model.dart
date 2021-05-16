class Chat {
  Chat({
    this.recipientId,
    this.text,
  });

  /// 0: user; 1: bot
  String? recipientId;
  String? text;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        recipientId: json["recipient_id"],
        text: json["text"],
      );
}
