import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat_Screen extends StatefulWidget {
  static String routename = 'chat_screen';
  const Chat_Screen({super.key});

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? messageText;
  String? mail;

  void iniState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      final uid = user?.uid;
      print("uid is " + uid!);
      if (user != null) {
        print(user.email);
      }
    } catch (e) {
      print(e);
    }
  }

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
              // _auth.signOut();
              // Navigator.pop(context);
              messagesStream();
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
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
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
            )
          ],
        ),
      ),
    );
  }
}
