import 'dart:async';

import 'package:HeartDoc/scr/screens/graph.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:HeartDoc/scr/screens/doctor.dart';
import 'package:HeartDoc/scr/models/user.dart';
import 'package:HeartDoc/scr/helpers/screen_navigation.dart';
import 'package:HeartDoc/scr/widgets/custom_text.dart';
import 'package:hovering/hovering.dart';
import 'package:HeartDoc/scr/screens/globals.dart' as globals;
import 'package:HeartDoc/scr/screens/plot.dart';

class Search extends StatefulWidget {
  final String search;
  // List<doctor> docs;
  // final int i;
  Search(this.search);
  Firestore _firestore = Firestore.instance;
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override

  //   dynamic patient;
  //   Future<dynamic> getPatientById(String id) =>
  //     Firestore.instance.collection('patient').document('Ayush').get().then((doc) {
  //       return patient.fromSnapshot(doc);
  //     });
  //   // Future<void> getPatient(id) async {
  //   //   final DocumentReference document =
  //   //       Firestore.instance.collection('patients').document('Ayush');
  //   //   await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
  //   //     setState(() {
  //   //       patient = snapshot.data;
  //   //     });
  //   //   });
  //   // }
  //   void initState() {
  //   super.initState();
  //   getPatientById("Ayush");
  // }

  @override
  Widget build(BuildContext context) {
    int i;

    print("Reached");
    print("Reached");
    print("Reached");
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('patient').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text("Loading");
          print(snapshot.data.documents.length);
          print(snapshot.data.documents.length);
          print(snapshot.data.documents.length);
          print(snapshot.data.documents.length);
          print(snapshot.data.documents.length);
          int j = -1;
          for (i = 0; i < snapshot.data.documents.length; i++) {
            if (snapshot.data.documents[i]['name'] == widget.search) {
              if (snapshot.data.documents[i]['Date-Status'] != "null")
                j = snapshot.data.documents[i]['Date-Status'].length;
              print("----------------");
              print(j);
              print(j);
              print(j);
              print(j);
              break;
              //List<String> items=List.from(userDocument['items']);
              // var k = snapshot.data.documents[i]['Date'][0].length;

            }
          }
          if (j <= 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomText(
                      text: "No Records Found",
                      color: Colors.grey,
                      weight: FontWeight.w300,
                      size: 22,
                    ),
                  ],
                )
              ],
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomText(
                          text: "Name     :   ",
                          color: Colors.red,
                          size: 20,
                        ),
                        CustomText(
                          text: snapshot.data.documents[i]['name'],
                          color: Colors.blue,
                          size: 20,
                        ),
                      ],
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomText(
                          text: "Disease  :   ",
                          color: Colors.red,
                          size: 20,
                        ),
                        CustomText(
                          text: snapshot.data.documents[i]['disease'],
                          color: Colors.blue,
                          size: 20,
                        ),
                      ],
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomText(
                          text: "Doctor    :   ",
                          color: Colors.red,
                          size: 20,
                        ),
                        CustomText(
                          text: snapshot.data.documents[i]['doctor'],
                          color: Colors.blue,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Text("Disease : " + snapshot.data.documents[i]['disease']),
                    // Text("Doctor : " + snapshot.data.documents[i]['doctor']),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomText(
                          text: "      Date-Time                              ",
                          color: Colors.black,
                          size: 17,
                        ),
                        CustomText(
                          text: "Status",
                          color: Colors.black,
                          size: 17,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    for (int l = 0; l < j; l++)
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          HoverButton(
                            onpressed: () {
                              globals.contents =
                                  snapshot.data.documents[i]['Contents'][l];
                              doit();
                              Timer(Duration(seconds: 1), () {
                                print(
                                    "Yeah, this line is printed after 3 seconds");
                                changeScreenReplacement(context, Plot());
                              });
                            },
                            color: Colors.green,
                            hoverColor: Colors.red,
                            hoverTextColor: Colors.blue,
                            child: Text(
                                snapshot.data.documents[i]['Date-Status'][l]),
                            // child: CustomText(
                            //   text: snapshot.data.documents[i]['Date-Status'][l],
                            //   color: Colors.green,
                            //   size: 18,
                            // ),
                          )
                        ],
                      ),
                    // Text(snapshot.data.documents[i]['Date-Status'][l])
                    // "   :   " +
                    // snapshot.data.documents[i]['Status'][l]),
                    // for (int l = 0; l < j; l++)
                    //Text(),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

//body: productProvider.productsSearched.length < 1? Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Icon(Icons.search, color: grey, size: 30,),
//             ],
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               CustomText(text: "No products Found", color: grey, weight: FontWeight.w300, size: 22,),
//             ],
//           )
//         ],
//       ) : ListView.builder(
//           itemCount: productProvider.productsSearched.length,
//           itemBuilder: (context, index){
//             return GestureDetector(
//                 onTap: ()async{
//                   changeScreen(context, Details(product: productProvider.productsSearched[index]));
//                 },
//                 child: ProductWidget(product: productProvider.productsSearched[index]));
//           }),
//     );
//   }
// }
