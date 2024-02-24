import 'package:app01/settings/app_valuenotifier.dart';
import 'package:flutter/material.dart';
import 'package:app01/database/products_database.dart';
import 'package:app01/model/products_model.dart';
import 'package:intl/intl.dart';

class DespensaScreen extends StatefulWidget {
  const DespensaScreen({super.key});

  @override
  State<DespensaScreen> createState() => _DespensaScreenState();
}

class _DespensaScreenState extends State<DespensaScreen> {
  ProductsDatabase? productDB;

  ProductsDatabase? productsDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productDB = new ProductsDatabase();
  }

  @override
  Widget build(BuildContext context) {

    final conNombre = TextEditingController();
    final conCantidad = TextEditingController();
    final conFecha = TextEditingController();

    final txtNombre = TextFormField(
      keyboardType: TextInputType.text,
      controller: conNombre,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
    );

    final txtCantidad = TextFormField(
      keyboardType: TextInputType.number,
      controller: conCantidad,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
    );

    final btnAgregar = ElevatedButton.icon(
      onPressed: (){
        productsDB!.INSERTAR({
          "nomProducto": conNombre.text,
          "canProducto": int.parse(conCantidad.text),
          "fechaCaducidad": conFecha.text
        }).then((value){
          Navigator.pop(context);
          String msj = "";
          if(value > 0){
            AppValueNotifier.banProducts.value = !AppValueNotifier.banProducts.value;
            msj = "Producto Isertado";
          } else{
            msj = 'Ocurrio un error';
          }
          var snackbar = SnackBar(content: Text(msj));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        });
      },
      icon: const Icon(Icons.save),
      label: const Text('Guardar'),
    );

    final txtFecha = TextFormField(
      controller: conFecha,
      keyboardType: TextInputType.none,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101)
        );
        if(pickedDate != null){
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState((){
            conFecha.text = formattedDate;
          });
        }
      },
    );

    final space = SizedBox(height: 10,);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi despensa :)'),
        actions: [
          IconButton(
            onPressed: () {
              showModal(context);
            },
            icon: Icon(Icons.shop),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: AppValueNotifier.banProducts,
        builder: (context, value,_) {
          return FutureBuilder(
            future: productDB!.CONSULTAR(),
            builder: (context, AsyncSnapshot<List<ProductosModel>> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Algo salió mal'));
              } else {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        return itemDespensa(
                          snapshot.data![index],
                          txtNombre,
                          space,
                          txtCantidad,
                          txtFecha,
                          btnAgregar
                        );
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }
            },
          );
        }
      ),
    );
  }

  Widget itemDespensa(ProductosModel producto, txtNombre, space, txtCantidad, txtFecha, btnAgregar){
    return Container(
      margin: EdgeInsets.only(top:10),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      height: 100,
      child: Column(
        children: [
          Text('${producto.nomProducto!}'),
          Text('${producto.fechaCaducidad!}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: (){
                showModal(context);
              }, icon: Icon(Icons.edit)),
              IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
            ],
          ),
        ]
      ),
    );
  }

  showModal(context){
    final conNombre = TextEditingController();
    final conCantidad = TextEditingController();
    final conFecha = TextEditingController();

    final txtNombre = TextFormField(
      keyboardType: TextInputType.text,
      controller: conNombre,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
    );

    final txtCantidad = TextFormField(
      keyboardType: TextInputType.number,
      controller: conCantidad,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
    );

    final btnAgregar = ElevatedButton.icon(
      onPressed: (){
        productsDB!.INSERTAR({
          "nomProducto": conNombre.text,
          "canProducto": int.parse(conCantidad.text),
          "fechaCaducidad": conFecha.text
        }).then((value){
          Navigator.pop(context);
          String msj = "";
          if(value > 0){
            AppValueNotifier.banProducts.value = !AppValueNotifier.banProducts.value;
            msj = "Producto Isertado";
          } else{
            msj = 'Ocurrio un error';
          }
          var snackbar = SnackBar(content: Text(msj));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        });
      },
      icon: const Icon(Icons.save),
      label: const Text('Guardar'),
    );

    final txtFecha = TextFormField(
      controller: conFecha,
      keyboardType: TextInputType.none,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101)
        );
        if(pickedDate != null){
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState((){
            conFecha.text = formattedDate;
          });
        }
      },
    );

    final space = SizedBox(height: 10,);
    showModalBottomSheet(
      context: context,
      builder: (context){
        return ListView(
          padding: EdgeInsets.all(15),
          children: [
            txtNombre,
            space,
            txtCantidad,
            space,
            txtFecha,
            space,
            btnAgregar,
          ],
        );
      },
    );
  }
}