import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pre_dashboard/widgets/custom_text_field.dart';
import 'package:pre_dashboard/widgets/gender_radio.dart';

import '../../constants/constants.dart';

class Step1ContentWidget extends StatefulWidget {
   Step1ContentWidget({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.fatherNameController,
    required this.birthPlaceController,
    required this.dobController,
    required this.onGenderChanged,
    this.selectedGender,
    required this.isValidated,
    required this.onValidation,
    
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController fatherNameController;
  final TextEditingController dobController;
  final TextEditingController birthPlaceController;
  final ValueChanged<String?> onGenderChanged;
  final String? selectedGender;
  final bool isValidated;
  final Function(bool) onValidation;
   

   

  @override
  State<Step1ContentWidget> createState() => _Step1ContentWidgetState();
}

class _Step1ContentWidgetState extends State<Step1ContentWidget> {
  

 

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: widget.formKey, // Attach the form key here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.03),
                CustomTextField(
                  controller: widget.fullNameController,
                  labelText: "Full Name",
                  hintText: 'John Doe',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: widget.fatherNameController,
                  labelText: "Father’s Full Name",
                  hintText: 'Father Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your father\'s full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.015),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Gender',
                        style: GoogleFonts.poppins(
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '*',
                        style: GoogleFonts.poppins(
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff0F3CC9),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.002),
                GenderInput(widget: widget, screenHeight: screenHeight),
                SizedBox(height: screenHeight * 0.02),
                CustomTextField(
                  controller: widget.dobController,
                  labelText: 'Date of Birth',
                  hintText: 'DD/MM/YYYY',
                  prefixIcon: const Icon(Icons.calendar_today,
                      color: AppColors.secondaryTextColor),
                  isDatePicker: true,
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      widget.dobController.text =
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: widget.birthPlaceController,
                  hintText: 'Select State',
                  labelText: 'State',
                  isDropdown: true,
                  dropdownItems: const [
                    'Uttar Pradesh',
                    'Maharashtra',
                    'Delhi',
                    'Karnataka',
                    'Tamil Nadu',
                    'Gujarat',
                    'Rajasthan',
                  ],
                  onDropdownChanged: (value) {
                    print('Selected State: $value');
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your state';
                    }
                    return null;
                  },
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenderInput extends StatelessWidget {
  const GenderInput({
    super.key,
    required this.widget,
    required this.screenHeight,
  });


  
  final Step1ContentWidget widget;
  final double screenHeight;


  String? validateGender(String? gender) {
    if (gender == null || gender.isEmpty) {
      return 'Please select a gender.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.selectedGender,
      validator: validateGender,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GenderRadio(
                  gender: 'Male',
                  selectedGender: field.value,
                  onChanged: (value){
                    field.didChange(value);
                    widget.onGenderChanged(value);
                  },
                  isError: field.hasError,
                ),
                SizedBox(width: screenHeight * 0.01),
                GenderRadio(
                  gender: 'Female',
                  selectedGender: field.value,
                  onChanged: (value){
                    field.didChange(value);
                    widget.onGenderChanged(value);
                  },
                  isError: field.hasError,
                ),
                SizedBox(width: screenHeight * 0.01),
                GenderRadio(
                  gender: 'Other',
                   selectedGender: field.value,
                  onChanged: (value){
                    field.didChange(value);
                    widget.onGenderChanged(value);

                  },
                  isError: field.hasError,
                ),
              ],
            ),
             if (field.hasError)
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.01,left: screenHeight * 0.02),
                child: Text(
                  field.errorText!,
                  style: GoogleFonts.poppins(color: Colors.red[900], fontSize: screenHeight*0.014),
                  
                ),
              ),
          ],
        );
      }
    );
  }
}
