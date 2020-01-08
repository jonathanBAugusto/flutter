import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final double size = 500;
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple,
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      child: Container(
                        color: Colors.yellow,
                      ),
                      width: size,
                      height: size,
                    ),
                    SizedBox(
                      child: Container(
                        color: Colors.red,
                      ),
                      width: size,
                      height: size,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      child: Container(
                        color: Colors.blue,
                      ),
                      width: size,
                      height: size,
                    ),
                    SizedBox(
                      child: Container(
                        color: Colors.green,
                      ),
                      width: size,
                      height: size,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
