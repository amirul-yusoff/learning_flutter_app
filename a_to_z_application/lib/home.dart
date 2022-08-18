import 'package:a_to_z_application/waktu_azan_page.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Flexible(
                child: Image.asset(
              'assets/images/amirul_mobile.png',
              scale: 2,
            )),
            const Text("Please Choose"),
            const SizedBox(height: 20),
            const Expanded(child: HomeSelectionPage()),
          ],
        ),
      ),
    );
  }
}

class HomeSelectionPage extends StatefulWidget {
  const HomeSelectionPage({Key? key}) : super(key: key);

  @override
  State<HomeSelectionPage> createState() => _HomeSelectionPageState();
}

class _HomeSelectionPageState extends State<HomeSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              child: InkWell(
                highlightColor: Colors.orange.withOpacity(0.3),
                splashColor: Colors.red.withOpacity(0.5),
                onTap: () {
                  print("Click event on Container");
                },
                child: Ink(
                    child: const Center(
                      child: Icon(
                        Icons.location_city,
                        size: 80,
                      ),
                    ),
                    height: 200,
                    width: 200,
                    color: Colors.blue),
              ),
            ),
          ),
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              color: Colors.blue,
              elevation: 8,
              child: InkWell(
                  highlightColor: Colors.orange.withOpacity(0.3),
                  splashColor: Colors.red.withOpacity(0.5),
                  onTap: () {
                    print("Go to Waktu Azan");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WaktuAzanPage()),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const SizedBox(height: 40),
                      const Text(
                        "Waktu Azan",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Center(
                          child: Icon(
                        Icons.location_city,
                        size: 80,
                      )),
                      Ink(
                        child: const Center(),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
