
// ignore_for_file: avoid_unnecessary_containers, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secqrv3/models/url_scan.dart';
import 'package:secqrv3/themes/themes.dart';
import 'package:url_launcher/url_launcher.dart';


//TODO: Import images into Firestore if possible
//TODO: Fix this, add/update/delete to Firestore
class HistoryListData extends StatelessWidget {
  const HistoryListData({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History of List Data URL', style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryDark),)),
      // ignore: unnecessary_new
      body: new Stack(
        children: <Widget>[
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('url').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(child: CircularProgressIndicator(),),
                );
              }
              return historyList(document: snapshot.data!.docs);
            },
          ),
        ],
      ),
    );
  }
}

class historyList extends StatelessWidget {
  const historyList({required this.document});
  final List <DocumentSnapshot> document;
    
  @override
  Widget build(BuildContext context) {
  

    return ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i){
        String title = document[i].data().toString();
        String url = document[i].data().toString();
        String status = document[i].data().toString();

        return SafeArea(child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Container(
              color: Colors.deepPurple[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24.0, letterSpacing: 1.0,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "URL: ",
                        style: TextStyle(fontSize: 18.0,),
                      ),
                      Expanded(
                        child: Text(
                          url,
                          style: TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 1.0,
                            color: Colors.black,
                          ),
                        )
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Status: ",
                        style: TextStyle(fontSize: 18.0,),
                      ),
                      Expanded(
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 1.0,
                            color: Colors.black,
                          ),
                        )
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 65.0),
                        child: IconButton(
                          icon: Icon(Icons.sports_basketball, color: Colors.green,),
                          onPressed: () async {
                            await canLaunch(url);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red,),
                          onPressed: () {}, 
                        ),
                      ),                   

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    );
  }
}