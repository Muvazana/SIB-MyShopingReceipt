import 'package:flutter/material.dart';
import 'package:flutter_myshopingreceipt/nvvm/view_model/formaddreceipt_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_myshopingreceipt/components/textformfield_datepicker.dart';
import 'package:flutter_myshopingreceipt/components/textformfield_uploadimage.dart';

class FormAddReceipt extends StatelessWidget {
  static const routeName = '/Dashboard/FormAddReceipt';
  FormAddReceipt({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _dateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<FormAddReceiptViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "History Belanja",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormFieldDatePicker(
              title: "Tanggal Belanja",
              controller: _dateController,
            ),
            SizedBox(height: 16),
            TextFormFieldUploadImage(
              title: "Struk",
              onImageSelected: (String filePath) {
                provider.setImagePath(filePath);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Tambahkan"),
        onPressed: () => provider.onAddReceipt(context, _dateController.text),
      ),
    );
  }
}
