import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_scrapingg/kitap.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class KitapYurdu extends StatefulWidget {
  KitapYurdu({Key? key}) : super(key: key);

  @override
  State<KitapYurdu> createState() => _KitapYurduState();
}

class _KitapYurduState extends State<KitapYurdu> {
  var url = Uri.parse(
      "https://www.kitapyurdu.com/index.php?route=product/best_sellers&list_id=1&filter_in_stock=1&filter_in_stock=1&limit=100");
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
        .getElementsByClassName("product-grid")[0]
        .getElementsByClassName("product-cr")
        .forEach(
      (element) {
        setState(() {
          kitaplar.add(
            Kitap(
              image: element.children[3].children[0].children[0].children[0]
                  .attributes["src"]
                  .toString(),
              kitapAdi: element.children[4].text.toString(),
              yazarAdi: element.children[6].text.toString(),
              yayinEvi: element.children[5].text.toString(),
              fiyat: element.children[9].children[1].text.toString(),
              //link: element.children[10].children[1].text,
            ),
          );
        });
        setState(() {
          loading = false;
        });
      },
    );
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
        backgroundColor: CupertinoColors.activeBlue,
        title: Text("KitapYurdu Çok Satanlar"),
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
                    crossAxisSpacing: 10),
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
                                    child:
                                        Image.network(kitaplar[index].image)),
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
                            height: 10,
                          ),
                          Text(
                            kitaplar[index].kitapAdi,
                            style: _style,
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
                            kitaplar[index].fiyat + " TL",
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
