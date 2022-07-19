import 'package:flutter/material.dart';
import 'package:flutter_banckofamerica/components/tabs_component.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class ListadoScreen extends StatelessWidget {
  const ListadoScreen({Key? key}) : super(key: key);
  static String routerName = 'listado';
  @override
  Widget build(BuildContext context) {
    final bankProvider = Provider.of<BankProvider>(context);
    final geolocationProvider = Provider.of<GeolocationProvider>(context);

    String longitud = geolocationProvider.currentPosition.longitude.toString();
    String latitud = geolocationProvider.currentPosition.latitude.toString();
    final size = MediaQuery.of(context).size;
    // String coordenadas = '33.530965, -86.723663';
    String coordenadas = '$longitud, $latitud';
    bankProvider.getListBanks(coordenadas);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, 'home'),
            icon: const Icon(Icons.home)),
        title: const Text('BankofAmerica'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabsComponent(
              size: size,
              colorLista: Colors.blue,
              colorMapa: Colors.white,
              colorTexto: Colors.black),
          if (bankProvider.listaBancos.isEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  color: Colors.red,
                  child: Text(
                    'No results found for coordinates $coordenadas ',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  )),
            ),
          Expanded(
            child: FutureBuilder(
              future: bankProvider.getListBanks(coordenadas),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: bankProvider.listaBancos.length,
                    itemBuilder: (BuildContext context, int index) {
                      String distancia =
                          (bankProvider.listaBancos[index].distance.length > 3)
                              ? bankProvider.listaBancos[index].distance
                                  .substring(0, 3)
                              : bankProvider.listaBancos[index].distance;
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12)),
                        child: ListTile(
                          leading: const Icon(Icons.map),
                          trailing: Text('$distancia mi'),
                          title: Text(
                            bankProvider.listaBancos[index].name,
                            style: const TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(
                            bankProvider.listaBancos[index].address,
                            style: const TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            bankProvider.bancoSeleccionado =
                                bankProvider.listaBancos[index];
                            Navigator.pushNamed(context, 'detalle');
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
