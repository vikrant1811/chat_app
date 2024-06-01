import 'package:app_chat/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ChatService extends ChangeNotifier {
  //get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Send message
 Future<void> sendMessage(String receiverId, String message) async {
   // get user info
   final String currentUserid = _firebaseAuth.currentUser!.uid;
   final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
   final Timestamp timestamp = Timestamp.now();

   // create a new message
   Message newMessage =Message(
       senderId: currentUserid,
       senderEmail: currentUserEmail,
       receiverId: receiverId,
       message: message,
       timestamp: timestamp
   );

   //construct chat room id from current user ud and receiver id (sorted to ensure uniqueness)
   List<String> ids = [currentUserid, receiverId];
   ids.sort();//sort the ids (this ensures the chat room id is always the same for any pair of people
   String chatRoomId = ids.join("_"); // combine the ids into a single string to use as a chatroom



   // add new message to the database
   await _firestore
       .collection('chat_rooms')
       .doc(chatRoomId).collection('message')
       .add(newMessage.toMap());
 }
   //get message
   Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
   // construct chatroom id from ids (sorted to ensure it matches the id used when sending)
   List<String> ids = [userId, otherUserId];
   ids.sort();
   String chatRoomId = ids.join("_");

   return _firestore.
   collection('chat_rooms')
       .doc(chatRoomId)
       .collection('message')
       .orderBy('timestamp', descending: false).snapshots();
   }
}