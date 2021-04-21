import 'package:flutter/material.dart';
import 'package:flttrxmprout/api/User.dart';
import 'package:flttrxmprout/screens/User.dart';
import 'package:responsive_grid/responsive_grid.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  final String title;
  HomeScreen({required this.title}) : super();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<ApiUser>>(
          builder: (c, s) {
            if (s.hasError) print(s.error);
            return (s.hasData && s.data != null)
                ? _UsersListWidget(items: s.data)
                : Center(child: CircularProgressIndicator());
          },
          future: fetchAllDataBase()),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class _UsersListWidget extends StatelessWidget {
  final List<ApiUser>? items;
  _UsersListWidget({this.items});

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridRow(
      children: items!
          .map((e) =>
              ResponsiveGridCol(xs: 12, md: 6, lg: 4, child: _CardWidget(e)))
          .toList(),
    );
  }
}

class _CardWidget extends StatelessWidget {
  final ApiUser item;
  const _CardWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(this.item.name),
            subtitle: Text('UUID: ' + this.item.uuid),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Open'),
                onPressed: () {
                  Navigator.pushNamed(
                      context, UserScreen.routeName + "/" + this.item.uuid);
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
