part of 'admin_category_bloc.dart';

abstract class AdminCategoryEvent extends Equatable {
  const AdminCategoryEvent();
}

class GetAdminCategoriesEvent extends AdminCategoryEvent {
  const GetAdminCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class AddAdminCategoryEvent extends AdminCategoryEvent {
  final String adminToken;
  final String name;

  const AddAdminCategoryEvent({
    required this.adminToken,
    required this.name,
  });

  @override
  List<Object?> get props => [name, adminToken];
}

class UpdateAdminCategoryEvent extends AdminCategoryEvent {
  final String adminToken;
  final String name;
  final String id;

  const UpdateAdminCategoryEvent({
    required this.adminToken,
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [name, adminToken, id];
}

class DeleteAdminCategoryEvent extends AdminCategoryEvent {
  final String adminToken;
  final String id;

  const DeleteAdminCategoryEvent({
    required this.adminToken,
    required this.id,
  });

  @override
  List<Object?> get props => [adminToken, id];
}
