import 'package:flutter/material.dart';

class Glossary extends StatelessWidget {
  const Glossary({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GMP Glossary'),
      ),
      body: Center(
        child: Text('body'),
      ),
    );
  }
}