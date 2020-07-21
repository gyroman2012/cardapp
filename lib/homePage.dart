import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      Firestore.instance.collection('ElyPics');

  @override
  void initState() {
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.documents;
      });
    });
    //  sdSubscription=sdcollectionReference.snapshots().listen((sddatasnap){
    //    sdSnapshot=sddatasnap.documents;
    //  }
    //  );
    super.initState();
    subscription.cancel();
  }

  passData(DocumentSnapshot snap) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailPage(
              snapshot: snap,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Elysia Rose",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
            backgroundColor: Colors.teal[400],
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            color: Colors.purple[400],
            child: ListView.builder(
              // itemCount: snapshot.15,

              scrollDirection: Axis.horizontal,

              itemBuilder: (context, index) {
                return Card(
                  color: Colors.blue[200],
                  elevation: 10.0,
                  margin: EdgeInsets.all(5.0),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          // child: Image.asset(
                          //   'images/squishy.jpeg',
                          child: Image.network(
                            snapshot[index].data["url"],
                            height: 130.0,
                            width: 130.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          snapshot[index].data["title"],
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.blue[600]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
