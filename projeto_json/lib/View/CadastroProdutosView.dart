import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_json/Model/ProdutosModel.dart';

import '../Controller/ProdutosController.dart';

class CadastroProduto extends StatefulWidget {
  final ProdutoController controller;

  const CadastroProduto({Key? key, required this.controller}) : super(key: key);

  @override
  _CadastroProdutoState createState() => _CadastroProdutoState();
}

class _CadastroProdutoState extends State<CadastroProduto> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _descricaoController;
  late TextEditingController _quantidadeController;
  late File? _imagemSelecionada;
  late TextEditingController _precoController;
  late TextEditingController _categoriasController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _descricaoController = TextEditingController();
    _quantidadeController = TextEditingController();
    _precoController = TextEditingController();
    _categoriasController = TextEditingController();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _quantidadeController.dispose();
    _precoController.dispose();
    _categoriasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Produto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do produto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição do produto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantidadeController,
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null) {
                    return 'Por favor, insira uma quantidade válida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _imagemSelecionada != null
                  ? Image.file(
                      _imagemSelecionada!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    )
                  : SizedBox.shrink(),
              ElevatedButton(
                onPressed: _tirarFoto,
                child: Text('Tirar Foto'),
              ),
              TextFormField(
                controller: _precoController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return 'Por favor, insira um preço válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoriasController,
                decoration: InputDecoration(labelText: 'Categorias'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira pelo menos uma categoria';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final product = Produto(
                      id: widget.controller.products.length + 1,
                      nome: _nomeController.text,
                      descricao: _descricaoController.text,
                      quantidade: int.parse(_quantidadeController.text),
                      foto: _imagemSelecionada != null
                          ? _imagemSelecionada!.path
                          : '',
                      preco: double.parse(_precoController.text),
                      categorias: _categoriasController.text.split(','),
                    );
                    widget.controller.products.add(product);
                    widget.controller.saveProductsToFile();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Produto cadastrado com sucesso')),
                    );
                    _resetFields();
                  }
                },
                child: Text('Cadastrar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetFields() {
    _nomeController.clear();
    _descricaoController.clear();
    _quantidadeController.clear();
    _precoController.clear();
    _categoriasController.clear();
    setState(() {
      _imagemSelecionada = null;
    });
  }

  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
      });
    }
  }
}
