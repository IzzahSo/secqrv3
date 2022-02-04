
// ignore_for_file: avoid_unnecessary_containers, camel_case_types

// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secqrv3/models/url_scan.dart';
import 'package:secqrv3/themes/themes.dart';
import 'package:secqrv3/views/screens/qr/qr_details.dart';
import 'package:url_launcher/url_launcher.dart';


//TODO: Fix this, add/update/delete to Firestore
class HistoryListData extends StatelessWidget {
  const HistoryListData({ Key? key }) : super(key: key);

  // navigateToDetail(BuildContext context, String url){
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => QRDetails(qrCodeText: url.toString())));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History', style: TextStyle(fontWeight: FontWeight.bold,),)),
      // ignore: unnecessary_new
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('url').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(child: CircularProgressIndicator(),),
            );
          }
          // return historyList(document: snapshot.data!.docs);
          // if (snapshot.hasData){
          //   return ListView.builder(
          //     itemCount: snapshot.data?.docs.length,
          //     itemBuilder: (context, index) {
          //       // var doc = snapshot.data?.docs[index].get('field');
          //       return ListTile(
          //         title: Text(
          //           snapshot.data?.docs[index].get('url'),
          //           style: TextStyle(color: kSecondaryDark),
          //         ),
          //       );
          //     },
          //   );
          // }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              // var doc = snapshot.data?.docs[index].get('field');
              String positives = snapshot.data?.docs[index].get('positives');
              String url = snapshot.data?.docs[index].get('url');
              
              return Card(
                child: ListTile(
                  title: Text(
                    snapshot.data?.docs[index].get('url'),
                    style: TextStyle(color: kSecondaryDark),
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QRDetails(qrCodeText: url))),
                  subtitle: Column(
                    children: <Widget>[
                      if(positives == "0")
                        Row(
                          children: [
                            Text(
                                'Positives: ',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              Text(
                                snapshot.data?.docs[index].get('positives'),
                                style: TextStyle(color: Colors.green),
                              ),
                              Text(
                                '/',
                                style: TextStyle(color: Colors.green),
                              ),
                              Text(
                                snapshot.data?.docs[index].get('total'),
                                style: TextStyle(color: Colors.green),
                              ),
                          ],
                        )
                        else if(positives != "0")
                        Row(
                          children: [
                            Text(
                                'Positives: ',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              Text(
                                snapshot.data?.docs[index].get('positives'),
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                '/',
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                snapshot.data?.docs[index].get('total'),
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
                        )
                    ],               
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  
                  trailing: Icon(
                    Icons.security_outlined
                  ),
                  
                ),
              );
            }, 
          );
        }  
      ),
    );
  }
}

// class historyList extends StatelessWidget {
//   const historyList({required this.document});
//   final List <DocumentSnapshot> document;
    
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: document.length,
//       itemBuilder: (BuildContext context, int i){
//         // String title = document[i].data().toString();
//         // var doc = document[i].data();

//         String url = document[i].data().toString();
//         String positives = document[i].data().toString();

//         // return ListTile(
//         //   title: Text(doc['url']),
//         // );
//         return SafeArea(child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
//             child: Container(
//               color: Colors.deepPurple[50],
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Text(
//                         "URL: ",
//                         style: TextStyle(fontSize: 15.0,),
//                       ),
//                       Expanded(
//                         child: Text(
//                           url,
//                           style: TextStyle(
//                             fontSize: 15.0,
//                             letterSpacing: 1.0,
//                             color: Colors.black,
//                           ),
//                         )
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Text(positives + ' security vendors flagged as malicious')
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(left: 50.0),
//                         child: IconButton(
//                           icon: Icon(Icons.sports_basketball, color: Colors.green,),
//                           onPressed: () async {
//                             await canLaunch(url);
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 70.0),
//                         child: IconButton(
//                           icon: Icon(Icons.delete, color: Colors.red,),
//                           onPressed: () {}, 
//                         ),
//                       ),                   

//                     ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//     );
//   }
// }