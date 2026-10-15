import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source_impl.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repo/home_repo_impl.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_repo.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_categiries_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_products_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme.dart';
import '../../home/presentation/view_model/home_cubit.dart';
import '../../home/presentation/views/home_screen.dart';
import '../../cart/screens/cart_screen.dart';
import '../../profile/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  late final HomeRepo homeRepo;
  late final ApiClient apiClient;
  late final HomeCubit homeCubit;
  late final GetProductsUseCase getProductsUseCase;
  late final GetCategiriesUseCase getCategiriesUseCase;
  late final HomeRemoteDataSource homeRemoteDataSource;

  @override
  void initState() {
    apiClient = ApiClient();
    homeRemoteDataSource = HomeRemoteDataSourceImpl(apiClient);
    homeRepo = HomeRepoImpl(homeRemoteDataSource);
    getProductsUseCase = GetProductsUseCase(homeRepo);
    getCategiriesUseCase = GetCategiriesUseCase(homeRepo);
    homeCubit = HomeCubit(
      getProductsUseCase: getProductsUseCase,
      getCategiriesUseCase: getCategiriesUseCase,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      BlocProvider(
        create: (BuildContext context) => homeCubit,
        child: const HomeScreen(),
      ),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: AppTheme.primary,
            unselectedItemColor: Colors.grey.shade400,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.home_filled, size: 28),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.home_filled, size: 32),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.shopping_cart_outlined, size: 28),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.shopping_cart, size: 32),
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.person_outline, size: 28),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Icon(Icons.person, size: 32),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
