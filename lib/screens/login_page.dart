import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebasefortest/component/component.dart';
import 'package:firebasefortest/cubit/cubit_cubit.dart';
import 'package:firebasefortest/screens/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/color.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
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
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    animationController!.forward();

    ChatCubit Cubit = ChatCubit.get(context);

    return AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Transform(
                    transform: Matrix4.translationValues(
                        animation!.value * w, 0.0, 0.0),
                    child: Column(
                      children: [
                        Stack(children: [
                          Container(
                            height: h * 0.50,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(.5),
                                      blurRadius: 7,
                                      spreadRadius: 5,
                                      offset: Offset(0, 3)),
                                ],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(130),
                                  topRight: Radius.circular(150),
                                ),
                                color: kPrimaryColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 15),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: kSecondaryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 120, left: 15),
                            child: Container(
                              height: 250,
                              width: 330,
                              decoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(.5),
                                //     blurRadius: 7,
                                //     spreadRadius: 5,
                                //     offset: Offset(0,3)
                                //   ),
                                // ],
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(130),
                                    topRight: Radius.circular(90)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10,right: 15,left: 5),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFieldWidget(
                                        controller: emailController,
                                        type: TextInputType.emailAddress,
                                        label: "Email",
                                        validator: (value) {
                                          if (value.length == 0) {
                                            return "Email Can not be empty ";
                                          }
                                          if (!RegExp(
                                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z-9+_.-]+.[a-z]")
                                              .hasMatch(value)) {
                                            return " please enter valid email";
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFieldWidget(
                                        controller: passwordController,
                                        label: "Password",
                                        type: TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value.length <= 6) {
                                            return "password should be return 6";
                                          }
                                          return null;
                                        }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: w * 0.3,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await Cubit.login(
                                              emailController.text,
                                              passwordController.text);
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()));
                                        },
                                        child: Text("Login"),
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
