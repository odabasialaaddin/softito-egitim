import 'dart:convert';
import 'dart:isolate';
import 'package:dio/dio.dart';
import '../models/exercise_model.dart';
import '../../../../core/network/api_constants.dart';

abstract class IWorkoutRemoteDataSource {
  Future<List<ExerciseModel>> getAllExercises();
}

class WorkoutRemoteDataSourceImpl implements IWorkoutRemoteDataSource {
  final Dio dio;

  WorkoutRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ExerciseModel>> getAllExercises() async {
    try {
      final response = await dio.get(ApiConstants.freeExerciseDbUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is String 
            ? jsonDecode(response.data) 
            : response.data;
        
        return await Isolate.run(() => _parseExercisesInBackground(data));
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      rethrow; 
    }
  }
}

List<ExerciseModel> _parseExercisesInBackground(List<dynamic> jsonList) {
  return jsonList
      .map((json) => ExerciseModel.fromJson(json as Map<String, dynamic>))
      .toList();
}