import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};

  _onMapCreated(GoogleMapController mapController){
    _controller.complete(mapController);
  }
  _movimentarCamera() async{
    GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(-20.251102, -40.272112),
          zoom: 19,
          tilt: 45,
          bearing: 90,
        ),
      ),
    );
  }

  _carregarMarcadores(){
    Set<Marker> marcadoresLocal = {};

    Marker marcadorShopping = Marker(
        markerId: MarkerId(
          "marcador_shopping"
        ),
      position: LatLng(-20.251102, -40.272112),
      infoWindow: InfoWindow(
        title: "Shopping Norte Sul"
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueMagenta,
      )
    );

    Marker marcadorNexa = Marker(
      markerId: MarkerId(
          "marcador_nexa"
      ),
      position: LatLng(-20.251936, -40.270040),
      infoWindow: InfoWindow(
          title: "Nexa Tecnologia e Outsourcing"
      ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue,
        )
    );
    marcadoresLocal.add(marcadorShopping);
    marcadoresLocal.add(marcadorNexa);

    setState(() {
      _marcadores = marcadoresLocal;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregarMarcadores();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapas e Geolocalização"),
      ),
      body: Container(
        child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-20.251943, -40.269759),
              zoom: 16,
            ),
          onMapCreated: _onMapCreated,
          markers: _marcadores,
          mapType: MapType.normal,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _movimentarCamera,
        child: Icon(Icons.location_on),
      ),
    );
  }
}
