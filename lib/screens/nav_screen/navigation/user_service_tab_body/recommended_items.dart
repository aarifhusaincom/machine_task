import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/category_model.dart';
import '../../../../models/product_model.dart';
import '../../../../services/firestore_service.dart';
import '../../../../widgets/button_small.dart';

class RecommendedItems extends StatelessWidget {
  const RecommendedItems({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService _service = FirestoreService();
    return ListView(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("See more",
                  style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.labelMedium)
                      ?.copyWith(
                    color: const Color(0xFFFFAF00),
                    fontWeight: FontWeight.w600,
                  ))
            ]),
        const SizedBox(
          height: 16,
        ),
        FutureBuilder<List<CategoryModel>>(
            future: _service.getCategories(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final categories = snapshot.data!;
              return SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    ...categories.map((category) {
                      return _itemCard(context,
                          title: category.name, imgUrl: category.imageUrl);
                    }),
                    // _itemCard(
                    //   context,
                    //   title: "Beauty",
                    //   index: 1,
                    // ),
                    // _itemCard(
                    //   context,
                    //   title: "Offers",
                    //   index: 2,
                    // ),
                    // _itemCard(
                    //   context,
                    //   title: "Fashion",
                    //   index: 3,
                    // ),
                    // _itemCard(
                    //   context,
                    //   title: "Home",
                    //   index: 4,
                    // ),
                    // _itemCard(
                    //   context,
                    //   title: "Shirt",
                    //   index: 5,
                    // ),
                    // _itemCard(
                    //   context,
                    //   title: "Bag",
                    //   index: 6,
                    // ),
                    // _itemCard(
                    //   context,
                    //   title: "Dress",
                    //   index: 7,
                    // ),
                    // _itemCard(
                    //   context,
                    //   title: "Mobiles",
                    //   index: 8,
                    // ),
                  ],
                ),
              );
            }),
        const SizedBox(
          height: 16,
        ),
        FutureBuilder<List<ProductModel>>(
            future: _service.getProducts(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final products = snapshot.data!;

              return SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...products.map((product) {
                      return _bigItemCard(context,
                          title: product.name, imgUrl: product.imageUrl);
                    }),
                    // _bigItemCard(
                    //   context,
                    //   title: "Multi Kit",
                    //   index: 1,
                    // ),
                    // _bigItemCard(
                    //   context,
                    //   title: "Lipstick",
                    //   index: 2,
                    // ),
                  ],
                ),
              );
            })
      ],
    );
  }

  Widget _itemCard(BuildContext context,
      {String? imgUrl, String? title, int? index}) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    // final screenHeight = screenSize.height;
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: (screenWidth - 80) / 4,
        decoration: BoxDecoration(
          // color: const Color(0xFFF7E5D1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // border: Border.all(
                  //   color: const Color(0xFFFFF4DB),
                  //   width: 1,
                  // )
                  //
                ),
                height: 48,
                width: 48,
                child: CachedNetworkImage(
                  imageUrl: imgUrl!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Image.asset(
                    fit: BoxFit.cover,
                    "assets/images/img.png",
                  ),
                )

                // Image.asset('assets/images/img.png'),

                ),
            Text(
              title ?? "title",
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: const Color(0xFF000000),
                      fontSize: 10,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// big item
  Widget _bigItemCard(BuildContext context,
      {String? imgUrl, String? title, int? index}) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    // final screenHeight = screenSize.height;
    return InkWell(
      onTap: () {},
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: 16),
        width: (screenWidth - 56) / 2,
        decoration: BoxDecoration(
          // color: const Color(0xFFF7E5D1),
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(
          //   color: const Color(0xFFDADADA),
          //   width: 1,
          // )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Stack(children: [
              Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    // border: Border.all(
                    //   color: const Color(0xFFFFF4DB),
                    //   width: 1,
                    // )
                    //
                  ),
                  // height: double.infinity,
                  // height: 200,
                  // width: 105,
                  child: SizedBox(
                    height: 120,
                    child: CachedNetworkImage(
                      imageUrl: imgUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Image.asset(
                        fit: BoxFit.cover,
                        "assets/images/img.png",
                      ),
                    ),
                  )

                  // Image.asset(
                  //   'assets/images/big$index.png',
                  // ),
                  ),
              Positioned(
                  top: 6,
                  left: 6,
                  child: SvgPicture.asset('assets/icons/favorite.svg')),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title ?? "title",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          textStyle:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: const Color(0xFF000000),
                                  ),
                        ),
                      ),
                      const ButtonSmall(
                        label: "Add",
                      )
                    ],
                  ),

                  /// price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$500",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          textStyle:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: const Color(0xFF000000),
                                  ),
                        ),
                      ),
                    ],
                  ),

                  /// rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          // color: ColorConstant.moyoOrangeFade,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Text(
                          "⭐ 4.6",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF000000),
                                  ),
                        ),
                      ),
                      Text(
                        "86 Reviews",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          textStyle:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                      SvgPicture.asset("assets/icons/more-vertical.svg")
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
