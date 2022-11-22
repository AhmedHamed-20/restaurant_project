part of 'admin_auth_bloc.dart';

class AdminAuthState extends Equatable {
  final bool loginAdminPasswordVisibility;
  final AdminAuthRequestStatues adminAuthRequestStatues;
  final AuthAdminModel? adminModel;
  final String errorMessage;
  const AdminAuthState(
      {this.loginAdminPasswordVisibility = true,
      this.errorMessage = '',
      this.adminModel,
      this.adminAuthRequestStatues = AdminAuthRequestStatues.idle});

  AdminAuthState copyWith({
    AuthAdminModel? adminModel,
    AdminAuthRequestStatues? adminAuthRequestStatues,
    bool? loginAdminPasswordVisibility,
    String? errorMessage,
  }) {
    return AdminAuthState(
      adminModel: adminModel ?? this.adminModel,
      errorMessage: errorMessage ?? this.errorMessage,
      adminAuthRequestStatues:
          adminAuthRequestStatues ?? this.adminAuthRequestStatues,
      loginAdminPasswordVisibility:
          loginAdminPasswordVisibility ?? this.loginAdminPasswordVisibility,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        loginAdminPasswordVisibility,
        adminAuthRequestStatues,
        adminModel
      ];
}
