import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:amazon_app/adaptive/components_adaptive.dart';
import 'package:amazon_app/layout/home_provider.dart';
import 'package:amazon_app/models/products_model.dart';
import 'package:amazon_app/modules/product_details/detials.dart';
import 'package:amazon_app/shared/components/components.dart';
import 'package:amazon_app/shared/components/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

class InterHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<HomeProvider>(context, listen: true).selectedCat != null
        ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Builder(builder: (context) {
                  dynamic selItem =
                      Provider.of<HomeProvider>(context, listen: true)
                          .selectedCat;
                  if (selItem != null) {
                    context.read<HomeProvider>().getProducts(selItem);
                  }
                  return DropdownButton<String>(
                    alignment: AlignmentDirectional.topCenter,
                    isExpanded: true,
                    elevation: 0,
                    items: Provider.of<HomeProvider>(context, listen: true)
                        .categories
                        .map((selectItem) {
                      return DropdownMenuItem<String>(
                        value: selectItem,
                        child: Text(
                          selectItem!,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      Provider.of<HomeProvider>(context, listen: false)
                          .changeCat(val!);
                      Provider.of<HomeProvider>(context, listen: false)
                          .getProducts(val);
                    },
                    value: selItem,
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: Provider.of<HomeProvider>(context).getProducts(
                        Provider.of<HomeProvider>(context, listen: true)
                            .selectedCat),
                    builder: (ctx, snap) {
                      if (snap.hasData) {
                        List<ProductsModel> products =
                            snap.data as List<ProductsModel>;
                        return ConditionalBuilder(
                          condition: products.isNotEmpty,
                          builder: (context) {
                            Provider.of<HomeProvider>(context, listen: false)
                                .getProducts(
                                    context.watch<HomeProvider>().selectedCat);
                            return Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) =>
                                      buildItem(products[index], context),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 20,
                                      ),
                                  itemCount: products.length),
                            );
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                      }
                      return const CircularProgressIndicator();
                    }),
              ],
            ),
          )
        : AdaptiveIndicator(getOs());
  }

  buildItem(ProductsModel productsBasedCategories, context) {
    return InkWell(
      onTap: () {
        navigateToWithReturn(context, ProductDetails(productsBasedCategories));
      },
      child: StreamBuilder<String?>(
          stream: linkStream,
          builder: (context, snapshot) {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 5, left: 5, bottom: 10),
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      // color: HexColor('e4dddd'),
                      color: HexColor('2f2f2f'),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)
                              ),
                              height: 150,
                              width: 150,
                              // width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                productsBasedCategories.image.toString(),
                                // fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 300,
                                  child: Text(
                                    productsBasedCategories.title.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              child: Text(
                            productsBasedCategories.description.toString(),
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white),
                          )),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    productsBasedCategories.rating!.rate.toString(),
                                    style: TextStyle(
                                        color:HexColor('ff9900'),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  RatingBar.builder(
                                    initialRating: productsBasedCategories.rating!.rate,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 18,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color:HexColor('ff9900'),
                                    ),
                                    onRatingUpdate: (rating1) {
                                      print(rating1);
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                productsBasedCategories.rating!.count.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),         
              ],
            );
          }),
    );
  }
}
