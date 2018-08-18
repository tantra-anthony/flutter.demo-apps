final List<Profile> demoProfiles = [
  Profile(
    photos: [
      'assets/photo_1.jpg',
      'assets/photo_2.jpg',
      'assets/photo_3.jpg',
      'assets/photo_4.jpg',
    ],
    name: 'Special Someone',
    bio: 'This is the person you need!',
  ),
  Profile(
    photos: [
      'assets/photo_4.jpg',
      'assets/photo_3.jpg',
      'assets/photo_2.jpg',
      'assets/photo_1.jpg',
    ],
    name: 'Gross Person',
    bio: 'Better swipe left...',
  ),
];

class Profile {
  final List<String> photos;
  final String name;
  final String bio;

  Profile({
    this.bio,
    this.name,
    this.photos
  });
}