import 'package:MTApp/src/UI/Login/Widget/CommonWidget.dart';
import 'package:MTApp/src/UI/Login/Widget/SignUpWidget.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpWidget w = new SignUpWidget();
  CommonWidget c = new CommonWidget();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: c.bezierContainer(context),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    w.title(context),
                    SizedBox(
                      height: 30,
                    ),
                    w.emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    w.submitButton(context),
                    SizedBox(height: height * .14),
                    w.loginAccountLabel(context),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: w.backButton(context)),
          ],
        ),
      ),
    );
  }
}
