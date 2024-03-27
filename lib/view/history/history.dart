import 'package:adopt_pet/view/history/bloc/history_bloc.dart';
import 'package:adopt_pet/view/history/history_functions.dart';
import 'package:adopt_pet/view/history/history_items.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final HistoryBloc historyBloc = HistoryBloc();
  @override
  void initState() {
    historyBloc.add(HistoryItemsFetchedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    var size = MediaQuery.sizeOf(context);
    return BlocConsumer<HistoryBloc, HistoryState>(
      bloc: historyBloc,
      buildWhen: (previous, current) => true,
      listener: (context, state) {
        if (state is HistoryItemsFetchedState) {
          print("hello");
          setState(() {
            adoptedAnimals = List.of(state.listOfAdoptedPet);
          });
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: themeData.colorScheme.background,
              iconTheme: IconThemeData(
                color: themeData.colorScheme.primary,
              ),
              title: Text(
                "History",
                style: TextStyle(color: themeData.colorScheme.primary),
              ),
              centerTitle: true,
            ),
            body: adoptedAnimals.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      itemCount: adoptedAnimals.length,
                      itemBuilder: (BuildContext context, int index) {
                        int i = adoptedAnimals.length - index - 1;
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: size.height * 0.14,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  child: CachedNetworkImage(
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                        ),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    imageUrl: adoptedAnimals[i].image,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        adoptedAnimals[i].name,
                                        style: TextStyle(
                                          color: themeData.colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "Age : ${adoptedAnimals[i].age}",
                                        style: TextStyle(
                                          color: themeData.colorScheme.primary,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "Species : ${adoptedAnimals[i].species}",
                                        style: TextStyle(
                                          color: themeData.colorScheme.primary,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Price : \$ ${adoptedAnimals[i].price}",
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              formatDate(
                                                  adoptedAnimals[i].date!),
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      "No animals adopted yet",
                      style: TextStyle(
                        fontSize: 20,
                        color: themeData.colorScheme.primary,
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
