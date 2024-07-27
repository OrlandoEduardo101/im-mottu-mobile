import '../models/comic_item_detail_model.dart';
import '../params/get_comics_details_params.dart';

abstract class IComicsRepository {
  Future<(ComicItemDetailModel?, String errorMessage)> getComicDetails(GetComicsDetailsParams params);
}
