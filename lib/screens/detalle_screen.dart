import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_banckofamerica/themes/default_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';
import '../providers/providers.dart';

class DetalleScreen extends StatefulWidget {
  const DetalleScreen({Key? key}) : super(key: key);
  static String routerName = 'detalle';

  @override
  State<DetalleScreen> createState() => _DetalleScreenState();
}

class _DetalleScreenState extends State<DetalleScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final bankProvider = Provider.of<BankProvider>(context, listen: false);
    final utilsProvider = Provider.of<UtilsProvider>(context, listen: false);

    Set<Marker> markers = <Marker>{};
    double latitude = double.parse(bankProvider.bancoSeleccionado.latitude) ;
    double longitude = double.parse(bankProvider.bancoSeleccionado.longitude) ;
    markers.add(Marker(
        markerId: const MarkerId('MyUbication'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(latitude, longitude)));
    final CameraPosition puntoInicial = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 10,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      persistentFooterButtons: const [BannerPublicitarioComponent()],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _TituloBanco(bankProvider: bankProvider),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: double.infinity,
                height: 170,
                color: Colors.indigo,
                child: _Mapa(
                    mapType: mapType,
                    markers: markers,
                    puntoInicial: puntoInicial,
                    controller: _controller)),
            const SizedBox(
              height: 20,
            ),
            _BotonMapa(
                utilsProvider: utilsProvider, bankProvider: bankProvider),
            _Direccion(bankProvider: bankProvider),
            _Telefono(bankProvider: bankProvider),
            const _Horario(),
            _BotonTelefono(
                utilsProvider: utilsProvider, bankProvider: bankProvider),
          ],
        ),
      ),
    );
  }
}

class _BotonTelefono extends StatelessWidget {
  const _BotonTelefono({
    Key? key,
    required this.utilsProvider,
    required this.bankProvider,
  }) : super(key: key);

  final UtilsProvider utilsProvider;
  final BankProvider bankProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          utilsProvider.OpenUriExternal(
              Uri(scheme: 'tel', path: bankProvider.bancoSeleccionado.phone));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: double.infinity,
          height: 60,
          decoration: boxRecuadro(Colors.blue[900], 15),
          child: const Text(
            'CALL NOW',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _Horario extends StatelessWidget {
  const _Horario({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.access_time),
      title: Text('Schedule',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      subtitle: Text('Monday-Friday. 9:00-19:00'),
    );
  }
}

class _Telefono extends StatelessWidget {
  const _Telefono({
    Key? key,
    required this.bankProvider,
  }) : super(key: key);

  final BankProvider bankProvider;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.phone),
      title: const Text('Phone',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      subtitle: Text(bankProvider.bancoSeleccionado.phone),
    );
  }
}

class _Direccion extends StatelessWidget {
  const _Direccion({
    Key? key,
    required this.bankProvider,
  }) : super(key: key);

  final BankProvider bankProvider;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: const Text('Address',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      subtitle: Text(bankProvider.bancoSeleccionado.address),
    );
  }
}

class _BotonMapa extends StatelessWidget {
  const _BotonMapa({
    Key? key,
    required this.utilsProvider,
    required this.bankProvider,
  }) : super(key: key);

  final UtilsProvider utilsProvider;
  final BankProvider bankProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          utilsProvider.OpenUriExternal(Uri.parse(
              'https://www.google.com/maps/@${bankProvider.bancoSeleccionado.latitude},${bankProvider.bancoSeleccionado.longitude},17z'));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: double.infinity,
          height: 60,
          decoration: boxRecuadro(Colors.blue[900], 10),
          child: const Text(
            'HOW TO GET',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _TituloBanco extends StatelessWidget {
  const _TituloBanco({
    Key? key,
    required this.bankProvider,
  }) : super(key: key);

  final BankProvider bankProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        bankProvider.bancoSeleccionado.name,
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _Mapa extends StatelessWidget {
  const _Mapa({
    Key? key,
    required this.mapType,
    required this.markers,
    required this.puntoInicial,
    required Completer<GoogleMapController> controller,
  })  : _controller = controller,
        super(key: key);

  final MapType mapType;
  final Set<Marker> markers;
  final CameraPosition puntoInicial;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: mapType,
      markers: markers,
      initialCameraPosition: puntoInicial,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
