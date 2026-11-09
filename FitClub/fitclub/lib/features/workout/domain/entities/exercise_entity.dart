import 'package:equatable/equatable.dart';

class ExerciseEntity extends Equatable {
  final String id;
  final String name;
  final String? force;
  final String? level;
  final String? mechanic;
  final String? equipment;
  final List<String> primaryMuscles;
  final List<String> secondaryMuscles;
  final List<String> instructions;
  final String? category;
  final List<String> images;

  const ExerciseEntity({
    required this.id,
    required this.name,
    this.force,
    this.level,
    this.mechanic,
    this.equipment,
    this.primaryMuscles = const [],
    this.secondaryMuscles = const [],
    this.instructions = const [],
    this.category,
    this.images = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        force,
        level,
        mechanic,
        equipment,
        primaryMuscles,
        secondaryMuscles,
        instructions,
        category,
        images,
      ];
}