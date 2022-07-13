// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "title_register": "التسجيل",
  "user_name": "الاسم",
  "email": "الايميل",
  "password": "كلمة المرور",
  "buttom_register": "تسجيل",
  "have_account": "لدي حساب بالفعل",
  "login": "دخول",
  "photo": "التقاط صورة"
};
static const Map<String,dynamic> en = {
  "title_register": "Registration",
  "user_name": "name",
  "email": "email",
  "password": "password",
  "buttom_register": "register",
  "have_account": "already have an account",
  "login": "login",
  "photo": "take photo"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
