import 'package:auth_buttons/auth_buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasefortest/component/color.dart';
import 'package:firebasefortest/component/component.dart';
import 'package:firebasefortest/cubit/cubit_state.dart';
import 'package:firebasefortest/screens/homepage.dart';
import 'package:firebasefortest/screens/login_page.dart';
import 'package:firebasefortest/translation/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit_cubit.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  Animation? animation;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.fastOutSlowIn, parent: animationController!));
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    animationController!.forward();

    ChatCubit Cubit = ChatCubit.get(context);
    return AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return SafeArea(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: kPrimaryColor,
                  body: Center(
                    child: SingleChildScrollView(
                      child: Transform(
                        transform: Matrix4.translationValues(
                            animation!.value * w, 0.0, 0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: w,
                              height: h * 0.7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(100),
                                    topRight: Radius.circular(100),
                                  ),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      LocaleKeys.title_register.tr(),
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: kSecondaryColor),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFieldWidget(
                                        controller: nameController,
                                        type: TextInputType.name,
                                        label: LocaleKeys.user_name.tr()),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFieldWidget(
                                        controller: emailController,
                                        type: TextInputType.emailAddress,
                                        label: LocaleKeys.email.tr(),
                                        validator: (value) {
                                          if (value.length == 0) {
                                            return "Email can not be empty";
                                          }
                                          if (RegExp(
                                                  "[a-z A-Z 0-9 +_.-]+@[a-z A-Z]+.[a-z]")
                                              .hasMatch(value)) {
                                            return "please enter valid email";
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFieldWidget(
                                        controller: passController,
                                        type: TextInputType.visiblePassword,
                                        suffixIcon: Cubit.suffix,
                                        suffixPressed: () {
                                          Cubit.changePass();
                                        },
                                        isPassword: Cubit.isPassword,
                                        // obscureText: Cubit.isPassword,
                                        label: LocaleKeys.password.tr(),
                                        validator: (value) {
                                          if (value.length <= 6) {
                                            return "password must be greater than 6";
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: w * 0.5,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          // try {
                                          await Cubit
                                              .registerByEmailAndPassword(
                                                  emailController.text,
                                                  passController.text,
                                                  nameController.text);
                                          await ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text('Successfully Register'),
                                            duration: Duration(seconds: 1),
                                          ));
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()));
                                          // } on FirebaseAuthException catch (error) {
                                          //   showDialog(
                                          //       context: context,
                                          //       builder: (context) => AlertDialog(
                                          //             title: Text(
                                          //                 'Registration faild'),
                                          //           ));
                                          // }
                                        },
                                        child: Text(
                                          LocaleKeys.buttom_register.tr(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: kPrimaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GoogleAuthButton(
                                          onPressed: () async {
                                            await ChatCubit.get(context)
                                                .SignInByGoogle();
                                          },
                                          style: AuthButtonStyle(
                                            buttonType: AuthButtonType.icon,
                                            iconType: AuthIconType.secondary,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        FacebookAuthButton(
                                          onPressed: () {},
                                          style: AuthButtonStyle(
                                            buttonType: AuthButtonType.icon,
                                            iconType: AuthIconType.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          Cubit.Image('cam');
                                        },
                                        child: Text(LocaleKeys.photo.tr())),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 55.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            LocaleKeys.have_account.tr(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginPage()));
                                            },
                                            child: Text(
                                              LocaleKeys.login.tr(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: kPrimaryColor),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            // ElevatedButton(onPressed: () async{
                            //   await context.setLocale(Locale('ar'));
                            // }, child: Text('Ar')),
                            // ElevatedButton(onPressed: () async{
                            //   await context.setLocale(Locale('en'));
                            // }, child: Text('En')),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
