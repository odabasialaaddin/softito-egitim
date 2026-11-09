import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../data/datasources/workout_local_datasource.dart';
import '../../data/datasources/workout_remote_datasource.dart';
import '../../data/repositories/workout_repository_impl.dart';
import '../bloc/workout_cubit.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkoutCubit(
        repository: WorkoutRepositoryImpl(
          remoteDataSource: WorkoutRemoteDataSourceImpl(
            dio: Dio(),
          ),
          localDataSource: WorkoutLocalDataSourceImpl(
            box: Hive.box('workoutBox'), // main.dart'ta açtığımız kutuyu veriyoruz
          ),
        ),
      )..fetchExercises(), 
      child: const _WorkoutView(),
    );
  }
}

// Scaffold'u ayrı bir Widget'a ayırdık (Açıklaması notlarda)
class _WorkoutView extends StatelessWidget {
  const _WorkoutView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Egzersiz Kütüphanesi'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. ARAMA KUTUSU (Search Bar)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                // Kullanıcı her harfe bastığında Cubit'teki filtrelemeyi tetikler
                context.read<WorkoutCubit>().searchExercises(query);
              },
              decoration: InputDecoration(
                hintText: 'Egzersiz veya kas ara (Örn: Chest)...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          
          // 2. EGZERSİZ LİSTESİ
          Expanded(
            child: BlocBuilder<WorkoutCubit, WorkoutState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: Text('Hazırlanıyor...')),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (message) => Center(
                    child: Text(
                      'Hata:\n$message',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  loaded: (exercises) {
                    // Arama sonucu hiçbir şey bulunamazsa
                    if (exercises.isEmpty) {
                      return const Center(
                        child: Text('Aradığınız kritere uygun egzersiz bulunamadı.'),
                      );
                    }

                    return ListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = exercises[index];
                        final String displayMuscle = exercise.primaryMuscles.isNotEmpty 
                            ? exercise.primaryMuscles.first 
                            : 'Belirtilmedi';

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.fitness_center),
                            ),
                            title: Text(
                              exercise.name.toUpperCase(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Hedef Kas: $displayMuscle'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}