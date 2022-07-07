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
  static List<String> savedWords = [];
  int _selectedIndex = 0;
  List _widgetOption = [
    ShowGlossary(savedWords: savedWords),
    Save(savedWords: savedWords),
    MyAccountScreen(savedWord: savedWords),
  ];
  List _appBarTitleOption = ['GMP Vocabulary', 'Save', 'Account'];
  bool isSearching = false;
  String searchingWord = '';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        
        // title: Text('GMP Glossary'),
        //로그아웃 버튼
        leading: IconButton(
          icon: isSearching ? Icon(Icons.arrow_back) : SizedBox(),
          onPressed: (){
            setState(() {
              isSearching = false;
            });
          }
        ),
        title: isSearching 
          ? TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(14, 0, 14, 0),
              border: OutlineInputBorder(),
              hintText: 'Search',
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value){
              setState(() {
                searchingWord = value;
              });
            },
          ) 
          : Text(_appBarTitleOption[_selectedIndex]),
        actions: [
          if(_selectedIndex == 0)
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                isSearching = true;
              }
              );
            },
          )
        ],
      ),
      body: Center(child: _widgetOption.elementAt(_selectedIndex)),
        // : Center(child: searchResult(searchingWord: searchingWord,)),
      bottomNavigationBar: BottomNavigationBar(
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
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
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account'
          ),
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
              contentPadding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 20,
              ),
              title: Text(
                '${docs[index]['text']}',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
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

class Save extends StatefulWidget {
  const Save({ this.savedWords, this.removeWords, Key? key }) : super(key: key);
  final savedWords;
  final removeWords;

  @override
  State<Save> createState() => _SaveState();
}

class _SaveState extends State<Save> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.savedWords.length,
      separatorBuilder: (context, index) => Divider(height: 1,),
      itemBuilder: (context, index){
        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          title: Text(widget.savedWords[index]),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              setState(() {
                widget.savedWords.removeAt(index);
              });
            },
          ),
        );
      }
    );
  }
}

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({ this.savedWord ,Key? key }) : super(key: key);

  final savedWord;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(FirebaseAuth.instance.currentUser!.email!),
          ElevatedButton(
            child: Text('로그아웃'),
            onPressed: (){
              FirebaseAuth.instance.signOut();
            }
          )
        ],
      )
    );
  }
}