import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_tacks/profile_data_model.dart';
import 'package:test_tacks/profile_edit_page.dart';
import 'package:test_tacks/tabs_page.dart';

void main() => runApp(TestTasks());

class TestTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<ProfileDataModel>(
      create: (BuildContext context) => ProfileDataModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'Patua One',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Test Tasks'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: _createDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: _drawProgressBar(),
          centerTitle: true,
        ),
        body: TabsPage());
  }

  Widget _createDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 120.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: null,
            ),
          ),
          ListTile(
            title: Text('Tabs'),
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                fullscreenDialog: true,
                builder: (context) => ProfileEditPage(),
              ));
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _drawProgressBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _addProgressBox(Colors.amber),
        _addProgressBox(Colors.amber),
        _addProgressBox(Colors.amber),
        _addProgressBox(Colors.white),
      ],
    );
  }

  Widget _addProgressBox(Color color) {
    return Row(
      children: [
        SizedBox(
          width: 55.0,
          height: 8.0,
          child: ColoredBox(color: color),
        ),
        SizedBox(
          width: 5.0,
          height: 8.0,
        )
      ],
    );
  }
}
