import 'package:app/Cliente.dart';
import 'package:app/compras.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Dio dio = new Dio();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text("Projeto de Vendas IGTI-2"),
      ),
      body: FutureBuilder(
          future: getConnection(),
          builder: (context, snap) {
            List? lista = [];
            lista = snap.data as List?;
            
            // List<Cliente>dados=lista!.map((e) => Cliente.from(e)).toList();
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
                          ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Compras(
                                              id: lista![index]["id"],
                                              nome: lista[index]["nome"],
                                            )));
                              },
                              trailing: Text(lista![index]["id"].toString()),
                              leading: Icon(Icons.person),
                              title: Text(lista[index]["nome"]),
                              subtitle: Text(lista[index]["dn"])),
                          Divider()
                        ],
                      );
                    });
            }
          }),
    );
  }

  Future<List> getConnection() async {
    Response response =
        await dio.get('https://vendas-projeto-igti.herokuapp.com/clientes');
    return response.data;
  }

  Future<Response> salvarCliente(Cliente cliente) async {
    Response response = await dio
        .post("https://vendas-projeto-igti.herokuapp.com/clientes",
            data: cliente.toJson())
        .then((value) {
      return value;
    });
    return response;
  }
}
