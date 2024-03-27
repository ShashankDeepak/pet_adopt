import 'package:adopt_pet/view/details/bloc/details_bloc.dart';
import 'package:adopt_pet/view/details/preview_image.dart';
import 'package:adopt_pet/view/home/modals/animal_modal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String adoptStatus = "Adopt Me";
  ConfettiController? _controllerCenter;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter!.dispose();
    super.dispose();
  }

  void showAlertDialog(BuildContext context, String name) {
    ThemeData themeData = Theme.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: ConfettiWidget(
          confettiController: _controllerCenter!,
          blastDirection: math.pi * 2,
          minBlastForce: 30,
          shouldLoop: true,
          maxBlastForce: 50,
          child: SizedBox(
            height: 80,
            child: Center(
              child: Text(
                "You've now adopted $name",
                style: TextStyle(
                  color: themeData.colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: themeData.colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final animalModal = arguments['animalModal'] as AnimalModal;
    final allAnimals = arguments['all_animals'] as List<AnimalModal>;
    ThemeData themeData = Theme.of(context);
    DetailsBloc detailsBloc = DetailsBloc();
    return BlocConsumer<DetailsBloc, DetailsState>(
      bloc: detailsBloc,
      listenWhen: (previous, current) => current is DetailsActionState,
      buildWhen: (previous, current) => current is! DetailsActionState,
      listener: (context, state) {
        if (state is DetailsPetAdoptedState) {
          print("Animal Adopted");
          setState(() {
            animalModal.isAdopted = true;
          });
          showAlertDialog(context, animalModal.name);
        } else if (state is AnimalImageClickState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PreviewImage(
                image: animalModal.image,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        var size = MediaQuery.sizeOf(context);
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: SizedBox(
              width: size.width,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: themeData.colorScheme.primary,
                          )),
                      width: size.width * 0.4,
                      height: 40,
                      child: Center(
                        child: Text(
                          "\$ ${animalModal.price}",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.green),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (!animalModal.isAdopted) {
                          detailsBloc.add(
                            DetailsPetAdoptedEvent(
                                animalModal: animalModal,
                                allAnimals: allAnimals),
                          );
                          _controllerCenter!.play();
                        } else {}
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: animalModal.isAdopted
                                  ? Colors.grey
                                  : themeData.colorScheme.primary,
                            )),
                        width: size.width * 0.4,
                        height: 40,
                        child: Center(
                          child: Text(
                            animalModal.isAdopted
                                ? "Already Adopted"
                                : "Adopte Me",
                            style: TextStyle(
                                fontSize: 18,
                                color: animalModal.isAdopted
                                    ? Colors.grey
                                    : themeData.colorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: animalModal.image,
                    child: GestureDetector(
                      onTap: () => detailsBloc.add(AnimalImageClickEvent()),
                      child: CachedNetworkImage(
                        imageUrl: animalModal.image,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: size.height * 0.3,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            animalModal.name,
                            style: TextStyle(
                              color: themeData.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          Text(
                            "Age : ${animalModal.age}",
                            style: TextStyle(
                              color: themeData.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          "About",
                          style: TextStyle(
                            color: themeData.colorScheme.primary,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "${animalModal.name} is a ${animalModal.species} of about age ${animalModal.age}",
                          style: TextStyle(
                            color: themeData.colorScheme.primary,
                            fontSize: 14,
                          ),
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
    );
  }
}
