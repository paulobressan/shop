import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // O parametro listen, é para cenarios aonde temos um changeNotifier e vamos usar dados dele que não mudam
    // Se colocar false, não vamos mais escutar as alterações do produto
    // default é true
    final Product product = Provider.of<Product>(context, listen: false);
    // O listen desse widget vai ser false porque quando tiver alteração no carrinho, o item de produto não precisa ser alterado
    final Cart cart = Provider.of<Cart>(context, listen: false);

    // Componente para estilizar, Clip = cortar o que esta para fora dele, R = arrededonda, Rect = retangulo.
    return ClipRRect(
      // borda arredondada
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          child: Image.network(
            product.imageUrl,
            // Cobrir toda area disponivel
            fit: BoxFit.cover,
          ),
        ),
        // Adicionando uma barra no rodapé
        footer: GridTileBar(
          // Cor da barra
          backgroundColor: Colors.black87,
          // leading : Widget do lado esquerdo
          leading: Consumer<Product>(
            child: Text('Nunca muda'),
            builder: (
              ctx,
              product,
              child,
            ) =>
                IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavorite();
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          // Widget no centro
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          // Widget do lado direito
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product);
              print(cart.itemCount);
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
