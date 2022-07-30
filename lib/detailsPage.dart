import 'package:flutter/material.dart';

import 'kelimeler.dart';

class DetailsPage extends StatefulWidget {
  Kelimeler kelime;
  DetailsPage({Key? key, required this.kelime}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detay Sayfa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  <Widget>[
            Text(widget.kelime.ingilizce, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            Text(widget.kelime.turkce,style: TextStyle(fontSize: 20),),
          ],
        ),
      ),

    );
  }
}
