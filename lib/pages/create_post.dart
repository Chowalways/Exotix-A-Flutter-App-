import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';




class CreatePost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreatePostState();
  }
}

class _CreatePostState extends State<CreatePost> {
  File _image;
  String _name;
  String _type;
  String _species;
  int _age;
  int _cost;
  String _origin;
  String _location;
  String _notes;
  String imgUrl;
  DateTime time = DateTime.now();
  DateFormat formatter = new DateFormat('yyyy-MM-dd');

  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _speciesController = TextEditingController();
  final _ageController = TextEditingController();
  final _costController = TextEditingController();
  final _originController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();


  CollectionReference ref = Firestore.instance.document('Exotics').collection('Animals/To Sell');




  Future _getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future _getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _speciesController.dispose();
    _ageController.dispose();
    _costController.dispose();
    _originController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }


  Future<Null> _uploadImage() async{
    String imgName = formatter.format(time);
    final StorageReference storageReference = FirebaseStorage.instance.ref().child('$imgName');
    final StorageUploadTask task = storageReference.putFile(_image);
    final Uri downloadUrl = (await task.future).downloadUrl;
    imgUrl = downloadUrl.toString();
    Map<String, dynamic> data = <String, dynamic>{
      "name" : _name,
      "type" : _type,
      "species" : _species,
      "age" : _age,
      "cost" : _cost,
      "location" : _location,
      "notes" : _notes,
      "origin" : _origin,
      "url" : imgUrl
    };
    ref.add(data).whenComplete((){
//      Fluttertoast.showToast(
//          msg: "Saved",
//          toastLength: Toast.LENGTH_LONG,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIos: 1,
//          bgcolor: "#74f442",
//          textcolor: '#ffffff'
//      );
    });


  }
//  void _setImageUrl(Uri downloadUrl){
//    setState(() {
//      imgUrl = downloadUrl.toString();
//      print("image url is" + imgUrl);
//    });
//  }
//  void _saveToDatabase(){
//
//
//    Map<String, dynamic> data = <String, dynamic>{
//      "name" : _name,
//      "type" : _type,
//      "species" : _species,
//      "age" : _age,
//      "cost" : _cost,
//      "location" : _location,
//      "notes" : _notes,
//      "origin" : _origin,
//      "url" : imgUrl
//    };
//    ref.add(data).whenComplete((){
//      Fluttertoast.showToast(
//          msg: "Saved",
//          toastLength: Toast.LENGTH_LONG,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIos: 1,
//          bgcolor: "#74f442",
//          textcolor: '#ffffff'
//      );
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: new AppBar(
        title: const Text('Post'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                setState(() {
                  _name = _nameController.text.toString();
                  _type = _typeController.text.toString();
                  _species = _speciesController.text.toString();
                  _age = int.parse(_ageController.text.toString());
                  _cost = int.parse(_costController.text.toString());
                  _origin = _originController.text.toString();
                  _location = _locationController.text.toString();
                  _notes = _notesController.text.toString();
                });
                Navigator.pop(context);
                _uploadImage();
                //_saveToDatabase();
              })
        ],
      ),
      body: new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),
            new Center(
              child: new Container(
                color: Colors.grey,
                height: 90.0,
                width: 100.0,
                child: _image == null
                    ? new Text(
                  'No Image',
                  textAlign: TextAlign.center,
                )
                    : new Image.file(_image),
              ),
            ),
            new SizedBox(
              height: 10.0,
            ),
            new Center(
              //ButtonBar for Image Selection
             child: ButtonBar(
               alignment: MainAxisAlignment.center,
               children: <Widget>[
                 RaisedButton(
                   child: const Text('Open Gallery'),
                     color: Theme.of(context).primaryColor,
                     onPressed: (){
                     _getImageGallery();
                     }),
                 RaisedButton(
                   child: const Text('Open Camera'),
                     color: Theme.of(context).primaryColor,
                     onPressed: (){
                       _getImageCamera();
                     })
               ],

              )

            ),
            new SizedBox(
              height: 20.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: new TextField(
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                      )),
                ),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: _typeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Type'),
                        )))
              ],
            ),
            new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new TextField(
                      keyboardType: TextInputType.text,
                      controller: _speciesController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Species'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      controller: _ageController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Age'),
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      controller: _costController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Cost'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new TextField(
                      keyboardType: TextInputType.text,
                      controller: _originController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Origin'),
                    ),
                  ),
                ),
              ],
            ),
            new Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _locationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Location',
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _notesController,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Notes',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
