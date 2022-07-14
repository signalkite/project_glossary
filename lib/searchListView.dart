import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({this.savedWords, this.totalList, this.searchList, Key? key }) : super(key: key);
  final savedWords;
  final totalList;
  final searchList;

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {



  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.searchList.length,
      separatorBuilder: (context, index) => Divider(height: 1,),
      itemBuilder: (context, index){
        return ListTile(
          title: Text('${widget.searchList[index]}'),
          onTap: (){},
        );
      }, 
    );
  }
}