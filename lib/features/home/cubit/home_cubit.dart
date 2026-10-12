import 'package:ecommerce_app_huma_volve/features/home/cubit/home_states.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_services.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeServices homeServices;
  HomeCubit({required this.homeServices}) : super(HomeInitial());

  CategoryModel? _selectedCategory; // آخر قسم اتختار (لزرار إعادة المحاولة)
  int _productsRequestId = 0; // علشان نتجاهل الردود القديمة لو المستخدم داس بسرعة

  /// أول ما الشاشة تفتح: يجيب الأقسام وبعدين منتجات أول قسم
  Future<void> loadHomeData() async {
    emit(CategoriesLoading());
    try {
      final categories = await homeServices.getCategories();
      if (isClosed) return;
      emit(CategoriesSuccess(categories: categories));

      if (categories.isEmpty) {
        emit(ProductsSuccess(products: const []));
        return;
      }
      await loadProducts(categories.first);
    } catch (e) {
      if (isClosed) return;
      emit(CategoriesError(errorMessage: e.toString()));
    }
  }

  /// يجيب منتجات قسم معيّن (بيتنادى لما المستخدم يدوس على قسم)
  Future<void> loadProducts(CategoryModel category) async {
    _selectedCategory = category;
    final requestId = ++_productsRequestId;

    emit(ProductsLoading());
    try {
      final products = await homeServices.getProducts(category.id);
      if (isClosed || requestId != _productsRequestId) return;
      emit(ProductsSuccess(products: products));
    } catch (e) {
      if (isClosed || requestId != _productsRequestId) return;
      emit(ProductError(errorMessage: e.toString()));
    }
  }

  void retryProducts() {
    final category = _selectedCategory;
    if (category != null) loadProducts(category);
  }
}