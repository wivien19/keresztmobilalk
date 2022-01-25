import 'package:flutter/material.dart';

class Infos extends StatefulWidget {
  const Infos({Key? key}) : super(key: key);

  @override
  _InfosState createState() => _InfosState();
}

class _InfosState extends State<Infos> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Infos',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pinkAccent[100],
            title: Text('Infos about'),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'This is a flutter project at University of Szeged.',
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    child: Text('Leave a comment'),
                    onPressed: () {
                      openDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent[100], // background
                      // foreground
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Thank you'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Write here...'),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Send'))
          ],
        ),
      );
}
