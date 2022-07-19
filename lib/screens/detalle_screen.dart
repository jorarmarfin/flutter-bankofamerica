import 'package:flutter/material.dart';
import 'package:flutter_banckofamerica/themes/default_theme.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class DetalleScreen extends StatelessWidget {
  const DetalleScreen({Key? key}) : super(key: key);
  static String routerName = 'detalle';
  @override
  Widget build(BuildContext context) {
    final bankProvider = Provider.of<BankProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              bankProvider.bancoSeleccionado.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: double.infinity,
              height: 60,
              decoration: boxRecuadro(Colors.blue[900], 10),
              child: const Text(
                'COMO LLEGAR',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Direccion',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            subtitle: Text(bankProvider.bancoSeleccionado.address),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Teléfono',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            subtitle: Text(bankProvider.bancoSeleccionado.phone),
          ),
          const ListTile(
            leading: Icon(Icons.access_time),
            title: Text('Horario',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            subtitle: Text('De lunes a viernes de 8:00 a 14:00'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: double.infinity,
              height: 60,
              decoration: boxRecuadro(Colors.blue[900], 15),
              child: const Text(
                'LLAMAR AHORA',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
