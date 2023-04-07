// import '../const/app_strings.dart';

// class ValidationHelper {
//   static String? validateEmail({
//     required String? value,
//   }) {
//     Pattern pattern =
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//     RegExp regex = RegExp(pattern.toString());

//     if (value == null || value == '') {
//       return AppStrings.pleaseEnterYourEmail.tr();
//     } else if (!(regex.hasMatch(value))) {
//       return AppStrings.invalidEmail.tr();
//     } else {
//       return null;
//     }
//   }

//   static String? validatePassword({
//     required String? value,
//   }) {
//     RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$');
//     if (value == null || value == '') {
//       return AppStrings.pleaseEnterYourPassword.tr();
//     } else {
//       if (!regex.hasMatch(value)) {
//         return AppStrings.shouldContainOneUpperCaseDigitAndMinimum8Characters
//             .tr();
//       } else {
//         return null;
//       }
//     }
//   }

//   static String? validatePassowrdConfirm(
//       {required String? confirmPassword, required String password}) {
//     if (confirmPassword == null || confirmPassword == '') {
//       return AppStrings.pleaseEnterYourPasswordAgain.tr();
//     } else if (confirmPassword != password) {
//       return AppStrings.invalidPassword.tr();
//     } else {
//       return null;
//     }
//   }

//   static String? validateName({required String? value, String? name}) {
//     if (value == null || value == '') {
//       return '${AppStrings.pleaseEnter.tr()} ${name ?? AppStrings.name.tr()}';
//     } else {
//       return null;
//     }
//   }

//   static String? validateBio({required String? value}) {
//     if (value == null || value == '') {
//       return AppStrings.pleaseEnterYourBio.tr();
//     } else {
//       return null;
//     }
//   }

//   static String? validateRoomName({required String? value}) {
//     RegExp regex = RegExp(r'^[a-zA-Z0-9_]+$');
//     if (value == null || value == '') {
//       return AppStrings.pleaseEnterYourRoomName.tr();
//     } else if (value.length < 3) {
//       return AppStrings.roomNameMustBeAtLeast3Characters.tr();
//     } else if (!regex.hasMatch(value)) {
//       return AppStrings.roomNameMustBeAlphanumeric.tr();
//     } else {
//       return null;
//     }
//   }

//   static String? privateRoomId({required String? value}) {
//     if (value == null || value == '') {
//       return AppStrings.pleaseEnterYourRoomId.tr();
//     } else if (value.length != 24) {
//       return AppStrings.roomIdMustBe24Characters.tr();
//     } else {
//       return null;
//     }
//   }
// }
