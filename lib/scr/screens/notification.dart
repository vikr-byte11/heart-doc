import 'package:HeartDoc/scr/providers/app.dart';
import 'package:flutter/material.dart';
import 'package:HeartDoc/scr/helpers/screen_navigation.dart';
import 'package:HeartDoc/scr/helpers/style.dart';
import 'package:HeartDoc/scr/providers/user.dart';
import 'package:HeartDoc/scr/screens/home.dart';
import 'package:HeartDoc/scr/screens/registration.dart';
import 'package:HeartDoc/scr/widgets/custom_text.dart';
import 'package:HeartDoc/scr/widgets/loading.dart';
import 'package:provider/provider.dart';

class notification_screen extends StatefulWidget {
  @override
  _notification_screenState createState() => _notification_screenState();
}

class _notification_screenState extends State<notification_screen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Container(
      
    );
  }
}