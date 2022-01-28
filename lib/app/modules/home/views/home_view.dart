import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getongkir/app/modules/home/controllers/home_controller.dart';

import 'widgets/berat.dart';
import 'widgets/city.dart';
import 'widgets/province.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetOngkir'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Profinsi(
            tipe: "Asal",
          ),
          Obx(
            () => controller.hiddenCityAsal.isTrue
                ? SizedBox()
                : Kota(
                    provId: controller.provAsalId.value,
                    tipe: "asal",
                  ),
          ),
          Profinsi(
            tipe: "Tujuan",
          ),
          Obx(
            () => controller.hiddenCityTujuan.isTrue
                ? SizedBox()
                : Kota(
                    provId: controller.provTujuanId.value,
                    tipe: "tujuan",
                  ),
          ),
          BeratBarang(),
        ],
      ),
    );
  }
}
