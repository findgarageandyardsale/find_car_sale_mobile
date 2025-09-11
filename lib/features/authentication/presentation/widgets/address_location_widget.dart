import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:findcarsale/features/authentication/presentation/widgets/auth_field.dart';
import 'package:findcarsale/services/capitalize_word_formatter_service.dart';
import 'package:findcarsale/shared/constants/spacing.dart';

import '../../../../shared/globals.dart';
import '../../../../shared/widgets/custom_bottomsheet.dart';

class AddressLocationWidget extends StatelessWidget {
  const AddressLocationWidget({
    super.key,
    required this.cityController,
    required this.stateController,
    required this.streetNumberController,
    required this.suiteController,
    required this.zipCodeController,
    required this.formKey,
    this.isRequired,
  });
  final TextEditingController streetNumberController;
  final TextEditingController suiteController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipCodeController;
  final bool? isRequired;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        Spacing.sizedBoxH_08(),
        AuthField(
          name: 'street_number',
          textCapitalization: TextCapitalization.words,
          hintText: 'Street Name',

          labelText: 'Street Name',
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            if (isRequired == true)
              FormBuilderValidators.required(
                errorText: 'Street Name cannot be empty.',
              ),
          ]),
          keyboardType: TextInputType.text,
          onChanged: (p0) {
            if (formKey.currentState?.fields['street_number']?.hasError ??
                false) {
              formKey.currentState?.fields['street_number']?.validate();
            }
          },
          controller: streetNumberController,
          inputFormatters: [
            CapitalizeWordsInputFormatter(),
          ], // Apply the custom TextInputFormatter
        ),
        Spacing.sizedBoxH_16(),
        AuthField(
          name: 'suite_apt',
          textCapitalization: TextCapitalization.words,
          hintText: 'Suite/Apt',
          labelText: 'Suite/Apt',
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            // FormBuilderValidators.required(
            //     errorText: 'Suite/Apt cannot be empty.'),
          ]),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            if (formKey.currentState?.fields['suite_apt']?.hasError ?? false) {
              formKey.currentState?.fields['suite_apt']?.validate();
            }
          },
          controller: suiteController,
        ),

        // Row(
        //   children: [
        //     Expanded(
        //       child: AuthField(
        //         name: 'street_name',
        //         hintText: 'Street Name',
        //         labelText: 'Street Name',
        //         textInputAction: TextInputAction.next,
        //         validator: FormBuilderValidators.compose([
        //           FormBuilderValidators.required(
        //               errorText: 'Street Name cannot be empty.'),
        //         ]),
        //         keyboardType: TextInputType.text,
        //         onChanged: (value) {},
        //         controller: streetNameController,
        //       ),
        //     ),
        //     Spacing.sizedBoxW_12(),
        //     Expanded(
        //       child: AuthField(
        //         name: 'suite_apt',
        //         hintText: 'Suite/Apt',
        //         labelText: 'Suite/Apt',
        //         textInputAction: TextInputAction.next,
        //         validator: FormBuilderValidators.compose([
        //           FormBuilderValidators.required(
        //               errorText: 'Suite/Apt cannot be empty.'),
        //         ]),
        //         keyboardType: TextInputType.text,
        //         onChanged: (value) {},
        //         controller: suiteController,
        //       ),
        //     ),
        //   ],
        // ),
        Spacing.sizedBoxH_16(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AuthField(
                name: 'city',
                hintText: 'City',
                textCapitalization: TextCapitalization.words,
                labelText: 'City',
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose([
                  if (isRequired == true)
                    FormBuilderValidators.required(
                      errorText: 'City cannot be empty.',
                    ),
                ]),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  if (formKey.currentState?.fields['city']?.hasError ?? false) {
                    formKey.currentState?.fields['city']?.validate();
                  }
                },
                controller: cityController,
              ),
            ),
            Spacing.sizedBoxW_12(),
            Expanded(
              child: AuthField(
                name: 'state',
                hintText: 'State',
                labelText: 'State',
                readOnly: true,
                onTap: () {
                  primaryBottomSheet(
                    context,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select State',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: usStates.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    '${usStates[index]['name']!} (${usStates[index]['abbreviation']!})',
                                  ),
                                  onTap: () {
                                    stateController.text =
                                        usStates[index]['abbreviation']!;
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose([
                  if (isRequired == true)
                    FormBuilderValidators.required(
                      errorText: 'State cannot be empty.',
                    ),
                ]),
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                controller: stateController,
              ),
            ),
          ],
        ),
        Spacing.sizedBoxH_16(),
        AuthField(
          name: 'zip_code',
          hintText: 'Zip Code',
          labelText: 'Zip Code',
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            if (isRequired == true)
              FormBuilderValidators.required(
                errorText: 'Zip Code cannot be empty.',
              ),
          ]),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            if (formKey.currentState?.fields['zip_code']?.hasError ?? false) {
              formKey.currentState?.fields['zip_code']?.validate();
            }
          },
          controller: zipCodeController,
        ),
      ],
    );
  }
}
