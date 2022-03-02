import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:HeartDoc/scr/helpers/screen_navigation.dart';
import 'package:HeartDoc/scr/helpers/style.dart';
import 'package:HeartDoc/scr/providers/app.dart';
import 'package:HeartDoc/scr/providers/user.dart';
import 'package:HeartDoc/scr/screens/login.dart';
import 'package:HeartDoc/scr/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    final authProvider1 = Provider.of<UserProvider>(context);
    String userID = "";
    fetchUseridInfo() async {
      FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
      userID = getUser.uid;
    }

    //  TextEditingController _email = TextEditingController();
    //  TextEditingController _password = TextEditingController();
    //  TextEditingController _name = TextEditingController();
    //  TextEditingController _dob = TextEditingController();
    //  TextEditingController _disease = TextEditingController();
    //  TextEditingController _doctor = TextEditingController();
    fetchUseridInfo();
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    authProvider1.name.text = user.userModel?.name;
    authProvider1.dob.text = user.userModel?.dob;
    authProvider1.disease.text = user.userModel?.disease;
    authProvider1.doctor.text = user.userModel?.doctor;
    authProvider1.email.text = user.userModel?.email;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: white),
          elevation: 0.5,
          backgroundColor: primary,
          title: CustomText(
            text: "HeartDoc",
            color: white,
          ),
          // actions: <Widget>[
          //   Stack(
          //     children: <Widget>[
          //       IconButton(
          //         icon: Icon(Icons.notification_important),
          //         onPressed: () {
          //           changeScreen(context, notification_screen());
          //         },
          //       ),
          //     ],
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "images/logo.jpg",
                width: 100,
                height: 100,
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: grey),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  // initialValue: user.userModel?.name,
                  controller: authProvider1.name,

                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: user.userModel?.name,
                      icon: Icon(Icons.person)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: grey),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: authProvider1.disease,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: user.userModel?.disease,
                      icon: Icon(Icons.medical_services)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: grey),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  
                  controller: authProvider1.doctor,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: user.userModel?.doctor,
                      icon: Icon(Icons.local_hospital_rounded)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: grey),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                            controller: authProvider1.dob,
                            decoration: InputDecoration(
                              // labelText: "Date of birth",
                              icon: Icon(Icons.event),
                              hintText: "Date of birth",
                            ),
                            onTap: () async {
                              DateTime date = DateTime(1900);
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());

                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));
                              var date1 =
                                  DateTime.parse("2019-04-16 12:18:06.018950");
                              var formattedDate =
                                  "${date.day}-${date.month}-${date.year}";
                              String newDate = formattedDate.toString();
                              authProvider1.dob.text = newDate;
                            },
                          )
                
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                  onTap: () async {
                    print("MY USER ID");
                    print("MY USER ID");
                    print("MY USER ID");
                    print("MY USER ID");
                    print(userID);
                    user.Update(userID);
                    authProvider1.clearController();
                    user.clearController();
                    user.signOut();
                    changeScreenReplacement(context, LoginScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: red,
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomText(
                            text: "Update",
                            color: white,
                            size: 22,
                          )
                        ],
                      ),
                    ),
                  )))
        ]))
//       body: Center(
//           child: Column(children: <Widget>[
//         Container(
//           margin: EdgeInsets.all(20),
//           child: Table(
//             defaultColumnWidth: FixedColumnWidth(120.0),
//             border: TableBorder.all(
//                 color: Colors.black, style: BorderStyle.solid, width: 2),
//             children: [
//               // TableRow(children: [
//               //   Column(children: [
//               //     Text('Name', style: TextStyle(fontSize: 20.0))
//               //   ]),
//               //   Column(children: [
//               //     Text('Dob', style: TextStyle(fontSize: 20.0))
//               //   ]),
//               //   Column(children: [
//               //     Text('Doctor', style: TextStyle(fontSize: 20.0))
//               //   ]),
//               //   // Column(children: [
//               //   //   Text('Disease', style: TextStyle(fontSize: 20.0))
//               //   // ])
//               // ]),
//               TableRow(children: [
//                 Column(children: [Text('Name',style: TextStyle(fontSize: 20.0))]),
//                 Column(children: [Text('Flutter')]),
//                 Column(children: [Text('5*')]),
//               ]),
//               TableRow(children: [
//                 Column(children: [Text('Doctor',style: TextStyle(fontSize: 20.0))]),
//                 Column(children: [Text('MySQL')]),
//                 Column(children: [Text('5*')]),
//               ]),
//               TableRow(children: [
//                 Column(children: [Text('Disease',style: TextStyle(fontSize: 20.0))]),
//                 Column(children: [Text('ReactJS')]),
//                 Column(children: [Text('5*')]),
//               ]),
//             ],
//           ),
//         ),
//       ])),
        );
  }
}
