import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../interactor/models/creators_model.dart';
import '../../../../interactor/models/resources.dart';
import '../../../../interactor/models/stories.dart';
import '../../../../interactor/models/thumbnail.dart';
import '../../../../interactor/models/url.dart';

class SerieItemDetailModel {
  final int id;
  final String title;
  final String? description;
  final String resourceUri;
  final List<Url> urls;
  final int startYear;
  final int endYear;
  final String rating;
  final String type;
  final String modified;
  final Thumbnail? thumbnail;
  final CreatorsModel? creators;
  final Resources? characters;
  final Stories? stories;
  final Resources? comics;
  final Resources? events;

  SerieItemDetailModel({
    this.id = -1,
    this.title = '',
    this.description,
    this.resourceUri = '',
    this.urls = const [],
    this.startYear = 0,
    this.endYear = 0,
    this.rating = '',
    this.type = '',
    this.modified = '',
    this.thumbnail,
    this.creators,
    this.characters,
    this.stories,
    this.comics,
    this.events,
  });

  SerieItemDetailModel copyWith({
    int? id,
    String? title,
    ValueGetter<String?>? description,
    String? resourceUri,
    List<Url>? urls,
    int? startYear,
    int? endYear,
    String? rating,
    String? type,
    String? modified,
    Thumbnail? thumbnail,
    CreatorsModel? creators,
    Resources? characters,
    Stories? stories,
    Resources? comics,
    Resources? events,
  }) {
    return SerieItemDetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description != null ? description() : this.description,
      resourceUri: resourceUri ?? this.resourceUri,
      urls: urls ?? this.urls,
      startYear: startYear ?? this.startYear,
      endYear: endYear ?? this.endYear,
      rating: rating ?? this.rating,
      type: type ?? this.type,
      modified: modified ?? this.modified,
      thumbnail: thumbnail ?? this.thumbnail,
      creators: creators ?? this.creators,
      characters: characters ?? this.characters,
      stories: stories ?? this.stories,
      comics: comics ?? this.comics,
      events: events ?? this.events,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'resourceUri': resourceUri,
      'urls': urls.map((x) => x.toMap()).toList(),
      'startYear': startYear,
      'endYear': endYear,
      'rating': rating,
      'type': type,
      'modified': modified,
      'thumbnail': thumbnail?.toMap(),
      'creators': creators?.toMap(),
      'characters': characters?.toMap(),
      'stories': stories?.toMap(),
      'comics': comics?.toMap(),
      'events': events?.toMap(),
    };
  }

  factory SerieItemDetailModel.fromMap(Map<String, dynamic> map) {
    return SerieItemDetailModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'],
      resourceUri: map['resourceUri'] ?? '',
      urls: List<Url>.from(map['urls']?.map((x) => Url.fromMap(x))),
      startYear: map['startYear']?.toInt() ?? 0,
      endYear: map['endYear']?.toInt() ?? 0,
      rating: map['rating'] ?? '',
      type: map['type'] ?? '',
      modified: map['modified'] ?? '',
      thumbnail: Thumbnail.fromMap(map['thumbnail']),
      creators: CreatorsModel.fromMap(map['creators']),
      characters: Resources.fromMap(map['characters']),
      stories: Stories.fromMap(map['stories']),
      comics: Resources.fromMap(map['comics']),
      events: Resources.fromMap(map['events']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SerieItemDetailModel.fromJson(String source) => SerieItemDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SerieItemDetailModel(id: $id, title: $title, description: $description, resourceUri: $resourceUri, urls: $urls, startYear: $startYear, endYear: $endYear, rating: $rating, type: $type, modified: $modified, thumbnail: $thumbnail, creators: $creators, characters: $characters, stories: $stories, comics: $comics, events: $events)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SerieItemDetailModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.resourceUri == resourceUri &&
        listEquals(other.urls, urls) &&
        other.startYear == startYear &&
        other.endYear == endYear &&
        other.rating == rating &&
        other.type == type &&
        other.modified == modified &&
        other.thumbnail == thumbnail &&
        other.creators == creators &&
        other.characters == characters &&
        other.stories == stories &&
        other.comics == comics &&
        other.events == events;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        resourceUri.hashCode ^
        urls.hashCode ^
        startYear.hashCode ^
        endYear.hashCode ^
        rating.hashCode ^
        type.hashCode ^
        modified.hashCode ^
        thumbnail.hashCode ^
        creators.hashCode ^
        characters.hashCode ^
        stories.hashCode ^
        comics.hashCode ^
        events.hashCode;
  }
}
