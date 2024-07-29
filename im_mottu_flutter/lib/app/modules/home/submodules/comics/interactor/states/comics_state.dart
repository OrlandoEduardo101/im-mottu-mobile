import '../models/comic_item_detail_model.dart';

enum ComicsStateStatus {
  loading,
  success,
  error;
}

class ComicsState {
  final ComicsStateStatus status;

  final String errorMessage;
  final ComicItemDetailModel comicDetails;
  ComicsState({
    required this.status,
    required this.errorMessage,
    required this.comicDetails,
  });

  static ComicsState empty() => ComicsState(
        status: ComicsStateStatus.loading,
        errorMessage: '',
        comicDetails: ComicItemDetailModel(),
      );

  ComicsState copyWith({
    ComicsStateStatus? status,
    String? errorMessage,
    ComicItemDetailModel? comicDetails,
  }) {
    return ComicsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      comicDetails: comicDetails ?? this.comicDetails,
    );
  }
}
