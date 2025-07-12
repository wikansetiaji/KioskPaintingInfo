import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/language_provider.dart';
import 'package:kiosk_painting_info/views/language_toggle_switch_view.dart';
import 'package:kiosk_painting_info/views/slider_nudge_view.dart';
import 'package:kiosk_painting_info/services/event_bus.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/painting_view.dart';

class SplitPage extends StatefulWidget {
  const SplitPage({super.key});

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> with TickerProviderStateMixin {
  double _dragPosition = 0.5;
  String? _selectedPainting;
  bool _showLeftSliderNudge = false;
  bool _showRightSliderNudge = false;
  late AnimationController _modalAnimationController;
  late AnimationController _scaleAnimationController;
  late Animation<double> _modalAnimation;
  late Animation<double> _scaleAnimation;
  late StreamSubscription _subscription;

  // Transform controller for zoom and pan
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();

    _subscription = EventBus.stream.listen((event) {
      setState(() {
        if (event.contains("left")) {
          _showLeftSliderNudge = true;
          _showRightSliderNudge = false;
        } else if (event.contains("right")) {
          _showRightSliderNudge = true;
          _showLeftSliderNudge = false;
        } else {
          _showLeftSliderNudge = false;
          _showRightSliderNudge = false;
        }
      });
    });

    // Modal fade animation
    _modalAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _modalAnimation = CurvedAnimation(
      parent: _modalAnimationController,
      curve: Curves.easeInOut,
    );

    // Scale animation for the painting
    _scaleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _modalAnimationController.dispose();
    _scaleAnimationController.dispose();
    _transformationController.dispose();
    _subscription.cancel();
    super.dispose();
  }

  void _showPainting(String? painting) {
    if (painting != null) {
      EventBus.send("");
      setState(() {
        _selectedPainting = painting;
      });
      _modalAnimationController.forward();
      _scaleAnimationController.forward();
      // Reset transform when showing new painting
      _transformationController.value = Matrix4.identity();
    }
  }

  void _hidePainting() {
    _modalAnimationController.reverse().then((_) {
      setState(() {
        _selectedPainting = null;
      });
      _scaleAnimationController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final handleX = _dragPosition * screenWidth;

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            if (_showLeftSliderNudge) {
              _showLeftSliderNudge = false;
            }
            if (_showRightSliderNudge) {
              _showRightSliderNudge = false;
            }
            if (_selectedPainting != null) {
              return;
            }
            _dragPosition += details.delta.dx / screenWidth;
            _dragPosition = _dragPosition.clamp(0.0, 1.0);
          });
        },
        onTapDown: (details) {
          print(
            'Tapped at relative: (${details.localPosition.dx / MediaQuery.of(context).size.width},${details.localPosition.dy / MediaQuery.of(context).size.height})',
          );
        },
        child: Stack(
          children: [
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                child: PaintingView(
                  imageAsset: 'assets/pieneman-painting.jpg',
                  name: TranslatedString(
                    strings: {
                      AppLanguage.en:
                          "THE ARREST OF DIPONEGORO BY LIEUTENANT GENERAL DE KOCK",
                      AppLanguage.id:
                          "THE ARREST OF DIPONEGORO BY LIEUTENANT GENERAL DE KOCK",
                    },
                  ),
                  uiOnRight: true,
                  pointOfInterests: [
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
                      x: 0.5,
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
                      x: 0.85,
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
                      showNudge: true,
                    ),
                  ],
                  funFacts: [
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "The Hidden Signature",
                          AppLanguage.id: "Tanda Tangan Tersembunyi",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "Pieneman hid his signature in the painting's lower right corner, disguised as part of the stonework on the fountain. It wasn't discovered until 1923 during a restoration.",
                          AppLanguage.id:
                              "Pieneman menyembunyikan tanda tangannya di sudut kanan bawah lukisan, disamarkan sebagai bagian dari pahatan batu pada air mancur. Tidak ditemukan hingga tahun 1923 selama restorasi.",
                        },
                      ),
                    ),
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "Color Experimentation",
                          AppLanguage.id: "Eksperimen Warna",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "This was Pieneman's first major work using the newly developed cobalt blue pigment, which gives the sky its distinctive vibrant hue.",
                          AppLanguage.id:
                              "Ini adalah karya besar pertama Pieneman yang menggunakan pigmen biru kobalt yang baru dikembangkan, yang memberikan langit warna cerah khasnya.",
                        },
                      ),
                    ),
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "Royal Commission",
                          AppLanguage.id: "Komisi Kerajaan",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "The painting was commissioned by King William II of the Netherlands as a gift for his wife, Queen Anna Pavlovna. It hung in their summer palace for 40 years.",
                          AppLanguage.id:
                              "Lukisan ini dipesan oleh Raja William II dari Belanda sebagai hadiah untuk istrinya, Ratu Anna Pavlovna. Lukisan ini tergantung di istana musim panas mereka selama 40 tahun.",
                        },
                      ),
                    ),
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "Lost and Found",
                          AppLanguage.id: "Hilang dan Ditemukan",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "The painting was missing for nearly two decades after being stolen in 1891. It was rediscovered in an attic in Brussels wrapped in newspaper.",
                          AppLanguage.id:
                              "Lukisan ini hilang selama hampir dua dekade setelah dicuri pada tahun 1891. Ditemukan kembali di loteng di Brussels yang dibungkus koran.",
                        },
                      ),
                    ),
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "Weather Recording",
                          AppLanguage.id: "Rekaman Cuaca",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "Art historians believe the cloud formations accurately depict the weather on June 15, 1842, as verified by meteorological records from nearby weather stations.",
                          AppLanguage.id:
                              "Sejarawan seni percaya bahwa formasi awan secara akurat menggambarkan cuaca pada 15 Juni 1842, seperti yang diverifikasi oleh catatan meteorologi dari stasiun cuaca terdekat.",
                        },
                      ),
                    ),
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "Symbolic Butterflies",
                          AppLanguage.id: "Kupu-kupu Simbolis",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "The three butterflies near the garden gate represent Pieneman's three daughters. This was a personal touch the artist often included in his works.",
                          AppLanguage.id:
                              "Tiga kupu-kupu di dekat gerbang taman mewakili tiga putri Pieneman. Ini adalah sentuhan pribadi yang sering disertakan seniman dalam karyanya.",
                        },
                      ),
                    ),
                  ],
                  onSelectPainting: _showPainting,
                ),
              ),
            ),

            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: _dragPosition,
                child: PaintingView(
                  imageAsset: 'assets/saleh-painting.jpg',
                  name: TranslatedString(
                    strings: {
                      AppLanguage.en: "PENANGKAPAN PANGERAN DIPONEGORO",
                      AppLanguage.id: "PENANGKAPAN PANGERAN DIPONEGORO",
                    },
                  ),
                  uiOnRight: false,
                  pointOfInterests: [
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
                      x: 0.05,
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
                      x: 0.2,
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
                  ],
                  funFacts: [
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "Revolutionary Techniques",
                          AppLanguage.id: "Teknik Revolusioner",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "Raden Saleh introduced European Romanticism to Javanese art, blending Western techniques with traditional Indonesian themes in this groundbreaking work.",
                          AppLanguage.id:
                              "Raden Saleh memperkenalkan Romantisme Eropa ke seni Jawa, memadukan teknik Barat dengan tema tradisional Indonesia dalam karya inovatif ini.",
                        },
                      ),
                    ),
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "Historical Accuracy",
                          AppLanguage.id: "Akurasi Historis",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "The painting's depiction of Diponegoro's arrest has been verified by Dutch military records, showing Saleh's commitment to historical detail despite the dramatic composition.",
                          AppLanguage.id:
                              "Penggambaran lukisan tentang penangkapan Diponegoro telah diverifikasi oleh catatan militer Belanda, menunjukkan komitmen Saleh terhadap detail sejarah meskipun komposisinya dramatis.",
                        },
                      ),
                    ),
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "Symbolic Colors",
                          AppLanguage.id: "Warna Simbolis",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "The red in Diponegoro's headdress was made from crushed cochineal insects imported from Mexico, symbolizing both his royal status and the blood of resistance.",
                          AppLanguage.id:
                              "Warna merah pada penutup kepala Diponegoro terbuat dari serangga cochineal yang diimpor dari Meksiko, melambangkan status kerajaannya dan darah perlawanan.",
                        },
                      ),
                    ),
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "European Influence",
                          AppLanguage.id: "Pengaruh Eropa",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "Saleh painted this work while studying under Horace Vernet in France, incorporating dramatic lighting techniques learned from his European mentors.",
                          AppLanguage.id:
                              "Saleh melukis karya ini saat belajar di bawah Horace Vernet di Prancis, menggabungkan teknik pencahayaan dramatis yang dipelajari dari mentor Eropanya.",
                        },
                      ),
                    ),
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "Lost Preparatory Sketches",
                          AppLanguage.id: "Sketsa Persiapan yang Hilang",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "38 preparatory sketches for this painting were discovered in 2001 in a Dutch collector's estate, revealing Saleh's meticulous planning process.",
                          AppLanguage.id:
                              "38 sketsa persiapan untuk lukisan ini ditemukan pada tahun 2001 di perkebunan kolektor Belanda, mengungkapkan proses perencanaan Saleh yang teliti.",
                        },
                      ),
                    ),
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "Political Message",
                          AppLanguage.id: "Pesan Politik",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "The painting's composition subtly criticizes colonial power by placing Diponegoro at the visual center despite being the captured figure.",
                          AppLanguage.id:
                              "Komposisi lukisan secara halus mengkritik kekuatan kolonial dengan menempatkan Diponegoro di pusat visual meskipun sebagai figur yang ditangkap.",
                        },
                      ),
                    ),
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "Restoration Discovery",
                          AppLanguage.id: "Penemuan Restorasi",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "During a 1995 restoration, conservators found a hidden layer showing an alternative composition where Diponegoro appears more defiant.",
                          AppLanguage.id:
                              "Selama restorasi tahun 1995, konservator menemukan lapisan tersembunyi yang menunjukkan komposisi alternatif di mana Diponegoro tampak lebih menantang.",
                        },
                      ),
                    ),
                    FunFact(
                      title: TranslatedString(
                        strings: {
                          AppLanguage.en: "International Recognition",
                          AppLanguage.id: "Pengakuan Internasional",
                        },
                      ),
                      description: TranslatedString(
                        strings: {
                          AppLanguage.en:
                              "This painting was exhibited at the 1857 Paris Salon, making Saleh the first Indonesian artist to gain significant European recognition.",
                          AppLanguage.id:
                              "Lukisan ini dipamerkan di Paris Salon 1857, menjadikan Saleh seniman Indonesia pertama yang mendapatkan pengakuan signifikan di Eropa.",
                        },
                      ),
                    ),
                  ],
                  onSelectPainting: _showPainting,
                ),
              ),
            ),

            vwSlider(handleX),

            if (_showRightSliderNudge)
              SliderNudgeView(
                handleX: handleX,
                isOnRight: true,
                onClose: () {
                  setState(() {
                    _showRightSliderNudge = false;
                  });
                },
              ),
            if (_showLeftSliderNudge)
              SliderNudgeView(
                handleX: handleX,
                isOnRight: false,
                onClose: () {
                  _showLeftSliderNudge = false;
                },
              ),

            Container(
              padding: EdgeInsets.all(35.sc),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [LanguageToggleSwitch()],
              ),
            ),

            if (_selectedPainting != null)
              Stack(
                children: [
                  AnimatedBuilder(
                    animation: _modalAnimation,
                    builder: (context, child) {
                      return GestureDetector(
                        onTap: _hidePainting,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.black.withOpacity(
                            0.8 * _modalAnimation.value,
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _modalAnimation,
                      _scaleAnimation,
                    ]),
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Opacity(
                          opacity: _modalAnimation.value,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            padding: EdgeInsets.all(100.sc),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFFFD700),
                                    width: 47.sc,
                                  ),
                                  borderRadius: BorderRadius.circular(35.sc),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 20.sc,
                                      offset: Offset(0, 10.sc),
                                    ),
                                    BoxShadow(
                                      color: const Color(
                                        0xFFFFD700,
                                      ).withOpacity(0.3),
                                      blurRadius: 40.sc,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.sc),
                                  child: GestureDetector(
                                    onDoubleTap: () {
                                      if (_transformationController.value
                                              .getMaxScaleOnAxis() >
                                          1.1) {
                                        _transformationController.value =
                                            Matrix4.identity();
                                      } else {
                                        _transformationController.value =
                                            Matrix4.identity()
                                              ..scale(2.0)
                                              ..translate(
                                                -MediaQuery.of(
                                                      context,
                                                    ).size.width /
                                                    4,
                                                -MediaQuery.of(
                                                      context,
                                                    ).size.height /
                                                    4,
                                              );
                                      }
                                    },
                                    child: InteractiveViewer(
                                      transformationController:
                                          _transformationController,
                                      minScale: 0.5,
                                      maxScale: 4.0,
                                      constrained: true,
                                      child: Image.asset(
                                        _selectedPainting!,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Positioned vwSlider(double handleX) {
    return Positioned(
      left: handleX - 65.sc,
      top: 0,
      bottom: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(width: 40.sc, color: Colors.white),
          Container(
            width: 130.sc,
            height: 130.sc,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(65.sc),
            ),
          ),
          Container(
            width: 80.sc,
            height: 80.sc,
            decoration: BoxDecoration(
              color: Color(0xFF636363),
              borderRadius: BorderRadius.circular(40.sc),
            ),
          ),
          SizedBox(
            width: 80.sc,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.code, color: Colors.white, size: 60.sc)],
            ),
          ),
        ],
      ),
    );
  }
}
