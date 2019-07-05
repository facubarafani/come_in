import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget _buildLogin() {
    return Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Wrap(
          children: [
            Text('Login'),
            Divider(),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 240),
              child: RaisedButton(
                onPressed: () {},
                child: Text('Sign In'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterText() {
    return Padding(
      padding: EdgeInsets.only(top: 280),
      child: Column(
        children: [
          Icon(Icons.arrow_drop_up),
          Text('Swipe up to register'),
        ],
      ),
    );
  }

  Widget _buildRegister() {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Wrap(
              children: [
                Text('Register'),
                Divider(),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'User'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 240),
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text('Sign In'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              _buildLogin(),
              _buildRegisterText(),
            ],
          ),
          _buildRegister()
        ],
      ),
    );
  }
}
