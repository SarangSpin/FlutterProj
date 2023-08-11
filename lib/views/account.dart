// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/controllers/carddateformatter.dart';
import 'package:my_app/controllers/cardinformatter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../models/cardetails.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountPage();
}

class _AccountPage extends State<Account> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardDateController = TextEditingController();
  TextEditingController cardcvvController = TextEditingController();

  late var cardNumber;
  late var cardDate;
  late var cardcvv;
  var datevar = '';
  Widget iconLogo = SizedBox(
    child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5))),
  );

  late CardDetails obj;
  CardType objlogo = CardType();

  void clearAll() {
    cardDateController.clear();
    cardNumberController.clear();
    cardcvvController.clear();
  }

  void iconlogo(String link) {
    if (link == 'none') {
      iconLogo = SizedBox(
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5))),
      );
    } else {
      iconLogo = Image.asset('assets/$link', width: 10, height: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
          elevation: 5,
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text(
            'Payments method',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  clearAll();
                },
                child: const Text(
                  "Clear All",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
          ]),
      body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('Please fill all the Payment Information'),
              SizedBox(
                height: 20,
              ),
              Text('Card Number'),
              SizedBox(height: 5),
              TextField(
                controller: cardNumberController,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  hintText: 'e.g 3422 4583 2838 4844',
                  suffixIcon:
                      Padding(padding: EdgeInsets.all(10), child: iconLogo
                          // SizedBox(
                          //   child: DecoratedBox(
                          //       decoration: BoxDecoration(
                          //           color: Colors.grey.shade300,
                          //           borderRadius: BorderRadius.circular(5))),
                          // ),
                          ),
                ),
                onChanged: (value) {
                  var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');

                  setState(() {
                    cardNumberController.value = cardNumberController.value
                        .copyWith(
                            text: text,
                            selection:
                                TextSelection.collapsed(offset: text.length),
                            composing: TextRange.empty);
                  });
                },
                onTapOutside: (dupvalue) {
                  var value = cardNumberController.value.text;
                  objlogo.logoIN(value);
                  setState(() {
                    iconlogo(objlogo.logomap[objlogo.logo].toString());
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  CardInputFormatter()
                ],
              ),
              SizedBox(height: 20),
              Text('Valid to'),
              SizedBox(height: 5),
              TextField(
                controller: cardDateController,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  hintText: 'MM/YY',
                  suffixIcon: IconButton(
                    onPressed: () => {
                      showMonthPicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100))
                          .then((date) {
                        if (date != null) {
                          final input = date.toIso8601String();
                          final formattedDate = input.replaceAllMapped(
                              RegExp(r'^(\d{4})-(\d{2}).*'), (match) {
                            return "${match.group(2)}/${match.group(1)!.substring(2)}";
                          });
                          print(formattedDate);
                          setState(() {
                            cardDateController.value = cardDateController.value
                                .copyWith(
                                    text: formattedDate,
                                    selection: TextSelection.collapsed(
                                        offset: formattedDate.length),
                                    composing: TextRange.empty);
                          });
                        }
                      })
                    },
                    icon: Icon(Icons.calendar_month_outlined),
                    iconSize: 20,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  CardDateInputFormatter()
                ],
                onChanged: (value) {
                  var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');

                  setState(() {
                    cardDateController.value = cardDateController.value
                        .copyWith(
                            text: text,
                            selection:
                                TextSelection.collapsed(offset: text.length),
                            composing: TextRange.empty);
                  });
                },
              ),
              SizedBox(height: 20),
              Text('CVV'),
              SizedBox(height: 5),
              TextField(
                  controller: cardcvvController,
                  obscureText: true,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3)
                  ],
                  onChanged: (value) {
                    var text = value;
                    setState(() {
                      cardcvvController.value = cardcvvController.value
                          .copyWith(
                              text: text,
                              selection:
                                  TextSelection.collapsed(offset: text.length),
                              composing: TextRange.empty);
                    });
                  }),
            ],
          )),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade300))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'By continuing, you consent to the collection and processing of your personal information for the purpose of providing our services. Your data will be treated with utmost confidentiality and security'),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: TextButton(
                  onPressed: () => {
                        cardNumber = cardNumberController.value.text
                            .replaceAll(RegExp(r"\s+\b|\b\s"), ""),
                        cardDate = cardDateController.value.text.toString(),
                        cardcvv = cardcvvController.value.text.toString(),
                        obj = CardDetails(
                            accno: cardNumber,
                            date: cardDate,
                            cvv: cardcvv.toString()),
                        print(obj.accno)
                      },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepOrange)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Save ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
