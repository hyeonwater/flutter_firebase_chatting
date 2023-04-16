import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatting_app_clone/common.dart';
import 'package:chatting_app_clone/widgets/logout_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/edit_profile_bottom_sheet.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
  final _user = FirebaseAuth.instance;
  var _editProfile = false;
  XFile? _photo;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('프로필'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(mediaHeight(context, 0.02)),
          child: Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: mediaHeight(context, 0.02)),
                      child: !_editProfile
                          ? Container(
                          height: mediaHeight(context, 0.15),
                          width: mediaHeight(context, 0.15),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_user.currentUser!.photoURL.toString())
                          )
                        ))
                          : Container(
                        height: mediaHeight(context, 0.15),
                        width: mediaHeight(context, 0.15),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:FileImage(File(_photo!.path)
                          )
                        ),
                    ))),
                    Container(
                        margin: EdgeInsets.only(right: mediaHeight(context, 0.02)).add(EdgeInsets.only(bottom: mediaHeight(context, 0.005))),
                        padding: EdgeInsets.all(mediaHeight(context, 0.005)),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(0xffDADDE3))
                        ),
                        child:  Icon(Icons.camera_alt_outlined,color: Color(0xffDADDE3),size: mediaHeight(context, 0.02))),
            ],
                ),
                onPressed: (){
                  showModalBottomSheet(context: context,shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                  ), builder: (builder) => Container(
                      padding: EdgeInsets.all(mediaHeight(context, 0.01)),
                      height: mediaHeight(context, 0.38),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20))
                      ),
                      child: EditProfileBottomSheet(
                        onPickPhoto: (photo){
                          if(photo != null){
                            setState(() {
                              _editProfile = true;
                              _photo = photo;
                              print(_photo!.path);
                            });
                          }
                        },
                      )
                  )
                  );
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${_user.currentUser!.displayName ?? ''}'),
                    Text('${_user.currentUser!.email}'),
                    Container(
                      alignment: Alignment.centerRight,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              Icon(Icons.logout_outlined),
                              Text('로그아웃',style: CustomTextStyle.w300(context),)
                            ],
                          ),
                          onPressed: () => showDialog(context: context, builder: (context) => LogoutDialog())
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
