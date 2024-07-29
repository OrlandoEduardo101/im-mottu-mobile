import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_mottu_flutter/app/modules/home/submodules/comics/interactor/states/comics_state.dart';
import 'package:im_mottu_flutter/app/modules/home/submodules/comics/interactor/stores/comic_store.dart';
import 'package:im_mottu_flutter/app/shared/widgets/loading/shimmer_container.dart';

import '../../../../../shared/widgets/img/cached_network_image_widget.dart';

class ComicPage extends StatefulWidget {
  const ComicPage({super.key, required this.comicStore, required this.uriResource});
  final ComicStore comicStore;
  final String uriResource;

  @override
  State<ComicPage> createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {
  @override
  void initState() {
    super.initState();
    widget.comicStore.getComicDetail(url: widget.uriResource);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return GetBuilder<ComicStore>(
      init: widget.comicStore,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              controller.state.comicDetails.title ?? '',
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
                  (ComicsStateStatus.loading) => ListView.separated(
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
                  (ComicsStateStatus.error) => Center(
                      child: Text(controller.state.errorMessage),
                    ),
                  (ComicsStateStatus.success) => Column(
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
                          if (controller.state.comicDetails.variantDescription?.isNotEmpty ?? false)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controller.state.comicDetails.variantDescription ?? 'Description is not found',
                                textAlign: TextAlign.justify,
                                style: textTheme.bodyLarge?.copyWith(),
                              ),
                            ),
                        ],
                        if (controller.state.comicDetails.characters?.items?.isNotEmpty ?? false) ...[
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
                            itemCount: controller.state.comicDetails.characters?.items?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = controller.state.comicDetails.characters?.items?[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '•  ${item?.name}',
                                  style: textTheme.titleLarge?.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                        if (controller.state.comicDetails.prices?.isNotEmpty ?? false) ...[
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Price',
                              style: textTheme.titleLarge
                                  ?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.state.comicDetails.prices?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = controller.state.comicDetails.prices?[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    if ('${item?.type}'.contains('print'))
                                      Text(
                                        'Printed Edition: ',
                                        style: textTheme.titleLarge?.copyWith(
                                          color: colorScheme.onSurface,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )
                                    else
                                      Text(
                                        'Digital Edition: ',
                                        style: textTheme.titleLarge?.copyWith(
                                          color: colorScheme.onSurface,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    Text(
                                      '\$  ${item?.price}',
                                      style: textTheme.titleLarge?.copyWith(
                                        color: colorScheme.onSurface,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                        if (controller.state.comicDetails.variants?.isNotEmpty ?? false) ...[
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Variants',
                              style: textTheme.titleLarge
                                  ?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.state.comicDetails.variants?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = controller.state.comicDetails.variants?[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '•  ${item?.name}',
                                  style: textTheme.titleLarge?.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              );
                            },
                          ),
                        ]
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
