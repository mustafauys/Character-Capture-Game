import 'package:flutter/material.dart';
import 'package:knowledge_treasure/services/auth.dart';
import 'package:knowledge_treasure/views/home.dart';
import 'package:knowledge_treasure/views/signin.dart';
import 'package:knowledge_treasure/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  String email, password,name;
  AuthService authService = new AuthService();
  bool _isLoading= false;

  signUp() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      authService.signUpWithEmailAndPassword(email, password).then((value){
        if (value != null) {
          setState(() {
        _isLoading = false;
      });
          Navigator.pushReplacement(context, MaterialPageRoute (
            builder: (context) => Home(),
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading ? Container (
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              Spacer(),
              TextFormField(
                  validator: (val){return val.isEmpty ? "Enter Name" : null;},
                  decoration: InputDecoration(
                    hintText: "Name"
                  ),
                  onChanged: (val){
                    name = val;
                  },
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val){return val.isEmpty ? "Enter Email id" : null;},
                  decoration: InputDecoration(
                    hintText: "Email"
                  ),
                  onChanged: (val){
                    email = val;
                  },
                ),
                SizedBox(height: 6,),

                TextFormField(
                  obscureText: true,
                  validator: (val){return val.isEmpty ? "Enter Password" : null;},
                  decoration: InputDecoration(
                    hintText: "Password"
                  ),
                  onChanged: (val){
                    password = val;
                  },
                ),
                SizedBox(height: 24,),
                  GestureDetector(
                    onTap: () {
                      signUp();
                    },
                      child: blueButton(context, "Sign Up"),
                  ),
                  SizedBox(height: 18,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Alread have an account? ", style: TextStyle(fontSize: 15.5),),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => SignIn()
                          ));
                          
                        },
                        child: Text("Sign In",style: TextStyle(fontSize: 15.5, decoration: TextDecoration.underline),)),
                    ],
                  ),


                SizedBox(height: 80,),
            ],
          ),
        ),
      ),
    );
  }
}