import 'package:flutter/material.dart';
import 'package:pre_dashboard/widgets/custom_dropdown_field.dart';
import 'package:pre_dashboard/widgets/custom_input_field.dart';

class Step3Content extends StatelessWidget {
  const Step3Content({super.key,
  required this.formKey
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: screenWidth*0.05),
        child: Form(
          key: formKey,
          child:   Column(
            
            children: [
              
              CustomInputField(label: "College Name",
              validator: (value) {
                if(value == null || value.isEmpty)
                {
                  return 'Please enter college name';
                }
                return null;
              },
              ),
              CustomDropdownField(label: "Select State",
              validator: (value) {
                if(value == null || value.isEmpty)
                {
                  return 'Please select state';

                }
                return null;
              },
              ),
              CustomDropdownField(label: "Select Branch",
               validator: (value) {
                if(value == null || value.isEmpty)
                {
                  return 'Please select branch';

                }
                return null;
              },
              ),
              CustomDropdownField(label: "Select Course",
               validator: (value) {
                if(value == null || value.isEmpty)
                {
                  return 'Please select course';

                }
                return null;
              },
              ),
              CustomInputField(label: "Select Year",
                validator: (value) {
                if(value == null || value.isEmpty)
                {
                  return 'Please enter year';
                }
                return null;
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}