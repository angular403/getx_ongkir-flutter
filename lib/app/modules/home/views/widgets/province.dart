import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:getongkir/app/modules/home/controllers/home_controller.dart';
import 'package:getongkir/app/modules/home/provinsi_model.dart';
import 'package:http/http.dart' as http;

class Profinsi extends GetView<HomeController> {
  const Profinsi({
    Key? key,
    required this.tipe,
  }) : super(key: key);
  final String tipe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Provinsi>(
        label: tipe == "Asal" ? " Provinsi Asal " : "Provinsi Tujuan",
        showSearchBox: true,
        showClearButton: true,
        searchBoxDecoration: InputDecoration(
          hintText: "Cari Provinsi...",
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        onFind: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

          try {
            final response = await http
                .get(url, headers: {"key": "834822fe68f57f82768f7f08e930a8ec"});

            var data = json.decode(response.body) as Map<String, dynamic>;

            var listAllProvinsi =
                data["rajaongkir"]["results"] as List<dynamic>;

            var statusCode = data["rajaongkir"]['status']["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]['status']["description"];
            }

            var models = Provinsi.fromJsonList(listAllProvinsi);
            return models;
          } catch (e) {
            print(e);
            return List<Provinsi>.empty();
          }
        },
        onChanged: (prov) {
          if (prov != null) {
            if (tipe == "Asal") {
              controller.hiddenCityAsal.value = false;
              controller.provAsalId.value = int.parse(prov.provinceId!);
            } else {
              controller.hiddenCityTujuan.value = false;
              controller.provTujuanId.value = int.parse(prov.provinceId!);
            }
          } else {
            if (tipe == "Asal") {
              controller.hiddenCityAsal.value = true;
              controller.provAsalId.value = 0;
            } else {
               controller.hiddenCityTujuan.value = true;
              controller.provTujuanId.value = 0;
            }
          }
        },
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "${item.province}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
        itemAsString: (item) => item.province!,
      ),
    );
  }
}
