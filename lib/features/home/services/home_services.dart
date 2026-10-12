import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';

import 'models/category_model.dart';
import 'models/product_model.dart';

class HomeServices {
  final ApiClient apiClient;
  HomeServices(this.apiClient);

  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categoriesEndPoint);
    final List jsonData = response.data;
    final List<CategoryModel> categories = jsonData
        .map((e) => CategoryModel.fromJson(e))
        .toList();

    return categories;
  }

  Future<List<ProductModel>> getProducts(int? categoryId) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoints.categoriesEndPoint}/$categoryId/${ApiEndpoints.productsEndPoint}',
    );
    final List jsonData = response.data;
    final List<ProductModel> products = jsonData
        .map((e) => ProductModel.fromJson(e))
        .toList();
    return products;
  }
}
