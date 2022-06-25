
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasefortest/cubit/cubit_cubit.dart';
import 'package:firebasefortest/firebase_options.dart';
import 'package:firebasefortest/screens/login_page.dart';
import 'package:firebasefortest/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>ChatCubit())
      ],
      child:BlocConsumer<ChatCubit,ChatState>(
        listener: (context, state) =>{},
        builder: (c,s)=>
            MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: RegisterPage(),
            ),
      ),
    );
  }
}
