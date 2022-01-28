import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:getongkir/app/modules/home/controllers/home_controller.dart';
import 'package:http/http.dart' as http;
import '../../city_model.dart';

class Kota extends GetView<HomeController> {
  const Kota({
    Key? key,
    required this.provId,
    required this.tipe,
  }) : super(key: key);

  final int provId;
  final String tipe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        label: tipe == "asal" ? "kota asal" : "kota tujuan",
        showSearchBox: true,
        showClearButton: true,
        searchBoxDecoration: InputDecoration(
          hintText: "Cari Kota/Kabupaten...",
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        onFind: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$provId");

          try {
            final response = await http
                .get(url, headers: {"key": "834822fe68f57f82768f7f08e930a8ec"});

            var data = json.decode(response.body) as Map<String, dynamic>;

            var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;

            var statusCode = data["rajaongkir"]['status']["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]['status']["description"];
            }

            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (e) {
            print(e);
            return List<City>.empty();
          }
        },
        onChanged: (cityValue) {
          if (cityValue != null) {
            if (tipe == "Asal") {
              controller.cityAsalId.value = int.parse(cityValue.cityId!);
            } else {
              controller.citytujuanlId.value = int.parse(cityValue.cityId!);
            }
            controller.showButton();
          } else {
            if (tipe == "Asal") {
              print("Tidak Memilih kota/kabupaten asal apapun");
              controller.cityAsalId.value = 0;
            } else {
              print("Tidak Memilih kota/kabupaten asal apapun");
              controller.citytujuanlId.value = 0;
            }
          }
        },
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "${item.type} ${item.cityName}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
        itemAsString: (item) => "${item.type} ${item.cityName}",
      ),
    );
  }
}
