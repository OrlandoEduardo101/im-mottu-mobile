class GetCharacterListParams {
  final int limit;
  final int offset;
  final String nameFilter;

  GetCharacterListParams({this.limit = 10, required this.offset, this.nameFilter = ''});
}
