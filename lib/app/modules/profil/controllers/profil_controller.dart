import 'package:get/get.dart';
import 'package:faker/faker.dart';

class ProfilController extends GetxController {
  final faker = Faker();

  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString imageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    generateFakeData();
  }

  void generateFakeData() {
    name.value = faker.person.name();
    email.value = faker.internet.email();
    imageUrl.value = faker.image.loremPicsum(
      width: 100,
      height: 100,
    );
  }
}
