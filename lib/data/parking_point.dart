
class ParkingPoint {
  final int id;
  final String name;
  final String amount;
  final String image;
  final String address;
  final String distance;

  const ParkingPoint({this.id, this.name, this.amount, this.image, this.address, this.distance});

}

class ParkingPointList {
  static List<ParkingPoint> list() {
    const list = <ParkingPoint> [
      ParkingPoint(
        id: 1,
        name: 'Ridge Park',
        amount: '56',
        image: 'assets/images/parking_point/1.png',
        address: 'House # 60 , Sector #12, Road# 20, Dhaka-1230',
        distance: '8'
      ),
      ParkingPoint(
        id: 2,
        name: 'Sonargao Road',
          amount: '49',
          image: 'assets/images/parking_point/2.png',
          address: 'House # 46 , Sector #3, Road# 2, Dhaka-1230',
          distance: '9'
      ),
      ParkingPoint(
        id: 3,
        name: 'Nawab Street',
          amount: '69',
          image: 'assets/images/parking_point/3.png',
          address: 'House # 35 , Sector #9, Road# 10, Dhaka-1230',
          distance: '4'
      ),
      ParkingPoint(
          id: 4,
          name: 'Friends Tower',
          amount: '40',
          image: 'assets/images/parking_point/4.png',
          address: 'House # 52 , Sector #3, Road# 36, Dhaka-1230',
          distance: '5'
      ),
      ParkingPoint(
          id: 5,
          name: 'Nobin Tower',
          amount: '39',
          image: 'assets/images/parking_point/5.png',
          address: 'House # 63 , Sector #7, Road# 45, Dhaka-1230',
          distance: '3'
      ),
      ParkingPoint(
          id: 6,
          name: 'King Plaza',
          amount: '50',
          image: 'assets/images/parking_point/1.png',
          address: 'House # 52 , Sector #11, Road# 12, Dhaka-1230',
          distance: '12'
      ),
    ];
    return list;
  }
}