import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishonch/cubit/mapping/map_cubit.dart';
import 'package:ishonch/data/repositories/geocoding_repository.dart';
import 'package:ishonch/service/api_service/api_service.dart';
import 'package:ishonch/utils/app_image.dart';
import 'dart:async';
import 'package:map_picker/map_picker.dart';
import '../../../../data/models/helper/lat_long_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.latLongModel}) : super(key: key);
  final LatLongModel latLongModel;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(widget.latLongModel.lat, widget.latLongModel.long),
      zoom: 20.h,
    );
    return BlocProvider(
      create: (context) =>
          MapCubit(geocodingRepo: GeocodingRepo(apiService: ApiService())),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<MapCubit>(context).fetchAddress(
              latLongModel: LatLongModel(
                lat: cameraPosition.target.latitude,
                long: cameraPosition.target.longitude,
              ),
              kind: "house",
            );
            Navigator.pop(context);
          },
          child: const Icon(Icons.done),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                AppImages.iconBackArrow,
              ),
            ),
          ),
          title: Column(
            children: [
              SizedBox(height: 20.h),
              Text(
                "Your location",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 12.sp,
                ),
              ),
              TextFormField(
                maxLines: 3,
                textAlign: TextAlign.center,
                readOnly: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
                controller: textController,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                MapPicker(
                  iconWidget: SvgPicture.asset(
                    "assets/icons/pin.svg",
                    height: 60,
                  ),
                  mapPickerController: mapPickerController,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: cameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMoveStarted: () {
                      mapPickerController.mapMoving!();
                      textController.text = "checking ...";
                    },
                    onCameraMove: (cameraPosition1) {
                      cameraPosition = cameraPosition1;
                    },
                    onCameraIdle: () async {
                      mapPickerController.mapFinishedMoving!();
                      textController.text = state.currentAddress;
                      BlocProvider.of<MapCubit>(context).fetchAddress(
                        latLongModel: LatLongModel(
                          lat: cameraPosition.target.latitude,
                          long: cameraPosition.target.longitude,
                        ),
                        kind: "house",
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
