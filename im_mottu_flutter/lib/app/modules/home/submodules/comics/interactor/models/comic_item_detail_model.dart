import 'dart:convert';

import '../../../../interactor/models/stories.dart';
import '../../../../interactor/models/thumbnail.dart';
import '../../../../interactor/models/url.dart';
import 'characters_summary_model.dart';
import '../../../../interactor/models/creators_model.dart';
import 'date_item.dart';
import 'events_summary_model.dart';
import 'price_item.dart';
import 'series_model.dart';
import 'text_object.dart';

class ComicItemDetailModel {
  final int? id;
  final int? digitalId;
  final String? title;
  final int? issueNumber;
  final String? variantDescription;
  final String? description;
  final String? modified;
  final String? isbn;
  final String? upc;
  final String? diamondCode;
  final String? ean;
  final String? issn;
  final String? format;
  final int? pageCount;
  final List<TextObject>? textObjects;
  final String? resourceUri;
  final List<Url>? urls;
  final Series? series;
  final List<Series>? variants;
  final List<DateItem>? dates;
  final List<Price>? prices;
  final Thumbnail? thumbnail;
  final List<Thumbnail>? images;
  final CreatorsModel? creators;
  final CharactersSummaryModel? characters;
  final Stories? stories;
  final EventsSummaryModel? events;

  ComicItemDetailModel({
    this.id,
    this.digitalId,
    this.title,
    this.issueNumber,
    this.variantDescription,
    this.description,
    this.modified,
    this.isbn,
    this.upc,
    this.diamondCode,
    this.ean,
    this.issn,
    this.format,
    this.pageCount,
    this.textObjects,
    this.resourceUri,
    this.urls,
    this.series,
    this.variants,
    this.dates,
    this.prices,
    this.thumbnail,
    this.images,
    this.creators,
    this.characters,
    this.stories,
    this.events,
  });

  ComicItemDetailModel copyWith({
    int? id,
    int? digitalId,
    String? title,
    int? issueNumber,
    String? variantDescription,
    String? description,
    String? modified,
    String? isbn,
    String? upc,
    String? diamondCode,
    String? ean,
    String? issn,
    String? format,
    int? pageCount,
    List<TextObject>? textObjects,
    String? resourceUri,
    List<Url>? urls,
    Series? series,
    List<Series>? variants,
    List<DateItem>? dates,
    List<Price>? prices,
    Thumbnail? thumbnail,
    List<Thumbnail>? images,
    CreatorsModel? creators,
    CharactersSummaryModel? characters,
    Stories? stories,
    EventsSummaryModel? events,
  }) =>
      ComicItemDetailModel(
        id: id ?? this.id,
        digitalId: digitalId ?? this.digitalId,
        title: title ?? this.title,
        issueNumber: issueNumber ?? this.issueNumber,
        variantDescription: variantDescription ?? this.variantDescription,
        description: description ?? this.description,
        modified: modified ?? this.modified,
        isbn: isbn ?? this.isbn,
        upc: upc ?? this.upc,
        diamondCode: diamondCode ?? this.diamondCode,
        ean: ean ?? this.ean,
        issn: issn ?? this.issn,
        format: format ?? this.format,
        pageCount: pageCount ?? this.pageCount,
        textObjects: textObjects ?? this.textObjects,
        resourceUri: resourceUri ?? this.resourceUri,
        urls: urls ?? this.urls,
        series: series ?? this.series,
        variants: variants ?? this.variants,
        dates: dates ?? this.dates,
        prices: prices ?? this.prices,
        thumbnail: thumbnail ?? this.thumbnail,
        images: images ?? this.images,
        creators: creators ?? this.creators,
        characters: characters ?? this.characters,
        stories: stories ?? this.stories,
        events: events ?? this.events,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'digitalId': digitalId,
      'title': title,
      'issueNumber': issueNumber,
      'variantDescription': variantDescription,
      'description': description,
      'modified': modified,
      'isbn': isbn,
      'upc': upc,
      'diamondCode': diamondCode,
      'ean': ean,
      'issn': issn,
      'format': format,
      'pageCount': pageCount,
      'textObjects': textObjects?.map((x) => x.toMap()).toList(),
      'resourceUri': resourceUri,
      'urls': urls?.map((x) => x.toMap()).toList(),
      'series': series?.toMap(),
      'variants': variants?.map((x) => x.toMap()).toList(),
      'dates': dates?.map((x) => x.toMap()).toList(),
      'prices': prices?.map((x) => x.toMap()).toList(),
      'thumbnail': thumbnail?.toMap(),
      'images': images?.map((x) => x.toMap()).toList(),
      'creators': creators?.toMap(),
      'characters': characters?.toMap(),
      'stories': stories?.toMap(),
      'events': events?.toMap(),
    };
  }

  factory ComicItemDetailModel.fromMap(Map<String, dynamic> map) {
    return ComicItemDetailModel(
      id: map['id']?.toInt(),
      digitalId: map['digitalId']?.toInt(),
      title: map['title'],
      issueNumber: map['issueNumber']?.toInt(),
      variantDescription: map['variantDescription'],
      description: map['description'],
      modified: map['modified'],
      isbn: map['isbn'],
      upc: map['upc'],
      diamondCode: map['diamondCode'],
      ean: map['ean'],
      issn: map['issn'],
      format: map['format'],
      pageCount: map['pageCount']?.toInt(),
      textObjects: map['textObjects'] != null
          ? List<TextObject>.from(map['textObjects']?.map((x) => TextObject.fromMap(x)))
          : null,
      resourceUri: map['resourceUri'],
      urls: map['urls'] != null ? List<Url>.from(map['urls']?.map((x) => Url.fromMap(x))) : null,
      series: map['series'] != null ? Series.fromMap(map['series']) : null,
      variants: map['variants'] != null ? List<Series>.from(map['variants']?.map((x) => Series.fromMap(x))) : null,
      dates: map['dates'] != null ? List<DateItem>.from(map['dates']?.map((x) => DateItem.fromMap(x))) : null,
      prices: map['prices'] != null ? List<Price>.from(map['prices']?.map((x) => Price.fromMap(x))) : null,
      thumbnail: map['thumbnail'] != null ? Thumbnail.fromMap(map['thumbnail']) : null,
      images: map['images'] != null ? List<Thumbnail>.from(map['images']?.map((x) => Thumbnail.fromMap(x))) : null,
      creators: map['creators'] != null ? CreatorsModel.fromMap(map['creators']) : null,
      characters: map['characters'] != null ? CharactersSummaryModel.fromMap(map['characters']) : null,
      stories: map['stories'] != null ? Stories.fromMap(map['stories']) : null,
      events: map['events'] != null ? EventsSummaryModel.fromMap(map['events']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ComicItemDetailModel.fromJson(String source) => ComicItemDetailModel.fromMap(json.decode(source));
}
