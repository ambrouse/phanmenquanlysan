import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/navbar/navbar.dart';

class Paymentrenyard extends StatefulWidget {
  const Paymentrenyard({super.key});

  @override
  State<StatefulWidget> createState() {
    return PaymentrentyardSetting();
  }
}

class PaymentrentyardSetting extends State<Paymentrenyard> {
  //varilabel style widget
  final colorText = const Color.fromARGB(255, 0, 0, 0);
  final colorBackgr = const Color.fromARGB(255, 217, 217, 217);
  final colorBackgr2 = Color.fromARGB(255, 198, 194, 194);
  final double sizeText1 = 20;
  final double sizeText2 = 15;
  final double sizeText3 = 10;

  @override
  Widget build(BuildContext context) {
    //size phone varilable
    final width_ = MediaQuery.of(context).size.width;
    final height_ = MediaQuery.of(context).size.height;
    
    //ulr param
    String idYard_ = ModalRoute.of(context)!.settings.arguments as String;

    return SafeArea(
        child: Scaffold(
            body: Container(
      width: width_,
      height: height_,
      color: colorBackgr,
      child: Stack(
        children: [
          ListView(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/user/detail_yard",arguments: idYard_);
                  },
                  child: Icon(Icons.arrow_back_outlined),
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "Thanh toán",
                  style: TextStyle(
                    color: colorText,
                    fontSize: sizeText1,
                  ),),
              ),
              Container(
                width: width_,
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    SizedBox(
                      width: (width_/1.3),
                      child:Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "So tai khoan :",
                              style: TextStyle(
                                fontSize: sizeText2,
                                color: colorText
                              ),)),
                          Expanded(
                            flex: 6,
                            child: Text(
                              "111111111111111",
                              style: TextStyle(
                                fontSize: sizeText2,
                                color: colorText
                              ),))
                        ],
                      ) 
                    ),
                    SizedBox(
                      width: (width_/1.3),
                      child:Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Ngan hang :",
                              style: TextStyle(
                                fontSize: sizeText2,
                                color: colorText
                              ),)),
                          Expanded(
                            flex: 6,
                            child: Text(
                              "MB bank",
                              style: TextStyle(
                                fontSize: sizeText2,
                                color: colorText
                              ),))
                        ],
                      ) 
                    ),
                    SizedBox(
                      width: (width_/1.3),
                      child:Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Ten chu the",
                              style: TextStyle(
                                fontSize: sizeText2,
                                color: colorText
                              ),)),
                          Expanded(
                            flex: 6,
                            child: Text(
                              "Duy ngu",
                              style: TextStyle(
                                fontSize: sizeText2,
                                color: colorText
                              ),))
                        ],
                      ) 
                    ),
                    SizedBox(
                      width: (width_/1.3),
                      child:Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Noi dung chuyen khoan :",
                              style: TextStyle(
                                fontSize: sizeText2,
                                color: colorText
                              ),)),
                          Expanded(
                            flex: 6,
                            child: Text(
                              "<Ten nguoi dung>, <Ten san>, <thoi gian dat san>, <thoi gian tra san>",
                              style: TextStyle(
                                fontSize: sizeText2,
                                color: colorText
                              ),))
                        ],
                      ) 
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Text(
                  "Vui long hoan tat thanh toan truoc khi thoat khoi trang",
                  style: TextStyle(
                    fontSize: sizeText2,
                    color: colorText
                  ),
                ),
              )
            ],
          ),

          Positioned(bottom: 20, left: 0, child: Navbar())
        ],
      ),
    )));
  }
}
