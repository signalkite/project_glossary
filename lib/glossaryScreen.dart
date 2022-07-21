import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_glossary/savedTermListView.dart';
import 'package:project_glossary/totalListView.dart';
import 'package:project_glossary/searchListView.dart';

class Glossary extends StatefulWidget {
  const Glossary({Key? key}) : super(key: key);

  @override
  State<Glossary> createState() => _GlossaryState();
}

class _GlossaryState extends State<Glossary> {
  static List<String> savedTerms = [];
  static List<int> savedTermsIndex = [];
  static List<int> savedTermsNumber = [];

  int _selectedIndex = 0;
  List _widgetOption = [
    TotalListView(
      savedTerms: savedTerms,
      savedTermsIndex: savedTermsIndex,
      savedTermsNumber: savedTermsNumber,
    ),
    SavedTermListView(
      savedTerms: savedTerms,
      savedTermsIndex: savedTermsIndex,
      savedTermsNumber: savedTermsNumber,
    ),
    MyAccountScreen(),
  ];
  List _appBarTitleOption = ['GMP 용어사전', '즐겨찾기', '설정'];
  bool isSearching = false;
  String searchingWord = '';

  List<String> totalList = [];
  List<String> searchList = [];

  Future<void> getData() async {
    // Get docs from collection reference
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('glossary');
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.forEach((doc) {
      totalList.add(doc['Terms']);
    });
    print('list has been downloaded');
  }

  @override
  void initState() {
    // 파이어베스트 사용량이 많아져서 현재 사용X(방법 찾고 있음)
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: !isSearching ? SizedBox() : Icon(Icons.arrow_back),
          onPressed: () {
            setState(
              () {
                isSearching = false;
              },
            );
          },
        ),
        title: !isSearching
            ? Text(_appBarTitleOption[_selectedIndex])
            : TextField(
                autofocus: true,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                  border: OutlineInputBorder(),
                  hintText: '검색어를 입력하세요',
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (String value) {
                  setState(() {
                    for (String terms in totalList) {
                      if (value.isEmpty) {
                        searchList.clear();
                      } else if (terms
                          .toLowerCase()
                          .contains(value.toLowerCase())) {
                        if (searchList.contains(terms)) {
                          continue;
                        } else {
                          searchList.add(terms);
                        }
                      } else {
                        searchList.remove(terms);
                      }
                    }
                  });
                },
              ),
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(
                  () {
                    isSearching = true;
                    searchList.clear();
                  },
                );
              },
            )
        ],
      ),
      body: !isSearching
          ? Center(child: _widgetOption.elementAt(_selectedIndex))
          : Center(
              child:
                  SearchListView(totalList: totalList, searchList: searchList),
            ),
      bottomNavigationBar: BottomNavigationBar(
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(
            () {
              _selectedIndex = index;
              isSearching = false;
            },
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '단어찾기',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: '즐겨찾기'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: '설정'),
        ],
      ),
    );
  }
}

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(FirebaseAuth.instance.currentUser!.email!),
          ElevatedButton(
            child: Text('로그아웃'),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
    );
  }
}
