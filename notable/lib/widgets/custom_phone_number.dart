// ignore: must_be_immutable
import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import '../core/app_export.dart';
import '../widgets/custom_text_form_field.dart';

class CustomPhoneNumber extends StatefulWidget {
  CustomPhoneNumber({
    Key? key,
    required this.country,
    required this.onTap,
    required this.controller,
  }) : super(
          key: key,
        );

  Country country;

  Function(Country) onTap;

  TextEditingController? controller;

  @override
  State<CustomPhoneNumber> createState() => _CustomPhoneNumberState();
}

class _CustomPhoneNumberState extends State<CustomPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20.h,
        ),
        border: Border.all(
          color: appTheme.lime50,
          width: 2.h,
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              _openCountryPicker(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: 12.h,
                top: 5.v,
                bottom: 9.v,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 33.v),
                    child: CountryPickerUtils.getDefaultFlagImage(
                      widget.country,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 31.v),
                    child: Text(
                      "+${widget.country.phoneCode}",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(2.h, 38.v, 0, 10.v),
                    child: const Icon(Icons.arrow_drop_down_sharp, size: 10,), // todo imageViewRep
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 29.h,
                right: 5.h,
              ),
              child: CustomTextFormField(
                width: 305.h,
                controller: widget.controller,
                hintText: "6912345678",
                textInputType: TextInputType.phone,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Container(
            margin: EdgeInsets.only(
              left: 10.h,
            ),
            width: 60.h,
            child: Text(
              "+${country.phoneCode}",
              style: TextStyle(fontSize: 14.fSize),
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Text(
              country.name,
              style: TextStyle(fontSize: 14.fSize),
            ),
          ),
        ],
      );

  void _openCountryPicker(BuildContext context) => showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
          searchInputDecoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(fontSize: 14.fSize),
          ),
          isSearchable: true,
          title: Text('Select your phone code',
              style: TextStyle(fontSize: 14.fSize)),
          onValuePicked: (Country country) => widget.onTap(country),
          itemBuilder: _buildDialogItem,
        ),
      );
}
