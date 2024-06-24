import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int photoIndex = 0;
  List<String> photos = [
    'assets/a.jpg',
    'assets/aa.jpg',
    'assets/b.jpg',
    'assets/b.jpg',
    'assets/c.jpg',
    'assets/def.jpg',
    'assets/ghi.jpg',
  ];

  void _previousImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : 0;
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
        title: Text('Products'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          // onPressed:() => exit(0),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MySecondScreen(photos: photos[photoIndex]),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      image: DecorationImage(
                          image: AssetImage(photos[photoIndex])),
                    ),
                    height: 400,
                    width: 300,
                  ),
                ),
                Positioned(
                    bottom: 10.0,
                    left: 25.0,
                    right: 25.0,
                    child: SelectedPhoto(
                      numberOfDots: photos.length,
                      photoIndex: photoIndex,
                    )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Previous'),
                onPressed: _previousImage,
                elevation: 5.0,
                color: Colors.blue[200],
              ),
              SizedBox(width: 10.0),
              RaisedButton(
                child: Text('Next'),
                onPressed: _nextImage,
                elevation: 5.0,
                color: Colors.blue[200],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MySecondScreen extends StatelessWidget {
  final String photos;

  MySecondScreen({Key key, @required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
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
          title: Text('Products'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                //    Restart.restartApp();
              }
              //  onPressed:() => exit(0),
              ),
        ),
        body: GestureDetector(
            child: PhotoView(
              imageProvider: AssetImage(photos),
              backgroundDecoration: BoxDecoration(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => ProductScreen()));
            }),
      ),
    );
  }
}

class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 8.0,
          width: 8.0,
          decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
    );
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 0.0, blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < numberOfDots; i++) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
