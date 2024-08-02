import 'package:get/get.dart';
import 'package:new_flutter/feature/conversation/data/conversation_repository.dart';
import 'package:new_flutter/feature/conversation/model/conversation.dart';
import 'package:rxdart/rxdart.dart';

class ConversationBloc {
  final ConversationRepository _conversationRepository = Get.find<ConversationRepository>();

  final _conversationSubject = BehaviorSubject<List<Conversation>?>.seeded(null);

  Stream<List<Conversation>?> get conversationStream => _conversationSubject.stream;

  Sink<List<Conversation>?> get conversationSink => _conversationSubject.sink;

  ConversationBloc() {
    _getConversations();
  }

  void dispose() {
    _conversationSubject.close();
  }

  void _getConversations() async {
    final conversations = await _conversationRepository.getConversations();
    conversationSink.add(conversations);
  }

  void addConversation() async {
    _conversationRepository.addConversation();
    final conversations = await _conversationRepository.getConversations();
    conversationSink.add(conversations);
  }
}
