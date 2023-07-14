import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../song/song.dart';
part 'playlist.g.dart';

@HiveType(typeId: 1)
class Playlist {
  @HiveField(0)
  final List<Song> playlist;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  Playlist({
    required this.playlist,
    required this.name,
    required this.description,
  });

  Playlist copyWith({
    List<Song>? playlist,
    String? name,
    String? description,
  }) {
    return Playlist(
      playlist: playlist ?? this.playlist,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playlist': playlist.map((x) => x.toMap()).toList(),
      'name': name,
      'description': description,
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      playlist: List<Song>.from(map['playlist']?.map((x) => Song.fromMap(x))),
      name: map['name'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) =>
      Playlist.fromMap(json.decode(source));

  @override
  String toString() =>
      'Playlist(playlist: $playlist, name: $name, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Playlist &&
        listEquals(other.playlist, playlist) &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => playlist.hashCode ^ name.hashCode ^ description.hashCode;
}
