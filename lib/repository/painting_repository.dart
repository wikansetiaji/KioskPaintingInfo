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

  // Pieneman

  final List<PointOfInterest> pienemanPointOfInterests = [
    PointOfInterest(
      id: "1",
      name: TranslatedString(
        strings: {
          AppLanguage.en: "The Mysterious Garden Gateway",
          AppLanguage.id: "Gerbang Taman Misterius",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "This ornate archway leads to a secret garden where ancient roses bloom year-round. Legend says that lovers who pass through together will be blessed with eternal happiness and prosperity.",
          AppLanguage.id:
              "Gerbang lengkung yang indah ini mengarah ke taman rahasia tempat mawar kuno mekar sepanjang tahun. Legenda mengatakan bahwa pasangan yang melewatinya bersama akan diberkati kebahagiaan dan kemakmuran abadi.",
        },
      ),
      x: 0.7,
      y: 0.95,
    ),
    PointOfInterest(
      id: "2",
      name: TranslatedString(
        strings: {
          AppLanguage.en: "The Weathered Stone Fountain",
          AppLanguage.id: "Air Mancur Batu yang Lapuk",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Built in 1847, this fountain was once the centerpiece of the estate's main courtyard. The intricate carvings depict scenes from classical mythology, including the story of Persephone and her journey between worlds.",
          AppLanguage.id:
              "Dibangun pada tahun 1847, air mancur ini dulunya menjadi pusat halaman utama perkebunan. Ukiran rumitnya menggambarkan adegan dari mitologi klasik, termasuk kisah Persephone dan perjalanannya antara dunia.",
        },
      ),
      x: 0.85,
      y: 0.91,
    ),
    PointOfInterest(
      id: "3",
      name: TranslatedString(
        strings: {
          AppLanguage.en: "The Artist's Studio Window",
          AppLanguage.id: "Jendela Studio Seniman",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "From this very window, the renowned painter Elena Martinez created her famous series of landscape paintings. The natural light streaming through this opening inspired some of the most celebrated works of the 19th century.",
          AppLanguage.id:
              "Dari jendela inilah, pelukis terkenal Elena Martinez menciptakan seri lukisan pemandangannya yang terkenal. Cahaya alami yang mengalir melalui bukaan ini menginspirasi beberapa karya paling terkenal abad ke-19.",
        },
      ),
      x: 0.2,
      y: 0.5,
    ),
    PointOfInterest(
      id: "4",
      name: TranslatedString(
        strings: {
          AppLanguage.en: "The Ancient Oak Tree",
          AppLanguage.id: "Pohon Ek Kuno",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "This majestic oak tree has stood here for over 300 years, witnessing countless seasons and historical events. Local folklore claims that wishes made while touching its bark during the full moon will come true within a year.",
          AppLanguage.id:
              "Pohon ek megah ini telah berdiri di sini selama lebih dari 300 tahun, menyaksikan banyak musim dan peristiwa sejarah. Cerita rakyat setempat mengklaim bahwa keinginan yang dibuat sambil menyentuh kulitnya saat bulan purnama akan terkabul dalam setahun.",
        },
      ),
      x: 0.6,
      y: 0.4,
      showNudge: false,
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

  // Saleh
  List<PointOfInterest> salehPointOfInterests = [
    PointOfInterest(
      id: "1",
      name: TranslatedString(
        strings: {
          AppLanguage.en: "The Grand Ballroom Chandelier",
          AppLanguage.id: "Lampu Gantung Balai Utama",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "This magnificent crystal chandelier contains over 2,000 individual crystals, each hand-cut and carefully positioned. It was commissioned by the estate's original owner and took master craftsmen three years to complete.",
          AppLanguage.id:
              "Lampu gantung kristal megah ini berisi lebih dari 2.000 kristal individu, masing-masing dipotong dengan tangan dan diposisikan dengan hati-hati. Ini dipesan oleh pemilik asli perkebunan dan membutuhkan waktu tiga tahun untuk diselesaikan oleh pengrajin ahli.",
        },
      ),
      x: 0.4,
      y: 0.85,
    ),
    PointOfInterest(
      id: "2",
      name: TranslatedString(
        strings: {
          AppLanguage.en: "The Hidden Library Alcove",
          AppLanguage.id: "Ceruk Perpustakaan Tersembunyi",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Behind this seemingly ordinary bookshelf lies a secret reading nook where the estate's children would hide during their lessons. The alcove contains first-edition books dating back to the 1600s, including rare manuscripts and poetry collections.",
          AppLanguage.id:
              "Di balik rak buku yang tampaknya biasa ini terdapat sudut baca rahasia tempat anak-anak perkebunan bersembunyi selama pelajaran mereka. Ceruk ini berisi buku edisi pertama yang berasal dari tahun 1600-an, termasuk manuskrip langka dan koleksi puisi.",
        },
      ),
      x: 0.5,
      y: 0.7,
    ),
    PointOfInterest(
      id: "3",
      name: TranslatedString(
        strings: {
          AppLanguage.en: "The Marble Staircase Banister",
          AppLanguage.id: "Pegangan Tangga Marmer",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "Carved from a single piece of Carrara marble, this banister features intricate floral patterns that change subtly as they spiral upward. Each flower represents a different member of the founding family.",
          AppLanguage.id:
              "Dipahat dari satu potong marmer Carrara, pegangan tangga ini menampilkan pola bunga rumit yang berubah secara halus saat melingkar ke atas. Setiap bunga mewakili anggota berbeda dari keluarga pendiri.",
        },
      ),
      x: 0.8,
      y: 0.2,
    ),
    PointOfInterest(
      id: "4",
      name: TranslatedString(
        strings: {
          AppLanguage.en: "The Portrait Gallery Corner",
          AppLanguage.id: "Sudut Galeri Potret",
        },
      ),
      description: TranslatedString(
        strings: {
          AppLanguage.en:
              "This corner houses portraits of five generations of the estate's inhabitants. The paintings are arranged chronologically, telling the visual story of changing fashion, artistic styles, and family traditions across two centuries.",
          AppLanguage.id:
              "Sudut ini menampung potret lima generasi penghuni perkebunan. Lukisan-lukisan disusun secara kronologis, menceritakan kisah visual tentang perubahan mode, gaya seni, dan tradisi keluarga selama dua abad.",
        },
      ),
      x: 0.3,
      y: 0.3,
      showNudge: true,
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
    PointOfInterest salehPOI = salehPointOfInterests.firstWhere((poi) => poi.id == id);
    PointOfInterest pienemanPOI = pienemanPointOfInterests.firstWhere((poi) => poi.id == id);
    if (salehPOI.x > pienemanPOI.x) {
      return null;
    }
    return (salehPOI.x + pienemanPOI.x) / 2;
  }

  PaintingRepository._internal();
}
