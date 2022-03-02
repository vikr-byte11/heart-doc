import 'package:HeartDoc/scr/models/patient.dart';
import 'package:HeartDoc/scr/screens/notification.dart';
import 'package:HeartDoc/scr/screens/update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:HeartDoc/scr/helpers/screen_navigation.dart';
import 'package:HeartDoc/scr/helpers/style.dart';
import 'package:HeartDoc/scr/providers/app.dart';
import 'package:HeartDoc/scr/providers/user.dart';
import 'package:HeartDoc/scr/screens/login.dart';
import 'package:HeartDoc/scr/widgets/custom_text.dart';
import 'package:HeartDoc/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:HeartDoc/scr/screens/graph.dart';
import 'package:HeartDoc/scr/models/user.dart';
import 'package:HeartDoc/scr/screens/search.dart';
import 'package:HeartDoc/scr/screens/plot.dart';
import 'package:HeartDoc/scr/screens/globals.dart' as globals;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    bool check = false;
    int l;
    // // final categoryProvider = Provider.of<CategoryProvider>(context);
    // // final restaurantProvider = Provider.of<RestaurantProvider>(context);
    // // final productProvider = Provider.of<ProductProvider>(context);
    // restaurantProvider.loadSingleRestaurant()
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Colors.orange, Colors.red]),
                color: primary,
              ),
              accountName: CustomText(
                text: user.userModel?.name ?? "username loading...",
                color: white,
                weight: FontWeight.bold,
                size: 25,
              ),
              accountEmail: CustomText(
                  text: user.userModel?.email ?? "email loading...",
                  color: white,
                  size: 25),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, Home());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, UpdateProfile());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Update Profile"),
            ),
            ListTile(
              onTap: () async {
                //await user.getOrders();
                print(user.userModel?.name);
                changeScreen(context, Search(user.userModel?.name));
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My records"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : SafeArea(
              // Divider(),
              //       SizedBox(
              //         height: 10,
              //        ),
              child: ListView(
                children: <Widget>[
                  Divider(),
                  SizedBox(
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      // child: Icon(Icons.input),
                      onTap: () async {
                        await getUpload();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomText(
                                text: "Input File",
                                color: white,
                                size: 22,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      // child: Icon(Icons.input),
                      onTap: () async {
                        if (globals.check == true) {
                          await runmodel();
                          changeScreenReplacement(context, Plot());
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Input a file first"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        //getprediction();
                        // SizedBox(
                        //   width: 80,
                        //   height: 220,
                        //   child: Column(children: <Widget>[
                        //     Expanded(
                        //       child: new charts.LineChart(
                        //         getSeriesData(),
                        //         animate: true,
                        //         primaryMeasureAxis: new charts.NumericAxisSpec(
                        //             tickProviderSpec:
                        //                 new charts.BasicNumericTickProviderSpec(
                        //           zeroBound: false,
                        //         )),
                        //       ),
                        //     )
                        //   ]),
                        // );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomText(
                                text: "Submit",
                                color: white,
                                size: 22,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
//
                  SizedBox(
                    height: 5,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       CustomText(
                  //         text: "Graphical Presentations",
                  //         size: 20,
                  //         color: grey,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // // if(check==true)
                  // // getprediction();

                  // SizedBox(
                  //   width: 80,
                  //   height: 220,
                  //   child: Column(children: <Widget>[
                  //     Expanded(
                  //       child: new charts.LineChart(
                  //         getSeriesData(),
                  //         animate: true,
                  //         primaryMeasureAxis: new charts.NumericAxisSpec(
                  //             tickProviderSpec:
                  //                 new charts.BasicNumericTickProviderSpec(
                  //           zeroBound: false,
                  //         )),
                  //       ),
                  //     )
                  //   ]),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       CustomText(
                  //         text: "Result",
                  //         size: 20,
                  //         color: grey,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }
}
