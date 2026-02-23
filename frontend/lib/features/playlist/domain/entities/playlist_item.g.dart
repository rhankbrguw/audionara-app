// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlaylistItemCollection on Isar {
  IsarCollection<PlaylistItem> get playlistItems => this.collection();
}

const PlaylistItemSchema = CollectionSchema(
  name: r'PlaylistItem',
  id: -7448504014523809551,
  properties: {
    r'addedAt': PropertySchema(
      id: 0,
      name: r'addedAt',
      type: IsarType.dateTime,
    ),
    r'artist': PropertySchema(
      id: 1,
      name: r'artist',
      type: IsarType.string,
    ),
    r'coverArt': PropertySchema(
      id: 2,
      name: r'coverArt',
      type: IsarType.string,
    ),
    r'streamUrl': PropertySchema(
      id: 3,
      name: r'streamUrl',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 4,
      name: r'title',
      type: IsarType.string,
    ),
    r'trackId': PropertySchema(
      id: 5,
      name: r'trackId',
      type: IsarType.string,
    )
  },
  estimateSize: _playlistItemEstimateSize,
  serialize: _playlistItemSerialize,
  deserialize: _playlistItemDeserialize,
  deserializeProp: _playlistItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'trackId': IndexSchema(
      id: -8614467705999066844,
      name: r'trackId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'trackId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'addedAt': IndexSchema(
      id: -8595779697745674092,
      name: r'addedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'addedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _playlistItemGetId,
  getLinks: _playlistItemGetLinks,
  attach: _playlistItemAttach,
  version: '3.1.0+1',
);

int _playlistItemEstimateSize(
  PlaylistItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.artist.length * 3;
  bytesCount += 3 + object.coverArt.length * 3;
  bytesCount += 3 + object.streamUrl.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.trackId.length * 3;
  return bytesCount;
}

void _playlistItemSerialize(
  PlaylistItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.addedAt);
  writer.writeString(offsets[1], object.artist);
  writer.writeString(offsets[2], object.coverArt);
  writer.writeString(offsets[3], object.streamUrl);
  writer.writeString(offsets[4], object.title);
  writer.writeString(offsets[5], object.trackId);
}

PlaylistItem _playlistItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlaylistItem();
  object.addedAt = reader.readDateTime(offsets[0]);
  object.artist = reader.readString(offsets[1]);
  object.coverArt = reader.readString(offsets[2]);
  object.id = id;
  object.streamUrl = reader.readString(offsets[3]);
  object.title = reader.readString(offsets[4]);
  object.trackId = reader.readString(offsets[5]);
  return object;
}

P _playlistItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _playlistItemGetId(PlaylistItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _playlistItemGetLinks(PlaylistItem object) {
  return [];
}

void _playlistItemAttach(
    IsarCollection<dynamic> col, Id id, PlaylistItem object) {
  object.id = id;
}

extension PlaylistItemByIndex on IsarCollection<PlaylistItem> {
  Future<PlaylistItem?> getByTrackId(String trackId) {
    return getByIndex(r'trackId', [trackId]);
  }

  PlaylistItem? getByTrackIdSync(String trackId) {
    return getByIndexSync(r'trackId', [trackId]);
  }

  Future<bool> deleteByTrackId(String trackId) {
    return deleteByIndex(r'trackId', [trackId]);
  }

  bool deleteByTrackIdSync(String trackId) {
    return deleteByIndexSync(r'trackId', [trackId]);
  }

  Future<List<PlaylistItem?>> getAllByTrackId(List<String> trackIdValues) {
    final values = trackIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'trackId', values);
  }

  List<PlaylistItem?> getAllByTrackIdSync(List<String> trackIdValues) {
    final values = trackIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'trackId', values);
  }

  Future<int> deleteAllByTrackId(List<String> trackIdValues) {
    final values = trackIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'trackId', values);
  }

  int deleteAllByTrackIdSync(List<String> trackIdValues) {
    final values = trackIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'trackId', values);
  }

  Future<Id> putByTrackId(PlaylistItem object) {
    return putByIndex(r'trackId', object);
  }

  Id putByTrackIdSync(PlaylistItem object, {bool saveLinks = true}) {
    return putByIndexSync(r'trackId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTrackId(List<PlaylistItem> objects) {
    return putAllByIndex(r'trackId', objects);
  }

  List<Id> putAllByTrackIdSync(List<PlaylistItem> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'trackId', objects, saveLinks: saveLinks);
  }
}

extension PlaylistItemQueryWhereSort
    on QueryBuilder<PlaylistItem, PlaylistItem, QWhere> {
  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhere> anyAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'addedAt'),
      );
    });
  }
}

extension PlaylistItemQueryWhere
    on QueryBuilder<PlaylistItem, PlaylistItem, QWhereClause> {
  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhereClause> trackIdEqualTo(
      String trackId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'trackId',
        value: [trackId],
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhereClause> trackIdNotEqualTo(
      String trackId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'trackId',
              lower: [],
              upper: [trackId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'trackId',
              lower: [trackId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'trackId',
              lower: [trackId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'trackId',
              lower: [],
              upper: [trackId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhereClause> addedAtEqualTo(
      DateTime addedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'addedAt',
        value: [addedAt],
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhereClause> addedAtNotEqualTo(
      DateTime addedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'addedAt',
              lower: [],
              upper: [addedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'addedAt',
              lower: [addedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'addedAt',
              lower: [addedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'addedAt',
              lower: [],
              upper: [addedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhereClause>
      addedAtGreaterThan(
    DateTime addedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'addedAt',
        lower: [addedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhereClause> addedAtLessThan(
    DateTime addedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'addedAt',
        lower: [],
        upper: [addedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterWhereClause> addedAtBetween(
    DateTime lowerAddedAt,
    DateTime upperAddedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'addedAt',
        lower: [lowerAddedAt],
        includeLower: includeLower,
        upper: [upperAddedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PlaylistItemQueryFilter
    on QueryBuilder<PlaylistItem, PlaylistItem, QFilterCondition> {
  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      addedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      addedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      addedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      addedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> artistEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      artistGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      artistLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> artistBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artist',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      artistStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      artistEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      artistContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> artistMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artist',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      artistIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artist',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      artistIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artist',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      coverArtEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverArt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      coverArtGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coverArt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      coverArtLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coverArt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      coverArtBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coverArt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      coverArtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'coverArt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      coverArtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'coverArt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      coverArtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coverArt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      coverArtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coverArt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      coverArtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coverArt',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      coverArtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coverArt',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      streamUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      streamUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'streamUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      streamUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'streamUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      streamUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'streamUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      streamUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'streamUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      streamUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'streamUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      streamUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'streamUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      streamUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'streamUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      streamUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      streamUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'streamUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      trackIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      trackIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      trackIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      trackIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      trackIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      trackIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      trackIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      trackIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      trackIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterFilterCondition>
      trackIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackId',
        value: '',
      ));
    });
  }
}

extension PlaylistItemQueryObject
    on QueryBuilder<PlaylistItem, PlaylistItem, QFilterCondition> {}

extension PlaylistItemQueryLinks
    on QueryBuilder<PlaylistItem, PlaylistItem, QFilterCondition> {}

extension PlaylistItemQuerySortBy
    on QueryBuilder<PlaylistItem, PlaylistItem, QSortBy> {
  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> sortByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> sortByAddedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.desc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> sortByArtist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> sortByArtistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.desc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> sortByCoverArt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverArt', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> sortByCoverArtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverArt', Sort.desc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> sortByStreamUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamUrl', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> sortByStreamUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamUrl', Sort.desc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> sortByTrackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> sortByTrackIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.desc);
    });
  }
}

extension PlaylistItemQuerySortThenBy
    on QueryBuilder<PlaylistItem, PlaylistItem, QSortThenBy> {
  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByAddedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedAt', Sort.desc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByArtist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByArtistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artist', Sort.desc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByCoverArt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverArt', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByCoverArtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coverArt', Sort.desc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByStreamUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamUrl', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByStreamUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamUrl', Sort.desc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByTrackId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.asc);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QAfterSortBy> thenByTrackIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackId', Sort.desc);
    });
  }
}

extension PlaylistItemQueryWhereDistinct
    on QueryBuilder<PlaylistItem, PlaylistItem, QDistinct> {
  QueryBuilder<PlaylistItem, PlaylistItem, QDistinct> distinctByAddedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addedAt');
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QDistinct> distinctByArtist(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artist', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QDistinct> distinctByCoverArt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coverArt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QDistinct> distinctByStreamUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streamUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlaylistItem, PlaylistItem, QDistinct> distinctByTrackId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackId', caseSensitive: caseSensitive);
    });
  }
}

extension PlaylistItemQueryProperty
    on QueryBuilder<PlaylistItem, PlaylistItem, QQueryProperty> {
  QueryBuilder<PlaylistItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlaylistItem, DateTime, QQueryOperations> addedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addedAt');
    });
  }

  QueryBuilder<PlaylistItem, String, QQueryOperations> artistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artist');
    });
  }

  QueryBuilder<PlaylistItem, String, QQueryOperations> coverArtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coverArt');
    });
  }

  QueryBuilder<PlaylistItem, String, QQueryOperations> streamUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streamUrl');
    });
  }

  QueryBuilder<PlaylistItem, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<PlaylistItem, String, QQueryOperations> trackIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackId');
    });
  }
}
