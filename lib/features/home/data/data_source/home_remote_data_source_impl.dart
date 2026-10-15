import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';

import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

import '../../../../core/constants/api_endpoints.dart';
import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl(this.apiClient);
  @override
  Future<List<HomeCategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categoriesEndPoint);
    final List jsonData = response.data;
    final List<HomeCategoryModel> categories = jsonData
        .map((e) => HomeCategoryModel.fromJson(e))
        .toList();

    return categories;
  }

  @override
  Future<List<HomeProductModel>> getProducts(
    int? categoryId, {
    required int offset,
    required int limit,
  }) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoints.categoriesEndPoint}/$categoryId/${ApiEndpoints.productsEndPoint}',
      queryParameters: {"limit": limit, "offset": offset},
    );
    final List jsonData = response.data;
    final List<HomeProductModel> products = jsonData
        .map((e) => HomeProductModel.fromJson(e))
        .toList();
    return products;
  }
}
