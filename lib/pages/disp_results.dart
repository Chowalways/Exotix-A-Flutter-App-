import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'more_details.dart';

class DisplayResults extends StatefulWidget{
  final String criteria;
  final dynamic searchValue;

  DisplayResults({this.criteria, this.searchValue});

  @override
  State<StatefulWidget> createState() {
    return _DisplayResultsState();
  }


}
class _DisplayResultsState extends State<DisplayResults>{

  Widget _viewBuilder(BuildContext context, DocumentSnapshot document){
    return new GestureDetector(
      onTap: (){
        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=>MoreDetails(document)),);
      },
     child: Card(
       child: ListTile(
         leading: document['url'] == null?
         Image.network('https://via.placeholder.com/100x100?text=NO%20Image')
             :Image.network(document['url']),
         title: Text(document['name'].toString()),
         subtitle: Text(document['type'].toString()),
       ),
     )
    );
  }



  @override
  Widget build(BuildContext context) {
    String crit = widget.criteria;
    dynamic searchVal = widget.searchValue;

    var search;
    if(crit == "location"){
      search = Firestore.instance.document('Exotics').collection('Animals/To Sell').where('location',isEqualTo: searchVal).snapshots();
    }
    if(crit == "price"){
      search = Firestore.instance.document('Exotics').collection('Animals/To Sell').where('cost',isLessThanOrEqualTo: searchVal).snapshots();
    }
    if(crit == "type"){
      search = Firestore.instance.document('Exotics').collection('Animals/To Sell').where('type',isEqualTo: searchVal).snapshots();
    }
    if(crit == null){
      search = Firestore.instance.document('Exotics').collection('Animals/To Sell').snapshots();
    }
    return Scaffold(
        appBar: new AppBar(
          title: const Text('Results'),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: search,
            builder: (context, snapshot){
              if(!snapshot.hasData)
                return Center(child: const Text('Loading...'));
              return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => _viewBuilder(context, snapshot.data.documents[index])
              );
            }
        )
    );
  }
}