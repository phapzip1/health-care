class ChatModel {
  String appointmentId;
  String senderId;
  String receiverName;
  String? text;
  String? image;
  DateTime time;

  ChatModel(this.appointmentId, this.senderId, this.receiverName, this.text,
      this.time, this.image);

  
}
