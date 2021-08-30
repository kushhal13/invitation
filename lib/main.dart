import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String link = "";

  @override
  void initState() {
    initUniLinks().then((value) => this.setState(() {
          link = value;
        }));
    super.initState();
  }

  Future<String> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      return initialLink;
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      return null;
    }
  }

  getLink(String email, String type) {
    var link = Uri.parse(
        'https://deeplinking.example/signup?email=$email&type=$type');
    //     Uri(host: "https://order.com", path: "/signup", queryParameters: {
    //   "email": email,
    //   "type": type,
    // });
    print("link$link");
    // Uri.parse('https://order.com/signup?email=$email&type=$type');
    return link;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(link == null ? "" : link),
            ElevatedButton(
                onPressed: () async {
                  var link = getLink("sdfjd", "sdjkf");
                  print("link");
                  await Share.share("$link");
                },
                child: Text("share"))
          ],
        ),
      ),
    );
  }
}
