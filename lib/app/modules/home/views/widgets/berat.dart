import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getongkir/app/modules/home/controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.beratC,
            autocorrect: false,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: "Berat Barang",
              hintText: "Berat Barang",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => controller.ubahBerat(value),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 150,
          child: DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              showSelectedItem: true,
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                hintText: "Cari Satuan Berat...",
                border: OutlineInputBorder(),
              ),
              items: [
                "ton",
                "kwintal",
                "ons",
                "lbs",
                "pound",
                "kg",
                "hg",
                "dag",
                "gram",
                "dg",
                "cg",
                "mg",
              ],
              label: "Satuan",
              selectedItem: "gram",
              onChanged: (value) => controller.ubahSatuan(value!)),
        ),
      ],
    );
  }
}
