import 'package:flutter/material.dart';
import 'package:HeartDoc/scr/helpers/screen_navigation.dart';
import 'package:HeartDoc/scr/helpers/style.dart';
import 'package:HeartDoc/scr/providers/user.dart';
import 'package:HeartDoc/scr/screens/login.dart';
import 'package:HeartDoc/scr/widgets/custom_text.dart';
import 'package:HeartDoc/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:HeartDoc/scr/screens/globals.dart' as globals;

import 'home.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    // final categoryProvider = Provider.of<CategoryProvider>(context);
    // final restaurantProvider = Provider.of<RestaurantProvider>(context);
    // final productProvider = Provider.of<ProductProvider>(context);
    String setValue = "Choose your doctor";
    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: auth.status == Status.Authenticating
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
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
                          controller: auth.name,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
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
                          controller: auth.email,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Emails",
                              icon: Icon(Icons.email)),
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
                          controller: auth.password,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              icon: Icon(Icons.lock)),
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
                          controller: auth.disease,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Disease",
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
                            controller: auth.dob,
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
                              auth.dob.text = newDate;
                            },
                          )
                          //  TextFormField(
                          //   controller: auth.dob,
                          //   decoration: InputDecoration(
                          //       border: InputBorder.none,
                          //       hintText: "Date of Birth",
                          //       icon: Icon(Icons.event)),
                          // ),
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
                          child: DropdownButton(
                            isExpanded: true,
                            hint: new Text(setValue),
                            items: globals.docs.map((globals.doctor value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value.name),
                              );
                            }).toList(),
                            onChanged: (newvalue) {
                              auth.doctor.text = newvalue.name;
                              print(newvalue.name);
                            },
                          )),

                      // TextFormField(
                      //   controller: auth.doctor,
                      //   decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       hintText: "Choose your doctor",
                      //       icon: Icon(Icons.local_hospital_rounded)),
                      // ),
                    ),
                  ),

                  // DropdownButton(
                  //         // icon: const Icon(Icons.arrow_downward),
                  //         // iconSize: 24,
                  //         // elevation: 16,
                  //         isExpanded: true,
                  //         items: <DropdownMenuItem>[
                  //           DropdownMenuItem(
                  //             child: Text(
                  //               "         Choose Your Doctor",
                  //               style: TextStyle(
                  //                 color: Colors.grey[700],
                  //               ),
                  //             ),
                  //           ),
                  //           DropdownMenuItem(
                  //             child: Text(
                  //               "Null",
                  //               style: TextStyle(
                  //                 color: Colors.black,
                  //               ),
                  //             ),
                  //           ),
                  //           for (int i = 0; i < globals.docs.length; i++)
                  //             DropdownMenuItem(
                  //               child: Text(
                  //                 globals.docs[i].name,
                  //                 style: TextStyle(
                  //                   color: Colors.black,
                  //                 ),
                  //               ),
                  //             ),
                  //         ],
                  //         onChanged: (String newvalue) {
                  //           // setState(() {
                  //           //   drop = newvalue;
                  //           // });
                  //           print(newvalue);
                  //           if (newvalue == "Choose Your Doctor" ||
                  //               newvalue == "Null") {
                  //             TextEditingController doctor;
                  //             doctor.text = "Null";
                  //             auth.doctor = doctor;
                  //           } else
                  //             auth.doctor.text = newvalue;
                  //         },
                  //       ),
                  //     ),
                  //     // TextFormField(
                  //     //   controller: auth.doctor,
                  //     //   decoration: InputDecoration(
                  //     //       border: InputBorder.none,
                  //     //       hintText: "Choose your doctor",
                  //     //       icon: Icon(Icons.local_hospital_rounded)),
                  //     // ),
                  //   ),
                  // ),
                  //padding: EdgeInsets.all(10),

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () async {
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");

                        if (!await auth.signUp()) {
                          _key.currentState.showSnackBar(
                              SnackBar(content: Text("Registration failed!")));
                          return;
                        }
                        auth.clearController();
                        changeScreenReplacement(context, Home());
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
                                text: "Register",
                                color: white,
                                size: 22,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeScreen(context, LoginScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: "Login here",
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
