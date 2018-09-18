import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MoreDetails extends StatelessWidget{
  final DocumentSnapshot snap;

  MoreDetails(this.snap);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Exotix'),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            child: snap['url'] == null?
            Image.network('https://via.placeholder.com/100x100?text=NO%20Image')
                :Image.network(snap['url']),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Text("Name: ")),
              Expanded(child: Text(snap['name']))
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Text("Type: ")),
              Expanded(child: Text(snap['type']))
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Text("Age: ")),
              Expanded(child: Text(snap['age'].toString()))
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Text("Cost: ")),
              Expanded(child: Text(snap['cost'].toString()))
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Text("Origin: ")),
              Expanded(child: Text(snap['origin']))
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Text("Location: ")),
              Expanded(child: Text(snap['location']))
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Text("Notes: ")),
              Expanded(child: Text(snap['notes']))
            ],
          ),
        ],
      ),
    );
  }
}