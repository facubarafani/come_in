import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget _buildLogin() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/main');
                    },
                    child: Text('Sign In'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterText() {
    return Padding(
      padding: EdgeInsets.all(8),
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text('Sign In'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ],
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
        centerTitle: true,
        title: Text('come_in'),
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
