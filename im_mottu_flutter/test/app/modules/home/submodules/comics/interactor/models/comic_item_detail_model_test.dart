import 'package:flutter_test/flutter_test.dart';
import 'package:im_mottu_flutter/app/modules/home/submodules/comics/interactor/models/comic_item_detail_model.dart';

import '../../comic_data.dart';

void main() {
  test('Must return a ComicItemDetailModel when fromMap was called with success', () {
    final dataWrapper = ComicItemDetailModel.fromJson((apiComicResponseJson));
    expect(dataWrapper.title, equals('Avengers: The Initiative (2007) #14'));
    expect(dataWrapper.id, equals(21366));
  });
}
