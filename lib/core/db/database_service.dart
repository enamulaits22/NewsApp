import 'dart:io';

import 'package:news_app/core/db/newsdb_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  DatabaseService._init();
  static Database? _database;

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // / If database don't exists, create one
    _database = await initDB();
    return _database;
  }

  Future<dynamic> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'newsData.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE NewsArticle('
          'id INTEGER PRIMARY KEY AUTOINCREMENT ,'
          'author TEXT DEFAULT "0",'
          'title TEXT DEFAULT "0",'
          'description TEXT DEFAULT "0",'
          'url TEXT DEFAULT "0",'
          'urlToImage TEXT DEFAULT "0",'
          'publishedAt TEXT DEFAULT "0",'
          'content TEXT DEFAULT "0"'
          ')'
        );
    });
  }

   // Insert value into "NewsArticle" table
  Future<List<NewsDbModel>> addToNewsArticle(
      String author, String title, String description, String url, String urlToImage, String publishedAt, String content) async {
    final db = await database;
    final res = await db!.rawQuery(
        "INSERT INTO NewsArticle(author, title, description, url, urlToImage, publishedAt, content) VALUES(?, ?, ?, ?, ?, ?, ?)",
        [author, title, description, url, urlToImage, publishedAt, content]);

    List<NewsDbModel> list = res.isNotEmpty
        ? res.map((c) => NewsDbModel.fromJson(c)).toList()
        : [];
    return list;
  }

  //Get data from "NewsArticle" table
  Future<List<NewsDbModel>> getNewsArticleData() async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM NewsArticle");

    List<NewsDbModel> list = res.isNotEmpty
        ? res.map((c) => NewsDbModel.fromJson(c)).toList()
        : [];
    return list;
  }

  //Check if data is in "NewsArticle" table
  Future<List<NewsDbModel>> checkNewsData(String title) async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM NewsArticle WHERE title = ?", [title]);

    List<NewsDbModel> list = res.isNotEmpty
        ? res.map((c) => NewsDbModel.fromJson(c)).toList()
        : [];
    return list;
  }
  
  //Delete data from "NewsArticle" table
  Future<List<NewsDbModel>> deleteNewsArticleData(String title) async {
    final db = await database;
    final res = await db!.rawQuery("DELETE FROM NewsArticle WHERE title = ?", [title]);

    List<NewsDbModel> list = res.isNotEmpty
        ? res.map((c) => NewsDbModel.fromJson(c)).toList()
        : [];
    return list;
  }
}
