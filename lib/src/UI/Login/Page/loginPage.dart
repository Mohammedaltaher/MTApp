import 'package:MTApp/src/Data/Login/User.dart';
import 'package:MTApp/src/UI/Login/Widget/CommonWidget.dart';
import 'package:MTApp/src/UI/Login/Widget/LoginWidget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginWidget w = new LoginWidget();
  CommonWidget c = new CommonWidget();

  var title = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: c.bezierContainer(context)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  w.title(context, title),
                  SizedBox(height: 20),
                  w.emailPasswordWidget(),
                  SizedBox(height: 20),
                  w.submitButton(context),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  w.divider(),
                  w.facebookButton(),
                  SizedBox(height: height * .055),
                  w.createAccountLabel(context),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: w.backButton(context)),
        ],
      ),
    ));
  }
}
