import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:canver/main.dart';
import 'package:canver/core/theme/theme_controller.dart';
import 'package:canver/features/blood_inventory_chart/controller/blood_inventory_controller.dart';
import 'package:canver/features/blood_inventory_chart/models/blood_inventory_model.dart';
import 'package:canver/features/donation_tracker/controller/donation_tracker_controller.dart';
import 'package:canver/features/donation_tracker/models/donation_tracker_model.dart';
import 'package:canver/features/urgent_requests/controller/urgent_requests_controller.dart';
import 'package:canver/features/urgent_requests/models/urgent_request_model.dart';
import 'package:canver/features/donation_reminders/controller/donation_reminders_controller.dart';
import 'package:canver/features/donation_reminders/models/donation_reminder_model.dart';

void main() {
  group('ThemeController Unit Tests', () {
    test('Default mode is system and toggles across modes', () {
      final controller = ThemeController.instance;
      controller.setThemeMode(ThemeMode.system);
      expect(controller.currentThemeMode, ThemeMode.system);

      controller.toggleTheme();
      expect(controller.currentThemeMode, ThemeMode.dark);

      controller.toggleTheme();
      expect(controller.currentThemeMode, ThemeMode.light);

      controller.toggleTheme();
      expect(controller.currentThemeMode, ThemeMode.system);
    });
  });

  group('BloodInventoryController & Model Unit Tests', () {
    test('Initial stock values and unit operations work properly', () {
      final controller = BloodInventoryController();
      expect(controller.totalUnits, greaterThan(0));
      expect(controller.criticalGroupCount, greaterThan(0));

      final initialUnits = controller.stocksNotifier.value
          .firstWhere((s) => s.bloodType == 'A Rh+')
          .currentUnits;

      controller.addUnits('A Rh+', 5);
      final afterAdd = controller.stocksNotifier.value
          .firstWhere((s) => s.bloodType == 'A Rh+')
          .currentUnits;
      expect(afterAdd, initialUnits + 5);

      controller.removeUnits('A Rh+', 2);
      final afterRemove = controller.stocksNotifier.value
          .firstWhere((s) => s.bloodType == 'A Rh+')
          .currentUnits;
      expect(afterRemove, initialUnits + 3);

      controller.selectBloodType('A Rh+');
      expect(controller.selectedBloodTypeNotifier.value, 'A Rh+');

      controller.resetToDefaults();
      expect(controller.selectedBloodTypeNotifier.value, isNull);
      controller.dispose();
    });

    test('BloodGroupStock model serialization and getters', () {
      const stock = BloodGroupStock(
        bloodType: '0 Rh-',
        currentUnits: 10,
        targetUnits: 100,
        minSafeUnits: 25,
        lastUpdated: 'Şimdi',
      );

      expect(stock.isCritical, isTrue);
      expect(stock.percentage, 10);
      expect(stock.fillRatio, 0.1);

      final json = stock.toJson();
      final fromJson = BloodGroupStock.fromJson(json);
      expect(fromJson.bloodType, '0 Rh-');
      expect(fromJson.currentUnits, 10);
    });
  });

  group('DonationTrackerController & Model Unit Tests', () {
    test('Adding and resetting donations updates values and records', () {
      final controller = DonationTrackerController();
      final initialCount = controller.currentDonatedUnits.value;

      controller.addDonation(location: 'Test Kan Merkezi', bloodType: '0 Rh+');
      expect(controller.currentDonatedUnits.value, initialCount + 1);
      expect(controller.historyNotifier.value.first.location, 'Test Kan Merkezi');

      controller.resetDonations();
      expect(controller.currentDonatedUnits.value, 0);
      expect(controller.historyNotifier.value.isEmpty, isTrue);
      controller.dispose();
    });

    test('DonorProfile & DonationRecord serialization', () {
      const profile = DonorProfile(
        name: 'Test Donör',
        bloodType: 'B Rh+',
        profileImage: '',
        donationCount: 5,
        healthPoints: 750,
        lastDonationDate: '10 Ekim',
        nextEligibleDate: '10 Ocak',
      );

      final copy = profile.copyWith(donationCount: 6);
      expect(copy.donationCount, 6);

      final json = copy.toJson();
      final fromJson = DonorProfile.fromJson(json);
      expect(fromJson.name, 'Test Donör');
      expect(fromJson.donationCount, 6);
    });
  });

  group('UrgentRequestsController & Model Unit Tests', () {
    test('Fulfilling unit and filtering by blood type', () {
      final controller = UrgentRequestsController();
      expect(controller.requestsNotifier.value.isNotEmpty, isTrue);

      final firstReq = controller.requestsNotifier.value.first;
      final initialFulfilled = firstReq.fulfilledUnits;

      controller.fulfillUnit(firstReq.id);
      final updatedReq = controller.requestsNotifier.value
          .firstWhere((r) => r.id == firstReq.id);
      expect(updatedReq.fulfilledUnits, initialFulfilled + 1);

      controller.filterByBloodType('0 Rh-');
      expect(controller.selectedFilterBloodType.value, '0 Rh-');
      for (final req in controller.filteredRequests) {
        expect(req.bloodType, '0 Rh-');
      }

      controller.dispose();
    });

    test('UrgentRequest model calculations', () {
      const req = UrgentRequest(
        id: 'test-1',
        patientName: 'Ahmet',
        hospitalName: 'Numune',
        city: 'Ankara',
        bloodType: 'A Rh+',
        requiredUnits: 4,
        fulfilledUnits: 2,
        createdAt: '1 saat önce',
      );

      expect(req.remainingUnits, 2);
      expect(req.fillRatio, 0.5);
      expect(req.isCompleted, isFalse);
    });
  });

  group('DonationRemindersController & Model Unit Tests', () {
    test('Toggling and deleting reminders', () {
      final controller = DonationRemindersController();
      final firstReminder = controller.remindersNotifier.value.first;
      final initialActive = firstReminder.isActive;

      controller.toggleReminder(firstReminder.id);
      final updated = controller.remindersNotifier.value
          .firstWhere((r) => r.id == firstReminder.id);
      expect(updated.isActive, !initialActive);

      final countBefore = controller.remindersNotifier.value.length;
      controller.deleteReminder(firstReminder.id);
      expect(controller.remindersNotifier.value.length, countBefore - 1);
      controller.dispose();
    });

    test('DonationReminder model serialization', () {
      const reminder = DonationReminder(
        id: 'r1',
        title: 'Hatırlatıcı',
        description: 'Detay',
        targetDate: 'Yarın',
        bloodType: 'A Rh+',
        isActive: true,
        daysLeft: 1,
      );

      final json = reminder.toJson();
      final fromJson = DonationReminder.fromJson(json);
      expect(fromJson.title, 'Hatırlatıcı');
      expect(fromJson.daysLeft, 1);
    });
  });

  group('CanVer App Widget Tests', () {
    testWidgets('App renders correctly and bottom navigation switches views',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CanVerApp());
      await tester.pumpAndSettle();

      // App title presence
      expect(find.textContaining('CanVer'), findsWidgets);

      // Verify bottom navigation bar destinations
      expect(find.text('Stok Grafiği'), findsOneWidget);
      expect(find.text('Bağış Takibi'), findsOneWidget);
      expect(find.text('Acil Talepler'), findsOneWidget);
      expect(find.text('Hatırlatıcı'), findsOneWidget);

      // Switch to Bağış Takibi tab
      await tester.tap(find.text('Bağış Takibi'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Yıllık Bağış Hedefi'), findsOneWidget);

      // Switch to Acil Talepler tab
      await tester.tap(find.text('Acil Talepler'));
      await tester.pumpAndSettle();
      expect(find.text('Acil Talep Aç'), findsOneWidget);

      // Switch to Hatırlatıcı tab
      await tester.tap(find.text('Hatırlatıcı'));
      await tester.pumpAndSettle();
      expect(find.text('Bağış Uygunluk Durumu'), findsOneWidget);
    });

    testWidgets('Theme toggle button cycles theme modes without error',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CanVerApp());
      await tester.pumpAndSettle();

      final themeButton = find.byType(IconButton);
      expect(themeButton, findsWidgets);

      await tester.tap(themeButton.first);
      await tester.pumpAndSettle();
    });
  });
}
