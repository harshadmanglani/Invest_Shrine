import 'dart:isolate';
import 'dart:ui';

import 'package:MobileApp/shared/custom_expanded_tile.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class ISAFEPage extends StatefulWidget {
  @override
  _ISAFEPageState createState() => _ISAFEPageState();
}

class _ISAFEPageState extends State<ISAFEPage> {
  List<dynamic> FAQs = [
    {
      "question": "What is an iSAFE note?",
      "answer":
          '> “iSAFE” stands for India Simple Agreement for Future Equity. An investor makes cash investment in return for a convertible instrument. An iSAFE note is not a debt instrument, a founder friendly convertible security note, that is beneficial for both startups and investors. To comply with applicable Indian law, iSAFE note takes the legal form of compulsorily convertible preference shares (CCPS) which is convertible on occurrence of specified events.'
              .replaceAll('. ', '.\n\n> ')
    },
    {
      "question": "How will an investment in iSAFE happen?",
      "answer":
          '> The investor and the startup agree on the investment amount, mutually sign an iSAFE agreement and the investor sends the startup the investment amount post completion of applicable legal and secretarial formalities. An outstanding iSAFE note would be referenced on the company’s cap table like any other convertible security (such as a warrant or an option).'
              .replaceAll('. ', '.\n\n> ')
    },
    {
      "question": "To whom will the startup issue iSAFE notes?",
      "answer":
          "> iSAFE notes are to be issued by the start up in favour of the investors i.e. iSAFE note holders."
    },
    {
      "question":
          "What are the benefits to the startup of receiving the FIRST investment through an iSAFE note?⭐",
      "answer":
          """> First and foremost is the point with respect to valuations. Early stage bootstrapped companies (Start-ups) are generally either at Idea, MVP (Minimum Viable Product) or Very Early Revenue stage and hence it’s unfair to assign a valuation so early in the lifecycle. iSAFE notes do away with the need to state pre-money or post money valuation, as the equity in favour of iSAFE note holders is issued much later viz. at an equity pricing round, once the start-up has achieved some stable and sustainable revenues.
Secondly, In India, even at seed stage funding, Angel networks / VCs use big fat one sided agreements with entrepreneurs. iSAFE note intends to obviate the need of such long agreements viz. SHA (Share Holder Agreements).
1) No legal cost, template driven, simple 6 page agreement
2) Favourable terms for entrepreneurs
3) Quick closure of the first funding round, when funds are so essential and timing is very important"""
              .replaceAll('viz.', 'namely')
              .replaceAll('. ', '.\n\n> ')
    },
    {
      "question":
          "Why iSAFE notes should be preferred investment instruments in India?",
      "answer":
          "> An iSAFE is neither debt nor equity, and there is no interest accruing, (though for legal compliance purposes, iSAFE note carry a non-cumulative dividend @ 0.0001%). If the startup fails, whatever money they have left after discharging other liabilities, will be returned to investors/iSAFE note holders in preference over the equity shareholders until iSAFE note holders receive their investment amount. Such liability is on the company, not on the founder individually. A convertible note is debt, while an iSAFE note is a convertible security that is not debt."
              .replaceAll('viz.', 'namely')
              .replaceAll('. ', '.\n\n> ')
    },
    {
      "question": "When do iSAFE notes convert to equity shares?",
      "answer":
          "> iSAFE notes are automatically convertible into equity shares either on occurrence on specified liquidity events viz. next pricing / valuation round, dissolution, merger / acquisition etc., or at the end of 3 years from date of it’s issue, whichever is earlier."
              .replaceAll('viz.', 'namely')
              .replaceAll('. ', '.\n\n> ')
    },
    {
      "question":
          "Do iSAFE note holders have liquidity preference over Equity holders / Promoters / Founders?",
      "answer":
          "> Yes, iSAFE note holders have liquidity preference (to the extent of their invested capital), over Founders / Equity shareholders."
    },
    {
      "question":
          "Do FIRST iSAFE note holders have liquidity preference over subsequent iSafe note holders / investors?",
      "answer":
          "> First iSAFE note holders will have pari-passu rights with subsequent iSAFE note holders/investors."
    },
    {
      "question": "Can a startup issue iSAFE notes to subsequent investors?",
      "answer":
          "> For the same reasons mentioned in reply no 4, we recommend startups to keep issuing sequel iSAFE notes, post the first iSAFE note as necessary. It helps the startup in securing a rightfully deserved higher valuation subsequently in a PRICING round (where pre and post money valuations get discussed), when the startup has gained significant revenue / business traction, such that a fair valuation is possible."
              .replaceAll('viz.', 'namely')
              .replaceAll('. ', '.\n\n> '),
    },
    {
      "question":
          "How will the iSAFE note be reflected in the startup’s financials and will the company’s authorised & paid up capital go up by the amount of investment made under iSAFE notes?",
      "answer":
          "> Investment will be reflected as CCPS – Compulsorily Convertible Preference Shares in the financial statements. Yes, the authorised and paid up capital will have to be increased by the extent of investment made under iSAFE note."
              .replaceAll('viz.', 'namely')
              .replaceAll('. ', '.\n\n> '),
    }
  ];

  List<dynamic> downloads = [
    {
      "title": "iSAFE - Valuation Cap",
      "url":
          "https://www.100x.vc/static/documents/Sequel%20iSAFE%20-%20Valuation%20Cap.pdf"
    },
    {
      "title": "iSAFE - Discount",
      "url":
          "https://www.100x.vc/static/documents/Sequel%20iSAFE%20-%20Discount%2005072019.pdf"
    },
    {
      "title": "iSAFE - Valuation Cap with Discount",
      "url":
          "https://www.100x.vc/static/documents/Sequel%20iSAFE%20-%20Valuation%20Cap%20with%20Discount.pdf"
    },
    {
      "title": "iSAFE - Pro Rata Side Letter",
      "url":
          "https://www.100x.vc/static/documents/Sequel%20iSAFE%20-%20Pro%20Rata%20Side%20Letter.pdf"
    },
    {
      "title": "iSAFE - MFN",
      "url":
          "https://www.100x.vc/static/documents/Sequel%20iSAFE%20-%20Pro%20Rata%20Side%20Letter.pdf"
    },
  ];
  ReceivePort _port = ReceivePort();
  final Permission permission = Permission.storage;
  PermissionStatus _permissionStatus = PermissionStatus.undetermined;
  downloadFile(String url) async {
    if (_permissionStatus.isGranted)
      await FlutterDownloader.enqueue(
        url: url,
        savedDir: '/storage/emulated/0/',
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    else {
      _requestPermission();
    }
  }

  _requestPermission() async {
    print("in");
    if (_permissionStatus.isDenied || _permissionStatus.isUndetermined) {
      final status = await permission.request();
      setState(() {
        print(status);
        _permissionStatus = status;
        print(_permissionStatus);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print("just got in");
    print("about to go in");
    _requestPermission();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text("iSAFE - FAQs and docs",
                style: TextStyle(color: Colors.white))),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            // Padding(
            //   padding:
            //       const EdgeInsets.only(left: 15.0, right: 10, bottom: 5.0),
            //   child: Text(
            //       "SAFE notes were created by Y-Combinator as an alternative to the traditional investment process and have been adopted according to the Indian legal system as iSAFE notes by Mr. Sanjay Mehta and his team at 100X.VC"),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 5, bottom: 5.0),
              child: ExpandablePanel(
                theme: ExpandableThemeData(iconColor: Colors.black),
                header: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "FAQs",
                    style: textTheme.headline6,
                  ),
                ),
                collapsed: Container(height: 0, width: 0),
                expanded: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: questionAnswerWidget()),
              ),
            ),
            Divider(color: Colors.grey[300], thickness: 3),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 5.0),
              child: ExpandablePanel(
                theme: ExpandableThemeData(iconColor: Colors.black),
                header: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Downloads",
                    style: textTheme.headline6,
                  ),
                ),
                collapsed: Container(height: 0, width: 0),
                expanded: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: downloadWiget()),
              ),
            ),
          ],
        )),
      ),
    );
  }

  questionAnswerWidget() {
    return Column(
      children: <Widget>[
        for (var i = 0; i < FAQs.length; i++)
          CustomExpandedTile(
              title: FAQs[i]["question"],
              content: FAQs[i]["answer"],
              hasIcon: true,
              initallyExpanded: false),
      ],
    );
  }

  downloadWiget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (var i = 0; i < downloads.length; i++)
          downloadFileButton(downloads[i]["title"], downloads[i]["url"])
      ],
    );
  }

  downloadFileButton(String title, String url) {
    return FlatButton(
        onPressed: () async {
          await downloadFile(url);
        },
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 3, child: Text(title, style: TextStyle(fontSize: 17))),
            SizedBox(width: 5),
            Expanded(flex: 1, child: Icon(Icons.file_download, size: 25))
          ],
        ));
  }
}
