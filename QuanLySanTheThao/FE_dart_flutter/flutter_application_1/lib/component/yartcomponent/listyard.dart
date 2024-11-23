import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/navbar/navbar.dart';

final dio = Dio();

class Listyard extends StatefulWidget {
  const Listyard({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListyardSetting();
  }
}

Future<List<dynamic>> funcGetAddressYard() async {
  Response response_ = await dio.get(
      "http://10.0.2.2:9090/user/api/v1/address_yard",
      options: Options(
          headers: {'Authorization': ""},
          contentType: Headers.jsonContentType));

  return response_.data['result_'];
}

Future<List> funcSearchYard(
    String nameSearch_, String addressSearch_, String statusSearch_) async {
  Response response_;
  try {
    response_ = await dio.get(
        "http://10.0.2.2:9090/user/api/v1/search_yard?nameYard_=$nameSearch_&addressYard_=$addressSearch_&statusYard_=$statusSearch_",
        options: Options(
            headers: {'Authorization': ""},
            contentType: Headers.jsonContentType));

    return [true, response_.data['result_']];
  } on DioException catch (e) {
    if (e.response != null) {
      return [false, e.response?.data['result_']];
    } else {
      return [false, e.toString()];
    }
  }
}

class ListyardSetting extends State<Listyard> {
  // curent vari
  String searchValueCurrent_ = "";
  String statusValueCurrent_ = "";
  String addressValueCureent_ = "";
  List listYard_ = [];
  bool checkRespone_ = true;
  String errDesription_ = "";
  List<dynamic> listAddRessYard_ = [];
  List<dynamic> listStatusYard_ = [
    {"idStatus_": "", "nameStatus_": "Tất cả"},
    {"idStatus_": "Đông", "nameStatus_": "Đông"},
    {"idStatus_": "Vừa", "nameStatus_": "Vừa"},
    {"idStatus_": "Vắng", "nameStatus_": "Vắng"}
  ];

  @override
  void initState() {
    super.initState();
    // Call the readJson method when the app starts
    funcSearchYard("", "", "").then((data) {
        setState(() {
          listYard_ = data[1];
          checkRespone_ = data[0];
        });
      });
    funcGetAddressYard().then((data) {
      setState(() {
        listAddRessYard_ = data;
        addressValueCureent_ =
            listAddRessYard_[(listAddRessYard_.length - 1)]['idAddress_'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width_ = MediaQuery.of(context).size.width;
    final height_ = MediaQuery.of(context).size.height;
    final currentCount = (MediaQuery.of(context).size.width ~/ 250).toInt();

    // vari setting widget style
    final colorText = const Color.fromARGB(255, 0, 0, 0);
    final colorBackgr = const Color.fromARGB(255, 217, 217, 217);

    // input controller value
    final searchValue_ = TextEditingController();

    //save value search
    if (searchValueCurrent_ != "") {
      searchValue_.text = searchValueCurrent_;
    }

    //read value from input
    @override
    void dispose() {
      searchValue_.dispose();
      super.dispose();
    }

    return SafeArea(
        child: Scaffold(
            body: Container(
                width: width_,
                height: height_,
                color: colorBackgr,
                child: Stack(children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/user/home");
                            },
                            child: Icon(Icons.arrow_back_outlined),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(
                            "Danh sách sân",
                            style: TextStyle(fontSize: 20, color: colorText),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                width: (width_ / 1.4),
                                height: 30,
                                child: TextField(
                                  controller: searchValue_,
                                  decoration: InputDecoration(
                                    hintText: "search",
                                    border: OutlineInputBorder(),
                                    hintStyle: TextStyle(fontSize: 15),
                                    contentPadding: EdgeInsets.only(
                                        top: 0, bottom: 0, left: 20),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: (width_ / 4),
                                      alignment: Alignment.center,
                                      child: DropdownButton<dynamic>(
                                        value: addressValueCureent_,
                                        dropdownColor: colorBackgr,
                                        items: listAddRessYard_.map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e['idAddress_'],
                                            child: Text(e['nameAddress_']),
                                          );
                                        }).toList(),
                                        onChanged: (dynamic value) {
                                          setState(() {
                                            addressValueCureent_ = value!;
                                            searchValueCurrent_ =
                                                searchValue_.text;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: (width_ / 4),
                                      alignment: Alignment.center,
                                      child: DropdownButton<String>(
                                        value: statusValueCurrent_,
                                        dropdownColor: colorBackgr,
                                        items: listStatusYard_.map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e['idStatus_'],
                                            child: Text(e['nameStatus_']),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            statusValueCurrent_ = value!;
                                            searchValueCurrent_ =
                                                searchValue_.text;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: (width_ / 3),
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (searchValue_ != "" ||
                                              addressValueCureent_ != "" ||
                                              statusValueCurrent_ != "") {
                                            funcSearchYard(
                                                    searchValue_.text,
                                                    addressValueCureent_,
                                                    statusValueCurrent_)
                                                .then((data) {
                                              setState(() {
                                                print(data[0]);
                                                if (data[0]) {
                                                  listYard_ = data[1];
                                                } else {
                                                  errDesription_ = data[1];
                                                }
                                                checkRespone_ = data[0];
                                                searchValueCurrent_ =
                                                    searchValue_.text;
                                                // print(searchValue_.text);
                                              });
                                            });
                                          }
                                        },
                                        style: ButtonStyle(
                                            padding:
                                                WidgetStateProperty.all<EdgeInsets>(
                                                    const EdgeInsets.only(
                                                        left: 0,
                                                        right: 0,
                                                        top: 0,
                                                        bottom: 0)),
                                            backgroundColor:
                                                WidgetStatePropertyAll<Color>(
                                                    const Color.fromARGB(
                                                        88, 0, 0, 0)),
                                            shape: WidgetStateProperty.all(
                                                const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(Radius.circular(5))))),
                                        child: Text(
                                          "search",
                                          style: TextStyle(
                                            color: colorText,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 198, 194, 194),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 500,
                                    mainAxisExtent: 150,
                                    // childAspectRatio: 3/4,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            // shrinkWrap: true,
                            itemCount:
                                checkRespone_ == true ? listYard_.length : 1,
                            itemBuilder: (context, index) {
                              if (checkRespone_) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      width: 300,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: colorBackgr,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Text("Tên Sân :",
                                                          style: TextStyle(
                                                              fontSize: 15)),
                                                    )),
                                                Expanded(
                                                    flex: 6,
                                                    child: Container(
                                                      child: Text(
                                                          listYard_[index]
                                                              ['nameYard_'],
                                                          style: TextStyle(
                                                              fontSize: 15)),
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Text("Địa chỉ :",
                                                          style: TextStyle(
                                                              fontSize: 15)),
                                                    )),
                                                Expanded(
                                                    flex: 6,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                          listYard_[index]
                                                              ['addrestYard_'],
                                                          style: TextStyle(
                                                              fontSize: 15)),
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Text(
                                                          "Trạng thái :",
                                                          style: TextStyle(
                                                              fontSize: 15)),
                                                    )),
                                                Expanded(
                                                    flex: 6,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        listYard_[index]
                                                            ['statusYard_'],
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Container(
                                              child: Container(
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(top: 10),
                                            padding: EdgeInsets.only(
                                                left: 20, top: 0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    "/user/detail_yard",
                                                    arguments: listYard_[index]
                                                        ['id_']);
                                              },
                                              child: Text(
                                                "Chi tiết >>>",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: colorText),
                                              ),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 50),
                                  child: Text(
                                    errDesription_,
                                    style: TextStyle(
                                        fontSize: 15, color: colorText),
                                  ),
                                );
                              }
                            },
                          ),
                        )

                            // ],
                            )
                      ],
                    ),
                  ),
                  Positioned(bottom: 20, left: 0, child: Navbar())
                ]))));
  }
}
