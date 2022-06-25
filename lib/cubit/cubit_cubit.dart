import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebasefortest/cubit/cubit_state.dart';
import 'package:firebasefortest/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseStorage storage = FirebaseStorage.instance;

  GoogleSignIn googleSignIn = GoogleSignIn();

  UserModel registerUser = UserModel();

  List<UserModel> user = [];
  var snapshot;

  List<UserModel> AllUsers = [
    // UserModel(
    //     name: 'walid',
    //     email: 'leadermatrix@yahoo.com',
    //     photoUrl:
    //         'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif')
  ];

  ImagePicker imagePicker = ImagePicker();
  XFile? userImage;

  Image(String Camera) async {
    if (Camera == 'cam') {
      userImage = await imagePicker.pickImage(source: ImageSource.camera);
      return userImage?.readAsBytes();
    } else {
      userImage = await imagePicker.pickImage(source: ImageSource.gallery);
      // return userImage?.readAsBytes();
    }
  }

  registerByEmailAndPassword(String email, String password, String name) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    emit(ChatRegistrationSuccessState());

    registerUser.email = email;
    registerUser.name = name;
    registerUser.id = credential.user!.uid;

    // emit(ChatRegistrationSuccessState());

    await storage
        .ref()
        .child("photos/")
        .child('${registerUser.id}.jpg')
        .putFile(File(userImage!.path));
    registerUser.photoUrl = await storage
        .ref()
        .child("photos/")
        .child('${registerUser.id}.jpg')
        .getDownloadURL();

    await firestore
        .collection('users')
        .doc(registerUser.id)
        .set(registerUser.toJson());

    emit(ChatCreateUserSuccessState());

    getAllUser();
  }

  login(String email, String password) async {
    // user =
    //     await auth.signInWithEmailAndPassword(email: email, password: password);
    // snapshot = await firestore.collection('users').doc(user.user.uid).get();
    //
    // registerUser = UserModel.fromJson(snapshot.data());

    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    snapshot =
        await firestore.collection('users').doc(userCredential.user!.uid).get();
    registerUser = UserModel.fromJson(snapshot.data()!);

    getAllUser();
  }

  SignInByGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential userCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    // amit('');
    var user = await auth.signInWithCredential(userCredential);

    registerUser.id = user.user!.uid;
    registerUser.name = googleSignInAccount.displayName;
    registerUser.email = googleSignInAccount.email;
    registerUser.photoUrl = googleSignInAccount.photoUrl;

    await firestore
        .collection("users")
        .doc(registerUser.id)
        .set(registerUser.toJson());
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePass() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(ChatChangePassState());
  }

  getAllUser() async {
    AllUsers = [];
    var docs = await firestore
        .collection('users')
        .where('id', isNotEqualTo: registerUser.id)
        .get();
    docs.docs.forEach((element) {
      AllUsers.add(UserModel.fromJson(element.data()));
      print(AllUsers.length);
    });
    emit(ChatGetAllUsersState());
  }
}
