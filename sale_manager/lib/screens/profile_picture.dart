import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? image;

  @override
  void initState() {
    super.initState();
    initImage();
  }

  Future<void> initImage() async {
    final path =
        join((await getApplicationDocumentsDirectory()).path, 'me.png');
    final file = File(path);
    if (file.existsSync()) {
      setState(() {
        image = file;
      });
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            child: CircleAvatar(
                radius: 200,
                backgroundColor: Colors.white,
                backgroundImage: image?.existsSync() == true
                    ? Image.memory(
                        image!.readAsBytesSync(),
                        fit: BoxFit.fill,
                      ).image
                    : null,
                child: image?.existsSync() != true
                    ? Icon(
                        Icons.account_circle_outlined,
                        size: 200,
                        color: Colors.black,
                      )
                    : null),
          ),
        ),
      ],
    );
  }
}
