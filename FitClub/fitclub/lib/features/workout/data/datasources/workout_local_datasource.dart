import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/exercise_model.dart';

abstract class IWorkoutLocalDataSource {
  /// İnternet yokken cihazın hafızasındaki son egzersizleri getirir.
  Future<List<ExerciseModel>> getLastExercises();

  /// İnternetten veri çekildiğinde, bir dahaki sefere offline çalışabilmesi için 
  /// gelen veriyi cihazın hafızasına kaydeder.
  Future<void> cacheExercises(List<ExerciseModel> exercises);
}

const String cachedExercisesKey = 'CACHED_EXERCISES';

class WorkoutLocalDataSourceImpl implements IWorkoutLocalDataSource {
  final Box box;

  WorkoutLocalDataSourceImpl({required this.box});

  @override
  Future<List<ExerciseModel>> getLastExercises() {
    final jsonString = box.get(cachedExercisesKey);
    
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final models = jsonList
          .map((json) => ExerciseModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return Future.value(models);
    } else {
      // İçeride veri yoksa Exception fırlatılır, Repository bunu CacheFailure'a çevirir.
      throw Exception('Önbellekte (Cache) kayıtlı egzersiz bulunamadı.');
    }
  }

  @override
  Future<void> cacheExercises(List<ExerciseModel> exercises) {
    final jsonList = exercises.map((model) => model.toJson()).toList();
        
    final jsonString = jsonEncode(jsonList);
    
    return box.put(cachedExercisesKey, jsonString);
  }
}