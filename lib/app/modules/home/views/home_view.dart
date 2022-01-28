import 'package:dropdown_search/dropdown_search.dart';
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
        title: Text('Getx Ongkir'),
        centerTitle: true,
        backgroundColor: Colors.red[900],
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
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: DropdownSearch<Map<String, dynamic>>(
              mode: Mode.MENU,
              showClearButton: true,
              items: [
                //Jne
                {
                  "code": "jne",
                  "name": "Jalur Nugraha Ekakurir (JNE)",
                },
                //Tiki
                {
                  "code": "tiki",
                  "name": "Titipan Kilat (TIKI)",
                },
                //Pos
                {
                  "code": "pos",
                  "name": "Perusahaan Optional Surat (POS)",
                },
              ],
              label: "Tipe Kurir",
              hint: "Pilih Tipe Kurir...",
              onChanged: (value) {
                if (value != null) {
                  controller.kurir.value = value["code"];
                  controller.showButton();
                } else {
                  controller.hiddenButton.value = true;
                  controller.kurir.value = "";
                }
              },
              itemAsString: (item) => "${item['name']}",
              popupItemBuilder: (context, item, isSelected) => Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Text(
                    "${item['name']}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => controller.hiddenButton.isTrue
                ? SizedBox()
                : ElevatedButton(
                    onPressed: () {},
                    child: Text("CEK ONGKOS KIRIM"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      primary: Colors.red[900],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
