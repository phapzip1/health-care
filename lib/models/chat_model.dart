class ChatModel {
  String postId;
  String senderId;
  String? text;
  String? image;
  DateTime time;

  ChatModel(this.postId, this.senderId ,this.time, {this.text, this.image});
}