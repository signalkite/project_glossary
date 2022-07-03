import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Glossary extends StatefulWidget {
  const Glossary({ Key? key }) : super(key: key);

  @override
  State<Glossary> createState() => _GlossaryState();
}

class _GlossaryState extends State<Glossary> {
  final _authentication = FirebaseAuth.instance;

  //저장한 단어 리스트
  static List<String> savedWords = [];
  
  int _selectedIndex = 0;
  List _widgetOption = [
    ShowGlossary(savedWords: savedWords),
    Save(savedWords: savedWords),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GMP Glossary'),
        //로그아웃 버튼
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
        child: _widgetOption.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Save'
          )
        ],
      ),
    );
  }
}

class ShowGlossary extends StatefulWidget {
  @override
  State<ShowGlossary> createState() => _ShowGlossaryState();
  const ShowGlossary({this.savedWords, Key? key }) : super(key: key);
    final savedWords;
}

class _ShowGlossaryState extends State<ShowGlossary> {

  var queryResult = FirebaseFirestore.instance.collection('glossary/V1Fdt2Ot7xAMobV16ycl/words').snapshots();

  void saveWord(String word){
    setState(() {
      widget.savedWords.add(word.toString());
    });
  }

  void removeWord(String word){
    setState(() {
      widget.savedWords.remove(word.toString());
    });
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: queryResult,
      builder: (context, 
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapShot){
        if(snapShot.hasError){
          return Text('Something went wrong');
        }
        
        if(snapShot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        
        final docs = snapShot.data!.docs;
        return ListView.separated(
          itemCount: docs.length,
          separatorBuilder: (context, index) => Divider(height: 1,),
          itemBuilder: (context, index){
            final alreadySaved = widget.savedWords.contains(docs[index]['text']);
            return ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              title: Text('${docs[index]['text']}'),
              trailing: IconButton(
                icon: !alreadySaved ? Icon(Icons.star_border) : Icon(Icons.star, color: Colors.amber),
                onPressed: (){
                  if(alreadySaved){
                    removeWord(docs[index]['text']);
                  } else {
                    saveWord(docs[index]['text']);
                  }
                },
              ),
            );
          }
        );
      },
    );
  }
}

class Save extends StatelessWidget {
  const Save({ this.savedWords, Key? key }) : super(key: key);
  
  final savedWords;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: savedWords.length,
      separatorBuilder: (context, index) => Divider(height: 1,),
      itemBuilder: (context, index){
        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          title: Text(savedWords[index]),
        );
      }
    );
  }
}