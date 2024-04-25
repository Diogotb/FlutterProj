
import 'package:flutter/material.dart';

import 'Controller/ProdutosController.dart';
import 'View/CadastroProdutosView.dart';
import 'View/ListarProdutosView.dart';
import 'View/TelaInicialView.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Aplicação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TelaInicial(),
        '/cadastrar': (context) => CadastroProduto(controller: ProdutoController()),
        '/listar': (context) => const ListarProdutos(),
      },
    );
  }
}
