import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatefulWidget {
  final VenturePortfolioModel searchResults;
  final String searchQuery;
  SearchResults({this.searchResults, this.searchQuery});
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  VenturePortfolioModel searchResults;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
