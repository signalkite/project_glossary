import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({this.savedWordDocId, this.totalList, this.searchList, Key? key }) : super(key: key);
  final savedWordDocId;
  final totalList;
  final searchList;

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      //검색바에서 검색치 최대 5개 단어까지만 보이도록 설정
      itemCount: widget.searchList.length < 5 ? widget.searchList.length : 5,
      separatorBuilder: (context, index) => Divider(height: 1,),
      itemBuilder: (context, index){
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
          title: Text(
            '${widget.searchList[index]}',
            style: TextStyle(
              fontSize: 20
            ),  
          ),
          onTap: (){},
        );
      }, 
    );
  }
}