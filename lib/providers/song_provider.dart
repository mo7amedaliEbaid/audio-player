import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/playlist/playlist.dart';
import '../models/song/song.dart';

class SongProvider extends ChangeNotifier {
  final audioPlayer = AudioPlayer();
  final songsCache = Hive.box('songs');
  final playlistCache = Hive.box('playlists');

  String? current = '';

  List playlists = [];

  List<FileSystemEntity>? _files;
  List? _songs = [];

  List? get songs => _songs;

  fetch() {
    fetchHive();
    scanDevice();
  }

  fetchHive() {
    _songs = songsCache.get('songs');
    _songs ??= [];
  }

  scanDevice() async {
    var status = await Permission.storage.status;
    var extStorage = await Permission.manageExternalStorage.status;
    if (status.isDenied || extStorage.isDenied) {
      await [
        Permission.storage,
        Permission.manageExternalStorage,
      ].request();
    }
    Directory directory = Directory('/storage/emulated/0/');

    _files = directory.listSync(recursive: true, followLinks: false);
    for (FileSystemEntity entity in _files!) {
      String path = entity.path;
      if (path.endsWith('.mp3')) {
        _songs!.add(
          Song(songPath: entity.path),
        );
      }
    }

    songsCache.put('songs', _songs!);
  }

  // Audio Player
  bool stopped = false;

  AudioPlayer get getPlayer => audioPlayer;
  PlayerState get state => audioPlayer.playerState;
  bool get isPlaying => audioPlayer.playerState.playing;
  bool get isStopped => stopped;

  playSong({String? path}) {
    stopped = false;
    String newPath = '';
    if (path == null) {
      var rd = Random();
      int r = rd.nextInt(songs!.length);

      newPath = songs![r].songPath;
    }
    current = path ?? newPath;
    audioPlayer.setFilePath(path ?? newPath);
    audioPlayer.play();
    notifyListeners();
  }

  pauseSong() {
    audioPlayer.pause();
    notifyListeners();
  }

  stopSong() {
    audioPlayer.stop();
    stopped = true;
    notifyListeners();
  }

  addPlaylist(Playlist playlist) {
    List<Playlist>? localLists = playlistCache.get('playlists');
    localLists ??= [];

    localLists.add(playlist);
    playlistCache.put('playlists', localLists);

    notifyListeners();
  }

  List get getLists => playlists;
  getPlaylists() {
    playlists = playlistCache.get('playlists') ?? [];
    notifyListeners();
  }

  liked(Song song) {
    List? localSongs = songsCache.get('liked');
    localSongs ??= [];
    localSongs.add(song);

    songsCache.put('liked', localSongs);
    likedSongs = localSongs;

    notifyListeners();
  }

  unLiked(Song song) {
    List? localSongs = songsCache.get('liked');
    localSongs ??= [];
    localSongs.remove(song);

    songsCache.put('liked', localSongs);
    likedSongs = localSongs;
    notifyListeners();
  }

  List likedSongs = [];

  List get likedSongsList => likedSongs;

  getLiked() {
    List? localLikedSongs = songsCache.get('liked');
    localLikedSongs ??= [];

    likedSongs = localLikedSongs;
    notifyListeners();
  }
}
