import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/exercise_entity.dart';
part 'exercise_model.freezed.dart';
part 'exercise_model.g.dart';

@freezed
abstract class ExerciseModel with _$ExerciseModel {
  const ExerciseModel._();

  const factory ExerciseModel({
    required String id,
    required String name,
    String? force,
    String? level,
    String? mechanic,
    String? equipment,
    List<String>? primaryMuscles,
    List<String>? secondaryMuscles,
    List<String>? instructions,
    String? category,
    List<String>? images,
  }) = _ExerciseModel;

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => 
      _$ExerciseModelFromJson(json);
}

extension ExerciseModelMapper on ExerciseModel {
  ExerciseEntity toEntity() {
    return ExerciseEntity(
      id: id,
      name: name,
      force: force,
      level: level,
      mechanic: mechanic,
      equipment: equipment,
      primaryMuscles: primaryMuscles ?? [],
      secondaryMuscles: secondaryMuscles ?? [],
      instructions: instructions ?? [],
      category: category,
      images: images ?? [],
    );
  }
}