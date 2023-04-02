abstract class DataBaseService {
  Future init(
      {required String databasesName,
      required int version,
      required String query});
  Future<List<Map<String, Object?>>> getAllDataFromDatabaseByUserId(
      String tableName, String userId);
  Future<List<Map<String, Object?>>> getAllDataFromDatabaseByRecipeIdAndUserId(
      {required String tableName,
      required String recipeId,
      required String userId});

  Future<int> deleteDataFromDatabaseByDataBaseIdAndUserId(
      {required int dataBaseId,
      required String tableName,
      required String userId});
  Future<int> deleteAllDataFromDatabaseByUserId(
      {required String tableName, required String userId});

  Future<int> deleteAllDataCartsFromDatabase({required String tableName});
  Future<void> insertIntoDataBase(
      {required List<Object?> data, required String query});
  Future<int> updateDataBase(String query, List arguments);
  Future close();
}
