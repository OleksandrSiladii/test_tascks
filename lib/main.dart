import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_tacks/models/profile_data_model.dart';
import 'package:test_tacks/ui/tabs_page.dart';

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
        home: TabsPage(title: 'Test Tasks'),
      ),
    );
  }
}
