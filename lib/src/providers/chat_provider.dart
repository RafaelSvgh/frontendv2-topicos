import 'package:front_ia/src/models/chat_model.dart';
import 'package:riverpod/riverpod.dart';

final chatProvider = StateProvider<Chat>((ref) {
  return Chat(id: '', name: '', messages: []);
});
