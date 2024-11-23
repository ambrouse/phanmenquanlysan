import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/navbar/navbar.dart';

class home extends StatefulWidget{
  const home({super.key});

  @override
  State<StatefulWidget> createState() {
    return homeSetting();
  }

}

class homeSetting extends State<home>{

  @override
  Widget build(BuildContext context) {
    final width_ = MediaQuery.of(context).size.width;
    final height_ = MediaQuery.of(context).size.height;
    final currentCount = (MediaQuery.of(context).size.width ~/ 250).toInt();

    
    return SafeArea(
      child: Scaffold(
        body:Container(
          width: width_,
          // height: height_,
          color: Color.fromARGB(255, 217, 217, 217),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                    "Wellcome",
                    style: TextStyle(
                      fontSize: 20
                    ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: ListView(
                  padding: EdgeInsets.only(top: 30,left: (width_/7)),
                  children: [
                    SizedBox(
                      height: 50,
                      // color: Colors.black,
                      child: SizedBox(
                        width:width_,
                        child: const Text(
                            "Liên hệ : ",
                            style: TextStyle(
                              fontSize: 20
                            ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width:width_,
                        child: const Text(
                          "Chi nhánh 1 : .................",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width:width_,
                        child: const Text(
                          "Chi nhánh 2 : .................",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width:width_,
                        child: const Text(
                          "Chi nhánh 3 : .................",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width:width_,
                        child: const Text(
                          "Chi nhánh 4 : .................",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width:width_,
                        child: const Text(
                          "Chi nhánh 5 : .................",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 30),
                      // color: Colors.black,
                      child: SizedBox(
                        width:width_,
                        child: const Text(
                          "Tổng quan công ty : ",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: 30,
                      padding: EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width:width_,
                        child: const Text(
                          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quos nisi quaerat recusandae porro. Nam eveniet atque sapiente. Perspiciatis placeat commodi qui quam, autem repudiandae doloremque, ea minus consequatur cumque tempora.",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 30),
                      // color: Colors.black,
                      child: SizedBox(
                        width:width_,
                        child: const Text(
                          "Các dịch vụ :",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: 30,
                      padding: EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width:width_,
                        child: const Text(
                          "Thuê sân ....",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: 30,
                      padding: EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width:width_,
                        child: const Text(
                          "Thuê sân ....",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: 30,
                      padding: EdgeInsets.only(left: 30),
                      child: SizedBox(
                        width:width_,
                        child: const Text(
                          "Thuê sân ....",
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),




                  ],
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 0,
                  child: Navbar()
              )
            ],
          ),
        ) ,
      ),
    );
  }

}