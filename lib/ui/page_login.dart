import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_collections/attdn.dart';
import 'package:flutter_ui_collections/utils/utils.dart';
import 'package:flutter_ui_collections/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'page_forgotpass.dart';
import 'page_home.dart';
import 'page_signup.dart';
import 'page_search.dart';

class LoginPage extends StatefulWidget {

 
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _Formkey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  FocusNode _emailFocusNode = new FocusNode();
  FocusNode _passFocusNode = new FocusNode();
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery
        .of(context)
        .size);

    return Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle(
              statusBarColor: backgroundColor,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarColor: backgroundColor),

          child: Container(
            color: Colors.white,
            child: SafeArea(
              top: true,
              bottom: false,
              child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[


              ClipPath(
              clipper: BottomShapeClipper(),
              child: Container(
                  color: colorCurve,
                  )),
                    SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.getWidthPx(20),
                        vertical: size.getWidthPx(20)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          _loginGradientText(),
                          SizedBox(height: size.getWidthPx(10)),
                          _textAccount(),
                          SizedBox(height: size.getWidthPx(30)),
                          loginFields()
                        ]),
                  ),
                )
              ]),
            ),
          ),
        ));
  }

  RichText _textAccount() {
    return RichText(
      text: TextSpan(

          text: "For Teacher Account ",
          children: [
            TextSpan(
              style: TextStyle(color: Colors.deepOrange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              text: 'CLICK HERE.\n',
              recognizer: TapGestureRecognizer()
                ..onTap = () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())),
            )
          ],
          style: TextStyle(
              color: Colors.black87, fontSize: 20, fontFamily: 'Exo2')),
    );
  }

  GradientText _loginGradientText() {
    return GradientText('Login as Student',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(97, 6, 165, 1.0),
          Color.fromRGBO(45, 160, 240, 1.0)
        ]),
        style: TextStyle(fontFamily: 'Exo2',fontSize: 36, fontWeight: FontWeight.bold));
  }

  BoxField _emailWidget() {
    return BoxField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        hintText: "Enter Email ID",
        lableText: "Email",
        obscureText: false,
        onSaved: (String val) {
          _email = val;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_passFocusNode);
        },
        icon: Icons.mail,
        iconColor: colorCurve);
  }

  BoxField _passwordWidget() {
    return BoxField(
        controller: _passwordController,
        focusNode: _passFocusNode,
        hintText: "Enter Password",
        lableText: "Password",
        obscureText: true,
        icon: Icons.lock_outline,
        onSaved: (String val) {
          _password = val;
        },
        iconColor: colorCurve);
  }

  Container _loginButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
      width: size.getWidthPx(200),
      child: RaisedButton(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(size.getWidthPx(12)),
        child: Text(
          "LOGIN",
          style: TextStyle(fontFamily: 'Exo2',color: Colors.white, fontSize: 20.0),
        ),
        color: colorCurve,
        onPressed: () {
          signIn();
          //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          // Going to DashBoard

        },
      ),
    );
  }

//  Row _socialButtons() {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//
//        socialCircleAvatar("assets/icons/icnfb.png",(){}),
//        SizedBox(width: size.getWidthPx(18)),
//        socialCircleAvatar("assets/icons/icn_twitter.png",(){}),
//        SizedBox(width: size.getWidthPx(18)),
//        socialCircleAvatar("assets/icons/icngmail.png",(){}),
//      ],
//    );
//  }

  GestureDetector socialCircleAvatar(String assetIcon,VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(

        maxRadius: size.getWidthPx(24),
        backgroundColor: Colors.transparent,
        child: Image.asset(assetIcon),
      ),
    );
  }


  loginFields() =>
      Container(
        child: Form(
            key: _formKey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _emailWidget(),
                SizedBox(height: size.getWidthPx(8)),
                _passwordWidget(),
                GestureDetector(
                    onTap: () {
                      //Navigate to Forgot Password Screen...
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PageForgotPassword()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: size.getWidthPx(24)),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("Forgot Password?\n",
                              style: TextStyle(fontFamily: 'Exo2',fontSize: 16.0))),
                    )),
                SizedBox(height: size.getWidthPx(8)),
                _loginButtonWidget(),
                SizedBox(height: size.getWidthPx(28)),

                Text("", style: TextStyle(
                    fontFamily: 'Exo2', fontSize: 16.0, color: Colors.grey),
                ),
                SizedBox(height: size.getWidthPx(12)),
                //_socialButtons()

              ],
            )),
      );


  Future<void> signIn() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Firestore.instance.collection('users').document(_email).setData(
            {'Name': _email, 'Subject': '',});


        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }catch(e){

        print(e.message);
      }




    }
  }




}


