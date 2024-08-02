import 'package:flutter/material.dart';
import 'package:new_flutter/feature/conversation/conversation_bloc.dart';
import 'package:new_flutter/feature/conversation/model/conversation.dart';
import 'package:new_flutter/navigation/ui/bottom_nav_bar.dart';
import 'package:new_flutter/shared/date_utils.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _conversationBloc = ConversationBloc();

  @override
  void dispose() {
    _conversationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 12.0, right: 12.0),
              child: StreamBuilder<List<Conversation>?>(
                stream: _conversationBloc.conversationStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final conversationList = snapshot.data!;
                    if (conversationList.isEmpty) {
                      return const Center(child: Text('No conversations'));
                    } else {
                      return ListView.separated(
                          itemCount: conversationList.length,
                          itemBuilder: (context, index) {
                            final item = conversationList[index];
                            return ConversationItem(name: item.name, preview: item.preview, timestamp: item.timestamp);
                          },
                          separatorBuilder: (context, index) => const Divider());
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _conversationBloc.addConversation();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavBar(
        context,
        currentIndex: 1,
      ),
    );
  }
}

class ConversationItem extends StatelessWidget {
  const ConversationItem({super.key, required this.name, required this.preview, required this.timestamp});

  final String name;
  final String preview;
  final int timestamp;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConversationAvatar(name: name),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child:
                          Text(name, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium)),
                  Text(DateTime.fromMillisecondsSinceEpoch(timestamp).toFormattedString,
                      style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
              Text(preview, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class ConversationAvatar extends StatelessWidget {
  const ConversationAvatar({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      child: Text(name[0], style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
