import 'package:flutter/material.dart';

import 'disp_results.dart';



class SearchOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchOptionsState();
  }
}

class _SearchOptionsState extends State<SearchOptions>{
  final _locationController  = TextEditingController();
  final _priceController  = TextEditingController();
  final _typeController  = TextEditingController();

  @override
  void dispose(){
     _locationController.dispose();
     _priceController.dispose();
     _typeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: new AppBar(
          title: const Text('Search'),
          centerTitle: true,
        ),
        body: new ListView(
          children: <Widget>[
            new SizedBox(
              height: 20.0,
            ),
            new Container(
              color: Colors.white,
              child: const Text(
                'Search By',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
            new SizedBox(
              height: 40.0,
            ),
            new Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: new Container(
                    height: 200.0,
                    color: Colors.white,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //button to search by type
                    new RaisedButton(
                        color: Theme.of(context).primaryColor,
                    child: const Text('Type',
                        style: TextStyle(
                          fontSize: 30.0,)
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_)=>new AlertDialog(
                            title: const Text('Enter Type'),
                            content: new TextField(
                              keyboardType: TextInputType.text,
                              controller: _typeController,
                            ),
                            actions: <Widget>[
                              new RaisedButton(
                                  child: const Text('Search'),
                                  onPressed: (){
                                    Navigator.pop(context);
                                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=> DisplayResults(criteria: 'type', searchValue: _typeController.text.toString(),)));
                                  })
                            ],
                          )
                      );
                    }),
                    //button to search by price
                    new RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: const Text('Price',
                            style: TextStyle(
                              fontSize: 30.0,)
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_)=>new AlertDialog(
                                title: const Text('Enter Price'),
                                content: new TextField(
                                  keyboardType: TextInputType.number,
                                  controller: _priceController,
                                ),
                                actions: <Widget>[
                                  new RaisedButton(
                                      child: const Text('Search'),
                                      onPressed: (){
                                        Navigator.pop(context);
                                        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=> DisplayResults(criteria: 'price', searchValue: int.parse(_priceController.text.toString()),)));
                                      })
                                ],
                              )
                          );
                        }),

                    //button to search by location
                    new RaisedButton(
                      color: Theme.of(context).primaryColor,
                        child: const Text('Location',
                            style: TextStyle(
                              fontSize: 30.0,)
                        ),
                        onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_)=>new AlertDialog(
                            title: const Text('Enter Location'),
                            content: new TextField(
                              controller: _locationController,
                            ),
                            actions: <Widget>[
                              new RaisedButton(
                                  child: const Text('Search'),
                                  onPressed: (){
                                    Navigator.pop(context);
                                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=> DisplayResults(criteria: 'location', searchValue: _locationController.text.toString(),)));
                                  })
                            ],
                          )
                        );
                        }),
                    //button to search for all
                    new RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: const Text('All',
                            style: TextStyle(
                              fontSize: 30.0,)
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=> DisplayResults()));
                        }),


                        ],
        )),)
    ]
    ,
    )
    );
  }
}
