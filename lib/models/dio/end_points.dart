import 'package:resturant/models/class_models/login_model.dart';
import 'package:resturant/models/class_models/sign_up_model.dart';

class EndPoints {
  static String url = 'https://panda-restaurant.herokuapp.com/api/v1';
  static String SignUp = url + '/users/signup';
  static String Login = url + '/users/login';
  static String allRecipies = url + '/recipes/';
  static LoginModel loginModel;
  static SignUpModel signUpModel;
}
