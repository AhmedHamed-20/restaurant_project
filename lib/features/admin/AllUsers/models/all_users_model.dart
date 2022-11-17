import 'package:equatable/equatable.dart';
import 'package:resturant/features/admin/AllUsers/models/all_user_data_model.dart';

class AllUsersModel extends Equatable {
  final int results;
  final List<AllUsersDataModel> usersData;

  const AllUsersModel({required this.results, required this.usersData});

  factory AllUsersModel.fromJson(Map<String, dynamic> json) {
    return AllUsersModel(
      results: json['results'],
      usersData: (json['data']['data'] as List)
          .map((e) => AllUsersDataModel.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [results, usersData];
}
