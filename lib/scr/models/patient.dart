import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  static const NAME = "name";
  static const STATUS = "status";

  String _name;
  String _date;
  List<String> _disease;
  List<String> _status;

  String get name => _name;

  List<String> get disease => _disease;

  String get date => _date;

  List<String> get status => _status;

  // public variable

  PatientModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];

    // _date = snapshot.data[DATE];

    // _disease = snapshot.data[DISEASE];

    _status = snapshot.data[STATUS];
  }
}
