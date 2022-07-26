import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);

  final void Function(
  String email,
  String password,
  String username,
  bool isLogIn,
  )submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey =GlobalKey<FormState>();
  var _isLogin =true;
  String _userEmail='';
  String _userName='';
  String _userpassword ='';

  void _trySubmit(){
  final isValid = _formKey.currentState!.validate();
  FocusScope.of(context).unfocus();

  if(isValid){
    _formKey.currentState!.save();
   widget.submitFn(
     _userEmail,
     _userpassword,
     _userName,
     _isLogin
   );

  }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: <Widget>[
                   TextFormField(
                     key: ValueKey('email'),
                     validator: (value){
                       if(value!.isEmpty || !value.contains('@')){
                         return 'Please enter a valid email address';
                       }
                       return null;
                     },
                     keyboardType: TextInputType.emailAddress,
                     decoration: InputDecoration(
                       labelText: 'Email adress'
                     ),
                     onSaved: (value){
                        _userEmail =value!;
                     },
                   ),
                   if(!_isLogin)
                   TextFormField(
                     key: ValueKey('username'),
                     validator: (value){
                       if(value!.isEmpty || value.length < 4){
                         return 'Please enter atleast 4 characters';
                       }
                       return null;
                     },
                     decoration:InputDecoration(
                       labelText: 'Username',
                     ),
                     onSaved: (value){
                       _userName = value!;
                     },
                   ),
                   TextFormField(
                     key: ValueKey('password'),
                     validator: (value){
                       if(value!.isEmpty|| value.length < 7){
                         return 'Password must be atleast & characters long';
                       }
                       return null;
                     },
                     decoration:InputDecoration(
                      labelText: 'Password',
                   ),
                     obscureText: true,
                     onSaved: (value){
                       _userpassword = value!;
                     },
                   ),
                   SizedBox(
                     height: 12,
                   ),
                   RaisedButton(onPressed:_trySubmit,
                   child: Text(_isLogin ? 'Login' : 'SignUp'),
                   ),
                   FlatButton(onPressed:(){
                     setState(() {
                       _isLogin = !_isLogin;
                     });
                   },
                       textColor: Theme.of(context).primaryColor,
                       child: Text(_isLogin ? 'Create new account': 'I already have an account')),

                 ],
               ),
            ),
          ),
        ),
      ),
    );
  }
}
