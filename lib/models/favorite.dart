import 'package:hive/hive.dart';

part 'favorite.g.dart'; // File ini akan digenerate otomatis

@HiveType(typeId: 0)
class FavoriteRecipe extends HiveObject {
  @HiveField(0)
  final String idMeal;

  @HiveField(1)
  final String strMeal;

  @HiveField(2)
  final String strMealThumb;

  FavoriteRecipe({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
  });
}