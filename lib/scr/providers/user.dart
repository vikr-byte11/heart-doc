import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:HeartDoc/scr/helpers/user.dart';
import 'package:HeartDoc/scr/models/user.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Firestore _firestore = Firestore.instance;
  UserServices _userServicse = UserServices();
  DocServices _docServices = DocServices();
  UserModel _userModel;
  DocModel _docModel;

//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  FirebaseUser get user => _user;
  DocModel get docModel => _docModel;

  // public variables

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController disease = TextEditingController();
  TextEditingController doctor = TextEditingController();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> Update(String userid) async {
    //print(userid);
    _firestore.collection('users').document(userid).updateData({
      'name': name.text,
      'disease': disease.text,
      'dob': dob.text,
      'email': email.text,
      'doctor': doctor.text,
    });
    _firestore.collection('patient').document(email.text).updateData({
      'name': name.text,
      'doctor': doctor.text,
      'disease': disease.text,
    });
    return true;
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('users').document(result.user.uid).setData({
          'name': name.text,
          'disease': disease.text,
          'dob': dob.text,
          'email': email.text,
          'uid': result.user.uid,
          'doctor': doctor.text,
        });
        List list;
        _firestore.collection('patient').document(email.text).setData({
          'name': name.text,
          'disease': disease.text,
          'Date-Status': "null",
          'doctor': doctor.text,
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
    dob.text = "";
    disease.text = "";
    doctor.text = "";
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServicse.getUserById(user.uid);
    notifyListeners();
  }

  Future<void> _onStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServicse.getUserById(user.uid);
    }
    notifyListeners();
  }
}

// class DocProvider with ChangeNotifier {
//   FirebaseAuth _auth1;
//   FirebaseUser _user1;
//   Status _status = Status.Uninitialized;
//   Firestore _firestore = Firestore.instance;
//   DocServices _docServices = DocServices();
//   DocModel _docModel;

// //  getter
//   Status get status => _status;
//   FirebaseUser get user1 => _user1;
//   DocModel get docModel => _docModel;

//   // public variables

//   final formkey = GlobalKey<FormState>();

//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController name = TextEditingController();

//   DocProvider.initialize() : _auth1 = FirebaseAuth.instance {
//     _auth1.onAuthStateChanged.listen(_onStateChanged);
//   }

//   Future<bool> signIn() async {
//     try {
//       _status = Status.Authenticating;
//       notifyListeners();
//       await _auth1.signInWithEmailAndPassword(
//           email: email.text.trim(), password: password.text.trim());
//       return true;
//     } catch (e) {
//       _status = Status.Unauthenticated;
//       notifyListeners();
//       print(e.toString());
//       return false;
//     }
//   }

//   Future<bool> Update(String userid) async {
//     //print(userid);
//     _firestore.collection('doc').document(userid).updateData({
//       'name': name.text,
//       'email': email.text,
//       'password': password.text,
//     });
//     return true;
//   }

//   // Future<bool> signUp() async {
//   //   try {
//   //     _status = Status.Authenticating;
//   //     notifyListeners();
//   //     await _auth
//   //         .createUserWithEmailAndPassword(
//   //             email: email.text.trim(), password: password.text.trim())
//   //         .then((result) {
//   //       _firestore.collection('users').document(result.user.uid).setData({
//   //         'name': name.text,
//   //         'disease': disease.text,
//   //         'dob': dob.text,
//   //         'email': email.text,
//   //         'uid': result.user.uid,
//   //         'doctor': doctor.text,
//   //       });
//   //     });
//   //     return true;
//   //   } catch (e) {
//   //     _status = Status.Unauthenticated;
//   //     notifyListeners();
//   //     print(e.toString());
//   //     return false;
//   //   }
//   // }

//   Future signOut() async {
//     _auth1.signOut();
//     _status = Status.Unauthenticated;
//     notifyListeners();
//     return Future.delayed(Duration.zero);
//   }

//   void clearController() {
//     name.text = "";
//     password.text = "";
//     email.text = "";
//   }

//   Future<void> reloadDocModel() async {
//     _docModel = await _docServices.getDocById(user1.uid);
//     notifyListeners();
//   }

//   Future<void> _onStateChanged(FirebaseUser firebaseUser) async {
//     if (firebaseUser == null) {
//       _status = Status.Unauthenticated;
//     } else {
//       _user1 = firebaseUser;
//       _status = Status.Authenticated;
//       _docModel = await _docServices.getDocById(user1.uid);
//     }
//     notifyListeners();
//   }

//   Future<bool> verifyDoc() async {
//     print("Found");
//     print("Found");
//     print("Found");
//     print("Found");
//     _docModel = await _docServices.getDocById(email.text);
//     print("Docservices");
//     print(_docModel.password);
//     print(_docModel.password);
//     print(_docModel.password);
//     _status = Status.Authenticating;
//     if (_docModel.password == password.text) {
//       return true;
//     } else {
//       print("Unauthenticated");
//       print("Unauthenticated");
//       print("Unauthenticated");
//       print("Unauthenticated");
//       print("Unauthenticated");

//       _status = Status.Unauthenticated;
//       return false;
//     }
//   }
// }
// }
