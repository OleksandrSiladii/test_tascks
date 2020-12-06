import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'file:///C:/flutter/projects/test_tacks/lib/models/profile_data_model.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  ProfileEditPageState createState() {
    return ProfileEditPageState();
  }
}

enum InputType { text, date, phone }

class ProfileEditPageState extends State<ProfileEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProfileDataModel model;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      model = Provider.of<ProfileDataModel>(context);
      _firstNameController.text = model.firstName;
      _lastNameController.text = model.lastName;
      _phoneNumberController.text = model.phoneNumber;
      _dateOfBirthController.text = model.dateOfBirth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Form")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildInput(
                'First Name',
                _firstNameController,
                InputType.text,
              ),
              _buildInput(
                'Last Name',
                _lastNameController,
                InputType.text,
              ),
              _buildInput(
                'Phone Number',
                _phoneNumberController,
                InputType.phone,
              ),
              _buildInput(
                'Date Of Birth',
                _dateOfBirthController,
                InputType.date,
              ),
              Builder(
                builder: (ctx) => RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'SEND',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ],
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _showConfirmationDialog(_formKey, ctx);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
      String title, TextEditingController controller, InputType type) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: _configureInputDecorator(title),
        // maxLength: 20,
        validator: (String value) {
          if (value.isEmpty) {
            return '$title is Required';
          }

          if (type == InputType.phone &&
              !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                  .hasMatch(value)) {
            return 'Please enter a valid Phone Number';
          }

          return null;
        },
        onTap: () => {
          if (type == InputType.date) {selectDate(controller)}
        },
      ),
    );
  }

  Future<void> _showConfirmationDialog(
      GlobalKey<FormState> key, BuildContext ctn) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Builder(
            builder: (ctx) => AlertDialog(
                  title: Text('Save'),
                  content: SingleChildScrollView(
                    child: Text('Do you want to update the profile data?'),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Ok'),
                      onPressed: () {
                        // key.currentState.save();
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.of(context).pop();
                        updateProfile();
                        _showConfirmSnackBar(ctn);
                      },
                    ),
                  ],
                ));
      },
    );
  }

  void _showConfirmSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Profile data has been updated'),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  _configureInputDecorator(String labelText) {
    return InputDecoration(
      labelText: labelText,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(),
      ),
    );
  }

  void updateProfile() {
    model.firstName = _firstNameController.text;
    model.lastName = _lastNameController.text;
    model.phoneNumber = _phoneNumberController.text;
    model.dateOfBirth = _dateOfBirthController.text;
  }

  Future selectDate(TextEditingController controller) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    DateTime date = DateTime(1900);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    date = await showDatePicker(
        context: context,
        initialDate: formatter.parse(controller.text),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (date != null) {
      final String formatted = formatter.format(date);
      controller.text = formatted;
      print(formatted);
    }
  }
}
