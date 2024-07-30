import 'package:flutter_test/flutter_test.dart';
import 'package:im_mottu_flutter/app/modules/home/submodules/series/interactor/models/serie_item_detail_model.dart';

import '../../serie_data.dart';

void main() {
  test('Must return a SerieItemDetailModel when fromMap was called with success', () {
    final dataWrapper = SerieItemDetailModel.fromJson((apiSerieResponseJson));
    expect(dataWrapper.title, equals('Avengers: The Initiative (2007 - 2010)'));
    expect(dataWrapper.id, equals(1945));
  });
}
