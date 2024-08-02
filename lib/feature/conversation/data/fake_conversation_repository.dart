import 'dart:math';

import 'package:new_flutter/feature/conversation/data/conversation_repository.dart';
import 'package:new_flutter/feature/conversation/model/conversation.dart';

class FakeConversationRepository extends ConversationRepository {
  late List<Conversation> _conversations;

  FakeConversationRepository() {
    var random = Random();

    _conversations = List.generate(
      20,
      (index) => Conversation(
        id: index,
        name: _conversationNames[random.nextInt(_conversationNames.length)],
        preview: _previews[random.nextInt(_previews.length)],
        timestamp: DateTime.now()
            .subtract(
              Duration(days: index),
            )
            .millisecondsSinceEpoch,
      ),
    );
  }

  @override
  Future<List<Conversation>> getConversations() async {
    Future.delayed(const Duration(seconds: 1));
    return _conversations;
  }

  @override
  void addConversation() {
    final random = Random();
    final newConversation = Conversation(
      id: _conversations.length,
      name: _conversationNames[random.nextInt(_conversationNames.length)],
      preview: _previews[random.nextInt(_previews.length)],
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    _conversations.insert(0, newConversation);
  }

  final List<String> _conversationNames = [
    "Epic Adventurers",
    "Mystic Falls",
    "Chatter Boxes",
    "Dream Team",
    "The Spartans",
    "Night Owls",
    "The Avengers",
    "Wanderlust Souls",
    "The Unicorns",
    "Dragon Riders",
    "Meme Team",
    "The Wizards",
    "Squad Goals",
    "The Elite Group",
    "Chaos Creators",
    "The Invincibles",
    "Laugh Factory",
    "The Trailblazers",
    "Mystery Machine",
    "The Brainiacs",
    "The Knights",
    "Future Billionaires",
    "The Vikings",
    "The Rebels",
    "The Dreamers",
    "The Achievers",
    "The Explorers",
    "The Pioneers",
    "The Innovators",
    "The Trendsetters",
    "The Champions",
    "The Guardians",
    "The Warriors",
    "The Mavericks",
    "The Renegades",
    "The Adventurers",
    "The Legends",
    "The Game Changers",
    "The Visionaries",
    "The Trailblazers",
    "The Pacesetters",
    "The Influencers",
    "The Motivators",
    "The Dynamos",
    "The Powerhouses",
    "The Gurus",
    "The Mavericks",
    "The Prodigies",
    "The Masters",
    "The Geniuses"
  ];

  final List<String> _previews = [
    "Hey, how's it going?",
    "Did you see the game last night?",
    "What's up for the weekend?",
    "Can't believe how fast time is flying!",
    "Did you finish the project?",
    "What's your favorite movie?",
    "Let's catch up soon!",
    "How's the family?",
    "Dreaming of a vacation!",
    "Any book recommendations?",
    "Feeling so motivated today!",
    "What's your go-to comfort food?",
    "Let's plan a road trip.",
    "How do you relax after a long day?",
    "Got any plans for tonight?",
    "What's the latest gossip?",
    "Remember our trip to the beach?",
    "How's work going?",
    "Feeling all the Monday blues.",
    "What's your favorite childhood memory?",
    "Let's start a book club.",
    "How do you stay fit?",
    "What's your dream job?",
    "Planning any home improvements?",
    "What's your favorite hobby?",
    "Let's have a movie marathon.",
    "How do you deal with stress?",
    "What's your favorite season?",
    "Dreaming of coffee right now.",
    "What's the best advice you've ever received?",
    "Let's go on an adventure.",
    "What's your favorite song?",
    "Feeling grateful today.",
    "What's your favorite thing to cook?",
    "Let's do a workout challenge.",
    "How do you stay organized?",
    "What's your morning routine?",
    "Planning any trips this year?",
    "What's your favorite dessert?",
    "Let's have a game night.",
    "How do you make friends in a new city?",
    "What's your favorite podcast?",
    "Feeling so nostalgic lately.",
    "What's your favorite way to relax?",
    "Let's volunteer together.",
    "How do you stay motivated?",
    "What's your favorite tea?",
    "Let's start a hobby together.",
    "How do you balance work and life?",
    "What's your favorite memory of us?"
  ];
}
