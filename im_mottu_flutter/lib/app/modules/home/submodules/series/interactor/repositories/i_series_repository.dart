import '../models/serie_item_detail_model.dart';
import '../params/get_series_details_params.dart';

abstract class ISeriesRepository {
  Future<(SerieItemDetailModel?, String errorMessage)> getSerieDetails(GetSeriesDetailsParams params);
}
