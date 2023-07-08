import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final user = _auth.currentUser;

void getCurrentUser() async {
  try {
    final uid = user?.uid;
    print("uid is " + uid!);
    if (user != null) {
      print(user?.email);
    }
  } catch (e) {
    print(e);
  }
}

class Chat_Screen extends StatefulWidget {
  static String routename = 'chat_screen';
  const Chat_Screen({super.key});

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  final meassageTextController = TextEditingController();

  String? messageText;
  String? mail;

  void iniState() {
    super.initState();
    getCurrentUser();
  }

  // void getCurrentUser() async {
  //   try {
  //     final user = await _auth.currentUser;
  //     final uid = user?.uid;
  //     print("uid is " + uid!);
  //     if (user != null) {
  //       print(user.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // CollectionReference _collectionRef =
  //     FirebaseFirestore.instance.collection('messages').snapshots();
  // Future<void> getData() async {
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //   final allData = querySnapshot.docs.map((e) => e.data()).toList();
  //   print(allData);
  // }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
              //messagesStream();
            },
            icon: Icon(Icons.close),
          )
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Color(0xFFCDD1C4),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // StreamBuilder<QuerySnapshot>(
            //     stream: _firestore.collection('messages').snapshots(),
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData) {
            //         return Center(
            //           child: CircularProgressIndicator(
            //             backgroundColor: Color(0xFF7E8D85),
            //           ),
            //         );
            //       }
            //       final messages = snapshot.data?.docs;
            //       List<MessageBubble> messagesBubble = [];
            //       for (var message in messages!) {
            //         var data = message.data() as Map;
            //         final messageText = data['text'];
            //         final messageSender = data['sender'];
            //         final messageBubble = MessageBubble(
            //           sender: messageSender,
            //           text: messageText,
            //         );
            //         messagesBubble.add(messageBubble);
            //       }
            //       return Expanded(
            //         child: ListView(
            //           padding: EdgeInsets.symmetric(
            //               horizontal: 10.0, vertical: 20.0),
            //           children: messagesBubble,
            //         ),
            //       );
            //     }),
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: meassageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      meassageTextController.clear();
                      final cuser = await _auth.currentUser;
                      _firestore.collection('messages').add({
                        'sender': cuser?.email,
                        'text': messageText,
                      });
                      print(User);
                    },
                    child: Text(
                      'Send',
                      style: KSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0xFF7E8D85),
            ),
          );
        }
        final messages = snapshot.data?.docs.reversed;
        List<MessageBubble> messagesBubble = [];
        for (var message in messages!) {
          var data = message.data() as Map;
          final messageText = data['text'];
          final messageSender = data['sender'];
          //final user = await _auth.currentUser;
          final currentUser = user!.email;
          if (currentUser == messageSender) {}
          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          messagesBubble.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messagesBubble,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.isMe});

  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Color(0xFFB3BFB8) : Color(0xFFB4ADEA),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
