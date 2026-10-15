import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_categiries_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategiriesUseCase getCategiriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  final int limit = 10;
  int _offset = 0;
  bool _loadingMore = false;
  bool _hasMore = true;

  List<HomeProductEntity> _products = [];

  HomeCubit({
    required this.getProductsUseCase,
    required this.getCategiriesUseCase,
  }) : super(HomeInitial());

  int _productsRequestId = 0;
  int _lastCategoryId = 0;

  Future<void> loadHomeData() async {
    emit(CategoriesLoading());
    final result = await getCategiriesUseCase.invoke();

    int? firstId;
    result.fold(
          (failure) => emit(CategoriesError(errorMessage: failure.errorMessage)),
          (categories) {
        if (categories.isNotEmpty) firstId = categories.first.id;
        emit(CategoriesSuccess(categories: categories));
      },
    );

    if (firstId == null) return;
    await loadProducts(firstId!);
  }

  /// Initial load or category switch — resets pagination state.
  Future<void> loadProducts(int id) async {
    _lastCategoryId = id;
    _offset = 0;
    _hasMore = true;
    _products = [];
    final requestId = ++_productsRequestId;

    emit(ProductsLoading());
    final result = await getProductsUseCase.invoke(
      id,
      offset: _offset,
      limit: limit,
    );

    if (requestId != _productsRequestId) return;

    result.fold(
          (failure) => emit(ProductError(errorMessage: failure.errorMessage)),
          (products) {
        _products = products;
        _hasMore = products.length == limit;
        _offset = products.length;
        emit(ProductsSuccess(products: _products, hasMore: _hasMore));
      },
    );
  }

  /// Called when the user scrolls near the bottom of the grid.
  Future<void> loadMoreProducts() async {
    if (_loadingMore || !_hasMore) return;

    _loadingMore = true;
    emit(ProductsSuccess(
      products: _products,
      hasMore: _hasMore,
      isLoadingMore: true,
    ));

    final requestId = _productsRequestId; // guard vs. category switch mid-flight
    final result = await getProductsUseCase.invoke(
      _lastCategoryId,
      offset: _offset,
      limit: limit,
    );

    _loadingMore = false;
    if (requestId != _productsRequestId) return;

    result.fold(
          (failure) {
        // Keep what's already on screen, just drop the bottom spinner.
        emit(ProductsSuccess(products: _products, hasMore: _hasMore));
      },
          (newProducts) {
        _products = [..._products, ...newProducts];
        _hasMore = newProducts.length == limit;
        _offset += newProducts.length;
        emit(ProductsSuccess(products: _products, hasMore: _hasMore));
      },
    );
  }

  Future<void> retryProducts() => loadProducts(_lastCategoryId);
}