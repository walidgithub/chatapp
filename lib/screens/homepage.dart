import 'package:firebasefortest/component/color.dart';
import 'package:firebasefortest/cubit/cubit_cubit.dart';
import 'package:firebasefortest/screens/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ChatCubit Cubit = ChatCubit.get(context);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('${Cubit.registerUser.photoUrl}'),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Chat',
                style: TextStyle(fontSize: 25, color: Colors.white),
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: kSecondaryColor,
                  child: Icon(
                    Icons.camera_alt,
                    size: 15,
                    color: Colors.white,
                  ),
                )),
            IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: kSecondaryColor,
                  child: Icon(
                    Icons.edit,
                    size: 15,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200]),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                            name: '${Cubit.AllUsers[index].name}',
                                            //we can replace index with ${Cubit.AllUsers[index].id}
                                            index: index)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              '${Cubit.AllUsers[index].photoUrl}'),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  bottom: 1.0, end: 1.0),
                                          child: CircleAvatar(
                                            radius: 7,
                                            backgroundColor: Colors.green,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            Cubit.AllUsers[index].name!,
                                            style: TextStyle(fontSize: 15),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: Cubit.AllUsers.length),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  // color: Colors.grey,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(MediaQuery.of(context).size.width, 80),
                        painter: BtnNaviagation(),
                      ),
                      Center(
                        heightFactor: 0.6,
                        child: FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: kSecondaryColor,
                          child: Icon(
                            Icons.add,
                            size: 30,
                          ),
                          elevation: 0.1,
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.home),
                              color: Colors.white,
                              iconSize: 30,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.account_circle_outlined),
                                color: Colors.white,
                                iconSize: 30),
                            Container(
                              width: size.width * 0.20,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.notifications),
                                color: Colors.white,
                                iconSize: 30),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.help_outline),
                                color: Colors.white,
                                iconSize: 30),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}

class BtnNaviagation extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
