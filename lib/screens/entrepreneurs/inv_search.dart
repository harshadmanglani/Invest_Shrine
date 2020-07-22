import 'package:MobileApp/screens/investors/investor_login.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';

class InvestorSearch extends StatefulWidget {
  @override
  _InvestorSearchState createState() => _InvestorSearchState();
}

class _InvestorSearchState extends State<InvestorSearch> {
  List<dynamic> industryImages = [
    {
      "industry": "Healthcare",
      "image": "assets/images/healthcare.png",
      "id": "SW5kdXN0cnlNb2RlbDo0"
    },
    {
      "industry": "Tech",
      "image": "assets/images/tech.png",
      "id": "SW5kdXN0cnlNb2RlbDox"
    },
    {
      "industry": "Travel",
      "image": "assets/images/travel.png",
      "id": "SW5kdXN0cnlNb2RlbDo1"
    },
    {
      "industry": "Fintech",
      "image": "assets/images/fintech.png",
      "id": "SW5kdXN0cnlNb2RlbDoy"
    },
    {
      "industry": "E-Commerce",
      "image": "assets/images/ecommerce.png",
      "id": "SW5kdXN0cnlNb2RlbDo2"
    },
    {
      "industry": "Food",
      "image": "assets/images/food.jpg",
      "id": "SW5kdXN0cnlNb2RlbDo5"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: loginMargin - 13, right: loginMargin - 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 25),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Search',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: ' for angels,\nVC Funds & private investors',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: TextField(
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: "Fuel innovation",
                            prefixIcon: Icon(
                              Icons.search,
                              size: 23,
                              color: navbarBackgroundColor,
                            )),
                        textInputAction: TextInputAction.go),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          icon: Icon(Icons.filter_list,
                              color: navbarBackgroundColor),
                          onPressed: () {}))
                ],
              ),
              SizedBox(height: 30),
              Text("By Industry",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/investor_portfolio_list',
                                  arguments: {
                                    'query': industryImages[index]["id"],
                                    'industry': industryImages[index]
                                        ["industry"]
                                  });
                            },
                            child: Card(
                              elevation: 4,
                              shape: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                width: 145,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            industryImages[index]["image"]),
                                        fit: BoxFit.contain)),
                                child: Align(
                                    alignment: FractionalOffset.bottomCenter,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20)),
                                                  color: Colors.black54),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2.0, left: 12.0),
                                                child: Text(
                                                    industryImages[index]
                                                        ["industry"],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              )),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ),
                    itemCount: industryImages.length),
              ),
              SizedBox(height: 40),
              /* Text("By Funding Goal",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Card(
                          child: Container(
                            width: 100,
                            child: Text("Healthcare"),
                          ),
                        ),
                    itemCount: 8),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
