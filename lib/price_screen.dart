import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

CoinData coinData = CoinData();

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btcInUsd = '?';
  late String rate;
  void getData() async {
    rate = await coinData.getCoinData();
    var mydouble = double.parse(rate);
    setState(() {
      btcInUsd = mydouble.toStringAsFixed(0);
    });
  }

  DropdownButton<String> androidDropdown() {
    final List<DropdownMenuItem<String>> dropDownitems = [];
    for (String currency in currenciesList) {
      var newitem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownitems.add(newitem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownitems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> currenctList = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      currenctList.add(newItem);
    }

    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32,
        onSelectedItemChanged: (selectedIndex) {},
        children: currenctList);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btcInUsd USD',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          )
        ],
      ),
    );
  }
}
