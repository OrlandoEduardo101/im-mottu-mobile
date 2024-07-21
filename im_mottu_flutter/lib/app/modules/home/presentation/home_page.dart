import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_mottu_flutter/app/app_store.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/states/home_state.dart';
import 'package:im_mottu_flutter/app/shared/services/theme/theme_app_state.dart';
import 'package:im_mottu_flutter/app/shared/widgets/bottom_sheet/bottom_sheet_service.dart';
import 'package:im_mottu_flutter/app/shared/widgets/img/marvel_logo.dart';

import '../../../shared/widgets/buttons/switch_theme_mode.dart';
import '../../../shared/widgets/text_input/custom_search_field.dart';
import '../interactor/stores/home_store.dart';
import 'widgets/character_card_widget.dart';
import 'widgets/character_detail_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.homeStore, required this.appStore});
  final HomeStore homeStore;
  final AppStore appStore;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.homeStore.getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: MarvelLogo(
          width: size.width * 0.35,
          colorFilter: colorScheme.onPrimary,
        ),
        actions: [
          SwitchThemeMode(
              value: widget.appStore.state.themeState.theme == ThemeEnum.lightTheme,
              onChanged: (value) {
                if (value) {
                  widget.appStore.changeTheme(ThemeEnum.lightTheme);
                } else {
                  widget.appStore.changeTheme(ThemeEnum.darkTheme);
                }
              }),
        ],
      ),
      body: GetBuilder<HomeStore>(
          init: widget.homeStore,
          builder: (controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22.0),
                    child: CustomSearchField(
                      hintText: 'Search character',
                      onChanged: (value) {
                        widget.homeStore.getCharactersByText(value);
                      },
                    ),
                  ),
                  if (controller.state.status == HomeStateStatus.loading)
                    const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  else if (controller.state.status == HomeStateStatus.error)
                    Center(
                      child: Text(controller.state.errorMessage),
                    )
                  else if (controller.state.charactersListFiltered.isEmpty)
                    const Center(
                      child: Text('Characters not found'),
                    )
                  else
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200, childAspectRatio: 6 / 7, crossAxisSpacing: 20, mainAxisSpacing: 20),
                      itemCount: controller.state.charactersListFiltered.length,
                      itemBuilder: (context, index) {
                        final item = controller.state.charactersListFiltered[index];
                        return CharacterCardWidget(
                          item: item,
                          onTap: () {
                            BottomSheetService.showCustomBottomSheet(context, CharacterDetailSheet(item: item));
                          },
                        );
                      },
                    ),
                ],
              ),
            );
          }),
    );
  }
}
