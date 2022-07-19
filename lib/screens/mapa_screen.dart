import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_banckofamerica/components/tabs_component.dart';
import 'package:flutter_banckofamerica/providers/providers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);
  static String routerName = 'mapa';

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  MapType mapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final bankProvider = Provider.of<BankProvider>(context, listen: false);
    final geolocationProvider = Provider.of<GeolocationProvider>(context);

    String longitud = geolocationProvider.currentPosition.longitude.toString();
    String latitud = geolocationProvider.currentPosition.latitude.toString();
    String coordenadas = '$latitud , $longitud';
    final CameraPosition puntoInicial = CameraPosition(
      target: LatLng(geolocationProvider.currentPosition.latitude!.toDouble(),
          geolocationProvider.currentPosition.longitude!.toDouble()),
      zoom: 10,
    );

    bankProvider.getListBanks(coordenadas);
    Set<Marker> markers = Set<Marker>();
    for (var element in bankProvider.listaBancos) {
      markers.add(Marker(
          infoWindow: InfoWindow(
            //popup info
            title: element.name,
            snippet: element.address,
          ),
          markerId: MarkerId(element.id.toString()),
          position: LatLng(double.parse(element.latitude),
              double.parse(element.longitude))));
    }
    markers.add(Marker(
        markerId: const MarkerId('MyUbication'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(double.parse(latitud), double.parse(longitud))));

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BankofAmerica'),
        leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, 'home'),
            icon: const Icon(Icons.home)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabsComponent(
              size: size,
              colorMapa: Colors.blue,
              colorLista: Colors.white,
              colorTexto: Colors.black),
          Expanded(
            child: _Mapa(
                mapType: mapType,
                markers: markers,
                puntoInicial: puntoInicial,
                controller: _controller),
          ),
        ],
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
