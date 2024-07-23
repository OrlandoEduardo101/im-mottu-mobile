import '../models/character_wrapper_model.dart';
import '../params/get_character_list_params.dart';

abstract class IHomeRepository {
  Future<(CharacterDataWrapper?, String errorMessage)> getCharacterListData(GetCharacterListParams params);
}
