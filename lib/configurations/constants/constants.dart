// Global APP - specific constants

import 'package:reactive_forms/reactive_forms.dart';
import 'package:tatpar_orange/configurations/constants/fonts.gen.dart';

///Generate by running ```fluttergen``` in the terminal
export 'assets.gen.dart'; //Uncomment if assets are needed
export 'fonts.gen.dart';

const appName = 'Tatpar Orange';
const kFontFamily = FontFamily.montserrat;

const nikshaySetuLink =
    'https://play.google.com/store/apps/details?id=com.iiphg.tbapp';

const loginLink =
    'https://sso.nikshay.in/v1/sso/login?returnUrl=https://www.nikshay.in/Home&clientId=29';
const registerLink = 'https://www.nikshay.in/Home/UserFacility';

final workingStatusList = [
  'Referral',
  'TB Screening',
  'Mental Health Screening',
  'Diagnosis',
  'Treatment',
  'Outcome',
  'Contact Tracing',
];

const caseOutcomeList = [
  'Treatment Done',
  'Still Under Treatment',
  'Cured',
  'Relapse',
  'Transferred Out',
  'Lost to Follow-up',
  'Died',
  'Not Assessed',
  'Other',
];

const udstOptions = [
  'MTb Detected. RIF Sensitive',
  'MTb Detected. RIF Resistant',
  'MTb Detected. RIF Intermediate',
  'MTb Not Detected',
];

const ihvChecklistValues = [
  "It is mandatory to take adequate nutrition along with the medicine and do not consume any kind of intoxicant during treatment.",
  "Your medication will last for 6 months, don't skip the drug between that time and why: TB will go back on, TB worm won't go away, risk of MDR TB. By taking regular and complete courses, your disease will be cured from the root.",
  "Side effects, such as: urine turning orange, gas formation, vomiting, nausea.",
  "Explain adverse effects, such as difficulty in vision, blurred vision, jaundice, tingling in the leg. As soon as this happens, contact ASHA or Government Hospital.",
  "If you have to go somewhere during treatment, then you have to tell the ASHA / IIH worker, so that proper arrangements of medicine can be made.",
  "Cover your nose and mouth with a towel while coughing or sneezing, when a person affected by TB coughs / sneezes / speaks, the disease spreads through the drops coming out of his mouth or nose.",
  "The room/place in which the TB patient is staying should be ventilated, open and with adequate sunlight.",
  "If anyone around the family or home has fever/cough/swelling in any part of the body, contact the nearest health center/ASHA immediately.",
  "You may ever feel heavy or anxious during TB treatment, if this happens, please call the Nikshay contact 1800116666 and consult.",
  "Please be informed that tuberculosis (TB) diagnosis, treatment, and medication are provided free of charge at government hospitals. Refrain from paying any fees or responding to monetary demands during your treatment."
];

const ihvChecklistValuesHindi = [
  "दवा के साथ पर्याप्त पोषण लेना अनिवार्य है एवं इलाज के दौरान किसी भी तरह का मादक सेवन ना करें।",
  "आपका दवा 6 माह तक चलेगा, उस बीच दवा नहीं छोडनी है और क्यों: दोबारा TB हो जाएगा, TB का कीड़ा ख़त्म नहीं होगा, MDR TB होने का ख़तरा। नियमित एवं पूरा कोर्स लेने से आपकी बीमारी जड़ से ठीक हो जाएगी।",
  "साइड इफ़ेक्ट बताना, जैसे: पेशाब का रंग लाल/नारंगी होना, गैस बनना, उल्टी, जी मिचलाना।",
  "एडवर्स इफ़ेक्ट समझाना, जैसे देखने में दिक़्क़त, धुँधला दिखना, पीलिया/जॉन्डिस, पैर में झुनझुनी। ऐसा होते ही आशा या सरकारी अस्पताल से संपर्क करें।",
  "ईलाज के दौरान कहीं जाना हो तो आशा/IIH कार्यकर्ता को बता कर जाना है, ताकि दवा की समुचित व्यवस्था हो सके।",
  "खाँसते या छींकते समय अपनी नाक और मुँह को तौलिया/गमछा से ढक लें, जब टीबी से प्रभावित व्यक्ति खाँसता/छींकता/बोलता है तो उसके मुँह या नाक से निकली बूंदों द्वारा यह रोग फैलता है।",
  "जिस कमरे/जगह में टीबी रोगी रह रहा है वह स्थान हवादार, खुला एवं पर्याप्त सूरज की रोशनी वाला होना चाहिए।",
  "परिवार या घर के आसपास किन्ही को यदि बुखार/खांसी/शरीर के किसी अंग में गिल्टी/सूजन हो तो तुरंत नजदीकी स्वास्थ्य केंद्र/आशा से संपर्क करें।",
  "टीबी उपचार के दौरान आपको कभी मन-भारी या चिंता सता सकती है, यदि ऐसा होता है तो कृपया निक्षय संपर्क 1800116666 पर कॉल कर परामर्श लें।",
  "सरकार द्वारा टीबी का जाँच, इलाज और दवा सरकारी अस्पताल में नि:शुल्क उपलब्ध है आपके इलाज के दौरान किसी भी तरीके का पैसे कि माँग को ना माने।"
];

Map<String, ValidationMessageFunction> reactiveFormValidators(
        {String? label = 'Field', int? maxLength}) =>
    {
      ValidationMessage.required: (error) => 'The $label must not be empty',
      ValidationMessage.minLength: (error) =>
          'The $label must be at least ${maxLength ?? (error as Map)['requiredLength']} digits',
      ValidationMessage.maxLength: (error) =>
          'The $label must be above ${maxLength ?? (error as Map)['requiredLength']} digits',
      ValidationMessage.min: (error) =>
          'The $label must be at least ${(error as Map)['min']}',
      ValidationMessage.max: (error) =>
          'The $label must be below ${(error as Map)['max']}'
    };
