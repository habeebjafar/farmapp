import 'package:flutter/material.dart';

class FormHelper{
  static Widget textInput(
    BuildContext context,
    Object initialValue,
    Function onChanged, {
      bool isTextArea = false,
      bool isNumberInput = false,
      obscureText: false,
      required Function onValidate,
      required Widget prefixIcon,
      required Widget suffixIcon


    }){
      return TextFormField(
        initialValue: initialValue != null ? initialValue.toString() : '',
        decoration: fieldDecoration(
          context,
          "",
          "",
          prefixIcon: suffixIcon,
          suffixIcon: suffixIcon
        ),
        obscureText: obscureText,
        maxLines: !isTextArea ? 1 : 3,
        keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
        onChanged: (String value){
          return onChanged(value);
        },
        validator: (value){
          return onValidate(value);
        },
      );

    }

    static InputDecoration fieldDecoration(
      BuildContext context,
      String hintText,
      String helperText, {
        required Widget prefixIcon,
        required Widget suffixIcon
      }
    ){

      return InputDecoration(
        contentPadding: EdgeInsets.all(6),
        hintText: hintText,
        helperText: helperText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1
          )
        )

      );

    }

    static Widget fieldLabel(String labelName){
      return new Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
        child: Text(
          labelName,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),

        ),
      );
    }

    static Widget saveButton(
      String buttonText, Function onTap, {
        required String color, required String textColor, required bool fullWidth
      }) {

        return Container(
          height: 50.0,
          width: 150.0,
          child: GestureDetector(
            onTap: (){
              onTap();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.redAccent,
                  style: BorderStyle.solid,
                  width: 1.0,

                ),
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1
                         ),
                    ),
                  )

              ],
              ),

            ),
            ),
        );

    }

    static void showMessage(
      BuildContext context,
      String title,
      String message,
      String buttonText,
      Function onPressed,
    ){

      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text(title),
            content: new Text(message),
            actions: [
              new FlatButton(
                onPressed: (){
                  return onPressed();
                }, 
                child: new Text(buttonText)
                )
            ],
          );
        }
        );

    }




}