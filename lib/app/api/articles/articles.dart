import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:webshop_flutter/app/utils/globals.dart' as global;

part 'articles.g.dart';

@RestApi(baseUrl: global.apiUrl)
abstract class ArticlesApi {
  factory ArticlesApi(Dio dio, {String baseUrl}) = _ArticlesApi;

  @GET("/articles")
  Future<List<Article>> getArticles();

  @GET("/articles/{id}")
  Future<Article> getArticle(@Path() String id);

  @POST("/articles")
  Future<void> createArticle(@Body() Article article);

  @PUT("/articles/{id}")
  Future<Article> updateArticle(@Path() String id, @Body() Article article);

  @DELETE("/articles/{id}")
  Future<void> deleteArticle(@Path() String id);
}

@JsonSerializable()
class Article {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;

  const Article({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
