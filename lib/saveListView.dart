import 'package:flutter/material.dart';
import 'package:project_glossary/definitionScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SaveListView extends StatefulWidget {
  const SaveListView({ this.savedWords, Key? key }) : super(key: key);
  final savedWords;

  @override
  State<SaveListView> createState() => _SaveState();
}

class _SaveState extends State<SaveListView> {


  @override
  Widget build(BuildContext context) {
    if(widget.savedWords.isEmpty)
    return Center(
      child: Text('등록된 단어가 없습니다.'),
    );
    return ListView.separated(
      itemCount: widget.savedWords.length,
      separatorBuilder: (context, index) => Divider(height: 1,),
      itemBuilder: (context, index){
        return ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return Definition(tappedItemIndex: index);
              }
            ));
          },
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