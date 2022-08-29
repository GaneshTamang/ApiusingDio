import 'package:catapi_1/models/favorite_model.dart';
import 'package:catapi_1/models/random_image_model.dart';
import 'package:catapi_1/models/vote_cat_model.dart';
import 'package:catapi_1/services/cat_api_endpoints.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CatApiService {
  final Dio _dio = Dio();
  //constructor
  CatApiService() {
    _dio.interceptors.add(ChuckerDioInterceptor());
  }

  Future<RandomImageModel>? fetchRandomImage() async {
    try {
      final getRandomImageResponse =
          await _dio.get(CatApiEndpoints.randomImageUrl);
      var result = RandomImageModel.fromJson(getRandomImageResponse.data[0]);
      debugPrint(getRandomImageResponse.data[0].toString());
      return result;
    } on DioError catch (e) {
      debugPrint("Status code:${e.response?.statusCode.toString()}");
      throw Exception("Failed to load image");
    }
  }

  Future<VoteCatModel?> vote(String imageId, int value) async {
    try {
      final sendResponse = await _dio.post(CatApiEndpoints.vote,
          options: Options(
            headers: {'x-api-key': CatApiEndpoints.apiKey},
          ),
          data: {
            "image_id": imageId,
            "value": value,
          });
      debugPrint("posting Data:${sendResponse.toString()}");

      return VoteCatModel.fromJson(sendResponse.data);
    } on DioError catch (e) {
      debugPrint("Status code:${e.response?.statusCode.toString()}");
      throw Exception("Failed to update vote  image");
    }
  }

  Future<FavoriteModel?> favorites(String imageId, String subId) async {
    try {
      final response = await _dio.post(CatApiEndpoints.favorite,
          options: Options(
            headers: {'x-api-key': CatApiEndpoints.apiKey},
          ),
          data: {
            "image_id": imageId,
            "sub_id": subId,
          });
      debugPrint("fav Response :${response.toString()}");

      return FavoriteModel.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code:${e.response?.statusCode.toString()}");
      throw Exception("Failed to favorite  image");
    }
  }

  Future<FavoriteModel> unFav(int favId, String subId) async {
    String unfavEndPoint =
        'https://api.thecatapi.com/v1/favourites/${favId.toString()}';
    try {
      final sendResponse = await _dio.delete(
        unfavEndPoint,
        options: Options(
          headers: {'x-api-key': CatApiEndpoints.apiKey, 'sub_Id': subId},
        ),
      );
      debugPrint("Deleted SuccessFully :$favId");
      return FavoriteModel.fromJson(sendResponse.extra);
    } on DioError catch (e) {
      debugPrint("Status code:${e.response?.statusCode.toString()}");
      throw Exception("Failed to unfav  image$favId");
    }
  }
}
