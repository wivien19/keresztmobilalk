import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sale_manager/l10n/l10n.dart';
import 'package:sale_manager/providers/counter_provider.dart';
import '/screens/product_list.dart';
import '/product.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvide;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvide.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ProductAdapter());

  final cameras = await availableCameras();

  final camera = cameras.length > 0 ? cameras.first : null;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Counter()),
    Provider.value(value: camera),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Manager',
      theme: ThemeData(
        backgroundColor: Colors.pinkAccent[100],
      ),
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: ProductListScreen(),
    );
  }
}
