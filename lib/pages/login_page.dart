import 'package:another_flushbar/flushbar.dart';
import 'package:demo_fllutter_cmdev/config/theme.dart' as customTheme;
import 'package:demo_fllutter_cmdev/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // # Field variables.
  final _color = Colors.black54;
  TextEditingController usernameController;
  TextEditingController passwordController;
  // # Show Password
  bool _obscureTextPassword;
  // # This variable is for next to another formfield,
  // # After typing is finished.
  final FocusNode _passwordFocusNode = FocusNode();

  // # Key
  final formKey = GlobalKey<FormState>();

  // # When this page is created,
  // # This method will be called before build method.
  @override
  void initState() {
    // set controllers
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    _obscureTextPassword = true;
    super.initState();
  }

  // # This method is for stop controller working .
  @override
  void dispose() {
    // stop controllers
    usernameController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              // use gradient color
              gradient: customTheme.ThemeBG.gradient,
            ),
          ),
          Column(
            children: [
              imageHeader(),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  buildCardForm(),
                  submitButton(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  // # This method is for displaying logo image only.
  imageHeader() {
    return Container(
      // margin: EdgeInsets.only(top: 50, bottom: 38),
      margin: EdgeInsets.all(50),
      child: Image.asset(
        Assets.LOGO_IMAGE,
        height: 80,
      ),
    );
  }

  // # This method is for building card form.
  Card buildCardForm() {
    // # Functional variable.
    // # For setting the form textstyles and then return it.
    final TextStyle Function() _textStyle = () {
      return TextStyle(
        fontWeight: FontWeight.w500,
        color: _color,
      );
    };

    return Card(
      margin: EdgeInsets.only(bottom: 22, left: 22, right: 22),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 58,
          left: 28,
          right: 28,
        ),
        // # Textformfield validators work in Form only.
        child: Form(
          key: formKey,
          child: Column(
            children: [
              buildUsername(_textStyle),
              // Add Dividing line
              Divider(
                height: 22,
                thickness: 1,
                indent: 13,
                endIndent: 13,
              ),
              buildPassword(_textStyle),
            ],
          ),
        ),
      ),
    );
  }

  // # This method is for buliding a username formfield.
  TextFormField buildUsername(TextStyle _textStyle()) {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: 'Email',
        hintText: 'example@gmail.com',
        icon: FaIcon(
          FontAwesomeIcons.envelope,
          size: 22.0,
          color: _color,
        ),
        labelStyle: _textStyle(),
      ),
      // validate textformfield
      validator: MultiValidator(
        [
          RequiredValidator(errorText: "Field cannto be empty."),
          EmailValidator(errorText: "Invalid email."),
        ],
      ),
      // after validated, back to save
      onSaved: (String email) {
        print(email);
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  // # This method is for buliding a password formfield.
  TextFormField buildPassword(TextStyle _textStyle()) {
    return TextFormField(
      focusNode: _passwordFocusNode,
      controller: passwordController,
      decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Password',
          icon: FaIcon(
            FontAwesomeIcons.lock,
            size: 22.0,
            color: _color,
          ),
          labelStyle: _textStyle(),
          // hide password
          suffixIcon: IconButton(
            icon: FaIcon(
              _obscureTextPassword
                  ? FontAwesomeIcons.eyeSlash
                  : FontAwesomeIcons.eye,
              color: _color,
              size: 15.0,
            ),
            onPressed: () {
              setState(() {
                // true -> false
                _obscureTextPassword = !_obscureTextPassword;
              });
            },
          )),

      obscureText: _obscureTextPassword, //hide text
      // password validator
      validator: (value) {
        if (value.isEmpty) {
          return 'Field cannot be empty.';
        } else if (value.length < 6) {
          return 'Password must be least 6 characters.';
        } else {
          return null;
        }
      },
      onSaved: (String password) {
        print(password);
      },
    );
  }

  Container submitButton() {
    return Container(
      width: 220,
      height: 50,
      decoration: _boxDecoration(),
      child: TextButton(
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
          ),
        ),
        onPressed: () {
          print("OnPressed");
          // get text form edittext
          // print(usernameController.text);
          // print(passwordController.text);

          // String userName = usernameController.text;
          // String password = usernameController.text;

          if (formKey.currentState.validate()) {
            // seve text
            formKey.currentState.save();
            // print(usernameController.text);
            // print(passwordController.text);

            Flushbar(
              message: 'Loadding ...',
              showProgressIndicator: true,
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.GROUNDED,
            ).show(context);

            Future.delayed(Duration(seconds: 2)).then(
              (value) => {
                Navigator.pop(context),

                Flushbar(
                  margin: EdgeInsets.all(8.0),
                  message: 'Login successfully',
                  icon: Icon(
                    Icons.info_outline,
                    size: 28.0,
                    color: Colors.blue[300],
                  ),
                  duration: Duration(seconds: 3),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ).show(context),

                // reset form
                formKey.currentState.reset()
              },
            );
          }
        },
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    // # Create variables for getting colors from themeBG.
    final gradientStart = customTheme.ThemeBG.gradientStart;
    final gradientEnd = customTheme.ThemeBG.gradientEnd;

    // # Functional variable.
    // # For setting shadow color in this scope only.
    final BoxShadow Function(Color color) boxShadowItem = (Color color) {
      // make shadow color
      return BoxShadow(
        color: color,
        offset: Offset(1.0, 6.0),
        blurRadius: 20.0,
      );
    };

    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      boxShadow: [
        // call boxShadowItem
        boxShadowItem(gradientStart),
        boxShadowItem(gradientEnd),
      ],
      // make gradient color from here
      gradient: LinearGradient(
        colors: [
          gradientEnd,
          gradientStart,
        ],
        begin: const FractionalOffset(0, 0),
        end: const FractionalOffset(1.0, 1.0),
        stops: [0.0, 1.0],
      ),
    );
  }
}
