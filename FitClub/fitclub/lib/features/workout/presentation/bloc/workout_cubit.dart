import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/exercise_entity.dart';
import '../../domain/repositories/workout_repository.dart';
part 'workout_cubit.freezed.dart';

@freezed
class WorkoutState with _$WorkoutState {
  const factory WorkoutState.initial() = _Initial;
  const factory WorkoutState.loading() = _Loading;
  const factory WorkoutState.loaded(List<ExerciseEntity> exercises) = _Loaded;
  const factory WorkoutState.error(String message) = _Error;
}

class WorkoutCubit extends Cubit<WorkoutState> {
  final IWorkoutRepository repository;
  
  // Ana veriyi RAM'de (Memory) tutacağımız gizli (private) değişken
  List<ExerciseEntity> _allExercises = [];

  WorkoutCubit({required this.repository}) : super(const WorkoutState.initial());

  Future<void> fetchExercises() async {
    emit(const WorkoutState.loading());
    
    final result = await repository.getAllExercises();
    
    result.fold(
      (failure) => emit(WorkoutState.error(failure.message)),
      (exercises) {
        _allExercises = exercises; // Gelen 800+ veriyi RAM'e kopyala
        emit(WorkoutState.loaded(_allExercises)); // Ekrana çizdir
      },
    );
  }

  // Arama metin kutusundan (TextField) tetiklenecek fonksiyon
  void searchExercises(String query) {
    // 1. Eğer arama kutusu temizlendiyse (boşsa) orijinal dev listeyi geri yükle
    if (query.trim().isEmpty) {
      emit(WorkoutState.loaded(_allExercises));
      return;
    }

    // 2. Büyük/küçük harf duyarlılığını ortadan kaldırmak için sorguyu küçült
    final lowerQuery = query.toLowerCase();

    // 3. RAM'deki orijinal liste üzerinde filtreleme yap (Where)
    final filteredList = _allExercises.where((exercise) {
      // İsme göre arama
      final matchName = exercise.name.toLowerCase().contains(lowerQuery);
      
      // Çalışan kas grubuna göre arama (Listede dön)
      final matchMuscle = exercise.primaryMuscles.any(
        (muscle) => muscle.toLowerCase().contains(lowerQuery)
      );

      return matchName || matchMuscle; // İsimde VEYA kasta varsa listeye al
    }).toList();

    // 4. Filtrelenmiş yeni listeyi UI'a fırlat
    emit(WorkoutState.loaded(filteredList));
  }
}