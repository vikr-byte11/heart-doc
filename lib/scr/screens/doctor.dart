
import 'package:HeartDoc/scr/screens/notification.dart';
import 'package:HeartDoc/scr/screens/update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:HeartDoc/scr/helpers/screen_navigation.dart';
import 'package:HeartDoc/scr/helpers/style.dart';
import 'package:HeartDoc/scr/providers/app.dart';
import 'package:HeartDoc/scr/screens/login.dart';
import 'package:HeartDoc/scr/widgets/custom_text.dart';
import 'package:HeartDoc/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:HeartDoc/scr/screens/graph.dart';
import 'package:HeartDoc/scr/models/user.dart';
import 'package:HeartDoc/scr/screens/search.dart';
import 'package:HeartDoc/scr/models/patient.dart';
import 'package:HeartDoc/scr/screens/globals.dart' as globals;

class Doctor extends StatefulWidget {
  List<globals.doctor> docs;
  final int i;
  Doctor(this.docs, this.i);

  @override
  _DoctorState createState() => _DoctorState();
}

TextEditingController search = TextEditingController();

class _DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "HeartDoc",
          color: white,
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notification_important),
                onPressed: () {
                  changeScreen(context, notification_screen());
                },
              ),
            ],
          ),
        ],
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
                text: widget.docs[widget.i].name ?? "username loading...",
                color: white,
                weight: FontWeight.bold,
                size: 25,
              ),
              accountEmail: CustomText(
                  text: widget.docs[widget.i].email ?? "email loading...",
                  color: white,
                  size: 25),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, Doctor(widget.docs, widget.i));
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () {
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
       body:
       app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          :
       SafeArea(
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.search,
                            color: red,
                          ),
                          //FilePickerResult result = await FilePicker.platform.pickFiles();

                          // User canceled the picker

                          title: TextField(
                            controller: search,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (pattern) async {
                              //app.changeLoading();
                              print("search");
                              print(search.text);
                              print(search.text);
                              print(search.text);
                              // await patientProvider.search(
                              //     patientName: pattern);
                              changeScreen(context, Search(search.text));
                            },
                            
                            decoration: InputDecoration(
                              hintText: "Search",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: <Widget>[
                  //     CustomText(
                  //       text: "Search by:",
                  //       color: grey,
                  //       weight: FontWeight.w300,
                  //     ),
                  //     DropdownButton<String>(
                  //       value: app.filterBy,
                  //       style: TextStyle(
                  //           color: primary, fontWeight: FontWeight.w300),
                  //       icon: Icon(
                  //         Icons.filter_list,
                  //         color: primary,
                  //       ),
                  //       elevation: 0,
                  //       onChanged: (value) {
                  //         if (value == "Products") {
                  //           app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                  //         } else {
                  //           app.changeSearchBy(
                  //               newSearchBy: SearchBy.RESTAURANTS);
                  //         }
                  //       },
                  //       items: <String>["Products", "Restaurants"]
                  //           .map<DropdownMenuItem<String>>((String value) {
                  //         return DropdownMenuItem<String>(
                  //             value: value, child: Text(value));
                  //       }).toList(),
                  //     ),
                  //   ],
                  // ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
//                   Container(
//                     height: 100,
//                     child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: categoryProvider.categories.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () async {
// //                              app.changeLoading();
//                               await productProvider.loadProductsByCategory(
//                                   categoryName:
//                                       categoryProvider.categories[index].name);

//                               changeScreen(
//                                   context,
//                                   CategoryScreen(
//                                     categoryModel:
//                                         categoryProvider.categories[index],
//                                   ));

// //                              app.changeLoading();
//                             },
//                             child: CategoryWidget(
//                               category: categoryProvider.categories[index],
//                             ),
//                           );
//                         }),
//                   ),
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
                  //                     zeroBound: false)),
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
                  // Column(
                  //   children: restaurantProvider.restaurants
                  //       .map((item) => GestureDetector(
                  //             onTap: () async {
                  //               app.changeLoading();

                  //               await productProvider.loadProductsByRestaurant(
                  //                   restaurantId: item.id);
                  //               app.changeLoading();

                  //               changeScreen(
                  //                   context,
                  //                   RestaurantScreen(
                  //                     restaurantModel: item,
                  //                   ));
                  //             },
                  //             child: RestaurantWidget(
                  //               restaurant: item,
                  //             ),
                  //           ))
                  //       .toList(),
                  // )
                ],
              ),
            ),
    );
  }
}
