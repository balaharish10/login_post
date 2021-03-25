import 'package:flutter/material.dart';
import 'package:login_post/networking.dart';
import 'constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
var data;
int count;
class activityscreen extends StatefulWidget {
  static String id='activity';
  @override
  _activityscreenState createState() => _activityscreenState();
}

class _activityscreenState extends State<activityscreen> {
  bool spinner=false;
  void updateUI() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://skillbanc.com/ObjectTag/SearchPost?sessionId=d3192ad5-3532-40ce-8133-10984d43655c&cname=Task App&oname=samy.balaharish@gmail.com&c2name=Task&App ID=IP App');
    data = await networkHelper.getData();
    setState(() {
      count=data['count'];
    });

  }
  @override
  void initState()  {
    super.initState();
    updateUI();

  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text("number of task : $count"),

        ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 1,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(count, (index) {
            return Center(
              child: Text(
               data['result']['Objects'][index]['O2Name'],
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }),
        ),
          );
  }

}


// ['result']['Objects'][i]['O2Name'];


