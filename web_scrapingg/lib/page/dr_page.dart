// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_scrapingg/kitap.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class Dr extends StatefulWidget {
  const Dr({super.key});

  @override
  State<Dr> createState() => _DrState();
}

class _DrState extends State<Dr> {
  var url = Uri.parse(
      "https://www.dr.com.tr/CokSatanlar/Kitap?Page=1&ShowNotForSale=false&SortOrder=1&SortType=0");
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
        .getElementsByClassName("facet__products-list js-facet-product-list")[0]
        .getElementsByClassName("prd-main-wrapper")
        .forEach((element) {
      setState(() {
        kitaplar.add(
          Kitap(
            image: element.children[0].children[0].children[0].children[0]
                .attributes["data-src"]
                .toString(),
            kitapAdi:
                element.children[1].children[0].children[0].text.toString(),
            yazarAdi: element.children[1].children[0].children[1].children[0]
                .children[0].text
                .toString(),
            yayinEvi: element.children[1].children[0].children[3].children[0]
                .children[0].text
                .toString(),
            fiyat: element.children[1].children[0].children[2].children[0]
                .children[0].text
                .toString(),
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
        title: Text("DR Çok Satanlar"),
        backgroundColor: CupertinoColors.activeOrange,
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
                          Expanded(
                            child: Text(
                              kitaplar[index].fiyat,
                              style: _style,
                            ),
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
