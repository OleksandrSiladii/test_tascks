import 'package:flutter/material.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
