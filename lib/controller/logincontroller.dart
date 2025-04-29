import 'package:get/get.dart';

class LoginController extends GetxController {
  var errorMessage = "".obs;
  setMessage(newMessage) {
    errorMessage.value = newMessage;
  }
}
