import 'dart:convert';
import 'dart:io';

import '../Model/ProdutosModel.dart';

class ProdutoController {
  List<Produto> products = [];

  Future<void> saveProductsToFile() async {
    final file = File('products.json');
    final jsonList = products.map((product) => product.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  Future<void> loadProductsFromFile() async {
    try {
      final file = File('products.json');
      final jsonList = jsonDecode(await file.readAsString());
      products = jsonList.map<Produto>((json) => Produto.fromJson(json)).toList();
    } catch (e) {
      // Caso o arquivo não exista ou ocorra um erro na leitura, não faz nada
      products = [];
    }
  }
}