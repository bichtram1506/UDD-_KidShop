import 'package:flutter/material.dart';
import '../shared/app_drawer.dart';
import 'products_grid.dart';
import '../cart/cart_screen.dart';
import '../cart/cart_manager.dart';
import 'top_right_badge.dart';
import 'package:provider/provider.dart';
import 'package:myproject_app/ui/products/product_grid_tile.dart';
import 'package:myproject_app/ui/products/products_manager.dart';
import 'package:myproject_app/ui/cart/cart_screen.dart';
enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts; 

    @override
  void initState(){
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Đồ Chơi Trẻ Em'),
        actions: <Widget>[
          buildProductFilterMenu(),
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
       body: FutureBuilder(
        future: _fetchProducts,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return ValueListenableBuilder<bool>(
              valueListenable: _showOnlyFavorites,
              builder: (conext, onlyFavorites, child){
                return ProductsGrid(onlyFavorites);
              });
          }
          return const Center(
            child: CircularProgressIndicator(),
              );
  
          },
      ),
      );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
    builder: (ctx, cartManager, child) {
    return TopRightBadge(
    data: cartManager.productCount,
    child: IconButton(
    icon: const Icon(
    Icons.shopping_cart,
    ),
    onPressed: () {
    Navigator.of(ctx).pushNamed(CartScreen.routeName);
    },
   ),
 );
 },
 );
 }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        setState(() {
          if (selectedValue == FilterOptions.favorites) {
            _showOnlyFavorites.value = true;
          } else {
            _showOnlyFavorites.value = false;
          }
        });
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Sản Phẩm Yêu thích'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Hiển Thị Tất Cả'),
        ),
      ],
    );
  }
  
}