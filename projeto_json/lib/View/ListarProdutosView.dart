import 'package:flutter/material.dart';

import '../Controller/ProdutosController.dart';

class ListarProdutos extends StatefulWidget {
  final ProdutoController controller;
  const ListarProdutos({Key? key, required this.controller}) : super(key: key);

  @override
  State<ListarProdutos> createState() => _ListarProdutosState();
}

class _ListarProdutosState extends State<ListarProdutos> {
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}