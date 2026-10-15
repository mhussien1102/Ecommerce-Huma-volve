import '../../domain/entites/home_category_entity.dart';
import '../../domain/entites/home_product_entity.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

// Categories
class CategoriesLoading extends HomeStates {}

class CategoriesSuccess extends HomeStates {
  final List<HomeCategoryEntity> categories;
  CategoriesSuccess({required this.categories});
}

class CategoriesError extends HomeStates {
  final String errorMessage;
  CategoriesError({required this.errorMessage});
}

// Products
class ProductsLoading extends HomeStates {}

class ProductsSuccess extends HomeStates {
  final List<HomeProductEntity> products;
  final bool hasMore;
  final bool isLoadingMore;

  ProductsSuccess({
    required this.products,
    this.hasMore = true,
    this.isLoadingMore = false,
  });
}

class ProductError extends HomeStates {
  final String errorMessage;
  ProductError({required this.errorMessage});
}