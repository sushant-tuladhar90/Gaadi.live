import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../features/routes/model/route_search_model.dart';

class RouteSearchService {
  static const String baseUrl = 'https://www.gaadi.live/api';

  Future<RouteSearchResponse> searchRoutes(
    String term, {
    int page = 1,
    int limit = 50,
  }) async {
    final query = term.trim();
    if (query.isEmpty) {
      return const RouteSearchResponse(
        success: true,
        routes: [],
        pagination: RouteSearchPagination(page: 1, limit: 50, total: 0),
      );
    }

    final encodedTerm = Uri.encodeComponent(query);
    final uri = Uri.parse('$baseUrl/routes/search/$encodedTerm?page=$page&limit=$limit');

    debugPrint('RouteSearchService: request URL = $uri');

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
      },
    );

    debugPrint('RouteSearchService: status = ${response.statusCode}');
    debugPrint('RouteSearchService: body = ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Route search failed: ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Invalid route search response');
    }

    return RouteSearchResponse.fromJson(decoded);
  }
}
