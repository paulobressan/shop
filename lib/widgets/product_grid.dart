import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final products = showFavoriteOnly
        ? productsProvider.favoriteItems
        : productsProvider.items;

    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(10),
      //Delegando para SliverGridDelegateWithFixedCrossAxisCount que gerencia rolagens dos itens
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //configurando para ter somente 2 itens no eixo cruzado
        crossAxisCount: 2,
        // Definir o tamanho de cada item
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      // Na documentação do ChangeNotifierProvider, diz que quando temos uma instancia de um ChangeNotifier já criada, temos que usar o .value
      // como já criamos ele no main.dart, e lá foi criado uma lista de produtos e para cada produto foi criado um changeNotifier do produto, vamos usar o .value para reaproveitar isso.
      // Se usarmos o create, pode ter bugs relacionado a manipulação
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        // O modelo de produto faz um mixin com ChangeNotifier. Para cada item, vamos criar um ChangeNotifierProvider
        // para que quando o produto ter alguma alteração vai ser reconstruido o widget ProductItem
        value: products[index],
        child: ProductItem(),
      ),
    );
  }
}
