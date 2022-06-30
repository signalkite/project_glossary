import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignUpScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('GMP GLOSSARY',
              style: TextStyle(
                fontSize: 24.0
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Column(
                    children: [
                      Text(
                        'Sign In',
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
                  width: 10.0,
                ),
                GestureDetector(
                  child: Column(
                    children: [
                      Text(
                        'Sign Up',
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


            //Signin
            if(!isSignUpScreen)
            Container(
              padding: EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        // prefixIcon: Icon(
                        //   Icons.account_circle,
                        // ),
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
                      decoration: InputDecoration(
                        // prefixIcon: Icon(
                        //   Icons.lock,
                        // ),
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
            if(isSignUpScreen)
            Container(
              padding: EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
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
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
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
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
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
                  ],
                ),
              )
            ),
            if(isSignUpScreen)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 40),
              ),
              child: Text('Sign Up'),
              onPressed: (){},
            ),
            if(!isSignUpScreen)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 40),
              ),
              child: Text('Sign In'),
              onPressed: (){},
            ),
          ],
        )
      ),
    );
  }
}