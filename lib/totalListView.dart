import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_glossary/definitionScreen.dart';

class TotalListView extends StatefulWidget {
  @override
  State<TotalListView> createState() => _TotalListViewState();
  const TotalListView({this.savedWords, Key? key }) : super(key: key);
    final savedWords;
}

class _TotalListViewState extends State<TotalListView> {

  var queryResult = FirebaseFirestore.instance.collection('glossary').orderBy('Terms').snapshots();

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
            final alreadySaved = widget.savedWords.contains(docs[index]['Terms']);
            return ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return Definition(tappedItemIndex: index);
                  }));
              },
              contentPadding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 20,
              ),
              title: Text(
                '${docs[index]['Terms']}',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              trailing: IconButton(
                icon: !alreadySaved ? Icon(Icons.star_border) : Icon(Icons.star, color: Colors.amber),
                onPressed: (){
                  if(alreadySaved){
                    removeWord(docs[index]['Terms']);
                  } else {
                    saveWord(docs[index]['Terms']);
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