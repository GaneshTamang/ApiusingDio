import 'package:catapi_1/models/cat_breed_model.dart';
import 'package:catapi_1/services/cat_api_endpoints.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BreedService {
  final Dio _breedDio = Dio();
  //contructor  actions when onject build
  BreedService() {
    _breedDio.interceptors.add(ChuckerDioInterceptor());
  }
  Future<List<CatBreedModel>> fetchBreedList() async {
    try {
      var getBreedListResponse = await _breedDio.get(CatApiEndpoints.breedList);
      final responseData = getBreedListResponse.data;
      final resultBreedList =
          responseData.map((e) => CatBreedModel.fromJson(e)).toList();
      return resultBreedList;
    } on DioError catch (e) {
      debugPrint("Status code:${e.response?.statusCode.toString()}");
      throw Exception("Failed to load post:");
    }
  }
}
