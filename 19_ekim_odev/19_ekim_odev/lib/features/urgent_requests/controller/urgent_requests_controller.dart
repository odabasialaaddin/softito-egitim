import 'package:flutter/foundation.dart';
import '../models/urgent_request_model.dart';

/// Hastanelerden ve hastalardan gelen acil kan taleplerini yöneten reaktif kontrolcü.
class UrgentRequestsController {
  late final ValueNotifier<List<UrgentRequest>> requestsNotifier;
  final ValueNotifier<String?> selectedFilterBloodType =
      ValueNotifier<String?>(null);

  UrgentRequestsController() {
    _initDefaults();
  }

  void _initDefaults() {
    requestsNotifier = ValueNotifier<List<UrgentRequest>>([
      const UrgentRequest(
        id: 'urg-1',
        patientName: 'Elif K.',
        hospitalName: 'Cerrahpaşa Tıp Fakültesi Hastanesi',
        city: 'İstanbul / Fatih',
        bloodType: '0 Rh-',
        requiredUnits: 3,
        fulfilledUnits: 1,
        isUrgent: true,
        createdAt: '25 dk önce',
        notes: 'Acil kalp cerrahisi operasyonu için.',
      ),
      const UrgentRequest(
        id: 'urg-2',
        patientName: 'Mehmet S.',
        hospitalName: 'Ankara Şehir Hastanesi',
        city: 'Ankara / Bilkent',
        bloodType: 'A Rh-',
        requiredUnits: 2,
        fulfilledUnits: 0,
        isUrgent: true,
        createdAt: '1 saat önce',
        notes: 'Trafik kazası yoğun bakım hastası.',
      ),
      const UrgentRequest(
        id: 'urg-3',
        patientName: 'Zeynep B.',
        hospitalName: 'Ege Üniversitesi Hastanesi',
        city: 'İzmir / Bornova',
        bloodType: 'B Rh-',
        requiredUnits: 4,
        fulfilledUnits: 2,
        isUrgent: false,
        createdAt: '3 saat önce',
        notes: 'Lösemi tedavisi trombosit ve tam kan.',
      ),
    ]);
  }

  /// Filtrelenmiş acil talepler listesi
  List<UrgentRequest> get filteredRequests {
    final filter = selectedFilterBloodType.value;
    if (filter == null || filter.isEmpty) {
      return requestsNotifier.value;
    }
    return requestsNotifier.value
        .where((req) => req.bloodType == filter)
        .toList();
  }

  /// Kan grubu filtresini ayarlar veya kaldırır
  void filterByBloodType(String? bloodType) {
    if (selectedFilterBloodType.value == bloodType) {
      selectedFilterBloodType.value = null;
    } else {
      selectedFilterBloodType.value = bloodType;
    }
  }

  /// Bir talebe 1 ünite destek bağışı kaydeder
  void fulfillUnit(String requestId) {
    requestsNotifier.value = requestsNotifier.value.map((req) {
      if (req.id == requestId && !req.isCompleted) {
        return req.copyWith(fulfilledUnits: req.fulfilledUnits + 1);
      }
      return req;
    }).toList();
  }

  /// Yeni bir acil kan talebi ekler
  void addRequest(UrgentRequest request) {
    requestsNotifier.value = [request, ...requestsNotifier.value];
  }

  /// Talebi listeden kaldırır
  void removeRequest(String requestId) {
    requestsNotifier.value =
        requestsNotifier.value.where((req) => req.id != requestId).toList();
  }

  void dispose() {
    requestsNotifier.dispose();
    selectedFilterBloodType.dispose();
  }
}
