import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_categiries_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategiriesUseCase getCategiriesUseCase;
  final GetProductsUseCase getProductsUseCase;

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

    // Stop if categories failed or the list is empty
    if (firstId == null) return;
    await loadProducts(firstId!);
  }

  Future<void> loadProducts(int id) async {
    _lastCategoryId = id;
    final requestId = ++_productsRequestId;

    emit(ProductsLoading());
    final result = await getProductsUseCase.invoke(id);

    // A newer request started while waiting, so ignore this old response
    if (requestId != _productsRequestId) return;

    result.fold(
          (failure) => emit(ProductError(errorMessage: failure.errorMessage)),
          (products) => emit(ProductsSuccess(products: products)),
    );
  }

  Future<void> retryProducts() => loadProducts(_lastCategoryId);
}