import '../../../comics/interactor/models/comic_item_detail_model.dart';
import '../models/serie_item_detail_model.dart';

enum ComicsStateStatus {
  loading,
  success,
  error;
}

class ComicsState {
  final ComicsStateStatus status;

  final String errorMessage;
  final SerieItemDetailModel comicDetails;
  ComicsState({
    required this.status,
    required this.errorMessage,
    required this.comicDetails,
  });

  static ComicsState empty() => ComicsState(
        status: ComicsStateStatus.loading,
        errorMessage: '',
        comicDetails: SerieItemDetailModel(),
      );

  ComicsState copyWith({
    ComicsStateStatus? status,
    String? errorMessage,
    SerieItemDetailModel? comicDetails,
  }) {
    return ComicsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      comicDetails: comicDetails ?? this.comicDetails,
    );
  }
}
