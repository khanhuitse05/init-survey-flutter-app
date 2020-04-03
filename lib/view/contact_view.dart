import 'package:flutter/material.dart';
import 'package:initsurvey/administrations/administrations.dart';
import 'package:initsurvey/administrations/administrations_sheet.dart';
import 'package:initsurvey/locale/app_translations.dart';
import 'package:initsurvey/repository/survey/survey_provider.dart';
import 'package:initsurvey/repository/survey_repository.dart';
import 'package:initsurvey/ui/button/gradient_submit.dart';
import 'package:initsurvey/ui/button/icon_button_home.dart';
import 'package:initsurvey/ui/form/validators.dart';
import 'package:initsurvey/ui/utility/app_snackbar.dart';
import 'package:provider/provider.dart';

class ContactView extends StatefulWidget {
  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  final _keyScaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final SurveyProvider survey = Provider.of(context);
    return WillPopScope(
      onWillPop: () async {
        await IconButtonHome.showConfirmQuit(context);
        return false;
      },
      child: Scaffold(
        key: _keyScaffold,
        appBar: AppBar(
          title: Text(
            AppTranslations.of(context).text('contact'),
            style: TextStyle(color: Colors.black87),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              IconButtonHome.showConfirmQuit(context);
            },
          ),
          actions: const [IconButtonHome()],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: GradientButton(
            child: Text(
              AppTranslations.of(context).text('submit').toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              onSubmit(context, survey);
            },
          ),
        ),
        body: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: ListView(
            padding: const EdgeInsets.all(32),
            children: <Widget>[
              Text(
                AppTranslations.of(context).text('contact_title'),
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                decoration: InputDecoration(
                    labelText:
                        AppTranslations.of(context).text('full_name') + " (*)"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'The username is invalid.';
                  }
                  return null;
                },
                onSaved: (value) {
                  survey.results.fullName = value;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                    labelText:
                        AppTranslations.of(context).text('phone') + " (*)"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value.isEmpty || value.length > 10) {
                    return 'The phone number is invalid (10 digits).';
                  }
                  return null;
                },
                onSaved: (value) {
                  survey.results.phoneNumber = value;
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  _showAddress(AdministrationsLevel.province);
                },
                child: IgnorePointer(
                  child: TextFormField(
                    readOnly: true,
                    controller: _controllerProvince,
                    decoration: const InputDecoration(
                      labelText: 'Province (*)',
                      suffixIcon: Icon(Icons.keyboard_arrow_down),
                    ),
                    validator: Validators.notEmpty,
                    onSaved: (value) {
                      survey.results.city = value;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  _showAddress(AdministrationsLevel.district);
                },
                child: IgnorePointer(
                  child: TextFormField(
                    readOnly: true,
                    controller: _controllerDistrict,
                    decoration: const InputDecoration(
                      labelText: 'District (*)',
                      suffixIcon: Icon(Icons.keyboard_arrow_down),
                    ),
                    validator: Validators.notEmpty,
                    onSaved: (value) {
                      survey.results.district = value;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  _showAddress(AdministrationsLevel.wards);
                },
                child: IgnorePointer(
                  child: TextFormField(
                    readOnly: true,
                    controller: _controllerWards,
                    decoration: const InputDecoration(
                      labelText: 'Wards (*)',
                      suffixIcon: Icon(Icons.keyboard_arrow_down),
                    ),
                    validator: Validators.notEmpty,
                    onSaved: (value) {
                      survey.results.ward = value;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                focusNode: _streetFocusNode,
                decoration: InputDecoration(
                    labelText:
                        AppTranslations.of(context).text('address') + " (*)"),
                validator: Validators.notEmpty,
                onSaved: (value) {
                  survey.results.address = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSubmit(BuildContext context, SurveyProvider survey) {
    _autoValidate = true;
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      sentData(survey.results);
    }
  }

  Future sentData(survey) async {
    final response = await SurveyRepository.sent(survey);
    if (response['status'] == 'success') {
      await Navigator.pushReplacementNamed(context, '/result-view',
          arguments: {"message": "true"});
    } else {
      String message = response['message'];
      switch (message) {
        case 'phone_number_already_submit':
          await Navigator.pushReplacementNamed(context, '/result-view',
              arguments: {"message": "false"});
          break;
        default:
          _keyScaffold.currentState.showSnackBar(mySnackBar(message));
          break;
      }
    }
  }

  final TextEditingController _controllerProvince = TextEditingController();
  final TextEditingController _controllerDistrict = TextEditingController();
  final TextEditingController _controllerWards = TextEditingController();
  final FocusNode _streetFocusNode = FocusNode();
  Administrations _province;
  Administrations _district;
  Administrations _wards;

  Future _showAddress(AdministrationsLevel level, {Duration delay}) async {
    if (delay != null) {
      await Future.delayed(delay);
    }
    final String codeParent = getParentCode(level);
    final String codeCurrent = getCurrentCode(level);
    if (codeParent != null || level == AdministrationsLevel.province) {
      await showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (_) {
            return AdministrationsSheet(
              level: level,
              parentCode: codeParent,
              onSelect: (item) {
                _selectItem(item, level);
              },
              currentCode: codeCurrent,
            );
          });
    } else {}
  }

  void _selectItem(Administrations region, AdministrationsLevel level) {
    switch (level) {
      case AdministrationsLevel.province:
        _province = region;
        _district = null;
        _wards = null;
        _showAddress(AdministrationsLevel.district,
            delay: const Duration(milliseconds: 500));
        _controllerProvince.text = "${region.type} ${region.name}";
        break;
      case AdministrationsLevel.district:
        _district = region;
        _wards = null;
        _showAddress(AdministrationsLevel.wards,
            delay: const Duration(milliseconds: 500));
        _controllerDistrict.text = "${region.type} ${region.name}";
        break;
      case AdministrationsLevel.wards:
        _wards = region;
        _controllerWards.text = "${region.type} ${region.name}";
        FocusScope.of(context).requestFocus(_streetFocusNode);
        break;
      default:
        break;
    }
    setState(() {});
  }

  String getParentCode(AdministrationsLevel level) {
    switch (level) {
      case AdministrationsLevel.district:
        if (_province == null) {
          _keyScaffold.currentState.showSnackBar(mySnackBar('Chọn tỉnh trước'));
          return null;
        }
        return _province?.code;
        break;

      case AdministrationsLevel.wards:
        if (_district == null) {
          _keyScaffold.currentState.showSnackBar(mySnackBar('Chọn quận trước'));
          return null;
        }
        return _district?.code;
        break;
      default:
        return null;
        break;
    }
  }

  String getCurrentCode(AdministrationsLevel level) {
    switch (level) {
      case AdministrationsLevel.province:
        return _province?.code;
        break;
      case AdministrationsLevel.district:
        return _district?.code;
        break;
      case AdministrationsLevel.wards:
        return _wards?.code;
        break;
      default:
        return null;
        break;
    }
  }
}
