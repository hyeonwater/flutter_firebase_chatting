import 'package:chatting_app_clone/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final _auth = FirebaseAuth.instance;
final TextEditingController _nameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

  String _name = '';
  String _email = '';
  String _password = '';

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('회원가입'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: mediaHeight(context, 1),
          padding: EdgeInsets.symmetric(horizontal: mediaHeight(context, 0.02)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: '이름'
                ),
                onChanged: (name) => setState(() => _name = name),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: '이메일'
                ),
                validator: (value){
                  if(value!.isEmpty || !value.contains('@')){
                    showSnackBar(context, '이메일 형식이 맞지 않습니다.');
                  }
                },
                onChanged: (email) => setState(() => _email = email),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: '비밀번호'
                ),
                onChanged: (password) => setState(() => _password = password),
                validator: (value){
                  if(value!.isEmpty || value.length < 6){
                    showSnackBar(context, '7자 이상이여야 합니다.');
                  }
                },
              ),
              CupertinoButton(child: Text('회원가입 하기'), onPressed: (){
                try{
                  _auth.createUserWithEmailAndPassword(email: _email, password: _password);
                  FirebaseAuth.instance.currentUser!.updateDisplayName(_name);
                }catch(e){
                  throw Exception(e);
                }
              }),
              CupertinoButton(child: Text('구글 로그인'), onPressed: (){
                try{
                  signInWithGoogle();
                }catch(e){
                  throw Exception(e);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    /// 구글 로그인
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
