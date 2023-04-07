import 'package:flutter/material.dart';

class TextEditingControllers {
  static TextEditingController loginEmailController = TextEditingController();
  static TextEditingController loginPasswordController =
      TextEditingController();
  static TextEditingController loginEmailAdminController =
      TextEditingController();
  static TextEditingController loginPasswordAdminController =
      TextEditingController();
  static TextEditingController signUpEmailController = TextEditingController();
  static TextEditingController signUpNameController = TextEditingController();
  static TextEditingController signUpPasswordController =
      TextEditingController();
  static TextEditingController signUpPasswordConfirmController =
      TextEditingController();
  static TextEditingController forgetPasswordEmailController =
      TextEditingController();
  static TextEditingController addressOrderController = TextEditingController();
  static TextEditingController phoneNymberOrderController =
      TextEditingController();

  static TextEditingController activeUserDataNameController =
      TextEditingController();
  static TextEditingController activeUserDataEmailController =
      TextEditingController();
  static TextEditingController activeUserDataOldPasswordController =
      TextEditingController();
  static TextEditingController activeUserDataPasswordController =
      TextEditingController();
  static TextEditingController activeUserDataPasswordConfirmController =
      TextEditingController();
  static TextEditingController allUsersNameController = TextEditingController();
  static TextEditingController allUsersEmailController =
      TextEditingController();
  static late TextEditingController recipeNameAdminScreenController;
  static late TextEditingController recipePriceAdminScreenController;
  static late TextEditingController recipeCookingTimeAdminScreenController;
  static late TextEditingController categoryAdminNameController;
  static TextEditingController categoryAdminAddNameController =
      TextEditingController();
  static late List<TextEditingController> recipeEditIngredientsControllers;
}
