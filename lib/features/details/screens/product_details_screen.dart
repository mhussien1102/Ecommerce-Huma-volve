import 'package:ecommerce_app_huma_volve/features/home/services/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../core/theme.dart';
import '../widgets/color_selector.dart';
import '../widgets/size_selector.dart';
import '../../../core/widgets/primary_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product; // كان Product

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // الـ API مبيرجعش ألوان ولا مقاسات، فدي قيم ثابتة مؤقتة للعرض.
  // لو عايزها من الـ API بعدين، بنضيفها في ProductModel.
  static const List<Color> _colors = [
    Color(0xFF212121),
    Color(0xFF0E7C86),
    Color(0xFFD9534F),
    Color(0xFFE0B252),
  ];
  static const List<String> _sizes = ['S', 'M', 'L', 'XL'];

  late Color _selectedColor;
  late String _selectedSize;

  @override
  void initState() {
    super.initState();
    _selectedColor = _colors.first;
    _selectedSize = _sizes.first;
  }

  /// أول صورة للمنتج (منضّفة من أي علامات زيادة)
  String? get _imageUrl {
    final images = widget.product.images;
    if (images == null || images.isEmpty) return null;
    final url = images.first.replaceAll(RegExp(r'[\[\]"]'), '').trim();
    return url.isEmpty ? null : url;
  }

  Widget _imagePlaceholder() => Container(
    color: Colors.grey.shade200,
    alignment: Alignment.center,
    child: Icon(
      Icons.image_not_supported_outlined,
      size: 48,
      color: Colors.grey.shade400,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final imageUrl = _imageUrl;
    final title = product.title ?? '';

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: AppTheme.background,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 16),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_border, size: 18),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product-${product.id}',
                child: imageUrl == null
                    ? _imagePlaceholder()
                    : Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) =>
                  progress == null ? child : _imagePlaceholder(),
                  errorBuilder: (context, error, stack) =>
                      _imagePlaceholder(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              transform: Matrix4.translationValues(0.0, -32.0, 0.0),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(fontSize: 28, height: 1.2),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '\$${(product.price ?? 0).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(color: AppTheme.primary, fontSize: 24),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description ?? '',
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(height: 1.6, fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Select Color',
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ColorSelector(
                      colors: _colors,
                      selectedColor: _selectedColor,
                      onColorSelected: (color) {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Select Size',
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    SizeSelector(
                      sizes: _sizes,
                      selectedSize: _selectedSize,
                      onSizeSelected: (size) {
                        setState(() {
                          _selectedSize = size;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                    PrimaryButton(
                      text: 'Add to Cart',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$title added to cart'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: AppTheme.primary,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}