import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavbarSetting();
  }
}

class NavbarSetting extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return  Container(
      width: width,
      alignment: Alignment.center,
      child: Container(
        width: (width/2),
        decoration:const BoxDecoration(
          color: Color.fromARGB(255, 103, 101, 101),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "/user/login");
                  },
                  color: Colors.white,
                  icon: const Icon(Icons.shopping_cart_checkout_outlined)
              )
            ),
            Container(
                child: IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, "/user/home");
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.home_filled)
                )
            ),
            Container(
                child: IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, "/user/login");
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.account_box)
                )
            ),
          ],
        ),
      ),
    );
  }
}
