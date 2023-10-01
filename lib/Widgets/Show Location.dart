import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../Cubit/get_fire_data_cubit.dart';
import '../constanse.dart';

class ShowLocation extends StatelessWidget {
  ShowLocation({super.key});

  GlobalKey<FormState> form = new GlobalKey<FormState>();
  var locationPermission;
  var userLocation;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetFireDataCubit, GetFireDataState>(
        listener: (context, state) {
      if (state is Getlocation) {
        userLocation = state.cuntry;
        print('ppppppppppppppppppppppppppppppppppp$userLocation');
      }
    }, builder: (context, state) {
      return IconButton(
          onPressed: () {
            Premissiones();
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                context: context,
                builder: (context) => Container(
                      padding: EdgeInsets.all(10),
                      width: w,
                      height: 500,
                      child: Form(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 320,
                              child: TextFormField(
                                onFieldSubmitted: (data) async {
                                  BlocProvider.of<GetFireDataCubit>(context).emit(Getlocation(cuntry: data));
                                  Get.back();
                                },
                                decoration: InputDecoration(
                                    hintText: 'enter location !'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              width: w,
                              height: h - 510,
                              decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  if (locationPermission !=
                                      LocationPermission.denied) {
                                    Position location;
                                    await Geolocator.getCurrentPosition()
                                        .then((value) async {
                                      location = value;
                                      double lat = location.latitude;
                                      double lang = location.longitude;
                                      List<Placemark> placemarks =
                                          await placemarkFromCoordinates(
                                              lat, lang);
                                      var cuntry = placemarks[0].locality;
                                      print(
                                          'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB1111111111111111');
                                      BlocProvider.of<GetFireDataCubit>(context)
                                          .emit(Getlocation(cuntry: cuntry));
                                      Get.back();
                                    });
                                  }
                                },
                                icon: Icon(Icons.my_location,color: Colors.green,))
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                    ));
          },
          icon: Icon(
            Icons.location_on_sharp,
            color: Colors.red,
            size: 26,
          ));
    });
  }

  Premissiones() async {
    LocationPermission locationPermission;
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    print('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW$locationPermission');
  }
}
