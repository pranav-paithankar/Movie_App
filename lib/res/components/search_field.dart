import 'package:flutter/material.dart';
import 'package:movie_app/res/color.dart';
import 'package:provider/provider.dart';

import '../../utils/size_config.dart';
import '../../view_model/Serach_Bar_Provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<SearchBarProvider>(builder: (context, _isSearch, _) {
      return _isSearch.isSearching
          ? Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(children: [
                Container(
                  width: SizeConfig.screenWidth * 0.70,
                  height: 40,
                  child: TextField(
                    textAlign: TextAlign.start,
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      prefixIcon: Icon(
                        Icons.search_sharp,
                        color: AppColors.greyColor,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Search',
                      suffixIcon: _isSearch.isSearching
                          ? Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                backgroundColor: AppColors.greyColor,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: AppColors.whiteColor,
                                  ),
                                  iconSize: 9,
                                  onPressed: () {
                                    _isSearch.Searching();
                                  },
                                ),
                              ),
                            )
                          : null,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(
                            12.0), // Set the border radius
                      ),
                    ),
                    onChanged: (value) {
                      _isSearch.Searching();
                    },
                  ),
                ),
                SizedBox(
                  child: TextButton(
                      onPressed: () {
                        _isSearch.Searching();
                      },
                      child: Text("Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppColors.greyColor,
                            fontSize: 18,
                          ))),
                )
              ]),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  _isSearch.Searching();
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(
                        12), // Adjust the radius as needed
                  ),
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.9,
                    height: SizeConfig.screenHeight * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_sharp,
                          color: AppColors.greyColor,
                        ),
                        Text("Search",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.greyColor,
                              fontSize: 16,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
