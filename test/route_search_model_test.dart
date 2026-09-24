import 'package:flutter_test/flutter_test.dart';
import 'package:gaadi_live/features/routes/model/route_search_model.dart';

void main() {
  test('RouteSearchModel parses route search API payload', () {
    const payload = {
      'success': true,
      'data': [
        {
          'id': '6a72e322ce157fa773890250',
          'name': 'Kharji - Rajbanshi',
          'cities': ['Biratnagar'],
        },
        {
          'id': '6a72ea5dce157fa773890432',
          'name': 'Rajbanshi - Kharji',
          'cities': <String>[],
        },
      ],
      'pagination': {
        'page': 1,
        'limit': 50,
        'total': 2,
      },
    };

    final model = RouteSearchResponse.fromJson(payload);

    expect(model.success, isTrue);
    expect(model.routes.length, 2);
    expect(model.routes.first.name, 'Kharji - Rajbanshi');
    expect(model.pagination.total, 2);
  });
}
