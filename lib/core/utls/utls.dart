enum AuthRequestStatues {
  idle,
  loading,
  authSuccess,
  cachedSuccess,
  error,
}

enum AdminAuthRequestStatues {
  idle,
  loading,
  success,
  error,
}

enum ForgetPasswordRequestStatues {
  idle,
  loading,
  success,
  error,
}

enum RecipeRequestStatues {
  loading,
  success,
  error,
}

enum RecipeAdminRequestStatues {
  loading,
  success,
  error,
}

enum OrdersAdminRequestStatues {
  loading,
  success,
  error,
}

enum CategoryRequestStatues {
  loading,
  success,
  error,
}

enum LayoutRequestStatues {
  loading,
  success,
  error,
}

enum ActiveUserUpdateDataRequestStatues {
  idle,
  loading,
  success,
  error,
}

enum LogoutRequestState {
  idle,
  loading,
  cacheCleared,
  databaseCleared,
  error,
}

enum ActiveUserUpdatePasswordRequestStatues {
  idle,
  loading,
  passwordUpdatedSuccess,
  accessTokenCachedSuccess,
  accessTokenGetSuccess,
  error,
}

enum OrdersRequestStatues {
  loading,
  success,
  error,
}

enum AllUsersRequestStatues {
  loading,
  success,
  error,
}

enum MyOrderCancelRequestStatues {
  idle,
  loading,
  success,
  error,
}

enum AllUsersUpdateDataRequestStatues {
  idle,
  loading,
  success,
  error,
}

enum ThemeModeValue {
  light,
  dark,
}
