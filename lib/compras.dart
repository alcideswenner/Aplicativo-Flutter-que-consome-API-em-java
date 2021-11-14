import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Compras extends StatefulWidget {
  final int id;
  final String nome;
  const Compras({Key? key, required this.id, required this.nome}) : super(key: key);

  @override
  _ComprasState createState() => _ComprasState();
}

class _ComprasState extends State<Compras> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: IconButton(onPressed: (){}, icon: Icon(Icons.add)),
      ),
      appBar: AppBar(title: Text(widget.id.toString()+": "+widget.nome.toString()),),
      body: FutureBuilder(
          future: getConnection(),
          builder: (context, snap) {
            List? lista = [];
            lista = snap.data as List?;
            switch (snap.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return ListView.builder(
                    itemCount: lista!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          widget.id==lista![index]["id"]?
                          ListTile(
                            onTap: (){
                            
                            },
                              trailing: Text(lista[index]["id"].toString()),
                              leading: Icon(Icons.person),
                              title: Text(lista[index]["totalCompra"].toString()),
                              subtitle: Text(lista[index]["dataCompra"])):SizedBox(height: 0,),
                          Divider()
                        ],
                      );
                    });
            }
          }),
    );
  }

  Future<List> getConnection() async {
    Dio dio = new Dio();
    Response response =
        await dio.get('https://vendas-projeto-igti.herokuapp.com/compras');
    return response.data;
  }
}
