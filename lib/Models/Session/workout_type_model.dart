class WorkoutType {
  final String imagePath;
  final String type;
  final List<HomeHeaderData> headerData;

  WorkoutType({
    required this.imagePath,
    required this.type,
    required this.headerData,
  });

  static final List<WorkoutType> types = [
    WorkoutType(
        imagePath: 'assets/icons/logo_outlined.svg',
        type: 'Recommended',
        headerData: [
          HomeHeaderData(
              title: 'Recommended',
              description:
                  'Allow us to find the correct trainer for you based on your goals and experience.',
              imagePath: 'assets/icons/logo.svg')
        ]),
    WorkoutType(
        imagePath: 'assets/images/workout/functional_training.svg',
        type: 'Functional Training',
        headerData: [
          HomeHeaderData(
              title: 'Functional Training',
              description:
                  'Training your body for regular movements that help you prepare for common situations encountered on your day to day.',
              imagePath: 'assets/images/workout/function_training_header.svg')
        ]),
    WorkoutType(
        imagePath: 'assets/images/workout/power_lifting.svg',
        type: 'Power Lifting',
        headerData: [
          HomeHeaderData(
              title: 'Power Lifting',
              description:
                  'Not for those faint of  heart.This focuses on you  becoming the strongest you can be by lifting as heavy as possible.',
              imagePath: 'assets/images/workout/powe_lifting_header.svg')
        ]),
    WorkoutType(
        imagePath: 'assets/images/workout/olympic_weightlifting.svg',
        type: 'Olympic Weightlifting',
        headerData: [
          HomeHeaderData(
              title: 'Olympic Weightlifting',
              description:
                  'Olympic style weightlifting that aims to have you lift as much weight as possible in a single lift.',
              imagePath:
                  'assets/images/workout/olympic_weightlifting_header.svg')
        ]),
    WorkoutType(
        imagePath: 'assets/images/workout/pilates.svg',
        type: 'Pilates',
        headerData: [
          HomeHeaderData(
              title: 'Pilates',
              description:
                  'Training to improve strength, flexibility, posture, and mental awareness. Usually involves special equipment. ',
              imagePath: 'assets/images/workout/pilates_header.svg')
        ]),
    WorkoutType(
        imagePath: 'assets/images/workout/mobility.svg',
        type: 'Mobility',
        headerData: [
          HomeHeaderData(
              title: 'Mobility',
              description:
                  "As the name suggests, this training aims to improve your body's full range of motion, helps prevent injury.",
              imagePath: 'assets/images/workout/mobility_header.svg')
        ]),
    WorkoutType(
        imagePath: 'assets/images/workout/boxing.svg',
        type: 'Boxing / MMA',
        headerData: [
          HomeHeaderData(
              title: 'Boxing / MMA',
              description:
                  "Combat sport that improves your resistance while teaching you the art of self defense. Great for burning calories.",
              imagePath: 'assets/images/workout/boxing_header.svg')
        ]),
    WorkoutType(
        imagePath: 'assets/images/workout/endurance.svg',
        type: 'Endurance',
        headerData: [
          HomeHeaderData(
              title: 'Endurance',
              description:
                  "This training aims to improve your heart's ability to endure more thus allowing you to train harder for longer.",
              imagePath: 'assets/images/workout/endurance_header.svg')
        ]),
    WorkoutType(
        imagePath: 'assets/images/workout/hiit.svg',
        type: 'H.I.I.T',
        headerData: [
          HomeHeaderData(
              title: 'H.I.I.T',
              description:
                  "High intensity interval training involves short intervals of intense workouts, followed by short periods of rest.",
              imagePath: 'assets/images/workout/hiit_header.svg')
        ]),
    WorkoutType(
        imagePath: 'assets/images/workout/natal.svg',
        type: 'Pre & Post Natal',
        headerData: [
          HomeHeaderData(
              title: 'Pre & Post Natal',
              description:
                  "Low impact training for expecting and/or new mothers that aims to help you stay active while taking care of that little one.",
              imagePath: 'assets/images/workout/pre_post_natal_header.svg')
        ]),
    WorkoutType(
        imagePath: 'assets/images/workout/swimming.svg',
        type: 'Swimming',
        headerData: [
          HomeHeaderData(
              title: 'Swimming',
              description:
                  "Water based full body workout that builds endurance and muscle while remaining low-impact. Need we say more?",
              imagePath: 'assets/images/workout/swimming_header.svg')
        ]),
    WorkoutType(
        imagePath: 'assets/images/workout/gymnastics.svg',
        type: 'Gymnastics',
        headerData: [
          HomeHeaderData(
              title: 'Gymnastics',
              description:
                  "Extremely demanding sports \ntraining that develops balance, strength, flexibility, agility, and coordination.",
              imagePath: 'assets/images/workout/gymnastics_header.svg')
        ]),
    WorkoutType(
        imagePath: 'assets/images/workout/strength.svg',
        type: 'Strength Training',
        headerData: [
          HomeHeaderData(
              title: 'Strength Training',
              description:
                  "Training that aims to improve overall strength and performance of your muscles while increasing resistance.",
              imagePath: 'assets/images/workout/strength_header.svg')
        ]),
  ];
}

class HomeHeaderData {
  final String title;
  final String description;
  final String imagePath;

  HomeHeaderData(
      {required this.title,
      required this.description,
      required this.imagePath});
}
