import 'package:flutter/material.dart';
import 'package:project_glossary/glossaryScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignUpScreen = true;
  bool showSpinner = false;
  final _formkey = GlobalKey<FormState>();
  final _authentication = FirebaseAuth.instance;

  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryValidation(){
    //밸리데이션이 통과가 되면 true를 반환한다.
    final isValid = _formkey.currentState!.validate();
    if(isValid){
      //save()를 호출하면 formkey가 적용된 form내 onSaved 메서드 작동
      _formkey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
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
                    height: 40,
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
                                // color: isSignUpScreen
                                //   ? Colors.black
                                //   : Colors.blueAccent
                              ),
                            ),
                            Container(
                              height: 3,
                              width: 56,
                              color: !isSignUpScreen 
                                ?Colors.blueAccent
                                : Colors.white,
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
                                // color: isSignUpScreen
                                //   ? Colors.blueAccent
                                //   : Colors.black
                              ),
                            ),
                            Container(
                              height: 3,
                              width: 70,
                              color: isSignUpScreen 
                                ? Colors.blueAccent
                                : Colors.white,
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
                    padding: EdgeInsets.all(30.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            // autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.emailAddress,
                            key: ValueKey(1),
                            validator: (value){
                              if(value!.isEmpty || !value.contains('@')){
                                return '이메일 주소를 입력해주세요';
                              }
                              return null;
                            },
                            onSaved: (value){
                              userEmail = value!;
                            },
                            onChanged: (value){
                              userEmail = value;
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
                                  color: Color.fromARGB(255, 22, 12, 12),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                )
                              ),
                              hintText: '이메일',
                              contentPadding: EdgeInsets.all(20)
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            obscureText: true,
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
                            onChanged: (value){
                              userPassword = value;
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
                              hintText: '비밀번호',
                              contentPadding: EdgeInsets.all(20)
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  
                  //회원가입(Signup)
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
                            onChanged: (value){
                              userName = value;
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
                              hintText: '이름',
                              contentPadding: EdgeInsets.all(20)
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
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
                            onChanged: (value){
                              userEmail = value;
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
                              hintText: '이메일',
                              contentPadding: EdgeInsets.all(20)
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            obscureText: true,
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
                            onChanged: (value){
                              userPassword = value;
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
                              hintText: '비밀번호',
                              contentPadding: EdgeInsets.all(20)
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  
                  //로그인버튼
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 40),
                    ),
                    child: isSignUpScreen
                      ? Text('회원가입 및 로그인')
                      : Text('로그인'),
                    onPressed: () async {
                      // 로그인 버튼을 누르면 로딩스피너 작동
                      setState(() {
                        showSpinner = true;
                      });
                      //회원가입 화면
                      if(isSignUpScreen){
                        _tryValidation();
                        //밸리데이션이 통과되면 사용자 생성
                        try{
                          final newUser = await _authentication.createUserWithEmailAndPassword(
                            //textformfield의 onChange매서드를 통해 받은 정보를 전달
                            email: userEmail,
                            password: userPassword
                          );
                          setState(() {
                            showSpinner = false;
                          });
                        } catch(e) {
                          setState(() {
                            showSpinner = false;
                          });
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('로그인 정보를 확인해주세요'),
                              backgroundColor: Colors.blueAccent,
                            ),
                          );
                        }
                      }

                      //로그인 화면(회원가입 화면x)
                      if(!isSignUpScreen){
                        _tryValidation();
                        try{
                          //이메일 및 비밀번호로 로그인
                          final newUser = await _authentication.signInWithEmailAndPassword(
                            email: userEmail,
                            password: userPassword
                          );
                          setState(() {
                            showSpinner = false;
                          });
                        } catch(e) {
                          setState(() {
                            showSpinner = false;
                          });
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('로그인 정보를 확인해주세요'),
                              backgroundColor: Colors.blueAccent,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}