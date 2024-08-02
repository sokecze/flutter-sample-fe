import 'package:get/get.dart';
import 'package:new_flutter/feature/authentication/data/remote_user_repository.dart';
import 'package:new_flutter/feature/authentication/data/user_repository.dart';
import 'package:new_flutter/feature/conversation/data/conversation_repository.dart';
import 'package:new_flutter/feature/conversation/data/fake_conversation_repository.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<UserRepository>(() => RemoteUserRepository());
    Get.lazyPut<ConversationRepository>(() => FakeConversationRepository());
  }
}
