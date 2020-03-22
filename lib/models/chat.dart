class Message {
  String content;
  DateTime createdAt;
  String uid;
}

class Chat {
  String uid1;
  String uid2;
  int count;
  List<Message> messages;

  Chat({ this.uid1, this.uid2, this.count, this.messages });
}