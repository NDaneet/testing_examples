import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/message_dao.dart';
import '../data/user_dao.dart';
import '../data/message.dart';
import 'message_display.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? email;
  bool hasValue = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
    final messageDAO = MessageDAO();
    //TODO: Modify the MessageDAO back to provider
    //Provider.of<MessageDAO>(context, listen: false);
    final userDAO = Provider.of<UserDAO>(context, listen: false);
    email = userDAO.email();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Simple App"),
          actions: <Widget>[
            IconButton(
              onPressed: () => userDAO.logout(),
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: Column(children: [
          Expanded(child: _getMessageList(messageDAO)),
          Center(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildTextCard(context, messageDAO)),
                const SizedBox(
                  width: 2,
                ),
                IconButton(
                  iconSize: 30,
                  onPressed: () => _sendMessage(messageDAO),
                  icon: setTextFieldValue(),
                )
              ],
            ),
          )
        ]));
  }

  Widget _buildTextCard(BuildContext context, MessageDAO messageDAO) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: TextField(
          maxLines: null,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          controller: _messageController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Message",
          ),
          onSubmitted: (_) => _sendMessage(messageDAO),
        ),
      ),
    );
  }

  void _sendMessage(MessageDAO messageDAO) {
    if (_canSendMessage()) {
      final message = Message(
          text: _messageController.text,
          timeStamp: DateTime.now(),
          email: email);
      messageDAO.sendMessage(message);
      _messageController.clear();
      setState(() {});
    }
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final message = Message.fromSnapshot(snapshot);
    return MessageDisplay(
      text: message.text,
      timeStamp: message.timeStamp,
      email: email,
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return ListView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      //TODO: probably add padding
      children: snapshot!
          .map(
            (item) => _buildListItem(context, item),
          )
          .toList(),
    );
  }

  Widget _getMessageList(MessageDAO messageDAO) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: messageDAO.getMessageStream(),
        builder: (context, snapshot) {
          // TODO: add other connection states
          if (snapshot.hasData) {
            //TODO: try and remove the context argument from all the build and see the effect
            return _buildList(context, snapshot.data!.docs);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  bool _canSendMessage() => _messageController.text.isNotEmpty;

  Widget setTextFieldValue() {
    setState(() {
      hasValue = _messageController.text.isNotEmpty;
    });
    return hasValue
        ? const Icon(
            Icons.send,
          )
        : const Spacer();
  }

  void _scrollToEnd() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}
