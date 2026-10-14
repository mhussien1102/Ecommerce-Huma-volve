import 'package:dartz/dartz.dart';

import '../../../../core/failure/fauiler.dart';
import '../entites/home_product_entity.dart';
import '../repo/home_repo.dart';

class GetProductsUseCase {
  final HomeRepo homeRepo;
  GetProductsUseCase(this.homeRepo);
  Future<Either<Failure, List<HomeProductEntity>>> invoke(int? categoryId) {
    return homeRepo.getProducts(categoryId);
  }
}
