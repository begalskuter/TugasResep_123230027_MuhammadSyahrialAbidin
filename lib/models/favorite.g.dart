// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteRecipeAdapter extends TypeAdapter<FavoriteRecipe> {
  @override
  final int typeId = 0;

  @override
  FavoriteRecipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteRecipe(
      idMeal: fields[0] as String,
      strMeal: fields[1] as String,
      strMealThumb: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteRecipe obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.idMeal)
      ..writeByte(1)
      ..write(obj.strMeal)
      ..writeByte(2)
      ..write(obj.strMealThumb);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteRecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
