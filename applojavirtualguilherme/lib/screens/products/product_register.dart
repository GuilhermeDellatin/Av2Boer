import 'package:applojavirtualguilherme/models/product.dart';
import 'package:applojavirtualguilherme/models/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductRegister extends StatelessWidget {
  ProductRegister(this.product);

  final Product product;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //final Product product = Product();

  List<String> listaImagem = List<String>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(

        title: product.name != null ? const Text('Alterar Produto') : const Text('Cadastrar Produto') ,
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<ProductManager>(
              builder: (_, productManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      decoration:
                      const InputDecoration(hintText: 'Nome do Produto'),
                      initialValue: product.name != null ? product.name : '' ,
                      enabled: !productManager.loading,
                      validator: (name) {
                        if (name.isEmpty) return 'Campo obrigatório';
                        return null;
                      },
                      onSaved: (name) => product.name = name,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(

                      decoration: const InputDecoration(hintText: 'Descrição'),
                      initialValue: product.description != null ? product.description : '' ,
                      enabled: !productManager.loading,
                      validator: (description) {
                        if (description.isEmpty) return 'Campo obrigatório';
                        return null;
                      },
                      onSaved: (description) =>
                      product.description = description,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Imagem 1:'),
                      enabled: !productManager.loading,
                      initialValue: product.imagens != null ? (product.imagens.length >=1 ? product.imagens[0] : ''):'' ,
                      validator: (imagem1) {
                        if (imagem1.isEmpty) return 'Campo obrigatório';
                        return null;
                      },
                      onSaved: (imagem1) =>
                      imagem1.isNotEmpty ? listaImagem.add(imagem1) : null,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Imagem 2:'),
                      enabled: !productManager.loading,
                      initialValue: product.imagens != null ? (product.imagens.length >=2 ? product.imagens[1] : ''):'' ,
                      onSaved: (imagem2) =>
                      imagem2.isNotEmpty ? listaImagem.add(imagem2) : null,
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: Theme.of(context).primaryColor,
                      disabledColor:
                      Theme.of(context).primaryColor.withAlpha(100),
                      textColor: Colors.white,
                      onPressed: productManager.loading
                          ? null
                          : () {
                        product.imagens = listaImagem;

                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          if (product.id == null) {
                            productManager.signUp(
                                product: product,
                                onSuccess: () {
                                  productManager.loadAllProducts();
                                  Navigator.of(context).pop();
                                },
                                onFail: (e) {
                                  scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Falha ao cadastrar Produto: $e'),
                                    backgroundColor: Colors.red,
                                  ));
                                });
                          } else {
                            productManager.updateProduct(
                                product: product,
                                onSuccess: (){
                                  productManager.loadAllProducts();
                                  Navigator.of(context).pop();
                                },
                                onFail: (e){
                                  scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text('Falha ao Alterar Produto: $e'),
                                        backgroundColor: Colors.red,
                                      )
                                  );
                                }
                            );
                          }
                        }
                      },
                      child: productManager.loading
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                          : const Text(
                        'Salvar',
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}