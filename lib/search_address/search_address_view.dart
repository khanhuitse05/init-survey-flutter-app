import 'dart:io';

import 'package:flutter/material.dart';
import 'package:initsurvey/core/utility.dart';
import 'package:initsurvey/search_address/place_data.dart';
import 'package:initsurvey/search_address/place_detail.dart';
import 'package:initsurvey/search_address/search_address_provider.dart';
import 'package:initsurvey/theme/app_styles.dart';
import 'package:initsurvey/ui/utility/app_snackbar.dart';
import 'package:initsurvey/ui/utility/indicator.dart';
import 'package:initsurvey/ui/utility/progress_dialog.dart';
import 'package:provider/provider.dart';

class SearchAddressView extends StatefulWidget {
  @override
  _SearchAddressViewState createState() => _SearchAddressViewState();
}

class _SearchAddressViewState extends State<SearchAddressView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SearchAddressProvider()),
          ],
          child: Column(
            children: <Widget>[
              SearchInput(),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                  child: SearchListItem(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchInput extends StatefulWidget {
  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(11, 10, 11, 0),
      height: (80),
      width: double.infinity,
      child: Card(
        child: Row(
          children: <Widget>[
            if (Platform.isIOS)
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            Expanded(
              flex: 10,
              child: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                      icon: Container(
                        width: 35,
                        child: Icon(Icons.search),
                        alignment: AlignmentDirectional.centerEnd,
                      ),
                      contentPadding: const EdgeInsets.only(top: 1),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      fillColor: Colors.transparent,
                      hintText: 'Search address'),
                  onChanged: (text) {
                    Provider.of<SearchAddressProvider>(context, listen: false)
                        .text = text;
                  }),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              width: 40,
              child: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.black45,
                ),
                onPressed: () {
                  setState(() {
                    controller.text = '';
                    Provider.of<SearchAddressProvider>(context, listen: false)
                        .text = '';
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchAddressProvider search = Provider.of(context);

    if (Utility.isNullOrEmpty(search.result) == false) {
      return ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                selectPlace(context, search.result[index]);
              },
              child: Container(
                height: (90),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(Icons.place),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        search.result[index].description,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Container(
              height: 2,
              color: Colors.black45,
            );
          },
          itemCount: search.result.length);
    } else {
      if (Utility.isNullOrEmpty(search.text)) {
        return Container();
      } else {
        return Container(
          height: 200,
          alignment: Alignment.center,
          child: const Indicator(),
        );
      }
    }
  }

  Future selectPlace(BuildContext context, Predictions predictions) async {
    showLoading(context);
    final PlaceDetailData data =
        await SearchAddressProvider.getPlaceDetail(predictions.placeId);
    hideLoading(context);
    if (data != null) {
      Navigator.pop(context);
    } else {
      Scaffold.of(context).showSnackBar(mySnackBar('Get place detail fail!'));
    }
  }
}
