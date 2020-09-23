import 'package:MTApp/src/UI/Login/Page/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class SignUpWidget {
  final fullName = TextEditingController();
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

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
    if (title == "Full Name") myController = fullName;
    if (title == "Username") myController = username;
    if (title == "Phone Number") myController = phoneNumber;
    if (title == "Email") myController = email;
    if (title == "Password") myController = password;
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

  Future<void> registorNewUser() async {
    final uri = 'http://192.168.8.185:8040/api/Users';
    var map = new Map<String, dynamic>();
    map['FullName'] = fullName.text;
    map['Username'] = username.text;
    map['PhoneNumber'] = phoneNumber.text;
    map['Email'] = email.text;
    map['Password'] = password.text;
    Response response = await post(
      uri,
      body: map,
    );
    print(response.body);
  }

  Widget submitButton(context) {
    return InkWell(
        onTap: () {
          registorNewUser();
          // print("fullName " + fullName.text);
          // print("password " + password.text);
          //post1();
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
            'Register Now',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  Widget loginAccountLabel(context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
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

  Widget title(context) {
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
              text: 'Traffic',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 20),
            ),
          ]),
    );
  }

  Widget emailPasswordWidget() {
    return Column(
      children: <Widget>[
        entryField("Full Name"),
        entryField("Username"),
        entryField("Phone Number"),
        entryField("Email"),
        entryField("Password", isPassword: true),
      ],
    );
  }
}
