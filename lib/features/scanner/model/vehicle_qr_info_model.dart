class VehicleQrInfoModel {
  const VehicleQrInfoModel({
    required this.success,
    required this.data,
  });

  final bool success;
  final VehicleQrInfoData data;

  factory VehicleQrInfoModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? <String, dynamic>{};

    return VehicleQrInfoModel(
      success: json['success'] as bool? ?? false,
      data: VehicleQrInfoData.fromJson(data),
    );
  }
}

class VehicleQrInfoData {
  const VehicleQrInfoData({
    required this.id,
    required this.name,
    required this.numberPlate,
    required this.type,
    required this.color,
    required this.canDrive,
    required this.operationalRoutes,
  });

  final String id;
  final String name;
  final String numberPlate;
  final String type;
  final String color;
  final bool canDrive;
  final List<OperationalRoute> operationalRoutes;

  factory VehicleQrInfoData.fromJson(Map<String, dynamic> json) {
    final rawRoutes = json['operational_routes'] as List? ?? const [];

    return VehicleQrInfoData(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      numberPlate: json['numberplate'] as String? ?? '',
      type: json['type'] as String? ?? '',
      color: json['color'] as String? ?? '',
      canDrive: json['can_drive'] as bool? ?? false,
      operationalRoutes: rawRoutes
          .map((route) => OperationalRoute.fromJson(route as Map<String, dynamic>))
          .toList(),
    );
  }
}

class OperationalRoute {
  const OperationalRoute({
    required this.id,
    required this.name,
    required this.cities,
  });

  final String id;
  final String name;
  final List<String> cities;

  factory OperationalRoute.fromJson(Map<String, dynamic> json) {
    final cities = json['cities'] as List? ?? const [];

    return OperationalRoute(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      cities: cities.map((city) => city.toString()).toList(),
    );
  }
}
