import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_mottu_flutter/app/modules/home/submodules/series/interactor/stores/serie_store.dart';
import 'package:im_mottu_flutter/app/shared/widgets/loading/shimmer_container.dart';

import '../../../../../shared/widgets/img/cached_network_image_widget.dart';
import '../interactor/states/serie_state.dart';

class SeriePage extends StatefulWidget {
  const SeriePage({super.key, required this.serieStore, required this.uriResource});
  final SerieStore serieStore;
  final String uriResource;

  @override
  State<SeriePage> createState() => _SeriePageState();
}

class _SeriePageState extends State<SeriePage> {
  @override
  void initState() {
    super.initState();
    widget.serieStore.getComicDetail(url: widget.uriResource);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return GetBuilder<SerieStore>(
      init: widget.serieStore,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              controller.state.comicDetails.title,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                switch ((controller.state.status)) {
                  (SerieStateStatus.loading) => ListView.separated(
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(),
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ShimmerContainer(
                          height: index == 0 ? 300 : 100,
                          width: double.infinity,
                        );
                      },
                    ),
                  (SerieStateStatus.error) => Center(
                      child: Text(controller.state.errorMessage),
                    ),
                  (SerieStateStatus.success) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Cover',
                            style: textTheme.titleLarge
                                ?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 3 / 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImageWidget(
                                imageUrl: '${controller.state.comicDetails.thumbnail?.path}/standard_fantastic.jpg',
                                fit: BoxFit.fitHeight,
                                errorWidget: (p0, p1, p2) => Icon(
                                  Icons.image_not_supported_outlined,
                                  color: colorScheme.onSecondaryFixed.withOpacity(0.25),
                                  size: 110,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (controller.state.comicDetails.description?.isNotEmpty ?? false) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Description',
                              style: textTheme.titleLarge
                                  ?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              controller.state.comicDetails.description ?? 'Description is not found',
                              textAlign: TextAlign.justify,
                              style: textTheme.bodyLarge?.copyWith(),
                            ),
                          ),
                          if (controller.state.comicDetails.characters?.items.isNotEmpty ?? false) ...[
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Characters',
                                style: textTheme.titleLarge
                                    ?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListView.builder(
                              padding: const EdgeInsets.all(8.0),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.state.comicDetails.characters?.items.length ?? 0,
                              itemBuilder: (context, index) {
                                final item = controller.state.comicDetails.characters?.items[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '•  ${item?.name}',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                          if (controller.state.comicDetails.comics?.items.isNotEmpty ?? false) ...[
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Comics',
                                style: textTheme.titleLarge
                                    ?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListView.builder(
                              padding: const EdgeInsets.all(8.0),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.state.comicDetails.comics?.items.length ?? 0,
                              itemBuilder: (context, index) {
                                final item = controller.state.comicDetails.comics?.items[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '•  ${item?.name}',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                          if (controller.state.comicDetails.creators?.items?.isNotEmpty ?? false) ...[
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Creators',
                                style: textTheme.titleLarge
                                    ?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListView.builder(
                              padding: const EdgeInsets.all(8.0),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.state.comicDetails.creators?.items?.length ?? 0,
                              itemBuilder: (context, index) {
                                final item = controller.state.comicDetails.creators?.items?[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        '•  ${item?.name}',
                                        style: textTheme.titleMedium?.copyWith(
                                          color: colorScheme.onSurface,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Role: ${item?.role}',
                                          style: textTheme.labelMedium?.copyWith(
                                            color: colorScheme.outline,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ]
                        ],
                      ],
                    ),
                }
              ],
            ),
          ),
        );
      },
    );
  }
}
