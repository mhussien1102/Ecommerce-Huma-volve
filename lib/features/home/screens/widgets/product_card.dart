import 'package:ecommerce_app_huma_volve/features/home/services/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme.dart';
import '../../../details/screens/product_details_screen.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/product_model.dart';

class ProductCard extends StatelessWidget {
   final ProductModel product; // كان Product

  const ProductCard({super.key, required this.product});

  /// أول صورة للمنتج (وبننضّفها لو الـ API رجّعها بعلامات زيادة)
  String? get _imageUrl {
    final images = product.images;
    if (images == null || images.isEmpty) return null;
    final url = images.first.replaceAll(RegExp(r'[\[\]"]'), '').trim();
    return url.isEmpty ? null : url;
  }

  Widget _imagePlaceholder() => Container(
    color: Colors.grey.shade200,
    alignment: Alignment.center,
    child: Icon(Icons.image_not_supported_outlined, color: Colors.grey.shade400),
  );

  @override
  Widget build(BuildContext context) {
    final imageUrl = _imageUrl;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                ProductDetailsScreen(product: product),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.08),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Hero(
                    tag: 'product-${product.id}',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: imageUrl == null
                          ? SizedBox.expand(child: _imagePlaceholder())
                          : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        loadingBuilder: (context, child, progress) =>
                        progress == null
                            ? child
                            : _imagePlaceholder(),
                        errorBuilder: (context, error, stack) =>
                            _imagePlaceholder(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: AppTheme.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.title ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${(product.price ?? 0).toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppTheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}