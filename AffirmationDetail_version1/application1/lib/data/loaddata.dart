import '../domain/affirmation.dart';
import 'AppConstant.dart';

List<Affirmation> loaddata() {
  return List.generate(10, (index) {
    return Affirmation(
      image: AppConstant.photos[index],
      desc: AppConstant.affirmations[index],
    );
  });
}
