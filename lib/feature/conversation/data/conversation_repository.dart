import 'package:new_flutter/feature/conversation/model/conversation.dart';

abstract class ConversationRepository {
  Future<List<Conversation>> getConversations();

  void addConversation();
}
