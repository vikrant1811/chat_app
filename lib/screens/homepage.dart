import 'package:app_chat/screens/chatpage.dart';
import 'package:app_chat/services/auth/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign user out
  void signOut() {
    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade100,

        actions: [
          //signOut button
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout),)
        ],
      ),
      body: _buildUserList(),
    );
  }
  // build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
       stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
         if(snapshot.hasError) {
           return const Center(child:  Text('Error'));
         }
         if(snapshot.connectionState == ConnectionState.waiting) {
           return const Center(child: Text('Loading...'));
         }

         return ListView(
           children: snapshot.data!.docs
               .map<Widget>((doc) => _buildUserListItem(doc)).toList(),
         );
      },
    );
  }

  // build individual user list items
 Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display all users except current user
   if(_auth.currentUser!.email != data['email']) {
     return ListTile(
       title: Row(
         children: [
           const Icon(Icons.person,size: 30,),
           const SizedBox(width: 10,),
           Text(
             data['email'],
             style: const TextStyle(
               fontSize: 20,color: Colors.black,
             ),
           ),
         ],

       ),
       onTap: () {
   //pass th clicked user's UID to the chat Page
   Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
       receiverUserEmail: data['email'],
       receiverUserID: data['uid'],
       ),
          ),
         );
       },
     );
   }
   else {
     return Container();
   }
 }
}
