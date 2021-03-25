import 'package:flutter/material.dart';
import 'package:login_post/activityscreen.dart';
import 'package:login_post/networking.dart';
import 'package:login_post/registrationscreen.dart';
import 'constants.dart';
import 'rounded_button.dart';
import 'activityscreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_session/flutter_session.dart';

class loginscreen extends StatefulWidget {
  static String id="login screen";


  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {

  bool showSpinner = false;
  bool isHiddenPassword=true;
  String email;
  String password;
  static String session_id;
  Future<bool> getstatus(String email,String pass)  async{

      NetworkHelper networkHelper = NetworkHelper(
          'https://skillbanc.com/Account/LoginPost?UserName=${email.replaceAll(' ', '')}&Password=$pass&appName=Skillbanc&mode=Login');
      var data = await networkHelper.getData();
      session_id=data['id'];
      var session = FlutterSession();
      await session.set("token", session_id);
      await session.set("email_id", email);


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
                obscureText: isHiddenPassword,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                    suffixIcon:InkWell(
                        onTap: _togglePasswordView,
                        child: isHiddenPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                    )),
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
  void _togglePasswordView() {
    setState(() {
      isHiddenPassword=!isHiddenPassword;
    });
  }
}


