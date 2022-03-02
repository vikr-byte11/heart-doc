library globals;

int length = 0;
List<String> result;
double error = 0;
bool check = false;
String url = "";
String contents = "";
bool input = false;
class doctor {
  final String name;
  final String email;
  final String pass;
  doctor({this.email, this.pass, this.name});
}
List<doctor> docs = [
  doctor(name: "Dr Ayush", email: "ayush1234@gmail.com", pass: "123456"),
  doctor(name: "Dr Rakesh", email: "rakesh1234@gmail.com", pass: "123456"),
  doctor(name: "Dr Rahul", email: "rahul1234@gmail.com", pass: "123456"),
  doctor(name: "Dr Fahiem", email: "fahiem1234@gmail.com", pass: "123456"),
  doctor(name: "Dr Harshit", email: "harshit1234@gmail.com", pass: "123456"),
];
