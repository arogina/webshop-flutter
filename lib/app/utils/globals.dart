import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:webshop_flutter/app/models/cart.dart';

const apiUrl = "https://6515cd3f09e3260018c92937.mockapi.io/webshop/api/";
final dio = Dio();

final logger = Logger();

List<Cart> currentCart = [];
