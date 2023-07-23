-- MariaDB dump 10.19  Distrib 10.4.27-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: songs
-- ------------------------------------------------------
-- Server version	10.4.27-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `composer`
--

DROP TABLE IF EXISTS `composer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `composer` (
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `composer`
--

LOCK TABLES `composer` WRITE;
/*!40000 ALTER TABLE `composer` DISABLE KEYS */;
INSERT INTO `composer` VALUES (''),('Lennon'),('MacCartney'),('Theodorakis'),('Γιώργος Νταλάρας'),('Διονύσης Σαββόπουλος'),('Μίκης Θεοδωράκης'),('Νταλάρας Γιώργος'),('Πέτρος');
/*!40000 ALTER TABLE `composer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lyricist`
--

DROP TABLE IF EXISTS `lyricist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lyricist` (
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lyricist`
--

LOCK TABLES `lyricist` WRITE;
/*!40000 ALTER TABLE `lyricist` DISABLE KEYS */;
INSERT INTO `lyricist` VALUES (''),('Lennon'),('MacCartney'),('Ritsos'),('Theodorakis'),('Ανδρικάκης Αντώνης'),('Γιάννης Ρίτσος'),('Διονύσης Σαββόπουλος'),('Μίκης Θεοδωράκης'),('Ρίτσος');
/*!40000 ALTER TABLE `lyricist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song`
--

DROP TABLE IF EXISTS `song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `song` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `lyrics` text DEFAULT NULL,
  `chords` text DEFAULT '',
  `likes` int(10) DEFAULT 0,
  `made_by` varchar(20) DEFAULT 'AntonisNikos',
  `public` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `made_by` (`made_by`),
  CONSTRAINT `song_ibfk_1` FOREIGN KEY (`made_by`) REFERENCES `user` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song`
--

LOCK TABLES `song` WRITE;
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
INSERT INTO `song` VALUES (1,'Αυτά τα δέντρα','Aυτά τα δέντρα δε βολεύονται με λιγότερο ουρανό,\r\nαυτές οι πέτρες δε βολεύονται κάτου απ’ τα, απ\' τα ξένα βήματα,\r\nαυτά τα πρόσωπα δε βολεύονται παρά μόνο στον ήλιο,\r\nαυτές οι καρδιές δε βολεύονται παρά μόνο στο δίκιο.\r\n\r\nEτούτο το τοπίο είναι σκληρό σαν τη σιωπή,\r\nσφίγγει στον κόρφο του τα πυρωμένα του λιθάρια,\r\nσφίγγει στο φως τις ορφανές ελιές του και τ’ αμπέλια του.\r\nΔεν υπάρχει νερό. Mονάχα φως.\r\n\r\nO δρόμος χάνεται στο φως\r\nκι ο ίσκιος της μάντρας είναι σίδερο.','Dm                    C            Dm    C   Dm\nDm                     C                Dm          C       Dm\n\n\n\n\n\n\n\n\n\n',0,'AntonisNikos',0),(2,'Μαργαρίτα Μαργαρώ','Η μαργαρίτα η μαργαρώ\nΠεριστεράκι στον ουρανό\nΤον ουρανό μεσ στα δυο σου μάτια κοιτάζω\nΒλέπω την πούλια και τον αστεριμό\nΗ μάνα σου είναι τρελή\nΚαι σε κλειδώνει μοναχή\nΣαν θέλω νά \'μπω στην κάμαρή σου\nΜου ρίχνεισ μεταξωτό σκοινί\nΚαι κλειδωμένουσ μασ βλέπει η νύχτα\nΜασ βλέπουν τ\' άστρα κι η χαραυγή\nΗ μαργαρίτα η μαργαρώ\nΒαρκούλα στο σαρωνικό\nΣαρωνικέ μου τα κυματάκια σου δώσ\' μου\nΔώσ\' μου τ\' αγέρι δώσ\' μου το πέλαγο\nΗ μάνα σου είναι τρελή\nΚαι σε κλειδώνει μοναχή\nΣαν θέλω νά \'μπω στην κάμαρή σου\nΜου ρίχνεισ μεταξωτό σκοινί\nΚαι κλειδωμένουσ μασ βλέπει η νύχτα\nΜασ βλέπουν τ\' άστρα κι η χαραυγή\nΗ μαργαρίτα η μαργαρώ\nΔεντράκι στο βοτανικό\nΠάρε το τραμ μόλισ δεισ πωσ πέφτει η νύχτα\nΠέφτουν οι ώρεσ πέφτω λιποθυμώ\nΗ μάνα σου είναι τρελή\nΚαι σε κλειδώνει μοναχή\nΣαν θέλω νά \'μπεισ στην κάμαρή σου\nΜου ρίχνεισ μεταξωτό σχοινί\nΚαι κλειδωμένουσ μασ βλέπει η νύχτα\nΜασ βλέπουν τ\' άστρα κι η χαραυγή','Dm           \nDm \nF                           A\nA7                             Dm\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',0,'AntonisNikos',1),(3,'A day in life','I read the news today, oh boy\nAbout a lucky man who made the grade\nAnd though the news was rather sad\nWell, I just had to laugh\nI saw the photograph\nHe blew his mind out in a car\nHe didn\'t notice that the lights had changed\nA crowd of people stood and stared\nThey\'d seen his face before\nNobody was really sure if he was from the House of Lords\nI saw a film today, oh boy\nThe English Army had just won the war\nA crowd of people turned away\nBut I just had to look\nHaving read the book\nI\'d love to turn you on\nWoke up, fell out of bed\nDragged a comb across my head\nFound my way downstairs and drank a cup\nAnd looking up, I noticed I was late\nFound my coat and grabbed my hat\nMade the bus in seconds flat\nFound my way upstairs and had a smoke\nAnd somebody spoke and I went into a dream\nI read the news today, oh boy\nFour thousand holes in Blackburn, Lancashire\nAnd though the holes were rather small\nThey had to count them all\nNow they know how many holes it takes to fill the Albert Hall\nI\'d love to turn you on','Am   F   C   G                      Am   F   C   E\nAm       F          C    G\nAm     F              C      E\nAm         F            C              G\nAm            F              C                E \nAm \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',0,'AntonisNikos',0),(4,'These Trees','Lyrics for These Trees\nΑυτά τα δέντρα\nΤεστ\nΤεσρ','Dm  C Dm\nDm          Dm\n\n',0,'AntonisNikos',0),(5,'Στο ίδιο έργο θεατές','Στο ίδιο έργο θεατές χαμένης νύχτασ εραστές\nΜε μια κιθάρα στησ αθήνασ τον εξώστη\nΑπό το σήμερα στο χτεσ τησ απουσίασ φοιτητέσ\nΜε έναν ήχο στην ψυχή ναυαγοσώστη\nΌ, τι ακούω να ακούσ μέσα σε κόσμους μυστικούς\nΘ\' ανακαλύψεισ μια πατρίδα ξεχασμένη\nΠαραδομένη στουσ καιρούσ και σε πελάτεσ πονηρούσ\nΣε συμπληγάδεσ μια ζωή παγιδευμένη\nΣτο ίδιο έργο θεατέσ εσύ κι εγώ τραγουδιστέσ\nΦανατικοί τησ πιο φευγάτησ εξουσίασ\nΟι ήχοι μασ διαδηλωτέσ και τα στιχάκια εμπρηστέσ\nΑυτό το έργο είναι παιχνίδι φαντασίασ\nΣενάριο χωρίσ πλοκή τησ ιστορίασ εμπλοκή\nΑυτά τα χρόνια που χρεώθηκεσ να ζήσεισ\nΜε ποια τραγούδια να σωθείσ\nΜε ποιουσ δικούσ σου να βρεθείσ\nΚαι ποιαν αλήθεια τώρα πια να μαρτυρήσεισ\nΘα βρούμε αλλιώτικουσ ρυθμούσ\nΣτου τραγουδιού μασ τουσ γκρεμούσ\nΘα περπατήσουμε κι απόψε ακροβάτεσ\nΜέσα από λόγια και λυγμούσ\nΤησ εποχήσ μασ τουσ χρησμούσ\nΘα ξεχωρίσουμε απ\' τισ οφθαλμαπάτεσ\nΣτο ίδιο έργο θεατέσ εσύ κι εγώ τραγουδιστέσ\nΦανατικοί τησ πιο φευγάτησ εξουσίασ\nΟι ήχοι μασ διαδηλωτέσ και τα στιχάκια εμπρηστέσ\nΑυτό το έργο είναι παιχνίδι φαντασίασ\nΣτο ίδιο πάντα σκηνικό και στησ ψυχήσ τον πανικό\nΑπόψε πνίγομαι χρειάζομαι αέρα\nΘέλω ν\' αρχίσω από δω αλλιώσ τα πράγματα να δω\nΝα πω στον κόσμο μια δική μου καλησπέρα','Am                E                      Am\n          Dm         F          Am\n                    C                     F\n        Dm          F        E\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',0,'AntonisNikos',0),(6,'Epitaph','The wall on which the prophets wrote\nIs cracking at the seams\nUpon the instruments of death\nThe sunlight brightly gleams\nWhen every man is torn apart\nWith nightmares and with dreams\nWill no one lay the laurel wreath\nWhen silence drowns the screams\nConfusion will be my epitaph\nAs I crawl a cracked and broken path\nIf we make it we can all sit back and laugh\nBut I fear tomorrow I\'ll be crying\nYes, I fear tomorrow I\'ll be crying\nYes, I fear tomorrow I\'ll be crying\nBetween the iron gates of fate\nThe seeds of time were sown\nAnd watered by the deeds of those\nWho know and who are known\nKnowledge is a deadly friend\nIf no one sets the rules\nThe fate of all mankind I see\nIs in the hands of fools\nThe wall on which the prophets wrote\nIs cracking at the seams\nUpon the instruments of death\nThe sunlight brightly gleams\nWhen every man is torn apart\nWith nightmares and with dreams\nWill no one lay the laurel wreath\nWhen silence drowns the screams?\nConfusion will be my epitaph\nAs I crawl a cracked and broken path\nIf we make it we can all sit back and laugh\nBut I fear tomorrow I\'ll be crying\nYes, I fear tomorrow I\'ll be crying\nYes, I fear tomorrow I\'ll be crying\nCrying\nCrying\nYes, I fear tomorrow I\'ll be crying\nYes, I fear tomorrow I\'ll be crying\nYes, I fear tomorrow I\'ll be crying\nCrying\n','Am        F \n\nC \n            Dm\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n',0,'AntonisNikos',0),(7,'Εσένα που σε ξέρω τόσο λίγο','Εσένα που σε ξέρω τόσο λίγο\nΕσένα π\' αγαπώ τόσο πολύ\nΓια πες μου θες να μείνω ή να φύγω\nΓια πες μου πριν μας πάρει το πρωί\n\nΤα αστέρια από ψηλά\nΜας βλέπουν σιωπηλά','Am            E         Am\nAm           G         C\n\n\n#####\n\n',0,'AntonisNikos',0),(8,'Τι έπαιξα στο Λαύριο','Δεν ξέρω τι να παίξω στα παιδιά\nστην αγορά, στο Λαύριο\nΕίμαι μεγάλος, με τιράντες και γυαλιά\nκι όλο φοβάμαι το αύριο\n\nΠώς να κρυφτείς απ\' τα παιδιά;\nΈτσι κι αλλιώς τα ξέρουν όλα.\nΚαι μας κοιτάζουν με μάτια σαν κι αυτά\nόταν ξυπνούν στις δύο η ώρα\n\nΡεφρέν (1ο)\n\nΖούμε μέσα σ\' ένα όνειρο που τρίζει\nσαν το ξύλινο ποδάρι της γιαγιάς μας\nμα ο χρόνος ο αληθινός\nσαν μικρό παιδί είναι εξόριστος\nμα ο χρόνος ο αληθινός\nείναι ο γιος μας ο μεγάλος κι ο μικρός\n\nΔεν ξέρω τι να παίξω στα παιδιά\nμα ούτε και στους μεγάλους\nπάει καιρός που έχω μάθει ξαφνικά\nπως είμαι ασχημοπαπαγάλος\n\nΠώς να τα κρύψεις όλα αυτά;\nΈτσι κι αλλιώς τα ξέρουν όλοι.\nΚαι σε κοιτάζουν με μάτια σαν κι αυτά\nόταν γυρνάς μέσα στην πόλη   \n\nΡεφρέν (2ο)\n\nΖούμε μέσα…\n','A        F#m     Bm\nE        E7       A\n\n\n\nD            E              A\nD           E            A C#\nD           C#         F#m\nB                       E\n\n\n\n\n\n\n\n\n\n\nA        F#m     Bm\n\n\n\n\n\n\n\n\n\n\n\n\n',0,'AntonisNikos',0),(9,'Αγαπώ σημαίνει','Αγαπώ σημαίνει να ανταμώνονται ξένοι\nκαι να θες να φτάσεις στην υπερβολή','Gm\nGm                              D#',0,'AntonisNikos',0);
/*!40000 ALTER TABLE `song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('AntonisNikos','ablaoublas');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wrotelyrics`
--

DROP TABLE IF EXISTS `wrotelyrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wrotelyrics` (
  `lyricist` varchar(50) NOT NULL,
  `song_id` int(20) NOT NULL,
  PRIMARY KEY (`lyricist`,`song_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `wrotelyrics_ibfk_1` FOREIGN KEY (`lyricist`) REFERENCES `lyricist` (`name`),
  CONSTRAINT `wrotelyrics_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wrotelyrics`
--

LOCK TABLES `wrotelyrics` WRITE;
/*!40000 ALTER TABLE `wrotelyrics` DISABLE KEYS */;
INSERT INTO `wrotelyrics` VALUES ('',6),('',7),('',9),('Lennon',3),('MacCartney',3),('Ανδρικάκης Αντώνης',5),('Γιάννης Ρίτσος',4),('Διονύσης Σαββόπουλος',8),('Μίκης Θεοδωράκης',2),('Ρίτσος',1);
/*!40000 ALTER TABLE `wrotelyrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wrotemusic`
--

DROP TABLE IF EXISTS `wrotemusic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wrotemusic` (
  `composer` varchar(50) NOT NULL,
  `song_id` int(20) NOT NULL,
  PRIMARY KEY (`composer`,`song_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `wrotemusic_ibfk_1` FOREIGN KEY (`composer`) REFERENCES `composer` (`name`),
  CONSTRAINT `wrotemusic_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wrotemusic`
--

LOCK TABLES `wrotemusic` WRITE;
/*!40000 ALTER TABLE `wrotemusic` DISABLE KEYS */;
INSERT INTO `wrotemusic` VALUES ('',6),('',7),('',9),('Lennon',3),('MacCartney',3),('Διονύσης Σαββόπουλος',8),('Μίκης Θεοδωράκης',1),('Μίκης Θεοδωράκης',2),('Μίκης Θεοδωράκης',4),('Νταλάρας Γιώργος',5);
/*!40000 ALTER TABLE `wrotemusic` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-23 21:00:44
