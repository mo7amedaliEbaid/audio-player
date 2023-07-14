import 'dart:convert';
import 'package:hive/hive.dart';

part 'song.g.dart';

@HiveType(typeId: 0)
class Song {
  @HiveField(0)
  final String songPath;
  Song({
    required this.songPath,
  });

  @override
  String toString() => 'Song(songPath: $songPath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Song && other.songPath == songPath;
  }

  @override
  int get hashCode => songPath.hashCode;

  Song copyWith({
    String? songPath,
  }) {
    return Song(
      songPath: songPath ?? this.songPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'songPath': songPath,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      songPath: map['songPath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));
}
