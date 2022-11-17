class EndPoints {
  static const String baseUrl = 'https://panda-restaurant.herokuapp.com/api/v1';
  static const String signUp = '$baseUrl/users/signup';
  static const String login = '$baseUrl/users/login';
  static const String getMe = '$baseUrl/users/me';
  static const String allRecipies = '$baseUrl/recipes/';
  static const String allRecipiesPage = '$baseUrl/recipes/?page=';
  static const String categories = '$baseUrl/categories/';
  static const String search = '$baseUrl/recipes/search';
  static const String updateMe = '$baseUrl/users/updateMe';
  static const String myOrder = '$baseUrl/orders/';
  static const String allusers = '$baseUrl/users/';
  static const String allusersPage = '$baseUrl/users/?page=';
  static const String allOrders = '$baseUrl/orders/all';
  static const String allOrdersPage = '$baseUrl/orders/all?page=';
  static const String getCategoryRecipe = '$baseUrl/recipes/?category=';
  static const String updatePassword = '$baseUrl/users/updateMyPassword';
  static const String forgetPassword = '$baseUrl/users/forgotPassword';
  static const String cancelOrder = '$baseUrl/orders/cancelOrder/';
}
