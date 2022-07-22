import 'package:flutter/material.dart';

class DefinitionView extends StatelessWidget {
  final tappedTerm;
  final tappedTermSource;
  final tappedTermDefinition;
  const DefinitionView({
    this.tappedTerm,
    this.tappedTermDefinition,
    this.tappedTermSource,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    tappedTerm,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
                DefaultTabController(
                  length: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.black,
                          labelStyle: TextStyle(fontSize: 16),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[200],
                          ),
                          tabs: <Widget>[
                            Tab(
                              text: "FDA",
                            ),
                            Tab(
                              text: "EMA",
                            ),
                            Tab(
                              text: "ICH",
                            ),
                          ],
                        ),

                        // Text(
                        //   tappedTermSource,
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    tappedTermDefinition,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
