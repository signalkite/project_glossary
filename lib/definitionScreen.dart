import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Definition extends StatefulWidget {
  const Definition({@required this.tappedItemIndex, Key? key }) : super(key: key);

  final tappedItemIndex;

  @override
  State<Definition> createState() => _DefinitionState();
}

class _DefinitionState extends State<Definition> {

  final queryResult = FirebaseFirestore.instance.collection('csvjson').orderBy('Terms');

  Future getData(int i, String field) async {
    QuerySnapshot querySnapshot = await queryResult.get();
    final data = querySnapshot.docs[i][field];
    return data;
  }

  getFieldData(String fieldName, double fontSize, FontWeight fontweight){
    return FutureBuilder(
      future: getData(widget.tappedItemIndex, fieldName),
      builder: (context, snapshot){
        if (snapshot.hasData == false) {
          return CircularProgressIndicator();
        }
        //error가 발생하게 될 경우 반환하게 되는 부분
        else if (snapshot.hasError) {
          return Text(
            'Error: ${snapshot.error}',
            style: TextStyle(fontSize: fontSize, fontWeight: fontweight),
          );
        } else {
          return Text(
            snapshot.data.toString(),
            style: TextStyle(fontSize: fontSize, fontWeight: fontweight),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: getFieldData('Terms', 30, FontWeight.bold)
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: getFieldData('Designation', 18, FontWeight.normal),
            ),
            getFieldData('Definition', 18, FontWeight.normal),
          ],
        ),
      ),
    );
  }
}