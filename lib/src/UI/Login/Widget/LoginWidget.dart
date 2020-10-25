import 'dart:convert';

import 'package:MTApp/src/Data/Login/LoginDto.dart';
import 'package:MTApp/src/Data/Login/User.dart';
import 'package:MTApp/src/Data/Street/StreetDto.dart';
import 'package:MTApp/src/UI/Home/Page/HomePage.dart';
import 'package:MTApp/src/UI/Home/Page/IAHomeData.dart';
import 'package:MTApp/src/UI/Home/Page/LodeHomeData.dart';
import 'package:MTApp/src/UI/Home/Page/PoliceManHomeData.dart';
import 'package:MTApp/src/UI/Login/Page/signup.dart';
import 'package:MTApp/src/UI/Street/Page/LodeStreetData.dart';
import 'package:MTApp/src/UI/Street/Page/StreetList.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class LoginWidget {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  LoginDto login;
  User user = new User();
  Widget backButton(context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget entryField(String title, {bool isPassword = false}) {
    var myController;
    if (title == "Username") myController = username;
    if (title == "Password") myController = password;
    if (title == "Email") myController = email;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: myController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Future<void> userLogin() async {
    final uri = 'http://192.168.43.234/mtApi/api/Login';
    var map = new Map<String, dynamic>();
//    map['Username'] = username.text;
    map['Email'] = email.text;
    map['Password'] = password.text;
    Response response = await post(
      uri,
      body: map,
    );
    print(response.body);
    Map data = jsonDecode(response.body);
    login = LoginDto.fromJson(data);
    print(login.errorMessage);
  }

  Widget submitButton(context) {
    return InkWell(
      onTap: () async {
        await userLogin();
        print("password " + password.text);
        print("email " + email.text);
        if (login.data != null) {
          if (login.data.userTypeId == 1) {
            // Traffic Man
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PoliceManHomeData()));
          } else if (login.data.userTypeId == 2) {
            //Citizen
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LodeHomeData()));
          } else if (login.data.userTypeId == 3) {
            //InfrastructureAuthority}
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => IAHomeData()));
          }
        } else {
          Fluttertoast.showToast(
              msg: login.errorMessage.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              //webPosition: ,
              fontSize: 15.0);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 40,
          ),
        ],
      ),
    );
  }

  Widget facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget createAccountLabel(context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget title(context, title) {
    //String data = await user.getData();
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'MT',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 50,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Monitoring',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            TextSpan(
              text: title, // 'Traffic',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 20),
            ),
          ]),
    );
  }

  Widget emailPasswordWidget() {
    return Column(
      children: <Widget>[
        entryField("Email"),
        entryField("Password", isPassword: true),
      ],
    );
  }
}
