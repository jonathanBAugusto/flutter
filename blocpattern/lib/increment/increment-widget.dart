import 'package:flutter/material.dart';

class IncrementWidget extends StatefulWidget {
  IncrementWidget({Key key}) : super(key: key);

  _IncrementWidgetState createState() => _IncrementWidgetState();
}

class _IncrementWidgetState extends State<IncrementWidget> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bloc'),
          centerTitle: true,
        ),
        body: Center(
          child: Text("Tocou no botão add $_count vezes"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => setState(() => _count++),
        ),
      ),
    );
  }
}
