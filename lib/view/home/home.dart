import 'package:adopt_pet/view/history/history.dart';
import 'package:adopt_pet/view/home/bloc/home_bloc.dart';
import 'package:adopt_pet/view/home/home_elements.dart';
import 'package:adopt_pet/view/home/modals/animal_modal.dart';
import 'package:adopt_pet/view/home/widgets/animal_card_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();
  final TextEditingController searchTextFieldEditingController =
      TextEditingController();
  String categorySelected = "";
  List<AnimalModal> temp = [];
  int startIndex = 0;
  int endIndex = 3;
  int pageNumber = 1;

  @override
  void initState() {
    homeBloc.add(HomeIntialAnimalFetchEvent());
    // homeBloc.add(PageButtonTappedEvent(
    //     start: startIndex, end: endIndex, animalModal: temp));
    // searchTextFieldEditingController.addListener(() {
    //   if (searchTextFieldEditingController.text.isEmpty &&
    //       categorySelected == "") {
    //     print("hello");

    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    searchTextFieldEditingController.dispose();
    super.dispose();
  }

  void navigateToDetails(AnimalModal modal, List<AnimalModal> allAnimals) {
    Navigator.pushNamed(context, "/details",
        arguments: {"animalModal": modal, "all_animals": allAnimals});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      buildWhen: (previous, current) => current
          is! HomeActionState, //Build when there is an HomeState called (Not HomeActionState)
      listenWhen: (previous, current) => current
          is HomeActionState, //Listen when there is an HomeActionState is
      listener: (context, state) {
        if (state is HomeClassAnimalCardTapState) {
          print("--------------------------------------------");
          // print();
          navigateToDetails(state.animalModal, allAnimalModalsList);
        } else if (state is HomeClassCategoryTapState) {
          setState(() {
            categorySelected = state.categoryName;
            temp = state.animalModal;
            print(temp.length);
          });
        } else if (state is HomeClassAnimalSearchState) {
          print(state.list.length);
          List<AnimalModal> list = state.originalList;

          setState(() {
            if (state.list.isNotEmpty) {
              temp = state.list;
            } else {
              List<AnimalModal> modals = [];
              for (int i = 0; i <= 3; i++) {
                modals.add(allAnimalModalsList[i]);
              }
              temp = modals;
            }
          });
        } else if (state is HomeClassHistoryButtonTapState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => History(),
            ),
          );
        } else if (state is PageButtonTappedState) {
          setState(() {
            if (state.start < startIndex) {
              pageNumber -= 1;
              startIndex -= 4;
              endIndex -= 4;
            } else {
              pageNumber += 1;
              startIndex += 4;
              endIndex += 4;
            }
            temp = state.list;
          });
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeClassLodaingAnimalDataState:
            ThemeData themeData = Theme.of(context);
            return Scaffold(
              backgroundColor: themeData.colorScheme.background,
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeClassLoadingAnimalFailedState:
            ThemeData themeData = Theme.of(context);
            return Scaffold(
              backgroundColor: themeData.colorScheme.background,
              body: const Center(
                child: Text("Error"),
              ),
            );
          case HomeClassLoadingAnimalSuccessState:
            final successState = state as HomeClassLoadingAnimalSuccessState;
            ThemeData themeData = Theme.of(context);
            if (temp.isEmpty) {
              temp = successState.animalModal;
            }
            return SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Scaffold(
                  backgroundColor: themeData.colorScheme.background,
                  appBar: AppBar(
                    backgroundColor: themeData.colorScheme.background,
                    title: Text(
                      "Welcome!",
                      style: TextStyle(color: themeData.colorScheme.primary),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          onPressed: () =>
                              homeBloc.add(HomeClassHistoryButtonTapEvent()),
                          icon: Icon(Icons.history,
                              color: themeData.colorScheme.primary),
                          iconSize: 30,
                        ),
                      )
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: size.height * 0.07,
                          child: TextFormField(
                            style: TextStyle(
                              color: themeData.colorScheme.primary,
                            ),
                            controller: searchTextFieldEditingController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                List<AnimalModal> modals = [];
                                for (int i = 0; i <= 3; i++) {
                                  modals.add(allAnimalModalsList[i]);
                                }
                                setState(() {
                                  temp = modals;
                                  categorySelected = "";
                                });
                              } else {
                                homeBloc.add(
                                  SearchTextFieldClickedEvent(
                                    animalModal: state.allAnimals,
                                    searchText: value,
                                    categoryName: categorySelected,
                                  ),
                                );
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Search...",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.all(10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.grey),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.grey),
                              ),
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Categories",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: themeData.colorScheme.primary),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (categorySelected == "Dog") {
                                    setState(() {
                                      temp = state.animalModal;
                                      categorySelected = "";
                                    });
                                    // print(state.animalModal);
                                    // print("afdsdfsdfsdf");
                                  } else {
                                    homeBloc.add(
                                      CategoryButtonClickedEvent(
                                        animalModal: state.allAnimals,
                                        categoryName: "Dog",
                                      ),
                                      // setState();
                                    );
                                  }
                                },
                                child: SizedBox(
                                  height: 80,
                                  width: 50,
                                  child: Stack(
                                    fit: StackFit.loose,
                                    children: [
                                      AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        opacity:
                                            categorySelected == "Dog" ? 1 : 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.green[200],
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: SizedBox(
                                          height: 60,
                                          width: 40,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset("assets/dog.png"),
                                              Text(
                                                "Dog",
                                                style: TextStyle(
                                                  color:
                                                      categorySelected == "Dog"
                                                          ? Colors.black
                                                          : themeData
                                                              .colorScheme
                                                              .primary,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (categorySelected == "Cat") {
                                    setState(() {
                                      temp = state.animalModal;
                                      categorySelected = "";
                                    });
                                  } else {
                                    homeBloc.add(CategoryButtonClickedEvent(
                                        animalModal: state.allAnimals,
                                        categoryName: "Cat"));
                                  }
                                },
                                child: SizedBox(
                                  height: 80,
                                  width: 50,
                                  child: Stack(
                                    fit: StackFit.loose,
                                    children: [
                                      AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        opacity:
                                            categorySelected == "Cat" ? 1 : 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.green[200],
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: SizedBox(
                                          height: 60,
                                          width: 40,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset("assets/cat.png"),
                                              Text(
                                                "Cat",
                                                style: TextStyle(
                                                  color:
                                                      categorySelected == "Cat"
                                                          ? Colors.black
                                                          : themeData
                                                              .colorScheme
                                                              .primary,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (categorySelected == "Cow") {
                                    setState(() {
                                      temp = state.animalModal;
                                      categorySelected = "";
                                    });
                                  } else {
                                    homeBloc.add(CategoryButtonClickedEvent(
                                        animalModal: state.allAnimals,
                                        categoryName: "Cow"));
                                  }
                                },
                                child: SizedBox(
                                  height: 80,
                                  width: 50,
                                  child: Stack(
                                    fit: StackFit.loose,
                                    children: [
                                      AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        opacity:
                                            categorySelected == "Cow" ? 1 : 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.green[200],
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: SizedBox(
                                          height: 60,
                                          width: 40,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset("assets/cow.png"),
                                              Text(
                                                "Cow",
                                                style: TextStyle(
                                                  color:
                                                      categorySelected == "Cow"
                                                          ? Colors.black
                                                          : themeData
                                                              .colorScheme
                                                              .primary,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (categorySelected == "Fox") {
                                    setState(() {
                                      temp = state.animalModal;
                                      categorySelected = "";
                                    });
                                  } else {
                                    homeBloc.add(CategoryButtonClickedEvent(
                                        animalModal: state.allAnimals,
                                        categoryName: "Fox"));
                                  }
                                },
                                child: SizedBox(
                                  height: 80,
                                  width: 50,
                                  child: Stack(
                                    fit: StackFit.loose,
                                    children: [
                                      AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        opacity:
                                            categorySelected == "Fox" ? 1 : 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.green[200],
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: SizedBox(
                                          height: 60,
                                          width: 40,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset("assets/fox.png"),
                                              Text(
                                                "Fox",
                                                style: TextStyle(
                                                  color:
                                                      categorySelected == "Fox"
                                                          ? Colors.black
                                                          : themeData
                                                              .colorScheme
                                                              .primary,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: temp.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    homeBloc.add(AnimaleCardClickedEvent(
                                      allAnimals: successState.animalModal,
                                      animalModal: temp[index],
                                    ));
                                  },
                                  child: AnimalCardTile(
                                    animalModal: temp[index],
                                  ));
                            },
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          child: Visibility(
                            visible: categorySelected == "" ||
                                searchTextFieldEditingController.text == "",
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    double p = (temp.length / 4.0);
                                    if (pageNumber > 1) {
                                      homeBloc.add(PageButtonTappedEvent(
                                          start: startIndex - 4,
                                          end: endIndex - 4,
                                          animalModal:
                                              successState.allAnimals));
                                    }
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: themeData.colorScheme.primary,
                                  ),
                                ),
                                Text(
                                  pageNumber.toString(),
                                  style: TextStyle(
                                      color: themeData.colorScheme.primary),
                                ),
                                IconButton(
                                  onPressed: () {
                                    double p =
                                        (successState.allAnimals.length / 4.0);
                                    if (pageNumber < p.ceil()) {
                                      homeBloc.add(
                                        PageButtonTappedEvent(
                                            start: startIndex + 4,
                                            end: endIndex + 4,
                                            animalModal:
                                                successState.allAnimals),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: themeData.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
