import 'package:get/get.dart';

import '../../../core/services/route_search_service.dart';
import '../model/route_search_model.dart';

class RoutesController extends GetxController {
  final RouteSearchService _service = RouteSearchService();

  final RxBool isLoading = false.obs;
  final RxBool isSearching = false.obs;
  final RxString selectedRouteId = ''.obs;
  final RxString searchTerm = ''.obs;
  final RxList<RouteSearchItem> searchResults = <RouteSearchItem>[].obs;

  Future<void> searchRoutes(String term) async {
    final query = term.trim();
    searchTerm.value = query;

    if (query.isEmpty) {
      searchResults.clear();
      isSearching.value = false;
      return;
    }

    isLoading.value = true;
    isSearching.value = true;

    try {
      final response = await _service.searchRoutes(query);
      searchResults.assignAll(response.routes);
    } catch (e) {
      searchResults.clear();
      Get.snackbar(
        'Route search',
        'Could not load routes: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      isSearching.value = searchResults.isNotEmpty;
    }
  }
}
