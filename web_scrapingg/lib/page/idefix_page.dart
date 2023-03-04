// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_scrapingg/kitap.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class Idefix extends StatefulWidget {
  const Idefix({super.key});

  @override
  State<Idefix> createState() => _IdefixState();
}

class _IdefixState extends State<Idefix> {
  var url =
      Uri.parse("https://www.idefix.com/kategori/Kitap/Edebiyat/grupno=00055");
  List<Kitap> kitaplar = [];
  bool loading = false;
  Future getData() async {
    setState(() {
      loading = true;
    });
    var res = await http.get(url);
    final body = res.body;
    final document = parser.parse(body);
    var response = document
        .getElementsByClassName(
            "no-margin productListNewBox boxes books clearfix")[0]
        .getElementsByClassName("cart-product-box-view")
        .forEach((element) {
      setState(() {
        kitaplar.add(
          Kitap(
            image: element
                .children[1].children[0].children[0].attributes["data-src"]
                .toString(),
            kitapAdi:
                element.children[2].children[2].children[0].text.toString(),
            yazarAdi: element.children[2].children[3].text.toString(),
            yayinEvi: element.children[2].children[5].text.toString(),
            fiyat: element.children[2].children[6].children[0].text.toString(),
          ),
        );
      });
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.activeGreen,
        title: Text("Idefix Çok Satanlar"),
      ),
      body: loading
          // ignore: prefer_const_constructors
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : SafeArea(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),

                // ignore: prefer_const_constructors
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.46,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: kitaplar.length,
                itemBuilder: (context, index) => InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 6,
                    color: Color.fromARGB(221, 234, 237, 237),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Image.network(kitaplar[index].image),
                                )),
                              ),
                              /*
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  index.toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                              */
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 20,
                            child: Text(
                              kitaplar[index].kitapAdi,
                              style: _style,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            kitaplar[index].yazarAdi,
                            style: _style,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            kitaplar[index].yayinEvi,
                            style: _style,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            kitaplar[index].fiyat,
                            style: _style,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  TextStyle _style = TextStyle(color: Colors.black87, fontSize: 15);
}
