import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:webshop_flutter/app/utils/globals.dart' as global;

part 'users.g.dart';

@RestApi(baseUrl: global.apiUrl)
abstract class UsersApi {
  factory UsersApi(Dio dio, {String baseUrl}) = _UsersApi;

  @GET("/users")
  Future<List<User>> getUsers();

  @GET("/users/{id}")
  Future<User> getUser(@Path() String id);

  @POST("/users")
  Future<void> createUser(@Body() User user);

  @PUT("/users/{id}")
  Future<User> updateUser(@Path() String id, @Body() User user);

  @DELETE("/users/{id}")
  Future<void> deleteUser(@Path() String id);
}

@JsonSerializable()
class User {
  final String? id;
  final DateTime? createdAt;
  final String username;
  final String password;

  const User({
    this.id,
    this.createdAt,
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
