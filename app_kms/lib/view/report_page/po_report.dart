import 'package:app_kms/model/user.dart';
import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class purchaseOrderReport extends StatefulWidget {
  final User user;
  const purchaseOrderReport({Key? key, required this.user}) : super(key: key);

  @override
  State<purchaseOrderReport> createState() => _purchaseOrderReportState();
}

class _purchaseOrderReportState extends State<purchaseOrderReport> {
  @override
  Widget build(BuildContext context) {
    late WebViewXController webViewController;
    late double screenHeight, screenWidth, resWidth, resHeight;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    int rowcount = 2;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'PO Report',
        style: Theme.of(context).textTheme.headline6,
      )),
      body: Container(
        child: SingleChildScrollView(
          child: WebViewX(
            initialContent:
                '<iframe title="PowerBITest - Page 1" width="100%" height="${size.height - 100}" src="https://app.powerbi.com/view?r=eyJrIjoiM2QyOWZhNTEtYjE3Ni00NTY4LWFkM2ItZGQ2NzFjZjJhMTFhIiwidCI6IjYwNGI1NzFmLTNmYzktNDRlOC1hZDc4LWE4OTg4NGUxYmE0NiIsImMiOjEwfQ%3D%3D" frameborder="0" allowFullScreen="true"></iframe>',
            initialSourceType: SourceType.html,
            onWebViewCreated: (controller) => webViewController = controller,
            width: screenWidth,
            height: screenHeight,
          ),
        ),
      ),
    );
  }
}
