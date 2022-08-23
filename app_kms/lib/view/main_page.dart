import 'package:flutter/material.dart';

import 'asset_list_page.dart';
import 'model/user.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late double screenHeight, screenWidth, resWidth, resHeight;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App KMS'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Flexible(
                flex: 2,
                child: Image.asset('assets/images/image.png'),
              ),
              Flexible(
                  flex: 8,
                  child: GridView.count(
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: ((itemWidth / itemHeight) * 2),
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Material(
                            color: Colors.blue[100],
                            elevation: 8,
                            child: InkWell(
                                highlightColor: Colors.yellow.withOpacity(0.3),
                                splashColor: Colors.red.withOpacity(0.5),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AssetListPage(user: widget.user)),
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: const <Widget>[
                                    SizedBox(height: 40),
                                    Text(
                                      "IT Asset",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Center(
                                        child: Icon(
                                      Icons.computer,
                                      size: 80,
                                    )),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Material(
                            color: Colors.blue[100],
                            elevation: 8,
                            child: InkWell(
                                highlightColor: Colors.yellow.withOpacity(0.3),
                                splashColor: Colors.red.withOpacity(0.5),
                                onTap: () {
                                  print("Go to Waktu Azan");
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const WaktuAzanPage()),
                                  // );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: const <Widget>[
                                    SizedBox(height: 40),
                                    Text(
                                      "IT Asset",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Center(
                                        child: Icon(
                                      Icons.computer,
                                      size: 80,
                                    )),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
