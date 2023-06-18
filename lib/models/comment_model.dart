class CommentModel {
  String postId;
  String senderId;
  String gender;
  int age;
  String? text;
  String? image;
  bool imageReadable;
  DateTime time;

  CommentModel(this.postId, this.senderId, this.gender, this.age, this.time,
      this.imageReadable,
      {this.text, this.image});
}
