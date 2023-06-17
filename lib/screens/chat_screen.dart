import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatefulWidget {

  static String id= 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth= FirebaseAuth.instance;
  final _firestore= FirebaseFirestore.instance;
   late User loggedInUSer;
   late String messageText;
   @override
   void initState(){
     super.initState();
     getCurrentUser();
   }
  void getCurrentUser() async{
    final user=  await _auth.currentUser!;
    try {
      if (user != null) {
        loggedInUSer = user;
        print(loggedInUSer.email);
      }
    } catch(e){
      print(e);
    }
  }
 // void getMessages() async{
    // final messages= await _firestore.collection('messages').get();
    // for(var message in messages.docs){
    //   print(message.data());
    // }
 // }
  void messageStream() async{
     await for(var snapshot in _firestore.collection('messages').snapshots()){
       for(var message in snapshot.docs){
         print(message.data());
       }
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messageStream();
                //getMessages();
               // _auth.signOut();
               // Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data?.docs;
                  List<Text> messageWidgets = [];

                  for (var message in messages!) {
                    final messageText = message['text'];
                    final messageSender = message['sender'];
                    final messageWidgetText = Text('$messageText from $messageSender');
                    messageWidgets.add(messageWidgetText);
                  }

                  return Column(
                    children: messageWidgets,
                  );
                } else {
                  // Handle the case when snapshot doesn't have data yet
                  return const CircularProgressIndicator();
                }
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                      messageText=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                       _firestore.collection('messages').add({
                         'text':messageText,
                         'sender':loggedInUSer.email,
                       });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
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
