import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/dio/dio.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/admin_screens/categories_admin_screen.dart';
import 'package:resturant/screens/admin_screens/orders_admin_screen.dart';
import 'package:resturant/screens/admin_screens/recipes_admin_screen.dart';
import 'package:resturant/screens/admin_screens/users_admin_screen.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AppintiState());

  static AdminCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<Widget> screen = [
    UsersAdmin(),
    RecipesAdmin(),
    CategoriesAdmin(),
    OrdersAdmin(),
  ];
  List<String> title = [
    'Users',
    'Recipes',
    'Categories',
    'Orders',
  ];

  changBottomnav(int index) {
    currentindex = index;

    emit(ChangebottomState());
  }

  bool result = true;

  Future<bool> checkConnecthion() async {
    result = await InternetConnectionChecker().hasConnection;
    emit(HasConnecthion());
    return result;
  }

  Future getAllusers(String token) {
    return DioFunc.getdate(
      url: EndPoints.users,
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      EndPoints.allUser = value.data['data']['data'];
      print(EndPoints.allUser);
      noDataUsers = false;
      emit(UsersGetSuccess());
    }).catchError((onError) {
      print(onError);
      emit(UsersGetError());
    });
  }

  deleteUserById(String token, String userId) {
    DioFunc.deleteData(
      url: '${EndPoints.users + userId}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      print(value);
      pageUsrs = 2;
      getAllusers(token);
      Fluttertoast.showToast(
          msg: 'Deleted success',
          backgroundColor: Colors.green,
          textColor: Colors.white);
    }).catchError((onError) {
      print(onError);
    });
  }

  updateuser(String token, String userId, String name, String email,
      BuildContext context, String role) {
    DioFunc.patchdata(
      url: '${EndPoints.users + userId}',
      token: token,
      name: name,
      email: email,
      role: role,
    ).then((value) {
      print(value);
      getAllusers(token);
      Navigator.of(context).pop();
    }).catchError((onError) {
      print(onError);
    });
  }

  Future getAllOrders(String token) {
    return DioFunc.getdate(
      url: '${EndPoints.allOrders}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      EndPoints.allorders = value.data['data']['data'];

      emit(OrderGetSuccess());
      print(EndPoints.allorders);
    }).catchError((onError) {
      emit(OrderGetError());
      print(onError);
    });
  }

  Future getAllCategories() {
    return DioFunc.getdate(
      url: EndPoints.categories,
    ).then((value) {
      EndPoints.allCategories = value.data['data']['data'];
      emit(CategorieCreatedSuccess());
      print(EndPoints.allCategories);
    }).catchError((onError) {
      emit(CategorieCreatedError());
      print(onError);
    });
  }

  createNewCategory(String token, String categorieName, BuildContext context) {
    DioFunc.postData(
      EndPoints.categories,
      {'name': categorieName},
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) async {
      print(value);

      Navigator.of(context).pop();
      await getAllCategories();
      emit(CategorieCreatedSuccess());
    }).catchError((onError) {
      emit(CategorieCreatedError());
      print(onError);
    });
  }

  deleteCategorie(String token, String CategorieId) {
    DioFunc.deleteData(
      url: '${EndPoints.categories + CategorieId}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      print(value);

      getAllCategories();
      Fluttertoast.showToast(
          msg: 'Deleted success',
          backgroundColor: Colors.green,
          textColor: Colors.white);
    }).catchError((onError) {
      print(onError);
    });
  }

  editCategorieName(
      String name, String token, String CategorieID, BuildContext context) {
    DioFunc.patchCategoriedata(
      url: '${EndPoints.categories + CategorieID}',
      token: token,
      name: name,
    ).then((value) {
      print(value);
      Navigator.of(context).pop();
      getAllCategories();
    }).catchError((onError) {
      print(onError);
    });
  }

  int page = 2;
  int pageUsrs = 2;
  int pageRecipe = 2;
  bool noData = false;
  bool noDataUsers = false;
  bool noDataRecipe = false;

  pageinathionOrders(String token) {
    emit(PageLoading());
    DioFunc.getdate(
      url: '${EndPoints.allOrdersPage + page.toString()}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((
      value,
    ) {
      // print(value.data['results']);
      if (value.data['results'] == 0) {
        page = page;
        noData = true;
        Fluttertoast.showToast(
          msg: 'End of data ):',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        emit(PageGetEnd());
      } else {
        page++;
        print(EndPoints.allorders.length);
        EndPoints.allorders.addAll(value.data['data']['data']);
        print(EndPoints.allorders);
        emit(PageGetSuccess());
      }
    }).onError((error, stackTrace) {
      print(error);
      emit(PageGetError());
    });
  }

  pageinathionusers(String token) {
    emit(PageLoading());
    DioFunc.getdate(
      url: '${EndPoints.allusersPage + pageUsrs.toString()}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((
      value,
    ) {
      // print(value.data['results']);
      if (value.data['results'] == 0) {
        pageUsrs = pageUsrs;
        noDataUsers = true;
        Fluttertoast.showToast(
          msg: 'End of data ):',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        emit(PageGetEnd());
      } else {
        pageUsrs++;
        print(EndPoints.allUser.length);
        EndPoints.allUser.addAll(value.data['data']['data']);
        print(EndPoints.allUser);
        emit(PageGetSuccess());
      }
    }).onError((error, stackTrace) {
      print(error);
      emit(PageGetError());
    });
  }

  pageinathionRecipes() {
    emit(PageLoading());
    DioFunc.getdate(
      url: '${EndPoints.allRecipiesPage + pageRecipe.toString()}',
    ).then((
      value,
    ) {
      // print(value.data['results']);
      if (value.data['results'] == 0) {
        pageRecipe = pageRecipe;
        noDataRecipe = true;
        Fluttertoast.showToast(
          msg: 'End of data ):',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        emit(PageGetEnd());
      } else {
        pageRecipe++;

        EndPoints.allrecipesAdmin.addAll(value.data['data']['data']);
        print(EndPoints.allrecipesAdmin);
        emit(PageGetSuccess());
      }
    }).onError((error, stackTrace) {
      print(error);
      emit(PageGetError());
    });
  }

  updateUserDataBase(
      {String name, String email, @required String token, context}) {
    DioFunc.patchdata(
      url: EndPoints.updateMe,
      name: name,
      email: email,
      token: token,
    ).then((value) {
      DataBaseFun.updateDataBase(email, name).then((value) {
        Fluttertoast.showToast(
          msg: 'Updated successfully',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        emit(updatedSucess());
      });

      print(name + email);
      //  print(value);
    }).catchError(
      (onError) {
        print(onError);
      },
    );
  }

  Future getallRecipes() {
    return DioFunc.getdate(
      url: EndPoints.allRecipies,
    ).then((value) {
      EndPoints.allrecipesAdmin = value.data['data']['data'];
      noDataRecipe = false;
      print(EndPoints.allrecipesAdmin);
      emit(RecipesGetSuccess());
    }).catchError((onError) {
      print(onError);
      emit(RecipesGetError());
    });
  }

  deleteRecipe(String token, String recipeId) {
    DioFunc.deleteData(
      url: '${EndPoints.allRecipies + recipeId}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      print(value);
      pageRecipe = 2;
      getallRecipes();

      Fluttertoast.showToast(
          msg: 'Deleted Success',
          backgroundColor: Colors.green,
          textColor: Colors.white);
      emit(RecipesDeleteSuccess());
    }).catchError((onError) {
      print(onError);
      emit(RecipesDeleteError());
    });
  }

  final ImagePicker picker = ImagePicker();
  File imagepicked;

  pickimage() async {
    // Pick an image
    File image =
        await picker.pickImage(source: ImageSource.gallery).then((value) {
      emit(ImagePicked());
      imagepicked = File(value.path);
    }).catchError((onError) {
      print(onError);
    });
    print(imagepicked.uri);
  }

  File AddImagePicked;

  Addimagepick() async {
    // Pick an image
    File image =
        await picker.pickImage(source: ImageSource.gallery).then((value) {
      emit(ImagePicked());
      AddImagePicked = File(value.path);
    }).catchError((onError) {
      print(onError);
    });
    print(AddImagePicked.uri);
  }

  editRecipeData(String token, String name, String slug, int price,
      int cookingtime, List ingredients, String recipeId, File image, context) {
    DioFunc.patchRecipe(
            token: token,
            image: image,
            ingredients: ingredients,
            slug: slug,
            price: price,
            cookingTime: cookingtime,
            name: name,
            url: '${EndPoints.allRecipies + recipeId}')
        .then((value) {
      print(value);

      getallRecipes();
      emit(RecipesGetSuccess());
      Fluttertoast.showToast(
          msg: 'Changes Saved Sucess',
          textColor: Colors.white,
          backgroundColor: Colors.green);
      Navigator.of(context).pop();
      imagepicked = null;
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: 'error', textColor: Colors.white, backgroundColor: Colors.red);
      print(onError);
    });
  }

  // CreateRecipeData(String token, String name, String slug, int price,
  //     int cookingtime, List ingredients, String recipeId, File image) {
  //  DioFunc.postData(url, {})
  // }
  List<TextEditingController> controller = [];

  cancelOrder(String recipeId, String token, BuildContext context) {
    DioFunc.deleteData(
      url: '${EndPoints.order + recipeId}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      page = 2;
      getAllOrders(token);
      Fluttertoast.showToast(
          msg: 'Deleted Success',
          backgroundColor: Colors.green,
          textColor: Colors.white);
      Navigator.of(context).pop();
      emit(OrderDeleteSuccess());

      print(value);
    }).catchError((onError) {
      emit(OrderDeleteError());
      print(onError);
    });
  }

  int lengthOFtextfield = 5;

  incrementTextfieldNumber(List<TextEditingController> savedcontroller) {
    controller = savedcontroller;
    lengthOFtextfield++;
    print(lengthOFtextfield);
    emit(IncrementTExtFieldNumer());
  }

  decrementTextfieldNumber(
      List<TextEditingController> savedcontroller, int index) {
    controller = savedcontroller;
    controller[index].clear();
    lengthOFtextfield--;
    print(lengthOFtextfield);
    emit(DecremntTExtFieldNumer());
  }

  addRecipe({
    String name,
    List ingredient,
    int price,
    int cockingtime,
    String slug,
    String category,
    String token,
    File image,
    context,
  }) {
    emit(UploadState());
    DioFunc.postRecipe(
            url: EndPoints.allRecipies,
            name: name,
            cookingTime: cockingtime,
            price: price,
            slug: slug,
            ingredients: ingredient,
            token: token,
            category: category,
            image: image)
        .then((value) {
      print(value);
      pageRecipe = 2;
      getallRecipes();

      emit(RecipeCreatedSucces());
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: 'Created Success',
          textColor: Colors.white,
          backgroundColor: Colors.green);
      for (int i = 0; i < controller.length; i++) {
        controller[i].clear();
      }
      lengthOFtextfield = 5;
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg:
              'error,please make sure to fill all fields and size of image less than 2 mb',
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white);
      print(onError);
      emit(RecipeCreatedError());
    });
  }

  editRecipeWithoutPhoto(
      String recipeId,
      String token,
      String name,
      String slug,
      List ingredients,
      String category,
      int cockingtime,
      int price,
      context) {
    emit(UploadState());
    DioFunc.patchRecipeWithoutPhoto(
            token: token,
            category: category,
            slug: slug,
            price: price,
            name: name,
            ingredients: ingredients,
            url: '${EndPoints.allRecipies + recipeId}',
            cookingTime: cockingtime)
        .then((value) {
      print(value);
      Fluttertoast.showToast(
          msg: 'changes saved success',
          textColor: Colors.white,
          backgroundColor: Colors.green);
      Navigator.of(context).pop();
      getallRecipes();
      emit(RecipesGetSuccess());
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: 'error', textColor: Colors.white, backgroundColor: Colors.red);
      print(onError);
    });
  }

  changeTheme() async {
    EndPoints.isDark = !EndPoints.isDark;
    await CachFunc.putBoolDate(key: 'isDark', data: EndPoints.isDark);
    emit(ChangeTheme());
  }
}
