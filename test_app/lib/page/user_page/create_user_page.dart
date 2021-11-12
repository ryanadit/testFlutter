import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:test_app/notifier/save_role_notifier.dart';

class CreateRolePage extends StatefulWidget {

  static const String route_name = "/create_user";

  CreateRolePage({
    Key? key,
  }) : super(key: key);

  @override
  _CreateRolePageState createState() => _CreateRolePageState();
}

class _CreateRolePageState extends State<CreateRolePage> {

  TextEditingController? _textRequirementEditingController = TextEditingController();
  TextEditingController? _textDescriptionEditingController = TextEditingController();
  TextEditingController? _textTitleEditingController = TextEditingController();
  String? _flagRequirement = "Requirement";
  String? _flagDescription = "Description";
  String? _flagTitle = "Title";
  ProgressDialog? pd;
  SaveRoleNotifier? _saveRoleNotifier;
  final _keyForm = GlobalKey<FormState>();

  _alertSave(BuildContext context) async {
    final title = "Konfirmasi";
    final message = "Apakah anda yakin ingin menyimpan?";
    final form = _keyForm.currentState;
    form?.save();

    if(form!.validate()) return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        if(Platform.isIOS) {
          return CupertinoAlertDialog(
            title: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height/75
              ),
              child: Text("$title",
                style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height/45,
                    fontWeight: FontWeight.w500,
                    color: Colors.deepOrange
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("$message",
                    style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height/50,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK',
                  style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height/55,
                      color: Colors.teal
                  ),),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _saveRole();
                },
              ),
              CupertinoDialogAction(
                child: Text('Batal',
                  style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height/55,
                      color: Colors.redAccent
                  ),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
        else {
          return AlertDialog(
            title: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height/75
              ),
              child: Text(title,
                style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height/45,
                    fontWeight: FontWeight.w500,
                    color: Colors.deepOrange
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(message,
                    style: GoogleFonts.roboto(
                        fontSize: MediaQuery.of(context).size.height/50,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK',
                  style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height/55,
                      color: Colors.teal
                  ),),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _saveRole();
                },
              ),
              TextButton(
                child: Text('Batal',
                  style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height/55,
                      color: Colors.redAccent
                  ),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      },
    );
    return ;
  }

  void _saveRole() async {
    try {
      await _saveRoleNotifier?.saveDataRole(
        context: context,
        title: _textTitleEditingController?.text,
        requirement: _textRequirementEditingController?.text,
        description: _textDescriptionEditingController?.text,
        pd: pd
      );
    } catch(e) {
      debugPrint("$e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _saveRoleNotifier = Provider.of(context, listen: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textDescriptionEditingController?.dispose();
    _textRequirementEditingController?.dispose();
    _textTitleEditingController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBodyContent(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final _mediaHeight = MediaQuery.of(context).size.height;
    String? titleAppBar = "Create Role";

    return AppBar(
      title: Text("$titleAppBar",
        style: GoogleFonts.poppins(
            fontSize: _mediaHeight/40
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              _alertSave(context);
            },
            child: Text("Simpan",
              style: GoogleFonts.poppins(
                  fontSize: _mediaHeight/50,
                  fontWeight: FontWeight.w300,
                color: Colors.white
              ),
            ),
        ),
      ],
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    final _mediaHeight = MediaQuery.of(context).size.height;
    final _mediaWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        width: _mediaWidth,
        height: _mediaHeight,
        padding: EdgeInsets.symmetric(
            horizontal: _mediaWidth/10,
            vertical: _mediaHeight/50
        ),
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              _buildTextField(context, _textTitleEditingController, "Title", _flagTitle, Icons.alternate_email_rounded),
              _buildTextField(context, _textRequirementEditingController, "Requirement", _flagRequirement, Icons.person),
              _buildTextField(context, _textDescriptionEditingController, "Description", _flagDescription, Icons.announcement_outlined),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, TextEditingController? textEditingController, String? title, String? flagType, IconData icons) {
    final _mediaHeight = MediaQuery.of(context).size.height;
    final _mediaWidth = MediaQuery.of(context).size.width;
    var _keyboardType = TextInputType.text;
    final _errorBorder = OutlineInputBorder(borderRadius:BorderRadius.circular(_mediaWidth/40),
        borderSide: BorderSide(color: Colors.redAccent, width: _mediaWidth/500));
    final _icon = Container(
      margin: EdgeInsets.only(
        right: _mediaWidth/80
      ),
      child: Icon(
        icons,
        color: Colors.blueGrey,
        size: _mediaHeight/30,
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: _mediaHeight/90
      ),
      child: Row(
        children: [
          _icon,
          Flexible(
            child: Container(
              child: TextFormField(
                controller: textEditingController,
                cursorColor: Colors.blueAccent,
                validator: (val) {
                  /*if(val!.isEmpty) {
                    return "$title is Empty";
                  }
                  else if(flagType == _flagTitle && !val.contains(Helper.regexEmail)) {
                    return "$title wrong format";
                  }
                  return null;*/
                  return _saveRoleNotifier?.validator(val, title);
                },
                keyboardType: _keyboardType,
                style: GoogleFonts.poppins(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                    fontSize: _mediaHeight/50
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: _mediaWidth/30,
                      vertical: _mediaHeight/50
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "$title",
                  labelStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: _mediaHeight/55
                  ),
                  enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(_mediaWidth/40),
                      borderSide: BorderSide(color: Colors.blueGrey, width: _mediaWidth/500)),
                  focusedErrorBorder: _errorBorder,
                  errorBorder: _errorBorder,
                  focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(_mediaWidth/40),
                      borderSide: BorderSide(color: Colors.blueAccent, width: _mediaWidth/500)),
                  prefixIconConstraints: BoxConstraints(
                      maxWidth: _mediaWidth/15
                  ),
                  prefixStyle: TextStyle(color: Colors.transparent),


                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
