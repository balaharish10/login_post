import 'package:flutter/material.dart';
import 'package:login_post/networking.dart';
import 'constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_session/flutter_session.dart';
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
    String token = await FlutterSession().get("token");
    String email=await FlutterSession().get("email_id");
    NetworkHelper networkHelper = NetworkHelper(
        'https://skillbanc.com/ObjectTag/SearchPost?sessionId=$token&cname=Task App&oname=$email&c2name=Task&App ID=IP App');
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
          
          crossAxisCount: 1,
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


