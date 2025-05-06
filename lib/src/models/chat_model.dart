import 'package:front_ia/src/models/message_model.dart';

class Chat {
  String? id;
  String? name;
  List<Message>? messages = [];

  Chat({this.id, this.name, this.messages});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['messages'] != null) {
      messages = <Message>[];
      json['messages'].forEach((v) {
        messages!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
