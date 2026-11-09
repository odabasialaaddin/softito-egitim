import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/exercise_entity.dart';
import '../../domain/repositories/workout_repository.dart';
import '../datasources/workout_local_datasource.dart';
import '../datasources/workout_remote_datasource.dart';
import '../models/exercise_model.dart';

class WorkoutRepositoryImpl implements IWorkoutRepository {
  final IWorkoutRemoteDataSource remoteDataSource;
  final IWorkoutLocalDataSource localDataSource;

  WorkoutRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<ExerciseEntity>>> getAllExercises() async {
    try {
      // 1. Önce internetten en güncel veriyi çekmeyi dene
      final models = await remoteDataSource.getAllExercises();
      
      // 2. İşlem başarılıysa, bir dahaki internetsiz giriş için verileri Hive'a kaydet (Cache)
      await localDataSource.cacheExercises(models);
      
      // 3. Modelleri saf Entity'e çevirip başarıyla (Right) üst katmana ilet
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);

    } on DioException catch (_) {
      // 4. İNTERNET YOKSA VEYA SUNUCU KOPUKSA BURAYA DÜŞER: Hata fırlatma, Hive'a (Local) sor!
      try {
        final localModels = await localDataSource.getLastExercises();
        final localEntities = localModels.map((model) => model.toEntity()).toList();
        
        // Çevrimdışı (Offline) veriyi başarıyla UI'a gönder
        return Right(localEntities);
      } catch (e) {
        // 5. İnternet yok VE cihazda da daha önceden kaydedilmiş veri yoksa (İlk girişse)
        return const Left(CacheFailure('İnternet bağlantısı yok ve cihazda kayıtlı veri bulunamadı.'));
      }
    } catch (e) {
      // Beklenmeyen sistem veya parse hataları için genel hata döndür
      return Left(ServerFailure('Beklenmeyen bir hata oluştu: $e'));
    }
  }
}