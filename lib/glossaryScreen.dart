import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Glossary extends StatefulWidget {
  const Glossary({ Key? key }) : super(key: key);

  @override
  State<Glossary> createState() => _GlossaryState();
}

class _GlossaryState extends State<Glossary> {

  final _authentication = FirebaseAuth.instance;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_authentication.currentUser!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GMP Glossary'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app
            ),
            onPressed: (){
              _authentication.signOut();
              Navigator.pop(context);
            }
          )
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('glossary/V1Fdt2Ot7xAMobV16ycl/words').snapshots(),
          builder: (context, 
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> Snapshot){
            if(Snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final docs = Snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index){
                return Container(
                  child: Text(
                    docs[index]['text']
                  ),
                );
              }
            );
          },
        )
      ),
    );
  }
}