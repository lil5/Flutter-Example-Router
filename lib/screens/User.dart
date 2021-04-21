import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/two';

  final String uuid;
  UserScreen({required this.uuid});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Color pickerColor = Color(0xffffff);
  Color bkColor = Color(0xffffffff);

  String get imageUrl {
    var hex = bkColor.value.toRadixString(16).padLeft(6, '0').substring(2);
    return "https://dummyimage.com/640x360/$hex/aaa";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User"),
        ),
        body: Column(
          children: [
            Text(widget.uuid), // widget is the UserScreen instance.
            MaterialPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color c) {
                setState(() {
                  bkColor = c;
                });
              },
            ),
            Image.network(imageUrl, fit: BoxFit.fitWidth),
          ],
        ));
  }
}
