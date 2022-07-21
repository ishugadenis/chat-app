import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection('chats/Cl5X2JTVBBOutWcz5PNo/messages')
            .snapshots() ,
        builder: (context, streamSnapshot) {
          if(streamSnapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data!.docs;
          return ListView.builder(

            itemCount: documents.length,
            itemBuilder: (ctx,i)=> Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[i]['test']),

            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
       onPressed:(){
         FirebaseFirestore.instance.collection('chats/Cl5X2JTVBBOutWcz5PNo/messages')
             .add({
           'test' :'This was aded on click'
         });
         // FirebaseFirestore.instance.collection('chats/Cl5X2JTVBBOutWcz5PNo/messages')
         //     .snapshots().listen((data) {
         //      print(data.docs[0]['test']);
         //   data.docs.forEach((document) {
         //     print(document['test']);
         //   });
         // });
       },
        child:Icon(Icons.add) ,

      ),
    );

  }
}
