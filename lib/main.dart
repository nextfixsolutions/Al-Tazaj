import 'package:flutter/material.dart';
import 'package:google_sheets_app/feedback_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_sheets_app/product_screen.dart';

void main() => runApp(MyApp());
Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al Tazaj Chicken Stall ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'AL Tazaj Chicken Stall'),
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
  TextEditingController _numberCtrl = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _numberCtrl.text = "09847465625";
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false, // hides default back button
        flexibleSpace: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xffB1097C),
                Color(0xff0947B1),
              ]),
        )),
        title: Text(widget.title,
            style: TextStyle(fontSize: 20.0, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image.asset('AlTazaj.jpeg',
                height: 500,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.fromSize(
                  size: Size(56, 56),
                  child: ClipOval(
                    child: Material(
                      color: Colors.green, // button color
                      child: InkWell(
                        splashColor: Colors.green,
                        onTap: () {
                          setState(() {
                            _makePhoneCall('tel:09847465625');
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.call,
                              color: Colors.white,
                            ), // icon
                            Text(
                              "Call",
                            ),
                            // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text('9847465625',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedbackListScreen(),
                          ));
                    },
                    child: Center(child: Text('View Price വില')),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 0, left: 50, right: 50, bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(),
                          ));
                    },
                    child: Center(child: Text('View Products')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
