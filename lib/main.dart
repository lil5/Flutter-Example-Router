import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'dart:developer';

import 'screens/User.dart';
import 'screens/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  FluroRouter router = FluroRouter();

  MyAppState() {
    defineRoutes(router);
  }

  void defineRoutes(FluroRouter router) {
    router.define("/",
        handler: Handler(
            handlerFunc: (_, __) =>
                HomeScreen(title: 'Flutter Demo Home Page')));

    router.define("/two/:uuid", handler: Handler(handlerFunc: (c, params) {
      var dbParam = params["uuid"]?.first;

      log('data: $params');
      if (dbParam != null) {
        return UserScreen(uuid: dbParam);
      }

      return _UnknownScreen();
    }));

    router.notFoundHandler = Handler(handlerFunc: (_, __) => _UnknownScreen());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example Router',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generator,
    );
  }
}

class _UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          Text('404!'),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"))
        ],
      )),
    );
  }
}
