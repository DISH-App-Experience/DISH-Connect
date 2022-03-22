import 'package:dish_connect/helpers/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OwnerServices {
  Future<bool> doesUserExist(String id) async {
    var result = false;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        result = false;
      } else {
        result = true;
      }
    });
    return Future<bool>.value(result);
  }
}

void getOwnerInformation() async {
  owner?.imageURL =
      "https://th.bing.com/th/id/OIP.g3HtByLwSRQjrxXiaCk0LgAAAA?pid=ImgDet&rs=1";
}
