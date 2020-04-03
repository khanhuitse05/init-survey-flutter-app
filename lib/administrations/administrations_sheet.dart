import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:initsurvey/administrations/administrations.dart';
import 'package:initsurvey/core/utility.dart';
import 'package:initsurvey/ui/button/select_button.dart';
import 'package:initsurvey/ui/utility/indicator.dart';

class AdministrationsSheet extends StatefulWidget {
  const AdministrationsSheet(
      {this.level, this.parentCode, this.onSelect, this.currentCode});

  final String parentCode;
  final AdministrationsLevel level;
  final ValueChanged<Administrations> onSelect;
  final String currentCode;

  @override
  _AdministrationsSheetState createState() => _AdministrationsSheetState();
}

class _AdministrationsSheetState extends State<AdministrationsSheet> {
  @override
  void initState() {
    super.initState();
    isLoading = true;
    _loadListRegion();
  }

  bool isLoading;

  Future _loadListRegion() async {
    List<Administrations> _temp;
    switch (widget.level) {
      case AdministrationsLevel.province:
        _temp =
            await _loadListRegionByFile('assets/administrations/tinh_tp.json');
        break;

      case AdministrationsLevel.district:
        _temp = await _loadListRegionByFile(
            'assets/administrations/quan-huyen/${widget.parentCode}.json');
        break;

      case AdministrationsLevel.wards:
        _temp = await _loadListRegionByFile(
            'assets/administrations/xa-phuong/${widget.parentCode}.json');
        break;
      default:
        _temp = [];
        break;
    }
    setState(() {
      isLoading = false;
      regions = _temp..sort((a, b) => a.name.compareTo(b.name));
    });
  }

  Future<List<Administrations>> _loadListRegionByFile(String fileName) async {
    try {
      final String jsonContent = await rootBundle.loadString(fileName);
      final message = json.decode(jsonContent);
      final List<Administrations> data = [];
      for (final key in message.keys) {
        final _temp = Administrations.fromJsonMap(message[key]);
        data.add(_temp);
      }
      return data;
    } catch (e) {
      debugPrint("Load file fail: $e");
      return null;
    }
  }

  List<Administrations> regions;
  List<Administrations> regionsFilter;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (regions != null && Utility.isNullOrEmpty(controller.text) == false) {
      regionsFilter = regions
          .where((item) =>
              item.name.toLowerCase().contains(controller.text.toLowerCase()))
          .toList();
    } else {
      regionsFilter = regions;
    }
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
                style: BorderStyle.solid,
              )),
            ),
            height: kToolbarHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                    child: Text(
                  _getTitleByLevel(widget.level),
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center,
                )),
                const SizedBox(width: 40),
              ],
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              border: Border.all(
                color: const Color(0xFFEDEDED),
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            child: TextField(
                controller: controller,
                style: Theme.of(context).textTheme.body1,
                showCursor: true,
                cursorColor: Colors.black87,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    fillColor: Colors.transparent,
                    hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                    hintText: 'Tìm kiếm'),
                onSubmitted: (text) {}),
          ),
          Expanded(
            flex: 1,
            child: _buildData(),
          )
        ],
      ),
    );
  }

  Widget _buildData() {
    if (regions == null) {
      return const Center(child: Indicator());
    }
    if (regions.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        alignment: Alignment.center,
        child: const Text('Không có địa chỉ nào'),
      );
    } else {
      return ListView(
        padding: const EdgeInsets.fromLTRB(15, 0, 25, 15),
        children: regionsFilter.map((item) {
          return SelectButton(
            title: item.name,
            onPressed: () {
              Navigator.pop(context);
              widget.onSelect(item);
            },
            isSelect: widget.currentCode == item.code,
          );
        }).toList(),
      );
    }
  }

  String _getTitleByLevel(AdministrationsLevel level) {
    switch (level) {
      case AdministrationsLevel.province:
        return 'Tỉnh thành';
        break;
      case AdministrationsLevel.district:
        return 'Quận/Huyện';
        break;
      case AdministrationsLevel.wards:
        return 'Phường/Xã';
        break;
      default:
        return 'Địa chỉ';
        break;
    }
  }
}
