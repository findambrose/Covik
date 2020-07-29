import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  //set default display value //stores current state of the dropdown
  var _displayValue = 2;

  var nameController,
      emailController,
      locationController,
      passwordController,
      confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Register'),
        ),
        body: Column(
          children: <Widget>[
            Text('Create an account'),
            SizedBox(height: 15),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'enter full name',
                        icon: Icon(Icons.people),
                      ),
                    ),

                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'enter email address',
                        icon: Icon(Icons.email),
                      ),
                    ),

                    // Code for select country
                    //use DropdownButton class which takes in a few properties

                    DropdownButton(
                        value: _displayValue,
                        items: [
                          DropdownMenuItem(
                            child: Text('Kenya'),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text('Uganda'),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text('Tanzania'),
                            value: 3,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _displayValue = value;
                          });
                        }),

                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'enter password',
                          icon: Icon(Icons.vpn_key)),
                    ),

                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        labelText: 'Confirm Pass',
                        hintText: 'confirm password',
                        icon: Icon(Icons.vpn_key),
                      ),
                    ),

                    Builder(builder: (context) {
                      return RaisedButton.icon(
                        onPressed: () {
                          //check if all information is valid the post to database
                          if (_formKey.currentState.validate()) {
                            print('Register button clicked');

                            //show toast
                            return AlertDialog(
                              content: Text('$emailController.text()'),
                            );

                            // Scaffold.of(context).showSnackBar(
                            //   //create new instance of the snack bar

                            //   SnackBar(content: Text('Register button clicked'),
                            //   backgroundColor: Colors.orange,

                            // ),);

                          }

                          return null;
                        },
                        label: Text('Create'),
                        textColor: Colors.orange,
                        icon: Icon(Icons.open_in_new),
                      );
                    })
                  ],
                ))
          ],
        ));
  }
}
