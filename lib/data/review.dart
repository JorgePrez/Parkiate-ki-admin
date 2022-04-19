
class Review {
  final int id;
  final String image;
  final String title;
  final String subtitle;
  final String time;
  final String rating;

  const Review({this.image, this.id, this.title, this.subtitle, this.time, this.rating});

}

class ReviewList {
  static List<Review> list() {
    const list = <Review> [
      Review(
        id: 1,
        image: 'assets/images/user1.png',
        title: 'Monulas Keeow',
          subtitle: 'I would not miss it for the world. But if something else came up I would',
        time: '1 day ago',
        rating: '5'
      ),
      Review(
        id: 2,
          image: 'assets/images/user2.png',
        title: 'Jasmin Walla',
          subtitle: 'I would not miss it for the world. But if something else came up I would',
          time: '7 day ago',
          rating: '4'
      ),
      Review(
        id: 3,
          image: 'assets/images/user3.png',
        title: 'Rocky Zones',
          subtitle: 'I would not miss it for the world. But if something else came up I would',
          time: '1 month ago',
          rating: '5'
      ),
      Review(
        id: 4,
          image: 'assets/images/user4.png',
        title: 'Vicky James',
          subtitle: 'I would not miss it for the world. But if something else came up I would',
          time: '2 month ago',
          rating: '4'
      ),
    ];
    return list;
  }
}