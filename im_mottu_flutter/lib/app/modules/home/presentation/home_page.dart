import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_mottu_flutter/app/app_store.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/states/home_state.dart';
import 'package:im_mottu_flutter/app/shared/services/theme/theme_app_state.dart';
import 'package:im_mottu_flutter/app/shared/widgets/bottom_sheet/bottom_sheet_service.dart';
import 'package:im_mottu_flutter/app/shared/widgets/img/marvel_logo.dart';

import '../../../shared/constants/constants.dart';
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
  final ScrollController scrollController = ScrollController();
  final searchEditingController = TextEditingController();
  double boundaryOffset = 0.5;
  @override
  void initState() {
    super.initState();
    widget.homeStore.getCharacters();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (widget.homeStore.state.status == HomeStateStatus.success) {
      //load more data
      if (scrollController.offset >= scrollController.position.maxScrollExtent * boundaryOffset) {
        widget.homeStore.getCharacters();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          transitionOnUserGestures: true,
          tag: kMarvelLogoHeroTag,
          child: MarvelLogo(
            width: size.width * 0.35,
            colorFilter: colorScheme.onPrimary,
          ),
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
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22.0),
                    child: CustomSearchField(
                      hintText: 'Search character',
                      textEditingController: searchEditingController,
                      onChanged: (value) {
                        if (widget.appStore.state.hasConnection) {
                          widget.homeStore.getCharactersByTextFromApi(value);
                        } else {
                          widget.homeStore.getCharactersByText(value);
                        }
                      },
                    ),
                  ),
                  if (controller.state.status == HomeStateStatus.loading && controller.state.charactersList.isEmpty)
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
                      itemCount: controller.state.charactersListFiltered.length + 1,
                      itemBuilder: (context, index) {
                        if (index == controller.state.charactersListFiltered.length) {
                          if (controller.state.status == HomeStateStatus.loading) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }
                        final item = controller.state.charactersListFiltered[index];
                        return CharacterCardWidget(
                          item: item,
                          onTap: () {
                            BottomSheetService.showCustomBottomSheet(context, CharacterDetailSheet(item: item));
                            widget.homeStore.logCharacterViewed(item.name);
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
