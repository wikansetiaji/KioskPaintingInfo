import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/language_provider.dart';
import 'package:provider/provider.dart';

class TranslatedString {
  final Map<AppLanguage, String> strings;

  TranslatedString({required this.strings});

  String text(BuildContext context) {
    return strings[context.watch<LanguageProvider>().language] ??
        strings[AppLanguage.en] ??
        strings.values.first;
  }
}

class PointOfInterest {
  final String id;
  final TranslatedString name;
  final TranslatedString description;
  final double x;
  final double y;
  bool showNudge = false;

  PointOfInterest({
    required this.id,
    required this.name,
    required this.description,
    required this.x,
    required this.y,
    this.showNudge = false,
  });
}

class FunFact {
  final TranslatedString title;
  final TranslatedString description;

  FunFact({required this.title, required this.description});
}

class PaintingRepository {
  static final PaintingRepository _singleton = PaintingRepository._internal();

  factory PaintingRepository() {
    return _singleton;
  }

  final List<PointOfInterest> pienemanPointOfInterests = [
    PointOfInterest(
      id: "pov",
      name: TranslatedString(strings: {AppLanguage.en: "Point of View"}),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Focused on the colonial perspective, portraying victory through Diponegoro's capture.",
          AppLanguage.id:
              "Difokuskan untuk kolonial yang menunjukkan kemenangannya lewat penangkapan Diponegoro",
        },
      ),
      x: 0.0817169189453125,
      y: 0.49489703757225434,
    ),
    PointOfInterest(
      id: "main_character",
      name: TranslatedString(strings: {AppLanguage.en: "Main Character Focus"}),
      description: TranslatedString(
        strings: {
          AppLanguage.en: "Highlights General De Kock as noble and calm.",
          AppLanguage.id:
              "Lukisan Nicolaas menonjolkan General De Kock yang digambarkan sebagai orang yang mulia dan tenang",
        },
      ),
      x: 0.5592193603515625,
      y: 0.4990234375,
    ),
    PointOfInterest(
      id: "viewer_position",
      name: TranslatedString(strings: {AppLanguage.en: "Viewer's Position"}),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "The perspective is from the Dutch colonial viewpoint.",
          AppLanguage.id: "Lukisan ini menempatkan diri pada Belanda",
        },
      ),
      x: 0.425921630859375,
      y: 0.47862287752890176,
    ),
    PointOfInterest(
      id: "diponegoro_posture",
      name: TranslatedString(strings: {AppLanguage.en: "Diponegoro's Posture"}),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Depicted as submissive, head bowed and hands lowered — a symbol of surrender.",
          AppLanguage.id:
              "Diponegoro digambarkan tunduk dengan Belanda yang digambarkan dengan kepala tertunduk serta tangan ke bawah yang berarti menyerah",
        },
      ),
      x: 0.5565155029296875,
      y: 0.5676481213872833,
    ),
    PointOfInterest(
      id: "de_kock_posture",
      name: TranslatedString(strings: {AppLanguage.en: "De Kock's Posture"}),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Taller, placed at the center of the composition — showing dominance.",
          AppLanguage.id:
              "Digambarkan lebih tinggi, dan berada di pusat komposisi lukisan",
        },
      ),
      x: 0.6402862548828125,
      y: 0.3479610729768786,
    ),
    PointOfInterest(
      id: "javanese_followers",
      name: TranslatedString(strings: {AppLanguage.en: "Javanese Followers"}),
      description: TranslatedString(
        strings: {
          AppLanguage.en: "Depicted as few in number and expressionless.",
          AppLanguage.id:
              "Digambarkan dengan jumlah yang sedikit dan tanpa ekspresi.",
        },
      ),
      x: 0.3455291748046875,
      y: 0.468433887283237,
    ),
    PointOfInterest(
      id: "dutch_figures",
      name: TranslatedString(
        strings: {AppLanguage.en: "Dutch Figures Depicted"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Heroic and authoritative, reinforcing Dutch superiority over Indonesia.",
          AppLanguage.id:
              "Gagah dan berwibawa, menunjukkan kekuasaan Belanda terhadap Indonesia",
        },
      ),
      x: 0.7018707275390625,
      y: 0.4705224891618497,
    ),
    PointOfInterest(
      id: "cultural_symbolism",
      name: TranslatedString(strings: {AppLanguage.en: "Cultural Symbolism"}),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Costumes are culturally inaccurate (resembling Arab attire), showing colonial neglect of local culture.",
          AppLanguage.id:
              "Busana kurang akurat, seperti Arab, menggambarkan budaya Indonesia yang sering diabaikan kolonialis",
        },
      ),
      x: 0.33896484375,
      y: 0.6253104678468208,
    ),
    PointOfInterest(
      id: "lighting_color",
      name: TranslatedString(strings: {AppLanguage.en: "Lighting & Color"}),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Neutral, flat, and orderly — conveying a peaceful surrender.",
          AppLanguage.id:
              "Netral, datar, teratur, menunjukkan penangkapan yang damai",
        },
      ),
      x: 0.1079833984375,
      y: 0.2452583092485549,
    ),
    PointOfInterest(
      id: "purpose",
      name: TranslatedString(strings: {AppLanguage.en: "Painting's Purpose"}),
      description: TranslatedString(
        strings: {
          AppLanguage.en: "Propaganda to present a peaceful conquest.",
          AppLanguage.id: "Propaganda untuk menunjukkan penaklukan damai",
        },
      ),
      x: 0.1772674560546875,
      y: 0.8066462698699421,
    ),
    PointOfInterest(
      id: "character_placement",
      name: TranslatedString(strings: {AppLanguage.en: "Character Placement"}),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Dutch figures are in the center — symbolizing control and authority.",
          AppLanguage.id:
              "Belanda berada di tengah yang menunjukkan bahwa Belanda memiliki pusat kuasa",
        },
      ),
      x: 0.4726165771484375,
      y: 0.533146676300578,
    ),
    PointOfInterest(
      id: "explicit_message",
      name: TranslatedString(strings: {AppLanguage.en: "Explicit Message"}),
      description: TranslatedString(
        strings: {
          AppLanguage.en: "A peaceful surrender with the Dutch as heroes.",
          AppLanguage.id:
              "Penyerahan damai dan menunjukkan bahwa Belanda sebagai pahlawan",
        },
      ),
      x: 0.189056396484375,
      y: 0.607246884031792,
    ),
    PointOfInterest(
      id: "implied_message",
      name: TranslatedString(strings: {AppLanguage.en: "Implied Message:"}),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Erases the fact that Diponegoro was deceived and arrested unfairly.",
          AppLanguage.id:
              "Menghapus fakta bahwa Diponegoro ditipu dan ditangkap dengan licik",
        },
      ),
      x: 0.5610260009765625,
      y: 0.7902366329479769,
    ),
  ];

  final List<PointOfInterest> salehPointOfInterests = [
    PointOfInterest(
      id: "pov",
      name: TranslatedString(
        strings: {AppLanguage.en: "Point of View"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Focused on the local (Javanese) perspective, showing resistance and betrayal during the arrest.",
          AppLanguage.id:
              "Difokuskan kepada orang lokal atau jawa, menunjukkan bahwa saat penangkapan Diponegoro ada perlawanan dan pengkhianatan",
        },
      ),
      x: 0.1427215576171875,
      y: 0.3453926571531792,
    ),
    PointOfInterest(
      id: "main_character",
      name: TranslatedString(
        strings: {AppLanguage.en: "Main Character Focus"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Highlights Prince Diponegoro as emotional yet dignified.",
          AppLanguage.id:
              "Lukisan Raden Saleh menonjolkan Pangeran Diponegoro yang digambarkan sebagai orang yang emosional dan bermartabat",
        },
      ),
      x: 0.3578399658203125,
      y: 0.3797416907514451,
    ),
    PointOfInterest(
      id: "viewer_position",
      name: TranslatedString(
        strings: {AppLanguage.en: "Viewer's Position"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "The perspective is from Diponegoro's and his followers' side.",
          AppLanguage.id:
              "Lukisan ini menempatkan diri pada Diponegoro dan orang-orangnya",
        },
      ),
      x: 0.6277496337890625,
      y: 0.6130667449421965,
    ),
    PointOfInterest(
      id: "diponegoro_posture",
      name: TranslatedString(
        strings: {AppLanguage.en: "Diponegoro's Posture"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Depicted with proud, honest, and emotional posture, shocked by the betrayal in the agreement.",
          AppLanguage.id:
              "Diponegoro digambarkan dengan postur yang bangga, jujur, dan emosional karena amarah atau terkejut yang dikarenakan oleh pengkhianatan Belanda dalam perjanjian mereka",
        },
      ),
      x: 0.3034942626953125,
      y: 0.3529680726156069,
    ),
    PointOfInterest(
      id: "de_kock_posture",
      name: TranslatedString(
        strings: {AppLanguage.en: "De Kock's Posture"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Smaller in scale, positioned on the left (symbolically weak in Javanese culture).",
          AppLanguage.id:
              "Postur lebih kecil dan berlokasi di sisi kiri (secara simbolis lemah dalam budaya Jawa), menunjukkan tidak dominan",
        },
      ),
      x: 0.40419921875,
      y: 0.32315751445086704,
    ),
    PointOfInterest(
      id: "javanese_followers",
      name: TranslatedString(
        strings: {AppLanguage.en: "Javanese Followers"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Shown emotionally expressive, crying, holding Diponegoro's hand — symbolizing humanity and solidarity.",
          AppLanguage.id:
              "Digambarkan banyak dan emosional, menangis memegang tangan Diponegoro yang ditangkap, memberikan sisi kemanusiaan dan solidaritas dari rakyat terhadap pahlawan mereka",
        },
      ),
      x: 0.3213897705078125,
      y: 0.508930184248555,
    ),
    PointOfInterest(
      id: "dutch_figures",
      name: TranslatedString(
        strings: {AppLanguage.en: "Dutch Figures Depicted"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Shown with large heads, stiff expressions, and sly looks — a subtle critique of colonial power.",
          AppLanguage.id:
              "Kepala besar, ekspresi kaku, dan terlihat licik yang secara halus sedang mengkritik kolonialisme melalui bentuk tubuh dan ekspresi wajah.",
        },
      ),
      x: 0.1437103271484375,
      y: 0.3441564306358382,
    ),
    PointOfInterest(
      id: "cultural_symbolism",
      name: TranslatedString(
        strings: {AppLanguage.en: "Cultural Symbolism"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Diponegoro wears blangkon, batik, and tasbih — highlighting Javanese and Islamic identity.",
          AppLanguage.id:
              "Diponegoro menggunakan blangkon, batik, dan tasbih yang sangat menggambarkan Jawa dan Islam, menekankan identitas budaya lokal Indonesia.",
        },
      ),
      x: 0.764678955078125,
      y: 0.5661014270231214,
    ),
    PointOfInterest(
      id: "lighting_color",
      name: TranslatedString(
        strings: {AppLanguage.en: "Lighting & Color"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Strong contrast between light and dark; spotlight on Diponegoro emphasizes suffering and inner conflict.",
          AppLanguage.id:
              "Gelap-terang kontras, sorot ke Diponegoro menonjolkan penderitaan dan konflik batin Diponegoro.",
        },
      ),
      x: 0.866357421875,
      y: 0.28325392882947975,
    ),
    PointOfInterest(
      id: "purpose",
      name: TranslatedString(
        strings: {AppLanguage.en: "Painting's Purpose"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en: "A subtle critique of colonialism.",
          AppLanguage.id: "Kritik terselubung terhadap kolonialisme.",
        },
      ),
      x: 0.1894927978515625,
      y: 0.7304913294797688,
    ),
    PointOfInterest(
      id: "character_placement",
      name: TranslatedString(
        strings: {AppLanguage.en: "Character Placement"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Dutch figures on the left, Indonesians in the center — symbolizing Dutch weakness (in Javanese terms).",
          AppLanguage.id:
              "Belanda di kiri dan Indonesia di tengah, menunjukkan posisi lemah menurut simbolisme Jawa",
        },
      ),
      x: 0.2567474365234375,
      y: 0.7352781791907514,
    ),
    PointOfInterest(
      id: "explicit_message",
      name: TranslatedString(
        strings: {AppLanguage.en: "Explicit Message"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en: "An emotional arrest and betrayal.",
          AppLanguage.id: "Penangkapan penuh emosi dan pnegkhianatan",
        },
      ),
      x: 0.473004150390625,
      y: 0.6617876174132948,
    ),
    PointOfInterest(
      id: "implied_message",
      name: TranslatedString(
        strings: {AppLanguage.en: "Implied Message"},
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "An early form of nationalism — uplifting Indonesian dignity through symbols and composition.",
          AppLanguage.id:
              "Bentuk awal nasionalisme–mengangkat harga diri bangsa secara halus melalui simbol dan lukisan",
        },
      ),
      x: 0.325970458984375,
      y: 0.7865731123554913,
    ),
  ];

  final List<FunFact> pienemanFunFacts = [
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "A European Perspective on the Java War",
          AppLanguage.id: "Perspektif Eropa terhadap Perang Jawa",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Nicolaas Pieneman never visited the Dutch East Indies, yet he was commissioned by King Willem III to commemorate the 'end' of the Java War through this iconic painting.",
          AppLanguage.id:
              "Nicolaas Pieneman tidak pernah mengunjungi Hindia Belanda, namun ia mendapat komisi dari Raja Willem III untuk memperingati 'berakhirnya' Perang Jawa melalui lukisan ikonik ini.",
        },
      ),
    ),
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "An Honorable Surrender",
          AppLanguage.id: "Penyerahan yang Terhormat",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "In contrast to later interpretations, Pieneman depicted Diponegoro as calmly and honorably surrendering — a sign of mutual respect and 'civilized diplomacy' according to 19th-century Dutch ideals.",
          AppLanguage.id:
              "Berbeda dengan interpretasi masa kini, Pieneman menggambarkan Pangeran Diponegoro menyerah dengan tenang dan terhormat — mencerminkan rasa saling menghormati dan 'diplomasi beradab' menurut pandangan Belanda abad ke-19.",
        },
      ),
    ),
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "Propaganda with Paint",
          AppLanguage.id: "Propaganda Lewat Kuas",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "The painting was used to justify Dutch colonial authority, portraying De Kock as a composed and firm military leader who peacefully resolved rebellion.",
          AppLanguage.id:
              "Lukisan ini digunakan untuk membenarkan otoritas kolonial Belanda, dengan menampilkan De Kock sebagai pemimpin militer yang tenang dan tegas dalam meredam pemberontakan secara damai.",
        },
      ),
    ),
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "Painted 22 Years After the Event",
          AppLanguage.id: "Dilukis 22 Tahun Setelah Peristiwa",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Completed in 1857, the painting was created over two decades after the actual arrest of Diponegoro in 1830 — based entirely on second-hand sources and imagination.",
          AppLanguage.id:
              "Diselesaikan pada tahun 1857, lukisan ini dibuat lebih dari dua dekade setelah penangkapan asli Pangeran Diponegoro pada tahun 1830 — seluruhnya berdasarkan sumber sekunder dan imajinasi.",
        },
      ),
    ),
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "Visual Symbolism of Control",
          AppLanguage.id: "Simbol Visual Kekuasaan",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Diponegoro is shown standing with lowered posture, while De Kock sits confidently — a clear symbol of power dynamics, meant to show Dutch control over the native elite.",
          AppLanguage.id:
              "Diponegoro digambarkan berdiri dengan postur merunduk, sementara De Kock duduk dengan percaya diri — simbol yang jelas dari dinamika kekuasaan, dimaksudkan untuk menunjukkan dominasi Belanda atas elite pribumi.",
        },
      ),
    ),
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "A Royal Commission",
          AppLanguage.id: "Komisi Kerajaan",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "The painting was commissioned by the Dutch monarchy as part of a series of colonial representations to glorify the Netherlands' overseas governance.",
          AppLanguage.id:
              "Lukisan ini dipesan oleh pihak kerajaan Belanda sebagai bagian dari rangkaian representasi kolonial untuk mengagungkan kekuasaan Belanda di wilayah jajahan.",
        },
      ),
    ),
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "Displayed at Paleis Noordeinde",
          AppLanguage.id: "Dipajang di Paleis Noordeinde",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Originally hung at the Royal Palace in The Hague, the painting was meant to impress visiting dignitaries and reflect the supposed 'success' of the Dutch civilizing mission.",
          AppLanguage.id:
              "Awalnya dipajang di Istana Kerajaan Den Haag, lukisan ini dimaksudkan untuk mengesankan para tamu kehormatan dan mencerminkan apa yang disebut sebagai 'keberhasilan' misi peradaban Belanda.",
        },
      ),
    ),
  ];

  List<FunFact> salehFunFacts = [
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "The Masterpiece of a Maestro: Raden Saleh",
          AppLanguage.id: "Karya Sang Maestro: Raden Saleh",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "The painting 'The Arrest of Prince Diponegoro' was created by Raden Saleh in 1857, shortly after his return from Europe. It has become a significant symbol in the history of Indonesian fine art.",
          AppLanguage.id:
              "Lukisan 'Penangkapan Pangeran Diponegoro' dibuat oleh Raden Saleh pada tahun 1857, usai kepulangannya dari Eropa. Karya ini menjadi simbol penting dalam sejarah seni lukis Indonesia.",
        },
      ),
    ),
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "Romanticism in Every Stroke",
          AppLanguage.id: "Romantisme dalam Goresan",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "This artwork emphasizes emotional and dramatic tones characteristic of European Romanticism, bringing the historical moment to life and evoking deep emotional responses from viewers.",
          AppLanguage.id:
              "Gaya lukisan ini menonjolkan nuansa emosional dan dramatis khas Romantisme Eropa, menjadikan peristiwa sejarah terasa hidup dan menggugah perasaan penonton.",
        },
      ),
    ),
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "A Response: Countering Pieneman's Narrative",
          AppLanguage.id: "Sebuah Tanggapan: Kontra Narasi Lukisan Pieneman",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Raden Saleh painted this piece as a direct response to Nicolaas Pieneman's depiction. While Pieneman showed Prince Diponegoro surrendering, Saleh highlighted the prince's courage and dignity.",
          AppLanguage.id:
              "Raden Saleh menciptakan lukisan ini sebagai bentuk respons terhadap karya Nicolaas Pieneman. Jika Pieneman menggambarkan Pangeran Diponegoro menyerah, Raden Saleh menegaskan keberanian dan martabat sang pahlawan.",
        },
      ),
    ),
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "A Symbol of Anti-Colonial Resistance",
          AppLanguage.id: "Simbol Perlawanan Kolonial",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "More than a historical record, this painting is a political statement. Raden Saleh portrayed Diponegoro as a brave figure standing against colonial injustice.",
          AppLanguage.id:
              "Tidak sekadar dokumentasi sejarah, lukisan ini adalah pernyataan politik. Raden Saleh menempatkan Diponegoro sebagai tokoh pemberani yang melawan ketidakadilan kolonial.",
        },
      ),
    ),
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "Dignity Unbowed",
          AppLanguage.id: "Martabat yang Tak Tertunduk",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "The composition and expression in this painting suggest that Prince Diponegoro did not surrender willingly, but was instead captured by force — a powerful message of resistance.",
          AppLanguage.id:
              "Komposisi dan ekspresi dalam lukisan ini menyiratkan bahwa Pangeran Diponegoro tidak menyerah secara sukarela, melainkan ditangkap secara paksa. Ini adalah pesan perlawanan yang kuat.",
        },
      ),
    ),
    FunFact(
      title: TranslatedString(
        strings: {
          AppLanguage.en: "From the Netherlands Back to the Homeland",
          AppLanguage.id: "Dari Belanda Kembali ke Ibu Pertiwi",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "After spending more than a century in the Netherlands, the painting was finally returned to Indonesia in 1975 as part of a cultural agreement between the two nations.",
          AppLanguage.id:
              "Setelah lebih dari satu abad berada di Belanda, lukisan ini akhirnya diserahkan kepada Indonesia pada tahun 1975 sebagai bagian dari perjanjian kebudayaan.",
        },
      ),
    ),
  ];

  double? getPOIPairCenterX(String id) {
    PointOfInterest salehPOI = salehPointOfInterests.firstWhere(
      (poi) => poi.id == id,
    );
    PointOfInterest pienemanPOI = pienemanPointOfInterests.firstWhere(
      (poi) => poi.id == id,
    );
    if (salehPOI.x > pienemanPOI.x) {
      return null;
    }
    return (salehPOI.x + pienemanPOI.x) / 2;
  }

  PaintingRepository._internal();
}
