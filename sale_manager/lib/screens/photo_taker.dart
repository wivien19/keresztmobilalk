import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sale_manager/screens/profile_picture.dart';

import 'camera_manager.dart';

class TakeProfilePictureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var camera = context.watch<CameraDescription?>();
    if (camera == null) {
      return CircularProgressIndicator();
    }
    return TakeProfilePicture(camera: camera);
  }
}

class TakeProfilePicture extends StatefulWidget {
  final CameraDescription camera;

  TakeProfilePicture({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  _TakeProfilePictureState createState() => _TakeProfilePictureState();
}

class _TakeProfilePictureState extends State<TakeProfilePicture> {
  late Future<void> _initializeControllerFuture;
  late CameraManager cameraManager;

  void initState() {
    super.initState();

    cameraManager = CameraManager(camera: widget.camera);
    _initializeControllerFuture = cameraManager.initialize();
  }

  @override
  void dispose() {
    cameraManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${AppLocalizations.of(context)!.selfie.toString()}"),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(cameraManager.cameraController);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent[100],
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final path =
                join((await getApplicationDocumentsDirectory()).path, 'me.png');
            final file = File(path);
            if (file.existsSync()) {
              file.deleteSync();
            }

            final picture = await cameraManager.cameraController.takePicture();
            final pictureFile = File(picture.path);
            await pictureFile.copy(file.path);

            Navigator.push(
                context, MaterialPageRoute(builder: (_) => ProfilePicture()));
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
