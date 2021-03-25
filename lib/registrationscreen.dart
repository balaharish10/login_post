import 'package:flutter/material.dart';
import 'activityscreen.dart';
import 'constants.dart';
import 'package:login_post/networking.dart';
import 'rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class registrationscreen extends StatefulWidget {
  static String id="reg screen";

  @override
  _registrationscreenState createState() => _registrationscreenState();
}

class _registrationscreenState extends State<registrationscreen> {
  bool showSpinner = false;
  bool isHiddenPassword=true;
  String email;
  String confirmPassword;
  String password;
  String ses1;
  Future<bool> getstatus(String email,String pass)  {
    setState(() async{
      NetworkHelper networkHelper = NetworkHelper(
          'https://skillbanc.com/Account/LoginPost?UserName=${email.replaceAll(' ', '')}&Password=$pass&appName=Skillbanc&mode=Register');
      var data = await networkHelper.getData();
      ses1=data['id'];
    });
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
                height: 8.0,
              ),
              TextField(
                obscureText: isHiddenPassword,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  confirmPassword = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Confirm your password',
                    suffixIcon:InkWell(
                        onTap: _togglePasswordView,
                        child: isHiddenPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                    )),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  final bool status=await getstatus(email, password);
                  try {
                    if (status == true && confirmPassword == password) {
                      Navigator.pushNamed(context, activityscreen.id);
                    }
                    else
                    {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Password not matching"),
                          content: Text("Password and Confirm password must be a match"),
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