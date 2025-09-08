import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/user_cache_service/domain/providers/current_user_provider.dart';
import '../../data/remote/dio_network_service.dart';

final netwokServiceProvider = Provider<DioNetworkService>(
  (ref) {
    final Dio dio = Dio();
    final currentUser =
        ref.watch(currentUserProvider); // Fetch the current user

    final dioNetworkService = DioNetworkService(dio: dio, ref: ref);
/*
    // Update the DioNetworkService with the user's token, if available
    if (currentUser is AsyncData && currentUser.value?.token != null) {
      dioNetworkService
          .updateHeader({'Authorization': 'Token ${currentUser.value?.token}'});
    } else {
      dioNetworkService.updateHeader({});
    }

    return DioNetworkService(dio: dio, ref: ref);
*/
    currentUser.when(
      data: (user) {
        // Update the DioNetworkService with the user's token, if available
        if (user?.token != null) {
          dioNetworkService
              .updateHeader({'Authorization': 'Token ${user?.token}'});
        } else {
          dioNetworkService.updateHeader({});
        }
      },
      loading: () {
        // Handle the loading state if necessary
      },
      error: (err, stack) {
        // Handle the error state
        dioNetworkService.updateHeader({});
      },
    );

    return dioNetworkService;
  },
);
