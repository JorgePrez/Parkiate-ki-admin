
class ParkingHistory {
  final int id;
  final String name;
  final String amount;
  final String image;
  final String parkingId;
  final String date;
  final String time;
  final bool status;

  const ParkingHistory({this.id, this.name, this.amount, this.image, this.parkingId, this.date,
    this.time, this.status});

}

class ParkingHistoryList {
  static List<ParkingHistory> list() {
    const list = <ParkingHistory> [
      ParkingHistory(
        id: 1,
        name: 'Dhanmondi Lake',
        amount: '150',
        image: 'assets/images/parking_point/1.png',
        parkingId: 'V41WAZ',
        date: '18 jan - 2021',
        time: '12:00am - 02:00am',
        status: true
      ),
      ParkingHistory(
        id: 2,
        name: 'Sopno Kunjo',
          amount: '49',
          image: 'assets/images/parking_point/2.png',
          parkingId: 'SE2154',
          date: '14 dec - 2020',
          time: '4:00am - 9:00pm',
        status: false
      ),
      ParkingHistory(
        id: 3,
        name: 'Mahmuda Tower',
          amount: '149',
          image: 'assets/images/parking_point/3.png',
          parkingId: '548541W',
          date: '22 nov - 2020',
          time: '7:00am - 10:00am',
          status: false
      ),
      ParkingHistory(
          id: 4,
          name: 'Friends Tower',
          amount: '149',
          image: 'assets/images/parking_point/4.png',
          parkingId: '87890E',
          date: '30 oct - 2020',
          time: '10:00pm - 03:00am',
          status: false
      ),
      ParkingHistory(
          id: 5,
          name: 'Lovely Tower',
          amount: '149',
          image: 'assets/images/parking_point/5.png',
          parkingId: '65890E',
          date: '01 sep - 2020',
          time: '01:00am - 12:00am',
          status: false
      ),
      ParkingHistory(
          id: 6,
          name: 'Nobin Tower',
          amount: '149',
          image: 'assets/images/parking_point/3.png',
          parkingId: '45890E',
          date: '21 aug - 2020',
          time: '01:00pm - 08:00am',
          status: false
      ),
    ];
    return list;
  }
}