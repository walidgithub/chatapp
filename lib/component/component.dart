import 'package:firebasefortest/component/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color.dart';



Widget TextFieldWidget({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  FormFieldValidator? validator,
  bool isPassword = false,
  String? hint,
  bool? obscureText,
  IconData? prefix,
  IconData? suffixIcon,
  Function? suffixPressed,
}) =>
    TextFormField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      validator: validator,
      decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: Icon(suffixIcon),
                )
              : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: kSecondaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: kSecondaryColor)),
          contentPadding: EdgeInsets.fromLTRB(-20, 10, -10, 10)),
    );
