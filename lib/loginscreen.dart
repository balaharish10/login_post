import 'package:flutter/material.dart';
import 'package:login_post/activityscreen.dart';
import 'package:login_post/networking.dart';
import 'constants.dart';
import 'rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class loginscreen extends StatefulWidget {
  static String id="login screen";
  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  bool showSpinner = false;
 String email;
  String password;
  Future<bool> getstatus(String email,String pass) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://skillbanc.com/Account/LoginPost?UserName=$email&Password=$pass&appName=Skillbanc&mode=Login');
    var data = await networkHelper.getData();
    return data['successful'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.jpeg'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Login',
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
final bool status=await getstatus(email, password);
try {
  if (status == true) {
    Navigator.pushNamed(context, activityscreen.id);
  }
  else
    {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("invalid username or password"),
          content: Text("Enter valid credentials"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("okay"),
            ),
          ],
        ),
      );
    }
  setState(() {
    showSpinner = false;
  });
}
catch (e) {
  print(e);
}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


