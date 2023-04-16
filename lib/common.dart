import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

double mediaHeight(BuildContext context, double scale) => MediaQuery.of(context).size.height * scale;

Future<XFile?> photoPick(ImageSource imageSource) async{
  ///사진을 가져옴
  final imagePicker = ImagePicker();
  final photo = await imagePicker.pickImage(source: imageSource);
  return photo;
}

Future<bool> permissionCheck(Permission permission) async{
  Map<Permission, PermissionStatus> statuses = await [permission].request();
  final PermissionStatus? status = statuses[permission];
  print(status);
  switch(status){
    case PermissionStatus.granted:
      return true;
    default:
      openAppSettings();
      return false;
  }
}
Future showSnackBar(BuildContext context, String msg, {SnackBarBehavior? behavior}) async{
  ///스낵 바를 띄움
  final SnackBar snackBar = SnackBar(
    content: Text(msg, style: CustomTextStyle.w500(context, color: Colors.white, scale: 0.016)),
    behavior: behavior ?? SnackBarBehavior.floating,
  );
  return ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
}

mixin CustomTextStyle implements TextStyle{
  static const double _scale = 0.016;
  static const Color _color = Colors.black;
  static const Color _appBarColor = Colors.white;
  static const String _family1 = 'Pretendard-Thin';
  static const String _family2 = 'Pretendard-Light';
  static const String _family3 = 'Pretendard-ExtraLight';
  static const String _family4 = 'Pretendard-Regular';
  static const String _family5 = 'Pretendard-Medium';
  static const String _family6 = 'Pretendard-Bold';
  static const TextDecoration _decoration = TextDecoration.none;

  static TextStyle appBarStyle(BuildContext context, {double? scale, Color? color}) => TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: mediaHeight(context, scale ?? 0.023),
      color: color ?? _appBarColor,
      fontFamily: _family3
  );
  static TextStyle w100(BuildContext context, {double? scale, double? height, Color? color, String? fontFamily, TextDecoration? decoration,Color? decorationColor,double? decorationThickness}) => TextStyle(
      fontWeight: FontWeight.w100,
      fontSize: mediaHeight(context, scale ?? _scale),
      color: color ?? _color,
      height: height,
      fontFamily: fontFamily ?? _family1,
      decoration: decoration ?? _decoration,
      decorationColor: decorationColor ?? _color,
      decorationThickness: decorationThickness ?? 0

  );
  static TextStyle w200(BuildContext context, {double? scale, double? height, Color? color, String? fontFamily, TextDecoration? decoration,Color? decorationColor,double? decorationThickness}) => TextStyle(
      fontWeight: FontWeight.w200,
      fontSize: mediaHeight(context, scale ?? _scale),
      color: color ?? _color,
      height: height,
      fontFamily: fontFamily ?? _family1,
      decoration: decoration ?? _decoration,
      decorationColor: decorationColor ?? _color,
      decorationThickness: decorationThickness ?? 0


  );
  static TextStyle w300(BuildContext context, {double? scale, double? height, Color? color, String? fontFamily, TextDecoration? decoration,Color? decorationColor,double? decorationThickness}) => TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: mediaHeight(context, scale ?? _scale),
      color: color ?? _color,
      height: height,
      fontFamily: fontFamily ?? _family2,
      decoration: decoration ?? _decoration,
      decorationColor: decorationColor ?? _color,
      decorationThickness: decorationThickness ?? 0


  );
  static TextStyle w400(BuildContext context, {double? scale, double? height, Color? color, String? fontFamily, TextDecoration? decoration,Color? decorationColor,double? decorationThickness}) => TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: mediaHeight(context, scale ?? _scale),
      color: color ?? _color,
      height: height,
      fontFamily: fontFamily ?? _family2,
      decoration: decoration ?? _decoration,
      decorationColor: decorationColor ?? _color,
      decorationThickness: decorationThickness ?? 0


  );
  static TextStyle w500(BuildContext context, {double? scale, double? height, Color? color, String? fontFamily, TextDecoration? decoration,Color? decorationColor,double? decorationThickness}) => TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: mediaHeight(context, scale ?? _scale),
      color: color ?? _color,
      height: height,
      fontFamily: fontFamily ?? _family3,
      decoration: decoration ?? _decoration,
      decorationColor: decorationColor ?? _color,
      decorationThickness: decorationThickness ?? 0

  );
  static TextStyle w600(BuildContext context, {double? scale, double? height, Color? color, String? fontFamily, TextDecoration? decoration,Color? decorationColor,double? decorationThickness}) => TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: mediaHeight(context, scale ?? _scale),
      color: color ?? _color,
      height: height,
      fontFamily: fontFamily ?? _family4,
      decoration: decoration ?? _decoration,
      decorationColor: decorationColor ?? _color,
      decorationThickness: decorationThickness ?? 0


  );
  static TextStyle w700(BuildContext context, {double? scale, double? height, Color? color, String? fontFamily, TextDecoration? decoration,Color? decorationColor,double? decorationThickness}) => TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: mediaHeight(context, scale ?? _scale),
      color: color ?? _color,
      height: height,
      fontFamily: fontFamily ?? _family4,
      decoration: decoration ?? _decoration,
      decorationColor: decorationColor ?? _color,
      decorationThickness: decorationThickness ?? 0


  );
  static TextStyle w800(BuildContext context, {double? scale, double? height, Color? color, String? fontFamily, TextDecoration? decoration,Color? decorationColor,double? decorationThickness}) => TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: mediaHeight(context, scale ?? _scale),
      color: color ?? _color,
      height: height,
      fontFamily: fontFamily ?? _family5,
      decoration: decoration ?? _decoration,
      decorationColor: decorationColor ?? _color,
      decorationThickness: decorationThickness ?? 0


  );
  static TextStyle w900(BuildContext context, {double? scale, double? height, Color? color, String? fontFamily, TextDecoration? decoration,Color? decorationColor,double? decorationThickness}) => TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: mediaHeight(context, scale ?? _scale),
      color: color ?? _color,
      height: height,
      fontFamily: fontFamily ?? _family6,
      decoration: decoration ?? _decoration,
      decorationColor: decorationColor ?? _color,
      decorationThickness: decorationThickness ?? 0


  );
}