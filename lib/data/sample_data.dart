import '../models/book.dart';
import '../models/loan.dart';
import '../models/app_notification.dart';

/// Static sample data used across the app (mock backend).
class SampleData {
  // ---- Member profile ----
  static const String memberName   = 'Budi Santoso';
  static const String memberLevel  = 'Anggota Premium';
  static const String memberId     = 'PD-2024-00817';
  static const String memberAvatar = 'assets/images/avatar.png';

  // ---- Categories ----
  static const List<String> categories = [
    'Fiksi',
    'Sains',
    'Bisnis',
    'Sejarah',
    'Motivasi',
  ];

  // ---- Books ----
  static const List<Book> books = [
    // ── Original 16 books ──────────────────────────────────────────────────
    Book(
      id: 'b1',
      title: 'Laskar Pelangi',
      author: 'Andrea Hirata',
      coverAsset: 'assets/covers/laskar_pelangi.png',
      category: 'Fiksi',
      rating: 4.8,
      year: 2005,
      pages: 529,
      publisher: 'Bentang Pustaka',
      synopsis:
          'Kisah inspiratif sepuluh anak dari keluarga miskin di Belitung yang '
          'berjuang menempuh pendidikan di tengah keterbatasan.',
      available: true,
    ),
    Book(
      id: 'b2',
      title: 'Filosofi Teras',
      author: 'Henry Manampiring',
      coverAsset: 'assets/covers/filosofi_teras.png',
      category: 'Motivasi',
      rating: 4.6,
      year: 2018,
      pages: 320,
      publisher: 'Kompas',
      synopsis:
          'Pengantar filsafat Stoa yang membantu mengelola emosi negatif dan '
          'hidup lebih tenang di tengah kekhawatiran modern.',
      available: true,
    ),
    Book(
      id: 'b3',
      title: 'Bumi Manusia',
      author: 'Pramoedya Ananta Toer',
      coverAsset: 'assets/covers/bumi_manusia.png',
      category: 'Fiksi',
      rating: 4.9,
      year: 1980,
      pages: 535,
      publisher: 'Lentera Dipantara',
      synopsis:
          'Roman epik tentang Minke, pemuda pribumi terpelajar di era kolonial, '
          'dan perlawanannya terhadap ketidakadilan.',
      available: true,
    ),
    Book(
      id: 'b4',
      title: 'Dilan 1990',
      author: 'Pidi Baiq',
      coverAsset: 'assets/covers/dilan_1990.png',
      category: 'Fiksi',
      rating: 4.4,
      year: 2014,
      pages: 332,
      publisher: 'Pastel Books',
      synopsis:
          'Kisah cinta remaja Dilan dan Milea di Bandung tahun 1990 yang '
          'penuh keunikan dan kehangatan.',
      available: false,
    ),
    Book(
      id: 'b5',
      title: 'Hujan',
      author: 'Tere Liye',
      coverAsset: 'assets/covers/hujan.png',
      category: 'Fiksi',
      rating: 4.5,
      year: 2016,
      pages: 320,
      publisher: 'Gramedia',
      synopsis:
          'Cerita tentang cinta, persahabatan, dan melupakan di tengah dunia '
          'yang berubah akibat bencana alam.',
      available: true,
    ),
    Book(
      id: 'b6',
      title: 'Pulang',
      author: 'Tere Liye',
      coverAsset: 'assets/covers/pulang.png',
      category: 'Fiksi',
      rating: 4.7,
      year: 2015,
      pages: 400,
      publisher: 'Republika',
      synopsis:
          'Perjalanan Bujang dari pedalaman Sumatra menuju dunia keras dalam '
          'sebuah keluarga penguasa shadow economy.',
      available: true,
    ),
    Book(
      id: 'b7',
      title: 'Negeri 5 Menara',
      author: 'Ahmad Fuadi',
      coverAsset: 'assets/covers/negeri_5_menara.png',
      category: 'Motivasi',
      rating: 4.6,
      year: 2009,
      pages: 423,
      publisher: 'Gramedia',
      synopsis:
          'Kisah Alif dan teman-temannya di pondok pesantren yang percaya pada '
          'kekuatan mantra "man jadda wajada".',
      available: true,
    ),
    Book(
      id: 'b8',
      title: 'Sapiens',
      author: 'Yuval Noah Harari',
      coverAsset: 'assets/covers/sapiens.png',
      category: 'Sejarah',
      rating: 4.7,
      year: 2011,
      pages: 498,
      publisher: 'KPG',
      synopsis:
          'Sejarah umat manusia sejak zaman prasejarah hingga era modern, '
          'ditelaah dari sudut pandang biologi, sosiologi, dan ekonomi.',
      available: true,
    ),
    Book(
      id: 'b9',
      title: 'Atomic Habits',
      author: 'James Clear',
      coverAsset: 'assets/covers/atomic_habits.png',
      category: 'Motivasi',
      rating: 4.8,
      year: 2018,
      pages: 319,
      publisher: 'Penguin Books',
      synopsis:
          'Panduan praktis membangun kebiasaan baik dan menghilangkan '
          'kebiasaan buruk melalui perubahan kecil yang konsisten.',
      available: true,
    ),
    Book(
      id: 'b10',
      title: 'Perahu Kertas',
      author: 'Dee Lestari',
      coverAsset: 'assets/covers/perahu_kertas.png',
      category: 'Fiksi',
      rating: 4.5,
      year: 2009,
      pages: 444,
      publisher: 'Bentang Pustaka',
      synopsis:
          'Kisah cinta Kugy dan Keenan yang bermimpi besar namun terhalang '
          'oleh realita dan keputusan hidup masing-masing.',
      available: false,
    ),
    Book(
      id: 'b11',
      title: 'Cosmos',
      author: 'Carl Sagan',
      coverAsset: 'assets/covers/cosmos.png',
      category: 'Sains',
      rating: 4.9,
      year: 1980,
      pages: 365,
      publisher: 'Random House',
      synopsis:
          'Eksplorasi megah semesta, sejarah sains, dan tempat manusia di '
          'alam raya yang tak terbatas.',
      available: true,
    ),
    Book(
      id: 'b12',
      title: 'Sejarah Singkat Waktu',
      author: 'Stephen Hawking',
      coverAsset: 'assets/covers/brief_history_time.png',
      category: 'Sains',
      rating: 4.6,
      year: 1988,
      pages: 212,
      publisher: 'Bantam Books',
      synopsis:
          'Perjalanan ke tepi fisika modern: lubang hitam, big bang, dan '
          'sifat dasar ruang dan waktu.',
      available: true,
    ),
    Book(
      id: 'b13',
      title: 'Homo Deus',
      author: 'Yuval Noah Harari',
      coverAsset: 'assets/covers/homo_deus.png',
      category: 'Sejarah',
      rating: 4.5,
      year: 2015,
      pages: 450,
      publisher: 'Harvill Secker',
      synopsis:
          'Menelaah ke mana arah perjalanan umat manusia di masa depan: '
          'antara keabadian, kebahagiaan, dan penciptaan dewa-dewa baru.',
      available: true,
    ),
    Book(
      id: 'b14',
      title: 'Rich Dad Poor Dad',
      author: 'Robert Kiyosaki',
      coverAsset: 'assets/covers/rich_dad.png',
      category: 'Bisnis',
      rating: 4.5,
      year: 1997,
      pages: 336,
      publisher: 'Warner Books',
      synopsis:
          'Pelajaran keuangan yang diajarkan oleh "ayah kaya" tentang aset, '
          'liabilitas, dan cara membangun kebebasan finansial.',
      available: true,
    ),
    Book(
      id: 'b15',
      title: 'Mariposa',
      author: 'Luluk HF',
      coverAsset: 'assets/covers/mariposa.png',
      category: 'Fiksi',
      rating: 4.3,
      year: 2018,
      pages: 360,
      publisher: 'Grasindo',
      synopsis:
          'Kisah cinta Acha yang jatuh hati pada Iqbal—cowok dingin dan '
          'populer di kampus—yang penuh rintangan dan kejutan.',
      available: true,
    ),
    Book(
      id: 'b16',
      title: 'Garis Waktu',
      author: 'Fiersa Besari',
      coverAsset: 'assets/covers/garis_waktu.png',
      category: 'Fiksi',
      rating: 4.4,
      year: 2016,
      pages: 250,
      publisher: 'Media Kita',
      synopsis:
          'Kumpulan puisi dan prosa yang mengisahkan perjalanan cinta, '
          'patah hati, dan bangkit kembali.',
      available: true,
    ),

    // ── 25 New Books ───────────────────────────────────────────────────────
    Book(
      id: 'b17',
      title: 'Harry Potter dan Batu Bertuah',
      author: 'J.K. Rowling',
      coverAsset: 'assets/covers/harry_potter.png',
      category: 'Fiksi',
      rating: 4.9,
      year: 1997,
      pages: 309,
      publisher: 'Gramedia',
      synopsis:
          'Seorang bocah yatim piatu bernama Harry Potter menemukan bahwa '
          'dirinya adalah seorang penyihir dan memulai petualangan ajaib di '
          'Hogwarts School of Witchcraft and Wizardry.',
      available: true,
    ),
    Book(
      id: 'b18',
      title: 'Sang Pemimpi',
      author: 'Andrea Hirata',
      coverAsset: 'assets/covers/sang_pemimpi.png',
      category: 'Fiksi',
      rating: 4.7,
      year: 2006,
      pages: 292,
      publisher: 'Bentang Pustaka',
      synopsis:
          'Kelanjutan kisah Laskar Pelangi; Ikal dan Arai bermimpi bersekolah '
          'di Eropa dan berjuang keras meraih impian dari Belitung yang terpencil.',
      available: true,
    ),
    Book(
      id: 'b19',
      title: 'Laut Bercerita',
      author: 'Leila S. Chudori',
      coverAsset: 'assets/covers/laut_bercerita.png',
      category: 'Fiksi',
      rating: 4.8,
      year: 2017,
      pages: 379,
      publisher: 'KPG',
      synopsis:
          'Novel berlatar era Reformasi 1998 tentang seorang mahasiswa '
          'aktivis yang diculik, dan keluarganya yang terus mencari kebenaran.',
      available: true,
    ),
    Book(
      id: 'b20',
      title: 'Koala Kumal',
      author: 'Raditya Dika',
      coverAsset: 'assets/covers/koala_kumal.png',
      category: 'Fiksi',
      rating: 4.2,
      year: 2015,
      pages: 228,
      publisher: 'Gagas Media',
      synopsis:
          'Kumpulan kisah lucu dan satir Raditya Dika tentang kehidupan, '
          'percintaan, dan persahabatan dengan gaya khasnya yang mengocok perut.',
      available: true,
    ),
    Book(
      id: 'b21',
      title: 'Ronggeng Dukuh Paruk',
      author: 'Ahmad Tohari',
      coverAsset: 'assets/covers/ronggeng_dukuh.png',
      category: 'Fiksi',
      rating: 4.7,
      year: 1982,
      pages: 400,
      publisher: 'Gramedia',
      synopsis:
          'Kisah tragis Srintil, seorang ronggeng di desa terpencil, yang '
          'terjebak antara tradisi, cinta, dan pergolakan politik Indonesia.',
      available: true,
    ),
    Book(
      id: 'b22',
      title: 'Sang Alkemis',
      author: 'Paulo Coelho',
      coverAsset: 'assets/covers/sang_alkemis.png',
      category: 'Motivasi',
      rating: 4.7,
      year: 1988,
      pages: 182,
      publisher: 'Gramedia',
      synopsis:
          'Perjalanan Santiago, seorang gembala Spanyol, mengejar mimpi '
          'menemukan harta karun dan makna sejati hidupnya.',
      available: true,
    ),
    Book(
      id: 'b23',
      title: '1984',
      author: 'George Orwell',
      coverAsset: 'assets/covers/1984.png',
      category: 'Fiksi',
      rating: 4.8,
      year: 1949,
      pages: 328,
      publisher: 'Secker & Warburg',
      synopsis:
          'Distopia klasik tentang Winston Smith yang hidup di bawah '
          'pengawasan total rezim totaliter "Big Brother" yang menguasai pikiran.',
      available: true,
    ),
    Book(
      id: 'b24',
      title: 'Membunuh Mockingbird',
      author: 'Harper Lee',
      coverAsset: 'assets/covers/to_kill_mockingbird.png',
      category: 'Fiksi',
      rating: 4.8,
      year: 1960,
      pages: 281,
      publisher: 'J.B. Lippincott',
      synopsis:
          'Melalui mata Scout Finch, novel ini mengisahkan perjuangan '
          'ayahnya membela pria kulit hitam yang dituduh secara tidak adil di Amerika Selatan.',
      available: true,
    ),
    Book(
      id: 'b25',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      coverAsset: 'assets/covers/great_gatsby.png',
      category: 'Fiksi',
      rating: 4.4,
      year: 1925,
      pages: 180,
      publisher: 'Scribner',
      synopsis:
          'Kisah Jay Gatsby yang kaya raya namun kesepian, mengejar cinta '
          'yang telah hilang di tengah kemewahan era Jazz Amerika tahun 1920-an.',
      available: false,
    ),
    Book(
      id: 'b26',
      title: '7 Kebiasaan Manusia yang Sangat Efektif',
      author: 'Stephen R. Covey',
      coverAsset: 'assets/covers/seven_habits.png',
      category: 'Motivasi',
      rating: 4.6,
      year: 1989,
      pages: 381,
      publisher: 'Free Press',
      synopsis:
          'Tujuh prinsip kepemimpinan diri yang telah mengubah jutaan orang: '
          'dari proaktif, visi, dan sinergi menuju pertumbuhan yang berkelanjutan.',
      available: true,
    ),
    Book(
      id: 'b27',
      title: 'Zero to One',
      author: 'Peter Thiel',
      coverAsset: 'assets/covers/zero_to_one.png',
      category: 'Bisnis',
      rating: 4.5,
      year: 2014,
      pages: 195,
      publisher: 'Crown Business',
      synopsis:
          'Peter Thiel berbagi rahasia membangun startup yang benar-benar '
          'inovatif: menciptakan sesuatu yang baru, bukan meniru yang sudah ada.',
      available: true,
    ),
    Book(
      id: 'b28',
      title: 'Start With Why',
      author: 'Simon Sinek',
      coverAsset: 'assets/covers/start_with_why.png',
      category: 'Bisnis',
      rating: 4.5,
      year: 2009,
      pages: 256,
      publisher: 'Portfolio',
      synopsis:
          'Mengapa ada pemimpin dan organisasi yang menginspirasi sementara '
          'yang lain tidak? Jawabannya ada pada "Mengapa" yang menjadi fondasi.',
      available: true,
    ),
    Book(
      id: 'b29',
      title: 'Deep Work',
      author: 'Cal Newport',
      coverAsset: 'assets/covers/deep_work.png',
      category: 'Motivasi',
      rating: 4.6,
      year: 2016,
      pages: 296,
      publisher: 'Grand Central Publishing',
      synopsis:
          'Argumen kuat untuk kemampuan fokus mendalam yang makin langka di '
          'era gangguan digital — dan cara melatihnya untuk sukses luar biasa.',
      available: true,
    ),
    Book(
      id: 'b30',
      title: 'Seni Perang',
      author: 'Sun Tzu',
      coverAsset: 'assets/covers/art_of_war.png',
      category: 'Sejarah',
      rating: 4.6,
      year: 500,
      pages: 112,
      publisher: 'Oxford University Press',
      synopsis:
          'Traktat militer kuno yang ajaran strateginya tetap relevan hingga '
          'hari ini, diterapkan dalam bisnis, olahraga, dan kepemimpinan.',
      available: true,
    ),
    Book(
      id: 'b31',
      title: 'Berpikir, Cepat dan Lambat',
      author: 'Daniel Kahneman',
      coverAsset: 'assets/covers/thinking_fast.png',
      category: 'Sains',
      rating: 4.7,
      year: 2011,
      pages: 499,
      publisher: 'Farrar, Straus and Giroux',
      synopsis:
          'Pemenang Nobel Ekonomi mengungkap dua sistem berpikir manusia: '
          'Sistem 1 yang cepat & intuitif, dan Sistem 2 yang lambat & rasional.',
      available: true,
    ),
    Book(
      id: 'b32',
      title: 'Manusia Mencari Makna',
      author: 'Viktor Frankl',
      coverAsset: 'assets/covers/mans_search.png',
      category: 'Motivasi',
      rating: 4.9,
      year: 1946,
      pages: 165,
      publisher: 'Beacon Press',
      synopsis:
          'Kisah nyata seorang psikiatris Austria yang selamat dari Holocaust '
          'dan membangun logoterapi — terapi pencarian makna hidup.',
      available: true,
    ),
    Book(
      id: 'b33',
      title: 'Kekuatan Kebiasaan',
      author: 'Charles Duhigg',
      coverAsset: 'assets/covers/power_of_habit.png',
      category: 'Motivasi',
      rating: 4.5,
      year: 2012,
      pages: 371,
      publisher: 'Random House',
      synopsis:
          'Mengungkap ilmu di balik kebiasaan manusia dan organisasi, serta '
          'cara mengubahnya untuk mencapai kehidupan yang lebih baik.',
      available: false,
    ),
    Book(
      id: 'b34',
      title: 'Outliers',
      author: 'Malcolm Gladwell',
      coverAsset: 'assets/covers/outliers.png',
      category: 'Sains',
      rating: 4.5,
      year: 2008,
      pages: 309,
      publisher: 'Little, Brown and Company',
      synopsis:
          'Mengapa orang-orang paling sukses di dunia berhasil? Gladwell '
          'membuktikan bahwa kesuksesan bukan hanya soal bakat, tetapi juga kesempatan.',
      available: true,
    ),
    Book(
      id: 'b35',
      title: 'Educated',
      author: 'Tara Westover',
      coverAsset: 'assets/covers/educated.png',
      category: 'Sejarah',
      rating: 4.8,
      year: 2018,
      pages: 352,
      publisher: 'Random House',
      synopsis:
          'Memoar luar biasa tentang seorang gadis yang dibesarkan tanpa '
          'sekolah formal oleh keluarga terisolir, namun berhasil meraih gelar PhD.',
      available: true,
    ),
    Book(
      id: 'b36',
      title: 'Siddhartha',
      author: 'Hermann Hesse',
      coverAsset: 'assets/covers/siddhartha.png',
      category: 'Motivasi',
      rating: 4.7,
      year: 1922,
      pages: 152,
      publisher: 'S. Fischer Verlag',
      synopsis:
          'Perjalanan spiritual Siddhartha mencari pencerahan melalui '
          'asketisme, kenikmatan duniawi, dan akhirnya kedamaian sejati.',
      available: true,
    ),
    Book(
      id: 'b37',
      title: 'Animal Farm',
      author: 'George Orwell',
      coverAsset: 'assets/covers/animal_farm.png',
      category: 'Fiksi',
      rating: 4.6,
      year: 1945,
      pages: 112,
      publisher: 'Secker & Warburg',
      synopsis:
          'Alegori satir tentang revolusi binatang yang membebaskan diri '
          'dari manusia, namun akhirnya terjebak dalam tirani baru yang lebih kejam.',
      available: true,
    ),
    Book(
      id: 'b38',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      coverAsset: 'assets/covers/pride_prejudice.png',
      category: 'Fiksi',
      rating: 4.7,
      year: 1813,
      pages: 432,
      publisher: 'T. Egerton',
      synopsis:
          'Kisah cinta Elizabeth Bennet dan Mr. Darcy yang penuh salah paham, '
          'gengsi, dan akhirnya pengakuan perasaan yang sejati.',
      available: true,
    ),
    Book(
      id: 'b39',
      title: 'Si Anak Cahaya',
      author: 'Tere Liye',
      coverAsset: 'assets/covers/si_anak_cahaya.png',
      category: 'Fiksi',
      rating: 4.5,
      year: 2019,
      pages: 360,
      publisher: 'Republika',
      synopsis:
          'Kisah Nurmas, gadis kecil dari keluarga sederhana di Sumatra, '
          'yang cahaya semangatnya menerangi semua orang di sekitarnya.',
      available: true,
    ),
    Book(
      id: 'b40',
      title: 'Jangan Menyerah',
      author: 'Zig Ziglar',
      coverAsset: 'assets/covers/dont_quit.png',
      category: 'Motivasi',
      rating: 4.4,
      year: 2000,
      pages: 248,
      publisher: 'Thomas Nelson',
      synopsis:
          'Panduan motivasi klasik untuk bangkit dari kegagalan, membangun '
          'mental juara, dan terus bergerak menuju tujuan hidup.',
      available: true,
    ),
    Book(
      id: 'b41',
      title: 'The Monk Who Sold His Ferrari',
      author: 'Robin Sharma',
      coverAsset: 'assets/covers/the_monk.png',
      category: 'Motivasi',
      rating: 4.5,
      year: 1997,
      pages: 198,
      publisher: 'HarperCollins',
      synopsis:
          'Kisah seorang pengacara sukses yang meninggalkan segalanya untuk '
          'mencari kebijaksanaan, dan kembali membawa pelajaran hidup yang mengubah segalanya.',
      available: false,
    ),
  ];

  // ---- Derived lists ----
  static List<Book> get popular => books.take(10).toList();
  static List<Book> get recommended =>
      books.where((b) => b.rating >= 4.6).take(10).toList();

  // ---- Loans ----
  static final List<Loan> loans = [
    Loan(
      book: books[0],
      borrowedDate: '01 Apr 2024',
      dueDate: '15 Apr 2024',
      status: LoanStatus.active,
    ),
    Loan(
      book: books[2],
      borrowedDate: '10 Mar 2024',
      dueDate: '10 Apr 2024',
      status: LoanStatus.active,
    ),
    Loan(
      book: books[1],
      borrowedDate: '15 Feb 2024',
      dueDate: '15 Mar 2024',
      status: LoanStatus.finished,
    ),
    Loan(
      book: books[7],
      borrowedDate: '02 Jan 2024',
      dueDate: '02 Feb 2024',
      status: LoanStatus.finished,
    ),
  ];

  static List<Loan> get activeLoans =>
      loans.where((l) => l.status == LoanStatus.active).toList();
  static List<Loan> get finishedLoans =>
      loans.where((l) => l.status == LoanStatus.finished).toList();

  // ---- Notifications ----
  static const List<AppNotification> notifications = [
    AppNotification(
      title: 'Jatuh Tempo Mendekat',
      message: 'Buku "Laskar Pelangi" harus dikembalikan pada 15 Apr 2024.',
      time: '2 jam lalu',
      type: NotificationType.dueSoon,
      unread: true,
    ),
    AppNotification(
      title: 'Buku Tersedia',
      message:
          'Buku "Dilan 1990" yang kamu antre kini tersedia untuk dipinjam.',
      time: '5 jam lalu',
      type: NotificationType.available,
      unread: true,
    ),
    AppNotification(
      title: 'Perpanjangan Berhasil',
      message: 'Pinjaman "Filosofi Teras" diperpanjang hingga 20 Apr 2024.',
      time: 'Kemarin',
      type: NotificationType.success,
    ),
    AppNotification(
      title: 'Koleksi Baru',
      message: '25 judul buku baru telah ditambahkan ke koleksi perpustakaan.',
      time: '2 hari lalu',
      type: NotificationType.info,
    ),
  ];

  static int get unreadCount => notifications.where((n) => n.unread).length;
}
