import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_glossary/definitionView.dart';

class TotalListView extends StatefulWidget {
  @override
  State<TotalListView> createState() => _TotalListViewState();

  // final savedWordDocId;
  final savedTerms;
  final savedTermsNumber;
  final savedTermsIndex;

  const TotalListView({
    this.savedTerms,
    this.savedTermsNumber,
    this.savedTermsIndex,
    Key? key,
  }) : super(key: key);
}

class _TotalListViewState extends State<TotalListView> {
  Stream<QuerySnapshot> _glossaryStream = FirebaseFirestore.instance
      .collection('glossary')
      .orderBy('Terms')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _glossaryStream,
      builder: (context, AsyncSnapshot snapShot) {
        if (snapShot.hasError) {
          return Text('Something went wrong');
        }

        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapShot.data!.docs;

        return ListView.separated(
          key: PageStorageKey('pageOne'),
          itemCount: docs.length,
          separatorBuilder: (context, index) => Divider(height: 1),
          itemBuilder: (context, index) {
            // final alreadySaved =
            //     widget.savedWordDocId.contains(docs[index].id);
            final saved = widget.savedTermsNumber.contains(docs[index]['No']);
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DefinitionView(
                        tappedTerm: docs[index]['Terms'],
                        tappedTermDefinition: docs[index]['Definition'],
                        tappedTermSource: docs[index]['Source'],
                      );
                    },
                  ),
                );
              },
              contentPadding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 20,
              ),
              title: Text(
                '${docs[index]['Terms']}',
                style: TextStyle(fontSize: 20),
              ),
              trailing: IconButton(
                icon: !saved
                    ? Icon(Icons.star_border)
                    : Icon(Icons.star, color: Colors.amber),
                onPressed: () {
                  if (!saved) {
                    setState(
                      () {
                        widget.savedTerms.add(docs[index]['Terms']);
                        widget.savedTermsNumber.add(docs[index]['No']);
                        widget.savedTermsIndex.add(index);
                        print(widget.savedTermsNumber);
                      },
                    );
                  } else {
                    setState(
                      () {
                        widget.savedTerms.remove(docs[index]['Terms']);
                        widget.savedTermsNumber.remove(docs[index]['No']);
                        widget.savedTermsIndex.remove(index);
                        print(widget.savedTermsNumber);
                      },
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
