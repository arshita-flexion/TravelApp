// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:codefest_travel_app/core/utils/local_storage/sqflite_storage_box.dart';

class Prefobj {
  static KeyValueStore? preferences; // Static reference to key-value storage
  static final _storageQueue = <Future<void>>[];
  static bool _isProcessingQueue = false;
}

/// Optimized storage operations to reduce UI blocking
class OptimizedStorage {
  /// Batch multiple storage operations to reduce I/O overhead
  static Future<void> batchPut(Map<String, dynamic> data) async {
    if (Prefobj.preferences == null) return;

    final futures = data.entries.map((entry) => Prefobj.preferences!.put(entry.key, entry.value));

    await Future.wait(futures);
  }

  /// Queue storage operations to prevent blocking
  static Future<void> queuedPut(String key, dynamic value) async {
    final operation = _performPut(key, value);
    Prefobj._storageQueue.add(operation);

    if (!Prefobj._isProcessingQueue) {
      _processQueue();
    }

    return operation;
  }

  static Future<void> _performPut(String key, dynamic value) async {
    await Prefobj.preferences?.put(key, value);
  }

  static Future<void> _processQueue() async {
    Prefobj._isProcessingQueue = true;

    while (Prefobj._storageQueue.isNotEmpty) {
      final batch = Prefobj._storageQueue.take(5).toList();
      Prefobj._storageQueue.removeRange(0, batch.length.clamp(0, Prefobj._storageQueue.length));

      await Future.wait(batch);
    }

    Prefobj._isProcessingQueue = false;
  }

  /// Immediately cancel any queued storage operations (used during logout)
  static void cancelQueuedOperations() {
    if (Prefobj._storageQueue.isNotEmpty) {
      Prefobj._storageQueue.clear();
    }
    Prefobj._isProcessingQueue = false;
  }

  /// Clear all preferences except onboarding status
  static Future<void> clearExceptOnboarding() async {
    if (Prefobj.preferences == null) return;

    // Save onboarding status before clearing
    final onboardingStatus = Prefobj.preferences!.get(Prefkeys.ONBOARDING);

    // Clear all preferences
    await Prefobj.preferences!.clear();

    // Restore onboarding status if it existed
    if (onboardingStatus != null) {
      await Prefobj.preferences!.put(Prefkeys.ONBOARDING, onboardingStatus);
    }
  }
}

class Prefkeys {
  static const String AUTHTOKEN = 'auth_token';
  static const String REFRESHTOKEN = 'refresh_token';
  static const String LIGHTDARK = 'light_dark';
  static const String FOLLOW_SYSTEM = 'follow_system';
  static const String ONBOARDING = 'onboarding';
  static const String ISPERSONALDETAILCOMPLETED = 'is_personal_detail_completed';

  static const List<String> allKeys = <String>[
    AUTHTOKEN,
    REFRESHTOKEN,
    LIGHTDARK,
    FOLLOW_SYSTEM,
    ONBOARDING,
    ISPERSONALDETAILCOMPLETED,
  ];
}
