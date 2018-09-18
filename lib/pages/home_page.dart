import 'package:flutter/material.dart';

import 'create_post.dart';
import 'search_options.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Exotix'),
          centerTitle: true,
        ),
        backgroundColor: Colors.lightGreen,
        body: new Center(
          child: Container(
            height: 300.0,
            width: 300.0,
            color: Colors.white,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 50.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=>SearchOptions()));
                    },
                  ),
                ),
                RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: const Text(
                      'Post',
                      style: TextStyle(fontSize: 50.0),
                    ),
                    onPressed: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) =>CreatePost(),));
                    }),
              ],
            ),
          ),
        ));
  }
}
