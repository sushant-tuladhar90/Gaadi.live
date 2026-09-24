import 'package:flutter_test/flutter_test.dart';
import 'package:gaadi_live/features/scanner/model/vehicle_qr_info_model.dart';

void main() {
  test('VehicleQrInfoModel parses can_drive true from API payload', () {
    const payload = {
      'success': true,
      'data': {
        'id': '6aa250f55beb4cded58413fc',
        'name': 'Call Test Bus',
        'numberplate': 'bahh-khai-ta',
        'type': 'bus',
        'color': '',
        'can_drive': true,
        'operational_routes': [
          {'id': 'route-1', 'name': 'Kharji - Rajbanshi', 'cities': ['Biratnagar']},
        ],
      },
    };

    final model = VehicleQrInfoModel.fromJson(payload);

    expect(model.success, isTrue);
    expect(model.data.canDrive, isTrue);
    expect(model.data.name, 'Call Test Bus');
  });

  test('VehicleQrInfoModel parses can_drive false from API payload', () {
    const payload = {
      'success': true,
      'data': {
        'id': 'abc',
        'name': 'Bad Vehicle',
        'numberplate': 'xyz',
        'type': 'bus',
        'color': '',
        'can_drive': false,
        'operational_routes': <Map<String, dynamic>>[],
      },
    };

    final model = VehicleQrInfoModel.fromJson(payload);

    expect(model.success, isTrue);
    expect(model.data.canDrive, isFalse);
  });
}
