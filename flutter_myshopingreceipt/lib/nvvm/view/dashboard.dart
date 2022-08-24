import 'package:flutter/material.dart';
import 'package:flutter_myshopingreceipt/nvvm/view/form_add_receipt.dart';
import 'package:flutter_myshopingreceipt/nvvm/view_model/dashboard_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_myshopingreceipt/nvvm/model/item_model.dart';

class Dashboard extends StatelessWidget {
  static const routeName = 'Dashboard';
  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<DashboardViewModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "History Belanja",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<ItemModel>>(
        future: provider.getItemListData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.length == 0) {
            return Center(
              child: Text(
                "No Data!",
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var date = snapshot.data!.elementAt(index).date;
              return ListTile(
                title: Text(
                  date.day.toString() +
                      "/" +
                      date.month.toString() +
                      "/" +
                      date.year.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  "Jumlah Belanja: Rp ${snapshot.data!.elementAt(index).total}",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.1,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 42,
              child: Divider(
                color: Colors.white,
                thickness: 2,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Belanja: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Rp ${provider.getTotalBelanja}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(FormAddReceipt.routeName);
        },
        child: Icon(
          Icons.add,
          size: 32,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
