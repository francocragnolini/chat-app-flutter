import "package:flutter/material.dart";
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/models/usario.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarios = [
    Usuario(
        online: true, email: "agostina@gmail.com", name: "Agostina", uid: "1"),
    Usuario(online: false, email: "tomas@gmail.com", name: "Tomas", uid: "2"),
    Usuario(online: true, email: "franco@gmail.com", name: "Franco", uid: "2"),
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("mi nombre"),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: const IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            ),
            onPressed: null,
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue[400],
              ),
              /*Icon(
              Icons.offline_bolt,
              color: Colors.red[400],
            ),*/
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: WaterDropHeader(
            waterDropColor: Color(0xFF42A5F5),
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
          ),
          //metodo para hacer el request
          onRefresh: _cargarUsuarios,
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) => _usuarioListTile(usuarios[index]),
        separatorBuilder: (_, index) => Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.name),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(child: Text(usuario.name.substring(0, 2))),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: usuario.online ? Colors.green[300] : Colors.red),
      ),
    );
  }

  //simulacion
  _cargarUsuarios() async {
    // espera  1s
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    //llama al refershController como completado
    _refreshController.refreshCompleted();
  }
}
