import 'package:chatting_app_clone/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('로그아웃 하시겠습니까?'),
      actions: [
        CupertinoButton(
          child: Text('취소'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        SizedBox(
          width: mediaHeight(context, 0.02),
        ),
        CupertinoButton(
          child: Text('확인'),
          onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
