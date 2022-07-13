import 'package:firebasefortest/component/color.dart';
import 'package:firebasefortest/cubit/cubit_state.dart';
import 'package:firebasefortest/screens/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../component/color.dart';
import '../component/component.dart';
import '../cubit/cubit_cubit.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key, required this.name, required this.index})
      : super(key: key);

  String name;
  int index;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

TextEditingController messageController = TextEditingController();

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    ChatCubit Cubit = ChatCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('${widget.name}'),
            Text('3 min ago'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: h,
          width: w,
          color: kSecondaryColor,
          child: Column(
            children: [
              Container(
                height: h * 0.7,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: BlocConsumer<ChatCubit, ChatState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return ListView.builder(
                      controller: Cubit.scrollController,
                      shrinkWrap: true,
                      itemCount: Cubit.AllMessages.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          textDirection: (Cubit.registerUser.id ==
                                  Cubit.AllMessages[index].recieverId
                              ? TextDirection.ltr
                              : TextDirection.rtl),
                          children: [
                            Container(
                                width: w * 0.75,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: kSecondaryColor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${Cubit.AllMessages[index].title}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: kContentColorLightTheme),
                                    ),
                                    Text('${Cubit.AllMessages[index].time}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: kPrimaryColor)),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        controller: messageController,
                        type: TextInputType.text,
                        label: 'Enter Message',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        if (messageController.text.length > 0) {
                          await Cubit.SendMessage(
                              messageController.text, widget.index);
                          messageController.clear();
                        } else {}
                      },
                      child: Icon(Icons.send),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   // isExtended: true,
      //   backgroundColor: kPrimaryColor,
      //   onPressed: (){},
      //   child: Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // backgroundColor: kSecondaryColor,
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   notchMargin: 10,
      //   child: Container(
      //     height: 50,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             MaterialButton(onPressed: (){},
      //               minWidth: 10,
      //             child: Column(
      //               children: [
      //                 SizedBox(
      //                   height: 5,
      //                 ),
      //                 Icon(Icons.call,color: Colors.grey,),
      //                 Text('Calls',style: Theme.of(context).textTheme.bodySmall,)
      //               ],
      //             ),
      //             ),
      //
      //             MaterialButton(onPressed: (){},
      //               minWidth: 10,
      //               child: Column(
      //                 children: [
      //                   SizedBox(
      //                     height: 5,
      //                   ),
      //                   Icon(Icons.account_circle,color: Colors.grey,),
      //                   Text('Account',style: Theme.of(context).textTheme.bodySmall,)
      //                 ],
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             MaterialButton(onPressed: (){
      //               Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreeen()));
      //             },
      //               minWidth: 10,
      //               child: Column(
      //                 children: [
      //                   SizedBox(
      //                     height: 5,
      //                   ),
      //                   Icon(Icons.settings,color: Colors.grey,),
      //                   Text('Settings',style: Theme.of(context).textTheme.bodySmall,)
      //                 ],
      //               ),
      //             ),
      //
      //             MaterialButton(onPressed: (){},
      //               minWidth: 10,
      //               child: Column(
      //                 children: [
      //                   SizedBox(
      //                     height: 5,
      //                   ),
      //                   Icon(Icons.camera,color: Colors.grey,),
      //                   Text('Camera',style: Theme.of(context).textTheme.bodySmall,)
      //                 ],
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
