import 'package:flutter/material.dart';
import 'package:project_glossary/glossaryScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignUpScreen = true;
  final _formkey = GlobalKey<FormState>();

  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryValidation(){
    final isValid = _formkey.currentState!.validate();
    if(isValid){
      _formkey.currentState!.save();
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => Glossary()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Text('GMP GLOSSARY',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Column(
                        children: [
                          Text(
                            '로그인',
                            style: TextStyle(
                              fontSize: 20,
                              color: isSignUpScreen
                                ? Colors.black
                                : Colors.blueAccent
                            ),
                          ),
                          if(!isSignUpScreen)
                          Container(
                            // margin: EdgeInsets.only(
                            //   top: 5
                            // ),
                            height: 2,
                            width: 70,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                      onTap: (){
                        setState(() {
                          isSignUpScreen = false;
                        });
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      child: Column(
                        children: [
                          Text(
                            '회원가입',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: isSignUpScreen
                                ? Colors.blueAccent
                                : Colors.black
                            ),
                          ),
                          if(isSignUpScreen)
                          Container(
                            // margin: EdgeInsets.only(
                            //   top: 5
                            // ),
                            height: 2,
                            width: 70,
                            color: Colors.blueAccent,
                          )
                        ],
                      ),
                      onTap: (){
                        setState(() {
                          isSignUpScreen = true;
                        });
                      },
                    ),
                  ],
                ),
            
            
                //로그인(Sign In)
                if(!isSignUpScreen)
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          key: ValueKey(1),
                          validator: (value){
                            if(value!.isEmpty || !value.contains('@')){
                              return 'Please type a valid email address';
                            }
                            return null;
                          },
                          onSaved: (value){
                            userEmail = value!;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )
                            ),
                            hintText: 'Email address',
                            contentPadding: EdgeInsets.all(20)
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          key: ValueKey(2),
                          validator: (value){
                            if(value!.isEmpty || value.length < 6){
                              return 'please type at least 6 characters';
                            }
                            return null;
                          },
                          onSaved: (value){
                            userPassword = value!;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )
                            ),
                            hintText: 'Password',
                            contentPadding: EdgeInsets.all(20)
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                
                //Signup
                if(isSignUpScreen)
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty || value.length < 6){
                              return 'please type at least 6 characters';
                            }
                            return null;
                          },
                          onSaved: (value){
                            userName = value!;
                          },
                          key: ValueKey(3),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )
                            ),
                            hintText: 'Username',
                            contentPadding: EdgeInsets.all(20)
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          key: ValueKey(4),
                          validator: (value){
                            if(value!.isEmpty || !value.contains('@')){
                              return 'Please type a valid email address';
                            }
                            return null;
                          },
                          onSaved: (value){
                            userEmail = value!;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )
                            ),
                            hintText: 'Email Address',
                            contentPadding: EdgeInsets.all(20)
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          key: ValueKey(5),
                          validator: (value){
                            if(value!.isEmpty || value.length < 6){
                              return 'Please type at least 6 characters';
                            }
                            return null;
                          },
                          onSaved: (value){
                            userPassword = value!;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )
                            ),
                            hintText: 'Password',
                            contentPadding: EdgeInsets.all(20)
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 40),
                  ),
                  child: isSignUpScreen
                    ? Text('Sign Up & Login')
                    : Text('Login'),
                  onPressed: (){
                    _tryValidation();
                  },
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}