import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_tacks/profile_data_model.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  ProfileEditPageState createState() {
    return ProfileEditPageState();
  }
}

class ProfileEditPageState extends State<ProfileEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ProfileDataModel model = Provider.of<ProfileDataModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Profile Form")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildFirstName(model),
              SizedBox(height: 10.0),
              _buildLastName(model),
              SizedBox(height: 10.0),
              _buildPhoneNumber(model),
              SizedBox(height: 10.0),
              _buildDateOfBirth(model),
              SizedBox(height: 20.0),
              RaisedButton(
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
                  _showConfirmationDialog(_formKey);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstName(ProfileDataModel model) {
    TextEditingController _firstNameController = TextEditingController();
    _firstNameController.text = model.firstName;
    return TextFormField(
      controller: _firstNameController,
      decoration: _configureInputDecorator("First Names"),
      // maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'First Name is Required';
        }
        return null;
      },
      onSaved: (String value) {
        model.firstName = value;
      },
    );
  }

  Widget _buildLastName(ProfileDataModel model) {
    TextEditingController _lastNameController = TextEditingController();
    _lastNameController.text = model.lastName;
    return TextFormField(
      controller: _lastNameController,

      decoration: _configureInputDecorator('Last Name'),
      // maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last Name is Required';
        }
        return null;
      },
      onSaved: (String value) {
        model.lastName = value;
      },
    );
  }

  Widget _buildPhoneNumber(ProfileDataModel model) {
    TextEditingController _phoneNumberController = TextEditingController();
    _phoneNumberController.text = model.phoneNumber;
    return TextFormField(
      controller: _phoneNumberController,
      decoration: _configureInputDecorator('Phone Number'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }
        if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
            .hasMatch(value)) {
          return 'Please enter a valid Phone Number';
        }

        return null;
      },
      onSaved: (String value) {
        model.phoneNumber = value;
      },
    );
  }

  Widget _buildDateOfBirth(ProfileDataModel model) {
    TextEditingController _dateOfBirthController = TextEditingController();
    _dateOfBirthController.text = model.dateOfBirth;
    return TextFormField(
      controller: _dateOfBirthController,
      decoration: _configureInputDecorator('Date Of Birth'),
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        DateTime date = DateTime(1900);

        date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now());

        if (date != null) {
          print(date.toIso8601String());
          _dateOfBirthController.text = date.toIso8601String();
        }
      },
      validator: (String value) {
        if (value.isEmpty) {
          return 'Date Of Birth is Required';
        }
        return null;
      },
      onSaved: (String value) {
        model.dateOfBirth = value;
      },
    );
  }

  Future<void> _showConfirmationDialog(GlobalKey<FormState> key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
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
                key.currentState.save();
                FocusScope.of(context).requestFocus(new FocusNode());
                Navigator.of(context).pop();
                _showConfirmSnackBar();
              },
            ),
          ],
        );
      },
    );
  }

  void _showConfirmSnackBar() {
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
}
