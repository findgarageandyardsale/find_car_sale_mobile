import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';

final firebaseInitializationProvider = FutureProvider<bool>((ref) async {
  try {
    await Firebase.app();
    PrintUtils.customLog('Firebase is initialized');
    return true;
  } catch (e) {
    PrintUtils.customLog('Firebase not initialized: $e');
    return false;
  }
});

final firebaseReadyProvider = Provider<bool>((ref) {
  final initializationState = ref.watch(firebaseInitializationProvider);
  return initializationState.when(
    data: (isInitialized) => isInitialized,
    loading: () => false,
    error: (_, __) => false,
  );
});
