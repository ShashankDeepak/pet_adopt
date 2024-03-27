import 'package:adopt_pet/view/home/bloc/home_bloc.dart';
import 'package:adopt_pet/view/home/modals/animal_modal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimalCardTile extends StatelessWidget {
  AnimalCardTile({super.key, required this.animalModal});
  final AnimalModal animalModal;
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: animalModal.image,
      // placeholder: (_, __) => const CircularProgressIndicator(),
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Hero(
                tag: animalModal.image,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imageProvider,
                      )),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        animalModal.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Age : ${animalModal.age}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 137, 137, 137)),
                          ),
                          animalModal.isAdopted
                              ? const Text(
                                  "Adopted",
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
