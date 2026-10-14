import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_repo.dart';

import '../../../../core/failure/fauiler.dart';
import '../entites/home_category_entity.dart';

class GetCategiriesUseCase {
  final HomeRepo homeRepo;
  GetCategiriesUseCase(this.homeRepo);

  Future<Either<Failure, List<HomeCategoryEntity>>> invoke() {
    return homeRepo.getCategories();
  }
}
