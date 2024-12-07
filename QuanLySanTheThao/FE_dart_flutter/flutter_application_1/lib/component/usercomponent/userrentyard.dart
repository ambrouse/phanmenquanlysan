import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/navbar/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userrentyard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserrentyardSetting();
  }
}

Future<List> funcGetRentYard() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String idUserRequest_ = sharedPreferences.getString("idUser_").toString();
  final dio = new Dio();
  try {
    Response response = await dio.get(
      "http://10.0.2.2:9090/user/api/v1/rentyard/" + idUserRequest_,
      options: Options(
          headers: {'Authorization': ""}, contentType: Headers.jsonContentType),
    );

    return [response.data['result_'].length,true, response.data['result_']];
  } on DioException catch (e) {
    if (e.response != null) {
      return [1,false, e.response?.data["result_"]];
    } else {
      return [1,false, e];
    }
  }
}

Future<String> funcDeleteRentYard_(String idUserRequest_) async {
  final dio = new Dio();
  try {
    Response response = await dio.delete(
      "http://10.0.2.2:9090/user/api/v1/rentyard/" + idUserRequest_,
      options: Options(
          headers: {'Authorization': ""}, contentType: Headers.jsonContentType),
    );

    return response.data['result_'];
  } on DioException catch (e) {
    if (e.response != null) {
      return e.response?.data["result_"];
    } else {
      return e.toString();
    }
  }
}

class UserrentyardSetting extends State<Userrentyard> {
  List listRentYard_ = [];
  var nofiticationDelete_ = null;
  bool checkDeleteChose_ = false;
  var idRentYardNow_ = null;

  @override
  void initState() {
    super.initState();
    funcGetRentYard().then((data) {
      setState(() {
        listRentYard_ = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //size phone varilabel
    final width_ = MediaQuery.of(context).size.width;
    final height_ = MediaQuery.of(context).size.height;

    //varilabel style widget
    final colorText = const Color.fromARGB(255, 0, 0, 0);
    final colorBackgr = const Color.fromARGB(255, 217, 217, 217);
    final colorBackgr2 = Color.fromARGB(255, 198, 194, 194);
    final double sizeText1 = 20;
    final double sizeText2 = 15;
    final double sizeText3 = 10;

    return SafeArea(
        child: Scaffold(
      body: Container(
        width: width_,
        height: height_,
        color: colorBackgr,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: colorBackgr2,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              height: (height_ - 100),
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/user/user_profile");
                      },
                      child: Icon(Icons.arrow_back_outlined),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "Sân đã đặt",
                      style: TextStyle(fontSize: sizeText1, color: colorText),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: (height_ - 200),
                    margin: EdgeInsets.only(top: 20),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 500,
                            mainAxisExtent: 300,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: listRentYard_.isEmpty ? 1 : listRentYard_[0],
                        itemBuilder: (context, item) {
                          if (listRentYard_.isEmpty) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text("load ..."),
                            );
                          } else if (listRentYard_[0] == 1&&listRentYard_[1] == false) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text(listRentYard_[1]),
                            );
                          }

                          return Container(
                              padding: EdgeInsets.only(left: 40, right: 40),
                              child: Container(
                                padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                    color: colorBackgr,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border:
                                        Border.all(color: colorText, width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 3,
                                          spreadRadius: 1),
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Tên sân :",
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              )),
                                          Expanded(
                                              flex: 6,
                                              child: Text(
                                                listRentYard_[2][item]
                                                    ["nameYard_"],
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Địa chỉ :",
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              )),
                                          Expanded(
                                              flex: 6,
                                              child: Text(
                                                listRentYard_[2][item]
                                                    ["addressYard_"],
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Trạng thái :",
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              )),
                                          Expanded(
                                              flex: 6,
                                              child: Text(
                                                listRentYard_[2][item]
                                                    ["statusYard_"],
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Ngày thuê :",
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              )),
                                          Expanded(
                                              flex: 6,
                                              child: Text(
                                                listRentYard_[2][item]
                                                    ["startDay_"],
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Ngày trả :",
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              )),
                                          Expanded(
                                              flex: 6,
                                              child: Text(
                                                listRentYard_[2][item]
                                                    ["endDay_"],
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Thời gian thuê :",
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              )),
                                          Expanded(
                                              flex: 6,
                                              child: Text(
                                                listRentYard_[2][item]
                                                    ["rentTime"],
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Xóa thông tin :",
                                                style: TextStyle(
                                                    fontSize: sizeText2,
                                                    color: colorText),
                                              )),
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    checkDeleteChose_ = true;
                                                    idRentYardNow_ =
                                                        listRentYard_[2][item]
                                                            ["id"];
                                                  });
                                                },
                                                child: Text(
                                                  "<<Ấn để xóa>>",
                                                  style: TextStyle(
                                                      fontSize: sizeText2,
                                                      color: colorText),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }),
                  )
                ],
              ),
            ),
            nofiticationDelete_ == null
                ? Container()
                : Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: width_,
                      height: height_,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(40),
                      color: const Color.fromARGB(0, 0, 0, 0),
                      child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 145, 143, 143),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(top: 10, right: 20),
                                child: InkWell(
                                  onTap: () {
                                      funcGetRentYard().then((data) {
                                        nofiticationDelete_ = null;
                                        setState(() {
                                          listRentYard_ = data;
                                        });
                                      }); 
                                  },
                                  child: Icon(Icons.close),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                alignment: Alignment.center,
                                child: Text(nofiticationDelete_),
                              )
                            ],
                          )),
                    ),
                  ),
            checkDeleteChose_ == false
                ? Container()
                : Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: width_,
                      height: height_,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(40),
                      color: const Color.fromARGB(0, 0, 0, 0),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 145, 143, 143),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: 250,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.only(right: 20, top: 10),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      checkDeleteChose_ = false;
                                    });
                                  },
                                  child: Icon(Icons.close),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                alignment: Alignment.center,
                                child: Text(
                                    "Chỉ xóa dơn hàng khi đã hết thời gian thuê, nếu xóa trước khi giao sân sẽ không giải quyết khi tới nhận sân !!!!!!!!!"),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                alignment: Alignment.center,
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: colorBackgr,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: InkWell(
                                  onTap: () {
                                    funcDeleteRentYard_(idRentYardNow_)
                                        .then((data) {
                                      setState(() {
                                        nofiticationDelete_ = data;
                                        checkDeleteChose_ = false;
                                      });
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Ấn để xóa"),
                                      Icon(Icons.check_circle_outline),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
            Positioned(bottom: 20, left: 0, child: Navbar()),
          ],
        ),
      ),
    ));
  }
}
