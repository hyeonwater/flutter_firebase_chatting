import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../common.dart';

class EditProfileBottomSheet extends StatelessWidget {
  final Function(XFile?) onPickPhoto;

  const EditProfileBottomSheet({required this.onPickPhoto,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // margin: (baseHorizontalPadding(context) * 10),
            alignment: Alignment.center,
            height: mediaHeight(context, 0.005),
            decoration: BoxDecoration(
              // color: CustomColors.hint,
              // borderRadius: baseBorderRadius,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: mediaHeight(context, 0.01)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('작업 선택',	style: TextStyle(
                  color: Color(0xff464a59),
                  fontSize: mediaHeight(context, 0.017),
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),),
              ],
            ),
          ),
          Divider(
            thickness: 0.8,
            color: Color(0xffe8e8e8),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin:EdgeInsets.only(bottom: mediaHeight(context, 0.02)),
                    child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            const Icon(Icons.camera_alt_outlined,color: Color(0xff464a59),
                            ),
                            SizedBox(
                              width: mediaHeight(context, 0.02),
                            ),
                            Text('카메라로 사진찍기',style: TextStyle(
                              color: Color(0xff464a59),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),),
                          ],
                        ),
                        onPressed: () async{
                          if(await permissionCheck(Permission.camera))
                            return onPickPhoto(await photoPick(ImageSource.camera)); /// permission check
                        }),
                  ),
                  Container(
                    margin:EdgeInsets.only(bottom: mediaHeight(context, 0.02)),
                    child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Icon(Icons.image_outlined,color: Color(0xff464a59)),
                            SizedBox(
                              width: mediaHeight(context, 0.02),
                            ),
                            Text('갤러리에서 가져오기',style: TextStyle(
                              color: Color(0xff464a59),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),),
                          ],
                        ),
                        onPressed: () async {
                          // Get.back();
                          if(await permissionCheck(Permission.photos))
                            return onPickPhoto(await photoPick(ImageSource.gallery)); /// permission check
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),);
  }
}
