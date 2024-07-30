import '../models/serie_item_detail_model.dart';

enum SerieStateStatus {
  loading,
  success,
  error;
}

class SerieState {
  final SerieStateStatus status;

  final String errorMessage;
  final SerieItemDetailModel comicDetails;
  SerieState({
    required this.status,
    required this.errorMessage,
    required this.comicDetails,
  });

  static SerieState empty() => SerieState(
        status: SerieStateStatus.loading,
        errorMessage: '',
        comicDetails: SerieItemDetailModel(),
      );

  SerieState copyWith({
    SerieStateStatus? status,
    String? errorMessage,
    SerieItemDetailModel? comicDetails,
  }) {
    return SerieState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      comicDetails: comicDetails ?? this.comicDetails,
    );
  }
}
