import 'package:resturant/models/class_models/login_model.dart';
import 'package:resturant/models/class_models/sign_up_model.dart';

class EndPoints {
  static String url = 'https://panda-restaurant.herokuapp.com/api/v1';
  static String SignUp = url + '/users/signup';
  static String Login = url + '/users/login';
  static String allRecipies = url + '/recipes/';
  static String categories = url + '/categories/';
  static String search = url + '/recipes/search';
  static String updateMe = url + '/users/updateMe';
  static String order = url + '/orders/';
  static String getCategoryRecipe = url + '/recipes/?category=';
  static LoginModel loginModel;
  static SignUpModel signUpModel;
  static Map<String, dynamic> allRecipiesMap;
  static Map<String, dynamic> allCategoriesMap;
  static List FilteredCartDataBase;
  static List FavoriteDataBase;
}
