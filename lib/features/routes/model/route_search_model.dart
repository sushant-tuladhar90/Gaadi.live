class RouteSearchResponse {
  const RouteSearchResponse({
    required this.success,
    required this.routes,
    required this.pagination,
  });

  final bool success;
  final List<RouteSearchItem> routes;
  final RouteSearchPagination pagination;

  factory RouteSearchResponse.fromJson(Map<String, dynamic> json) {
    final rawRoutes = (json['data'] as List? ?? const <dynamic>[])
        .map((item) => RouteSearchItem.fromJson(item as Map<String, dynamic>))
        .toList();

    return RouteSearchResponse(
      success: json['success'] as bool? ?? false,
      routes: rawRoutes,
      pagination: RouteSearchPagination.fromJson(
        (json['pagination'] as Map<String, dynamic>?) ?? const <String, dynamic>{},
      ),
    );
  }
}

class RouteSearchItem {
  const RouteSearchItem({
    required this.id,
    required this.name,
    required this.cities,
  });

  final String id;
  final String name;
  final List<String> cities;

  factory RouteSearchItem.fromJson(Map<String, dynamic> json) {
    final cities = (json['cities'] as List? ?? const <dynamic>[])
        .map((city) => city.toString())
        .toList();

    return RouteSearchItem(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      cities: cities,
    );
  }
}

class RouteSearchPagination {
  const RouteSearchPagination({
    required this.page,
    required this.limit,
    required this.total,
  });

  final int page;
  final int limit;
  final int total;

  factory RouteSearchPagination.fromJson(Map<String, dynamic> json) {
    return RouteSearchPagination(
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 50,
      total: json['total'] as int? ?? 0,
    );
  }
}
