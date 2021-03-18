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
    count=data['count'];
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
          body:ModalProgressHUD(
            inAsyncCall: spinner,
            child: Container(
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("number of task:  $count",style:kSendButtonTextStyle,),
                  Column(
                    children: [
                      // taskstream(),
                    ],
                  )
                ],
              ),
            ),
          ));
  }

}
class taskstream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        List<Widget> tasks = [];
        for(int i=0;i<count;i++) {
          String tep=data['result']['Objects'][i]['O2Name'];
          Widget temp=Text("$tep");
          tasks.add(temp);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: tasks,
          ),
        );
      },
    );
  }
}





