import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:nima/nima_actor.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedcurr = "AUD";

  Container getdropdownitem() {
    List<DropdownMenuItem<String>> dropdownitem = [];
    for (var x in currenciesList) {
      String currency = x;
      var menuitems = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownitem.add(menuitems);
    }

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE75353),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          isExpanded: true,
          style: TextStyle(fontSize: 20),
          underline: Container(),
          value: selectedcurr,
          items: dropdownitem,
          onChanged: (String value) {
            setState(
              () {
                selectedcurr = value;
                getCurrencyData();
              },
            );
          },
        ),
      ),
    );
  }

  CupertinoPicker getcupertinopicker() {
    List<Text> items = [];
    for (var x in currenciesList) {
      String currenc = x;

      items.add(Text(
        currenc,
        style: TextStyle(color: Colors.white, fontSize: 26),
      ));
    }

    return CupertinoPicker(
      backgroundColor: Color(0xFF215991),
      itemExtent: 35,
      onSelectedItemChanged: (currindex) {
        selectedcurr = currenciesList[currindex];
        getCurrencyData();
      },
      children: items,
    );
  }

  Widget getitemlist() {
    if (Platform.isIOS) {
      return getcupertinopicker();
    } else if (Platform.isAndroid) {
      return getdropdownitem();
    }
  }

  String btcinUSD = "?";

  void getCurrencyData() async {
    try {
      CoinData coinData = CoinData();
      String price = await coinData.getCoinData(selectedcurr);

      setState(() {
        btcinUSD = price;
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrencyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Center(child: Text('Bitcoin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Color(0xFF215991),
              elevation: 8.0,
              shadowColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btcinUSD $selectedcurr',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 550,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new FlareActor("assets/Onboarding_CashinHand.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "idle"),
            ),
          ),
          Container(
            height: 120.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF215991),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              child: getcupertinopicker(),
            ),
          ),
        ],
      ),
    );
  }
}
