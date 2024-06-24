import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'controller/form_controller.dart';
import 'model/form.dart';
import 'package:flutter_color/flutter_color.dart';

class FeedbackListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Price of Products',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FeedbackListPage());
  }
}

class FeedbackListPage extends StatefulWidget {
  FeedbackListPage({Key key}) : super(key: key);

  //final String title;

  @override
  _FeedbackListPageState createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  List<FeedbackForm> feedbackItems = List<FeedbackForm>();

  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();

    FormController().getFeedbackList().then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Price'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Restart.restartApp();
            }),
      ),
      body: SizedBox(
        child: ListView.builder(
          itemCount: feedbackItems.length,
          itemBuilder: (context, index) {
            return Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${feedbackItems[index].product} ",
                            style: TextStyle(
                                color: Color(0xffB1097C),
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Arial',
                                fontSize: 20)),
                      )
                    ],
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("${feedbackItems[index].stock}",
                            style: TextStyle(
                              color:
                                  Color(0xFFFF0000).mix(Color(0xFF00FF00), .25),
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.normal,
                            )),
                      )
                    ],
                  ),
                  leading: FittedBox(
                    child: Image.network(
                      feedbackItems[index].image,
                      height: 1000,
                      width: 1000,
                      fit: BoxFit.fill,
                    ),
                  ),
                  trailing: Text(
                    '\u{20B9}' ' ${feedbackItems[index].price}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Arial',
                        fontSize: 25),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
