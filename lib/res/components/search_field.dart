import 'package:flutter/material.dart';
import 'package:movie_app/res/color.dart';
import 'package:provider/provider.dart';
import '../../view_model/Serach_Bar_Provider.dart';
import '../size_config.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<SearchBarProvider>(builder: (context, isSearch, _) {
      return isSearch.isSearching
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
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      prefixIcon: const Icon(
                        Icons.search_sharp,
                        color: AppColors.greyColor,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Search',
                      suffixIcon: isSearch.isSearching
                          ? Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                backgroundColor: AppColors.greyColor,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: AppColors.whiteColor,
                                  ),
                                  iconSize: 9,
                                  onPressed: () {
                                    isSearch.stopSearching();
                                    _searchController.clear();
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
                      isSearch.setSearchQuery(value);
                    },
                  ),
                ),
                SizedBox(
                  child: TextButton(
                    onPressed: () {
                      isSearch.stopSearching();
                      _searchController.clear();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppColors.greyColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ]),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  isSearch.startSearching();
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_sharp,
                          color: AppColors.greyColor,
                        ),
                        Text(
                          "Search",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyColor,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
