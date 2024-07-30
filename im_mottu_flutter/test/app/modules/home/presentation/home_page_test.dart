import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:im_mottu_flutter/app/app_state.dart';
import 'package:im_mottu_flutter/app/app_store.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/models/resources.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/models/result_character.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/models/stories.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/models/thumbnail.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/states/home_state.dart';
import 'package:im_mottu_flutter/app/modules/home/interactor/stores/home_store.dart';
import 'package:im_mottu_flutter/app/modules/home/presentation/home_page.dart';
import 'package:im_mottu_flutter/app/modules/home/presentation/widgets/character_card_widget.dart';
import 'package:im_mottu_flutter/app/shared/services/theme/theme_app_state.dart';
import 'package:im_mottu_flutter/app/shared/widgets/loading/shimmer_container.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeStore extends GetxController with Mock implements HomeStore {}

class MockAppStore extends GetxController with Mock implements AppStore {}

void main() {
  late MockHomeStore mockHomeStore;
  late MockAppStore mockAppStore;

  setUpAll(() {
    mockHomeStore = MockHomeStore();
    mockAppStore = MockAppStore();

    when(() => mockAppStore.state).thenReturn(
      AppState(themeState: const ThemeAppState(theme: ThemeEnum.lightTheme), hasConnection: true),
    );

    when(() => mockHomeStore.getCharacters()).thenAnswer((_) async => true);
  });

  final characters = [
    ResultCharacter(
      name: 'Spider-Man',
      id: 0,
      description: '',
      modified: DateTime.now(),
      thumbnail: Thumbnail(path: '', extension: Extension.JPG),
      resourceUri: '',
      comics: Resources(available: 0, collectionUri: '', items: [], returned: 0),
      series: Resources(available: 0, collectionUri: '', items: [], returned: 0),
      stories: Stories(available: 0, collectionUri: '', items: [], returned: 0),
      events: Resources(available: 0, collectionUri: '', items: [], returned: 0),
      urls: [],
    ),
    ResultCharacter(
      name: 'Iron Man',
      id: 1,
      description: '',
      modified: DateTime.now(),
      thumbnail: Thumbnail(path: '', extension: Extension.JPG),
      resourceUri: '',
      comics: Resources(available: 0, collectionUri: '', items: [], returned: 0),
      series: Resources(available: 0, collectionUri: '', items: [], returned: 0),
      stories: Stories(available: 0, collectionUri: '', items: [], returned: 0),
      events: Resources(available: 0, collectionUri: '', items: [], returned: 0),
      urls: [],
    )
  ];

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: HomePage(
        homeStore: mockHomeStore,
        appStore: mockAppStore,
      ),
    );
  }

  testWidgets('Displays loading shimmer when state is loading and charactersList is empty', (tester) async {
    when(() => mockHomeStore.state).thenReturn(
      HomeState(status: HomeStateStatus.loading, charactersList: [], charactersListFiltered: [], errorMessage: ''),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(ShimmerContainer), findsWidgets);
  });

  testWidgets('Displays error message when state is error', (tester) async {
    const errorMessage = 'An error occurred';
    when(() => mockHomeStore.state).thenReturn(
      HomeState(
          status: HomeStateStatus.error, charactersList: [], charactersListFiltered: [], errorMessage: errorMessage),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('Displays "Characters not found" when state is success and charactersList is empty', (tester) async {
    when(() => mockHomeStore.state).thenReturn(
      HomeState(status: HomeStateStatus.success, charactersList: [], charactersListFiltered: [], errorMessage: ''),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Characters not found'), findsOneWidget);
  });

  testWidgets('Displays characters list when state is success and charactersList is not empty', (tester) async {
    when(() => mockHomeStore.state).thenReturn(
      HomeState(
          status: HomeStateStatus.success,
          charactersList: characters,
          charactersListFiltered: characters,
          errorMessage: ''),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CharacterCardWidget), findsNWidgets(characters.length));
  });

  testWidgets('Displays more characters and shimmer when state is loading and charactersList is not empty',
      (tester) async {
    when(() => mockHomeStore.state).thenReturn(
      HomeState(
        status: HomeStateStatus.loading,
        charactersList: characters,
        charactersListFiltered: characters,
        errorMessage: '',
      ),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CharacterCardWidget), findsNWidgets(characters.length));
    expect(find.byType(ShimmerContainer), findsWidgets);
  });
}
