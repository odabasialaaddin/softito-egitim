import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/exercise_entity.dart';

abstract class IWorkoutRepository {
  Future<Either<Failure, List<ExerciseEntity>>> getAllExercises();
}