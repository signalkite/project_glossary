import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_glossary/definitionView.dart';

class SavedTermListView extends StatefulWidget {
  final savedTerms;
  final savedTermsNumber;
  final savedTermsIndex;
  const SavedTermListView(
      {this.savedTerms, this.savedTermsNumber, this.savedTermsIndex, Key? key})
      : super(key: key);

  @override
  State<SavedTermListView> createState() => _SaveState();
}

class _SaveState extends State<SavedTermListView> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _glossaryStream =
        FirebaseFirestore.instance.collection('glossary').orderBy('Terms').snapshots();

    // 즐겨찾기에 등록된 단어가 없을 경우
    if (widget.savedTerms.isEmpty)
      return Center(
        child: Text('즐겨찾기에 등록된 단어가 없습니다.'),
      );

    //즐겨찾기에 등록한 단어가 있을 때
    return StreamBuilder(
      stream: _glossaryStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapshot.data!.docs;

        return ListView.separated(
          itemCount: widget.savedTerms.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
          ),
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DefinitionView(
                        tappedTerm: docs[widget.savedTermsIndex[index]]['Terms'],
                        tappedTermSource: docs[widget.savedTermsIndex[index]]['Source'],
                        tappedTermDefinition: docs[widget.savedTermsIndex[index]]['Definition'],
                      );
                    },
                  ),
                );
              },
              title: Text(
                widget.savedTerms[index],
                style: TextStyle(fontSize: 20),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 20,
              ),
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(
                    () {
                      widget.savedTerms.remove(widget.savedTerms[index]);
                      widget.savedTermsIndex.remove(
                          widget.savedTermsIndex[index]);
                      widget.savedTermsNumber
                          .remove(widget.savedTermsNumber[index]);
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
