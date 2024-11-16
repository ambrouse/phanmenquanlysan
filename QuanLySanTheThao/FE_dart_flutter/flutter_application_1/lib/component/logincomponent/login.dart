
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dio = Dio();

Future<String> funcLogin(String nameLogin, String password) async{
  Response response;
  // response = await dio.get('http://192.168.100.6:9090/api/v1/home/user'); realphone
  try{
    response = await dio.put('http://10.0.2.2:9090/user/api/v1/login',
        data: {
          "loginName_":"test3456@gmail.com",
          "loginPassword_":"@2dHkkkkkkkkkkkkk"
        },
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'Authorization': ""
          }
        ));
    if(response.data['result_']['checkLogin_']){
      print("save");
      // final storage = new FlutterSecureStorage();
      // await storage.write(key: 'jwt_token_', value: response.data['result_']['token_']);
      //
      // print(await storage.read(key: "jwt_token_"));
      return "";
    }else{
      return response.data['result_']['desriptions_'];
    }
  }on DioException catch(e){
    return e.response?.data['result_'];
  }
}


class login extends StatefulWidget {
  String nofitication = "";
  bool checkLoginfate1 = false;
  bool checkLoginfate2 = false;

  // login(this.nofitication,{super.key});

  @override
  State<StatefulWidget> createState() {
    return loginSetting();
  }
}


class loginSetting extends State<login> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final TextEditingController emailOrPhoneValue_ = TextEditingController();
    final TextEditingController passwordValue_ = TextEditingController();
    // if(widget.checkLoginfate1){
    //   Navigator.pushNamed(context, "/user/home");
    // }
    @override
    void dispose() {
      emailOrPhoneValue_.dispose();
      passwordValue_.dispose();
      super.dispose();
    }

    return Scaffold(
      body: SafeArea(
          child: Container(
          height: height,
          width: width,
            color: Color.fromARGB(255, 217, 217, 217),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 50),
                        child:const Text(
                            "Trang đăng nhập",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 1, 1, 1),
                            ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              width: (width/1.2),
                              child: TextField(
                                controller: emailOrPhoneValue_,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 20),
                                  hintText: "Email or phone",
                                  hintStyle: TextStyle(
                                    fontSize: 15
                                  )
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: (width/1.2),
                              child:  TextField(
                                controller: passwordValue_,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.only(top: 1,bottom: 1,left: 20),
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        fontSize: 15
                                    )
                                ),
                              ),
                            ),
                            Container(
                              child: Text(widget.nofitication),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              width: (width/1.2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      onPressed: (){
                                        Navigator.pushNamed(context, "/user/sigup");
                                      },
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.only(
                                                  left: 40,right: 40,top: 0,bottom: 0
                                              )
                                          ),
                                        shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                          )
                                        )
                                      ),
                                      child: const Text(
                                        "Sigup",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black
                                        ),
                                      )
                                  ),
                                  ElevatedButton(
                                      onPressed: (){
                                        funcLogin(emailOrPhoneValue_.text, passwordValue_.text).then((data){
                                          setState(() {
                                            // widget.nofitication = data;
                                            print(data);
                                          });
                                        });
                                      },
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.only(
                                                  left: 40,right: 40,top: 0,bottom: 0
                                              )
                                          ),
                                          shape: MaterialStateProperty.all(
                                              const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              )
                                          )
                                      ),
                                      child: const Text(
                                        "Next",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black
                                        ),
                                      )
                                  )
                                ],
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Positioned(
                //   bottom: 20,
                //   left: 0,
                //   child: Navbar()
                //   )
          ],
        ),
      )),
    );
  }
}
