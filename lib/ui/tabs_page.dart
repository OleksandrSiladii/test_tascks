import 'package:flutter/material.dart';
import 'package:test_tacks/ui/profile_edit_page.dart';

class TabsPage extends StatefulWidget {
  TabsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: _createDrawer(),
        bottomNavigationBar: SizedBox(
          height: 60.0,
          child: ColoredBox(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: _drawProgressBar(),
          centerTitle: true,
        ),
        body: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: TabBar(
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(icon: Icon(Icons.check_box_outlined)),
                Tab(icon: Icon(Icons.watch_later_outlined)),
                Tab(icon: Icon(Icons.today_rounded)),
                Tab(icon: Icon(Icons.star_border)),
              ],
            ),
            body: TabBarView(
              children: [
                _getTabContent(
                  iconData: Icons.check_box_outlined,
                  title: 'check box outlined',
                  context: context,
                ),
                _getTabContent(
                  iconData: Icons.watch_later_outlined,
                  title: 'watch later outlined',
                  context: context,
                ),
                _getTabContent(
                  iconData: Icons.today_rounded,
                  title: 'today rounded',
                  context: context,
                ),
                _getTabContent(
                  iconData: Icons.star_border,
                  title: 'star border',
                  context: context,
                ),
              ],
            ),
          ),
        ));
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

  Widget _getTabContent(
      {@required IconData iconData,
      @required String title,
      @required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 300.0,
          color: Theme.of(context).colorScheme.primary,
        ),
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 35,
          ),
        )
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
