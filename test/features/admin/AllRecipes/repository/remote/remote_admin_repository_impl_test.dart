import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/core/network/network_service.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipe_data_admin_model.dart';
import 'package:resturant/features/admin/AllRecipes/repository/base/base_admin_recipes_repository.dart';
import 'package:resturant/features/admin/AllRecipes/repository/remote/remote_admin_repository_impl.dart';

class MockNetworkService extends Mock implements NetworkService {}

void main() {
  late MockNetworkService mockNetworkService;
  late RemoteAdminRecipesRepository remoteAdminRecipesRepository;
  const RecipeAddParams recipeAddParams = RecipeAddParams(
    adminToken: '',
    imagePath: '',
    recipeData: RecipeAdminDataModel(
        cookingTime: 0,
        name: '',
        imageCover: '',
        category: '',
        ingredients: [],
        id: '',
        price: 0,
        slug: ''),
  );
  setUp(() {
    mockNetworkService = MockNetworkService();
    remoteAdminRecipesRepository =
        RemoteAdminRecipesRepository(mockNetworkService);
  });

  group('test remote admin recipes reposiotry', () {
    test('addRecipe should return failure when throw an exception', () async {
      when(() => mockNetworkService.postData(
            url: any(named: 'url'),
            headers: any(named: 'headers'),
            data: any(named: 'data'),
          )).thenThrow(Exception());
      final result =
          (await remoteAdminRecipesRepository.addRecipe(recipeAddParams))
              .fold((l) => l, (r) => null);
      expect(result, isA<ServerFailure>());
    });
  });
}
