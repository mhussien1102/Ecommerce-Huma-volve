import 'package:ecommerce_app_huma_volve/features/home/services/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/product_model.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class CategoriesLoading extends HomeStates {}

class CategoriesSuccess extends HomeStates {
  final List<CategoryModel> categories;
  CategoriesSuccess({required this.categories});
}

class CategoriesError extends HomeStates {
  final String errorMessage;

  CategoriesError({required this.errorMessage});
}

class ProductsLoading extends HomeStates {}

class ProductsSuccess extends HomeStates {
  final List<ProductModel> products;
  ProductsSuccess({required this.products});
}

class ProductError extends HomeStates {
  final String errorMessage;

  ProductError({required this.errorMessage});
}
