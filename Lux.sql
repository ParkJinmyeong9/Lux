-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.0.36 - MySQL Community Server - GPL
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- LUX 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `LUX` /*!40100 DEFAULT CHARACTER SET euckr */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `LUX`;

-- 테이블 LUX.auctions 구조 내보내기
CREATE TABLE IF NOT EXISTS `auctions` (
  `AuctionID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `StartTime` datetime DEFAULT NULL,
  `CurrentTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `WinnerID` int DEFAULT NULL,
  `FinalPrice` int DEFAULT NULL,
  PRIMARY KEY (`AuctionID`),
  KEY `ProductID` (`ProductID`),
  KEY `WinnerID` (`WinnerID`),
  CONSTRAINT `auctions_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`),
  CONSTRAINT `auctions_ibfk_2` FOREIGN KEY (`WinnerID`) REFERENCES `users` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=euckr;

-- 테이블 데이터 LUX.auctions:~5 rows (대략적) 내보내기
INSERT IGNORE INTO `auctions` (`AuctionID`, `ProductID`, `StartTime`, `CurrentTime`, `EndTime`, `WinnerID`, `FinalPrice`) VALUES
	(1, 1, '2023-09-01 00:00:00', '2024-04-05 17:27:35', '2024-08-23 00:00:00', 1, 1),
	(2, 2, '2023-09-05 00:00:00', '2024-04-05 17:27:41', '2024-05-15 00:00:00', 1, 1),
	(3, 3, '2024-01-02 15:32:57', '2024-04-05 17:27:41', '2024-05-05 15:33:14', 1, NULL),
	(4, 4, '2024-04-05 12:05:10', '2024-04-05 17:27:42', '2024-05-05 12:05:12', 1, NULL),
	(5, 5, '2024-04-05 12:05:46', '2024-04-05 17:27:43', '2024-06-05 12:05:47', 1, NULL);

-- 테이블 LUX.favoriteproducts 구조 내보내기
CREATE TABLE IF NOT EXISTS `favoriteproducts` (
  `FavoriteID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ProductID` int DEFAULT NULL,
  PRIMARY KEY (`FavoriteID`),
  KEY `UserID` (`UserID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `favoriteproducts_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`userID`),
  CONSTRAINT `favoriteproducts_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=euckr;

-- 테이블 데이터 LUX.favoriteproducts:~5 rows (대략적) 내보내기
INSERT IGNORE INTO `favoriteproducts` (`FavoriteID`, `UserID`, `ProductID`) VALUES
	(34, 3, 17),
	(36, 1, 9),
	(41, 1, 43),
	(42, 1, 28),
	(43, 1, 24);

-- 테이블 LUX.offlineshops 구조 내보내기
CREATE TABLE IF NOT EXISTS `offlineshops` (
  `ShopID` int NOT NULL AUTO_INCREMENT,
  `Location` varchar(255) NOT NULL,
  `Latitude` varchar(50) DEFAULT NULL,
  `Longitude` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ShopID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=euckr;

-- 테이블 데이터 LUX.offlineshops:~7 rows (대략적) 내보내기
INSERT IGNORE INTO `offlineshops` (`ShopID`, `Location`, `Latitude`, `Longitude`) VALUES
	(1, '서울 강남구 샵', '37.5115', '127.0596'),
	(2, '경기 하남 매장', '37.5456', '127.2237'),
	(3, '경기 수원 매장', '37.287375', '126.991562'),
	(4, '경기 고양 매장', '37.647160', '126.894928'),
	(5, '경기 안성 매장', '36.994641', '127.147483'),
	(6, '경기 부천 매장', '37.461428', '126.814013'),
	(7, '부산 강서 매장', '35.093288', '128.918257');

-- 테이블 LUX.payments 구조 내보내기
CREATE TABLE IF NOT EXISTS `payments` (
  `PaymentID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ProductID` int DEFAULT NULL,
  `TransactionID` varchar(255) NOT NULL,
  `Amount` int DEFAULT NULL,
  `PaymentMethod` enum('Card','BankTransfer','PayPal','Other') DEFAULT NULL,
  `PaymentStatus` enum('Pending','Completed','Failed','Refunded') DEFAULT 'Pending',
  PRIMARY KEY (`PaymentID`),
  KEY `UserID` (`UserID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`userID`),
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=euckr;

-- 테이블 데이터 LUX.payments:~2 rows (대략적) 내보내기
INSERT IGNORE INTO `payments` (`PaymentID`, `UserID`, `ProductID`, `TransactionID`, `Amount`, `PaymentMethod`, `PaymentStatus`) VALUES
	(1, 1, 1, 'TXN12345', 150000, 'Card', 'Completed'),
	(2, 2, 2, 'TXN67890', 250000, 'PayPal', 'Pending');

-- 테이블 LUX.products 구조 내보내기
CREATE TABLE IF NOT EXISTS `products` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `SellerID` int DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `Photo` text,
  `ModelNumber` varchar(50) DEFAULT NULL,
  `StartPrice` int DEFAULT NULL,
  `BuyNowPrice` int DEFAULT NULL,
  `CurrentBid` int DEFAULT NULL,
  `BidCount` int DEFAULT '0',
  `Description` text,
  `Status` enum('경매중','낙찰','검수중') DEFAULT '검수중',
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `Gender` enum('Male','Female') DEFAULT NULL,
  `Brand` enum('Louis Vuitton','Chanel','Gucci','Hermes','Cartier','Rolex','Dior','Tiffany','Burberry','Prada','Others') CHARACTER SET euckr COLLATE euckr_korean_ci DEFAULT NULL,
  `AuctionDuration` int DEFAULT NULL,
  PRIMARY KEY (`ProductID`),
  KEY `SellerID` (`SellerID`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`SellerID`) REFERENCES `users` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=euckr;

-- 테이블 데이터 LUX.products:~120 rows (대략적) 내보내기
INSERT IGNORE INTO `products` (`ProductID`, `SellerID`, `Name`, `Photo`, `ModelNumber`, `StartPrice`, `BuyNowPrice`, `CurrentBid`, `BidCount`, `Description`, `Status`, `CreatedAt`, `Gender`, `Brand`, `AuctionDuration`) VALUES
	(1, 1, '구찌 화이트 티셔츠', 'themes/images/carousel/banner-1.png', 'G1234', 70000, 150000, 100000, 5, '구찌 가방 설명', '경매중', '2024-03-27 12:49:57', 'Female', 'Gucci', NULL),
	(2, 1, '롤렉스 서브 마리나', 'themes/images/carousel/banner-3.png', 'C5678', 100000, 250000, 200000, 15, '롤렉스 설명', '경매중', '2024-03-27 12:49:57', 'Male', 'Rolex', NULL),
	(3, 1, '프라다 핸드백 동전지갑', 'themes/images/carousel/prada.png', 'R4875', 10000, 350000, 300000, 9, '프라다설명', '경매중', '2024-04-02 10:31:08', 'Female', 'Prada', NULL),
	(4, 1, 'BALLY 발리 크로스백', 'themes/images/carousel/Bally.png', 'R2441', 20000, 800000, 500000, 3, '발리설명', '경매중', '2024-04-02 16:56:45', 'Male', 'Others', NULL),
	(5, 1, 'Louis', 'themes/images/carousel/Louis.png', 'W2334', 50000, 500000, 320000, 5, '루이비통설명', '경매중', '2024-04-03 14:22:24', 'Female', 'Louis Vuitton', NULL),
	(6, 1, '버클 구찌 벨트', 'themes/images/carousel/Gucci_1.png', 'R2233', 300000, 500000, 420000, 5, '구찌 반지갑 설명', '경매중', '2024-04-07 17:40:01', 'Male', 'Gucci', NULL),
	(8, 1, '슈프림 리얼트리 리버시블 퀄티드 워커 재킷 블랙(24SS)', 'themes/images/carousel/supreme.png', 'S1234', 1000000, 1399000, 1100000, 20, '새상품', '경매중', '2024-04-05 10:37:18', 'Male', 'Others', NULL),
	(9, 1, '롤렉스 데이트저스트 36 브라이트 블루 126234 (플루티드/쥬빌리)', 'themes/images/carousel/rolex datejust 36 bright blue.png', 'C4567', 12000000, 18000000, 15000000, 7, '새상품', '경매중', '2024-04-05 11:47:45', 'Male', 'Rolex', NULL),
	(10, 1, '에르메스 집시에르 미니백 에버컬러 & 골드 하드웨어 골드', 'themes/images/carousel/hermes jypsiere mini bag.png', 'A5879', 8000000, 12500000, 11500000, 12, '새상품', '경매중', '2024-04-05 12:04:35', 'Female', 'Hermes', NULL),
	(12, 1, '루이비통 8 워치 케이스 모노그램', 'themes/images/carousel/Lois Vuitton 8 Watch Case Monogram3.png', 'Q1234', 5000000, 10000000, 5500000, 20, '새상품', '경매중', '2024-04-05 12:11:26', 'Female', 'Louis Vuitton', NULL),
	(13, 1, '에어 조던 1 하이 OG 트로피 룸 시카고 (F&F)', 'themes/images/carousel/Jordan 1 High OG Trophy Room Chicago.png', 'S1687', 500000, 9000000, 2500000, 8, '새상품', '경매중', '2024-04-05 12:22:45', 'Male', 'Others', NULL),
	(14, 1, '까르띠에 탱크 머스트 워치 엑스트라 라지 오토매틱 스틸 카프스킨 블랙', 'themes/images/carousel/Cartier Tank Must Watch Extra Large Automatic Steel Calfskin Blak.png', NULL, 5000000, 8600000, 5000000, 1, '새상품', '경매중', '2024-04-05 12:25:09', 'Male', 'Cartier', NULL),
	(15, 1, '포켓몬 카드 게임 25주년 울트라 프리미엄 메탈 피카츄 (북미판)', 'themes/images/carousel/Pokemon Card Game ultra Premium Collection Pikachu.png', NULL, 85000, 7500000, 125000, 3, '새상품', '경매중', '2024-04-05 12:27:29', 'Male', 'Others', NULL),
	(16, 1, '샤넬 코코 크러쉬 이어링 퀼티드 모티프 & 18K 베이지 골드 (W)', 'themes/images/carousel/Chanel Coco Crush Earrings Quilted Motif & 18k Beige Gold.png', NULL, 3000000, 6500000, 5000000, 0, '새상품', '경매중', '2024-04-05 12:29:35', 'Female', 'Chanel', NULL),
	(17, 1, '슈프림 x 제이콥앤코 로고 링크 브레이슬릿 14k 골드 (22SS)', 'themes/images/carousel/Supreme x Jacob & Co Logo Link Bracelet 14K Gold.png', NULL, 2000000, 5749000, 4000000, 4, '새상품', '경매중', '2024-04-05 12:31:30', 'Male', 'Others', NULL),
	(18, 1, '에르메스 피코탄 락 럭키 데이지 18 백 프린티드 스위프트 & 팔라듐 하드웨어 모브 실베스트레 퀴브레 블랑', 'themes/images/carousel/Hermes Picotin Lock Lucky Daisy 18 Bag Printed Swift & Palladium MAuve Sylvestre Cuivre Blanc.png', NULL, 2000000, 5570000, 5500000, 4, '새상품', '경매중', '2024-04-05 12:34:54', 'Female', 'Hermes', NULL),
	(19, 1, '삼성 갤럭시 Z 폴드5 톰브라운 에디션 (국내 정식 발매 제품)', 'themes/images/carousel/Samsung Galaxy Z Fold5 Thom Browne Edition.png', NULL, 3518000, 4000000, 3518000, 1, '새상품', '경매중', '2024-04-05 12:39:37', 'Male', 'Others', NULL),
	(20, 1, '카우스 패밀리 바이닐 피규어 세트', 'themes/images/carousel/KAWS Family Vinyl Figures Set.png', NULL, 2500000, 4000000, 3000000, 3, '새상품', '경매중', '2024-04-05 12:42:06', 'Male', 'Others', NULL),
	(22, 1, '젠틀 몬스터 X 메종 마르지엘라 MM110 블랙 블랙', 'themes/images/carousel/margiela MM110 Black.png', 'S5678', 250000, 444000, 300000, 2, '새상품', '경매중', '2024-04-05 10:39:56', 'Male', 'Others', NULL),
	(23, 1, '슈프림 x 버버리 데님 트러커 재킷 워시드 블루 (22SS)', 'themes/images/carousel/denimTrucker jaket.png', 'S9123', 800000, 1200000, 800000, 1, '중고', '경매중', '2024-04-05 10:47:00', 'Male', 'Others', NULL),
	(24, 1, '루이비통 타이가 네오 로부스토2', 'themes/images/carousel/louis_back2.png', 'L3132', 2000000, 2500000, 2200000, 9, '루이비통 메신저백 설명', '경매중', '2024-04-09 10:40:11', 'Male', 'Louis Vuitton', NULL),
	(25, 1, '루이비통 네버풀 MM 모노그램 캔버스 숄더백', 'themes/images/carousel/louis_back3.png', 'L2988', 2200000, 2800000, 2500000, 4, '루이비통 숄더백 설명', '경매중', '2024-04-09 10:47:17', 'Female', 'Louis Vuitton', NULL),
	(26, 1, '루이비통 루이스 체인 MM 클러치', 'themes/images/carousel/louis_wallet1.png', 'L8679', 1000000, 1600000, 1280000, 8, '루이비통 클러치 설명', '경매중', '2024-04-09 16:45:29', 'Female', 'Louis Vuitton', NULL),
	(27, 1, '루이비통 다미에 지피 컴펙트 지갑', 'themes/images/carousel/louis_wallet2.png', 'L2115', 1100000, 1700000, 1400000, 10, '루이비통 다미에 컴펙트 지갑 설명', '경매중', '2024-04-09 16:50:12', 'Female', 'Louis Vuitton', NULL),
	(28, 1, '루이비통 모노그램 캔버스 루이즈', 'themes/images/carousel/louis_wallet3.png', 'L6046', 500000, 800000, 600000, 11, '루이비통 장지갑 설명', '경매중', '2024-04-09 16:54:35', 'Female', 'Louis Vuitton', NULL),
	(29, 1, '루이비통 다미에 리버서블 벨트', 'themes/images/carousel/louis_item1.png', 'L0213', 500000, 800000, 590000, 9, '루이비통 남성 벨트 설명', '낙찰', '2024-04-09 16:58:47', 'Male', 'Louis Vuitton', NULL),
	(30, 1, '루이비통 모노그램 벨트', 'themes/images/carousel/louis_item2.png', 'L9608', 400000, 750000, 600000, 4, '루이비통 남성 벨트 설명', '낙찰', '2024-04-09 17:02:29', 'Male', 'Louis Vuitton', NULL),
	(31, 1, '루이비통  로고마니아 팔찌', 'themes/images/carousel/louis_item3.png', ' L4150', 300000, 700000, 500000, 99, '루이비통 여성 악세사리 설명', '낙찰', '2024-04-09 17:06:15', 'Female', 'Louis Vuitton', NULL),
	(32, 1, '루이비통  스피티 반둘리에 백', 'themes/images/carousel/louis_item4.png', 'L4623', 3000000, 4000000, 3696969, 128, '루이비통 스피디 반둘리에 토트넘 백 설명', '경매중', '2024-04-09 17:12:01', 'Female', 'Louis Vuitton', NULL),
	(33, 1, '샤넬 램스킨 클래식 점보 숄더백', 'themes/images/carousel/chanel_item1.png', 'C2860', 5000000, 7000000, 6000000, 1534, '샤넬 램스킨 클래식 점보 존나 비쌈', '경매중', '2024-04-09 17:30:05', 'Female', 'Chanel', NULL),
	(34, 1, '샤넬 램스킨 클래식 보이백 체인백', 'themes/images/carousel/chanel_item2.png', 'C1818', 1300000, 2500000, 1800000, 1818, '샤넬 램스킨 클래식 보이백 체인백 설명', '경매중', '2024-04-09 17:34:39', 'Female', 'Chanel', NULL),
	(35, 1, '샤넬 램스킨 클래식 로고 지갑', 'themes/images/carousel/chanel_item3.png', 'C6915', 600000, 800000, 760000, 852, '샤넬 램스킨 클래식 로고 지갑 설명', '경매중', '2024-04-09 17:41:00', 'Female', 'Chanel', NULL),
	(36, 1, '샤넬 1992 로고 턴락 미니 카메라 백', 'themes/images/carousel/chanel_item4.png', 'C9953', 8000000, 10000000, 8500000, 3654, '샤넬 1992 로고 미니 카메라 백 설명', '경매중', '2024-04-09 18:53:07', 'Female', 'Chanel', NULL),
	(37, 1, '샤넬 J12 블랙 38mm 칼리브 12.1', 'themes/images/carousel/chanel_item5.png', 'C5843', 4000000, 5500000, 5000000, 666, '샤넬 칼리브 12.1 시계', '경매중', '2024-04-09 18:56:47', 'Male', 'Chanel', NULL),
	(38, 1, '샤넬 프리미에르 20mm 시계', 'themes/images/carousel/chanel_item6.png', 'C4512', 6800000, 7999999, 7100000, 88, '샤넬 프리메에르 20mm 시계 설명', '경매중', '2024-04-09 18:58:54', 'Female', 'Chanel', NULL),
	(39, 1, '샤넬 필 드 까멜리아 18K 2013 목걸이', 'themes/images/carousel/chanel_item7.png', 'C5934', 12000000, 14000000, 13600000, 9, '샤넬 필 드 까멜리아 18K 화이트 골드와 다이아로 구성된 네클리스', '경매중', '2024-04-09 19:00:34', 'Female', 'Chanel', NULL),
	(40, 1, '샤넬 로고 더블 크리스탈 브로치', 'themes/images/carousel/chanel_item8.png', 'C4982', 690000, 900000, 780000, 90, '샤넬 CC로고 더블 크리스탈 브로치', '경매중', '2024-04-09 19:00:37', 'Female', 'Chanel', NULL),
	(41, 1, '샤넬 로고 블랙 진주 이어링', 'themes/images/carousel/chanel_item9.png', 'C7832', 1200000, 1350000, 1280000, 99, '셔낼 골드와 블랙 진주가 포인트 귀걸이 라지 사이즈', '경매중', '2024-04-09 19:01:16', 'Female', 'Chanel', NULL),
	(42, 1, '샤넬 COMETE CHEVRON 브레이슬릿', 'themes/images/carousel/chanel_item10.png', 'C0032', 20000000, 23000000, 22500000, 9999, '샤넬 18K 화이트 골드와 다이아몬드로 이루어진 브레이슬릿', '경매중', '2024-04-09 19:13:07', 'Female', 'Chanel', NULL),
	(43, 1, '구찌 로고 매트 레더 팬츠', 'themes/images/carousel/gucci_item1.png', 'G1480', 13000000, 14900000, 13700000, 3, '구찌 존나 비싼 팬츠', '경매중', '2024-04-09 20:16:23', 'Male', 'Gucci', NULL),
	(44, 1, '구찌 수프림 버고 스몰 탑 핸들백', 'themes/images/carousel/gucci_item2.png', 'G9887', 5000000, 6000000, 5500000, 72, '구찌 수프림 버고 스몰 탑 핸들백 설명', '경매중', '2024-04-09 20:18:34', 'Female', 'Gucci', NULL),
	(45, 1, '구찌 마틀라세 도트백', 'themes/images/carousel/gucci_item3.png', 'G1046', 4000000, 5600000, 5300000, 46, '구찌 마틀라세 토트백 설명', '경매중', '2024-04-09 20:19:09', 'Female', 'Gucci', NULL),
	(46, 1, '구찌 남성 접보 미디엄 토트백', 'themes/images/carousel/gucci_item4.png', 'G1000', 4500000, 5400000, 5100000, 100, '구찌 남성 점보 GG 미디엄 토트백 설명', '경매중', '2024-04-09 20:19:09', 'Male', 'Gucci', NULL),
	(47, 1, '구찌 코튼 캔버스 푸퍼 자켓', 'themes/images/carousel/gucci_item5.png', 'G2184', 2900000, 3600000, 3300000, 100, '구찌 GG 코튼 캔버스 푸퍼 자켓 설명', '경매중', '2024-04-09 20:19:09', 'Male', 'Gucci', NULL),
	(48, 1, '구찌 남성 라지 폴리에스테르 백팩', 'themes/images/carousel/gucci_item6.png', 'G1245', 2700000, 3500000, 3200000, 111, '구찌 남성 라지 GG 폴리에스테르 백팩 설명', '경매중', '2024-04-09 20:19:09', 'Male', 'Gucci', NULL),
	(49, 1, '구찌 마틀라세 미니 탑 핸들백', 'themes/images/carousel/gucci_item7.png', 'G1046', 2700000, 3300000, 3000000, 888, '구찌 GG 마틀라세 미니 탑 핸들백 설명', '경매중', '2024-04-09 20:19:09', 'Female', 'Gucci', NULL),
	(50, 1, '구찌 홀스빗 미니 숄더백', 'themes/images/carousel/gucci_item8.png', 'G9682', 3200000, 4000000, 3700000, 4563, '구찌 홀스빗 미니 숄더백 설명', '경매중', '2024-04-09 20:19:09', 'Female', 'Gucci', NULL),
	(51, 1, '구찌 남성 오피디아 미디엄 토트백', 'themes/images/carousel/gucci_item9.png', 'G8441', 3000000, 3800000, 3500000, 55, '구찌 [라벨루쏘] 남서 오피디아 미디엄 토트백 설명', '경매중', '2024-04-09 20:19:09', 'Male', 'Gucci', NULL),
	(52, 1, '구찌 24SS 여성 마몽 마틀라세 토트숄더백', 'themes/images/carousel/gucci_item10.png', 'G4981', 2600000, 3600000, 3300000, 52, '구찌 24SS 여성 GG 마몽 마틀라세 토트 숄더백 설명', '경매중', '2024-04-09 20:19:09', 'Female', 'Gucci', NULL),
	(53, 1, '에르메스 HAC A DOS PM 백팩', 'themes/images/carousel/hermes_item1.png', 'H1111', 10000000, 12000000, 11000000, 55, '에르메스 핵 어 도스 피엠 백펙 설명', '경매중', '2024-04-10 16:33:50', 'Male', 'Hermes', NULL),
	(54, 1, '에르메스 TRIBUNE 브리프케이스', 'themes/images/carousel/hermes_item2.png', 'H2222', 10000000, 11500000, 10500000, 80, '에르메스 TRIBUNE 설명', '경매중', '2024-04-10 16:33:50', 'Male', 'Hermes', NULL),
	(55, 1, '에르메스 BUDDYPOCKET 백', 'themes/images/carousel/hermes_item3.png', 'H3333', 8000000, 9500000, 9200000, 55, '에르메스 BUDDYPOCKET 백 설명', '경매중', '2024-04-10 16:33:50', 'Male', 'Hermes', NULL),
	(56, 1, '에르메스 JUMPING SHORTER 부츠', 'themes/images/carousel/hermes_item4.png', 'H4444', 2500000, 3600000, 3300000, 123, '에르메스 JUMPING SHORTER 부츠 설명', '경매중', '2024-04-10 16:33:50', 'Female', 'Hermes', NULL),
	(57, 1, '에르메스 JYSPIERE 미니 백', 'themes/images/carousel/hermes_item5.png', 'H1234', 9000000, 10500000, 10000000, 333, '에르메스 JYPSIERE 미니 백 설명', '경매중', '2024-04-10 16:33:50', 'Female', 'Hermes', NULL),
	(58, 1, '에르메스 LINDY 26 백', 'themes/images/carousel/hermes_item6.png', 'H5643', 10500000, 11900000, 11400000, 789, '에르메스 LINDY 26 백 설명', '경매중', '2024-04-10 16:33:50', 'Female', 'Hermes', NULL),
	(59, 1, '에르메스 HAUT A COURROIES 40 백', 'themes/images/carousel/hermes_item7.png', 'H4453', 20000000, 21000000, 20500000, 4, '에르메스 HAUT A COURROIES 40 백 설명', '경매중', '2024-04-10 16:33:50', 'Female', 'Hermes', NULL),
	(60, 1, '에르메스 EURYDIEC 네크리스 ', 'themes/images/carousel/hermes_item8.png', 'H8523', 3800000, 4500000, 4200000, 432, '에르메스 EURYDICE 네크리스 설명', '경매중', '2024-04-10 16:33:50', 'Female', 'Hermes', NULL),
	(61, 1, '에르메스 BEAUTE COMPOSEE 스카프 90', 'themes/images/carousel/hermes_item9.png', 'H7453', 680000, 740000, 710000, 63, '에르메스 COMPOSEE 스카프 90 설명', '경매중', '2024-04-10 16:33:50', 'Female', 'Hermes', NULL),
	(62, 1, '에르메스 ARCEAY L\' HEURE DE LA LUNE 위치, 43MM', 'themes/images/carousel/hermes_item10.png', 'H9999', 50000000, 53000000, 52000000, 999, '에르메스 ARCEAU L\' HEURE DE LA LUNE 위치, 43MM 설명', '경매중', '2024-04-10 16:33:50', 'Male', 'Hermes', NULL),
	(63, 1, '까르띠에 발롱 블루 드 워치 37 MM', 'themes/images/carousel/cartier_item1.png', 'C1234', 300000000, 315000000, 300000000, 44444, '발롱 블루 드 까르띠에 워치 37MM, 오토매틱 매니컬 무브먼트 화이트 골드, 다이아몬드 ', '경매중', '2024-04-10 16:42:50', 'Male', 'Cartier', NULL),
	(64, 1, '까르띠에 트리니티 이어링', 'themes/images/carousel/cartier_item2.png', 'C2523', 3200000, 4000000, 3700000, 1233, '까르띠에 트리니티 이어링 화이트 골드, 옐로우 골드, 핑크 골드', '경매중', '2024-04-10 16:42:50', 'Female', 'Cartier', NULL),
	(65, 1, '까르띠에 저스트 앵 끌루 링', 'themes/images/carousel/cartier_item3.png', 'C8523', 5300000, 6000000, 5700000, 2222, '가르띠에 저스트 앵 끌루 링 핑크 골드, 다이아몬드', '경매중', '2024-04-10 16:42:50', 'Female', 'Cartier', NULL),
	(66, 1, '까르띠에 미니 체인 백, C 드 까르띠에', 'themes/images/carousel/cartier_item4.png', 'C3970', 2300000, 3700000, 3400000, 853, '미니(MINI) 체인 백, C 드 까르띠에 자수및 체리 레드 송아지 가죽, 골드 피니싱', '경매중', '2024-04-10 16:42:50', 'Female', 'Cartier', NULL),
	(67, 1, '까르띠에 클래쉬 드 브레이슬릿 SMALL 모델', 'themes/images/carousel/cartier_item5.png', 'C8263', 9000000, 10500000, 9500000, 81, '까르띠에 클래쉬 드 브레이슬릿 SMALL 모델, 핑크 골드', '경매중', '2024-04-10 16:42:50', 'Female', 'Cartier', NULL),
	(68, 1, '까르띠에 클래쉬 드 이어링', 'themes/images/carousel/cartier_item6.png', 'C8863', 14500000, 16000000, 15000000, 99, '까르띠에 클래쉬 드 이어링 핑크골드, 다이아몬드', '경매중', '2024-04-10 16:42:50', 'Female', 'Cartier', NULL),
	(69, 1, '까르띠에 팬더 드 링', 'themes/images/carousel/cartier_item7.png', 'C3312', 4000000, 5000000, 4700000, 88, '까르띠에 팬더 드 링 핑크 골드, 차보라이트 가넷, 오닉스', '경매중', '2024-04-10 16:42:50', 'Male', 'Cartier', NULL),
	(70, 1, '까르띠에 LOVE 브레이슬릿 SMALL 모델', 'themes/images/carousel/cartier_item8.png', 'C9956', 12000000, 13000000, 12500000, 99, 'LOVE 브레이슬릿, SMALL 모델 핑크 골드, 다이아몬드 10', '경매중', '2024-04-10 16:42:50', 'Female', 'Cartier', NULL),
	(71, 1, '까르띠에 LOVE 네클리스', 'themes/images/carousel/cartier_item9.png', 'C4531', 2000000, 3300000, 2700000, 63, 'LOVE 네클리스 핑크 골드', '경매중', '2024-04-10 16:42:50', 'Female', 'Cartier', NULL),
	(72, 1, '까르띠에 산토스 드 워치', 'themes/images/carousel/cartier_item10.png', 'C5521', 14000000, 15600000, 14600000, 32, 'Large 모델, 오토매틱 무브먼트, 옐로우 골드, 스틸, 교체가능한 메탈 및 가죽 브레이슬릿', '경매중', '2024-04-10 16:42:50', 'Male', 'Cartier', NULL),
	(73, 1, '롤렉스 Datejust 36', 'themes/images/carousel/rolex_item1.png', 'R8945', 10500000, 12000000, 11000000, 66, '오이스터, 36mm 오이스터스틸과 화이트 골드', '경매중', '2024-04-10 16:45:27', 'Male', 'Rolex', NULL),
	(74, 1, '롤렉스 Submariner Date', 'themes/images/carousel/rolex_item2.png', 'R8855', 19000000, 21000000, 20000000, 68, '오이스터 , 41mm 오이스터스틸과 옐로우 골드', '경매중', '2024-04-10 16:45:27', 'Male', 'Rolex', NULL),
	(75, 1, '롤렉스 Day-Date 36', 'themes/images/carousel/rolex_item3.png', 'R5533', 85000000, 100000000, 95000000, 63, '오이스터, 36mm, 옐로우 골드 다이아몬드', '경매중', '2024-04-10 16:45:27', 'Female', 'Rolex', NULL),
	(76, 1, '롤렉스 Sky-Dweller', 'themes/images/carousel/rolex_item4.png', 'R6855', 45000000, 60000000, 50000000, 100, '오이스터, 42mm, 옐로우 골드', '경매중', '2024-04-10 16:45:27', 'Male', 'Rolex', NULL),
	(77, 1, '롤렉스 Deepsea', 'themes/images/carousel/rolex_item5.png', 'R7752', 60000000, 70000000, 65000000, 88, '오이스터, 44mm, 옐로우 골드', '경매중', '2024-04-10 16:45:27', 'Male', 'Rolex', NULL),
	(78, 1, '롤렉스 GMT- Master2', 'themes/images/carousel/rolex_item6.png', 'R5563', 40000000, 50000000, 46000000, 86, '오이스터, 40mm, 화이트 골드 ', '경매중', '2024-04-10 16:45:27', 'Male', 'Rolex', NULL),
	(79, 1, '롤렉스 Datejust 31 ', 'themes/images/carousel/rolex_item7.png', 'R2230', 15000000, 20000000, 18000000, 63, '오이스터, 31mm, 오이스터스틸, 옐로우 골드, 다이아몬드', '경매중', '2024-04-10 16:45:27', 'Female', 'Rolex', NULL),
	(80, 1, '롤렉스 Yacht-Master 42', 'themes/images/carousel/rolex_item8.png', 'R4242', 32000000, 39000000, 36000000, 22, '오이스터, 42mm, 옐로우 골드 ', '경매중', '2024-04-10 16:45:27', 'Male', 'Rolex', NULL),
	(81, 1, '롤렉스 Oyster Perpetual 28', 'themes/images/carousel/rolex_item9.png', 'R0706', 5000000, 6800000, 6300000, 66, '오이스터, 28mm, 오이스터스틸 ', '경매중', '2024-04-10 16:45:27', 'Female', 'Rolex', NULL),
	(82, 1, '롤렉스 Cosmograph Daytona', 'themes/images/carousel/rolex_item10.png', 'R8899', 69000000, 80000000, 76000000, 99, '오이스터, 40mm, 화이트 골드, 다이아몬드', '경매중', '2024-04-10 16:45:27', 'Male', 'Rolex', NULL),
	(83, 1, '디올 Rose des Vents 귀걸이', 'themes/images/carousel/dior_item1.png', 'D2010', 17000000, 18500000, 18000000, 63, '옐로우 골드, 다이아몬드, 자개', '경매중', '2024-04-10 16:47:15', 'Female', 'Dior', NULL),
	(84, 1, '디올 Rose des Vents 팔찌', 'themes/images/carousel/dior_item2.png', 'D2063', 15000000, 16500000, 16000000, 33, '옐로우 골드, 다이아몬드, 자개', '경매중', '2024-04-10 16:47:15', 'Female', 'Dior', NULL),
	(85, 1, '디올 Rose des Vents 목걸이', 'themes/images/carousel/dior_item3.png', 'D4063', 35000000, 40000000, 38000000, 12, '18K 화이트 골드, 다이몬드, 자개, 오닉스', '경매중', '2024-04-10 16:47:15', 'Female', 'Dior', NULL),
	(86, 1, '디올 Lady Dior 스몰 백 ', 'themes/images/carousel/dior_item4.png', 'D1450', 12500000, 14000000, 13500000, 66, '화이트 & 파스텔 미드나잇 블루 Toile de Jouy Mexico 라인 스톤 자수', '경매중', '2024-04-10 16:47:15', 'Female', 'Dior', NULL),
	(87, 1, '디올 Rose des Vents 귀걸이', 'themes/images/carousel/dior_item5.png', 'D3060', 26000000, 29000000, 28000000, 63, '옐로우골드, 다이아몬드, 장식용 스톤', '경매중', '2024-04-10 16:47:15', 'Female', 'Dior', NULL),
	(88, 1, '디올 Rose des Vents 컨버터블 벨트', 'themes/images/carousel/dior_item6.png', 'D6080', 55000000, 58000000, 57900000, 63, '옐로우골드 다이아몬드, 장식용 스톤', '경매중', '2024-04-10 16:47:15', 'Female', 'Dior', NULL),
	(89, 1, '디올 Saddle 백', 'themes/images/carousel/dior_item7.png', 'D07745', 5600000, 6900000, 6300000, 35, '블랙 Dior Oblique 입체 자수 캔버스', '경매중', '2024-04-10 16:47:15', 'Male', 'Dior', NULL),
	(90, 1, '디올 8 메신저 백', 'themes/images/carousel/dior_item8.png', 'D0037', 2000000, 3000000, 2700000, 33, '블랙 Dior Oblique 자카드', '경매중', '2024-04-10 16:47:15', 'Male', 'Dior', NULL),
	(91, 1, '디올 8 플립 백팹', 'themes/images/carousel/dior_item9.png', 'D4006', 3500000, 4300000, 3700000, 23, '블랙 Dior Oblique 자카드', '경매중', '2024-04-10 16:47:15', 'Male', 'Dior', NULL),
	(92, 1, '디올 까나쥬 베스트', 'themes/images/carousel/dior_item10.png', 'D0460', 3200000, 4300000, 3700000, 6, '블루 테크니컬 코튼 오토만', '경매중', '2024-04-10 16:47:15', 'Male', 'Dior', NULL),
	(93, 1, '티파니 락', 'themes/images/carousel/tiffany_item1.png', 'T0490', 2900000, 4500000, 4200000, 68, '스몰 팬던트, 로즈 골드, 핑크 사파이어 세팅', '경매중', '2024-04-10 16:48:52', 'Female', 'Tiffany', NULL),
	(94, 1, '티파니 HardWear', 'themes/images/carousel/tiffany_item2.png', 'T2030', 16800000, 18000000, 17500000, 50, '더블 링크 팬던트, 18L 로즈 골드, 파베 다이아몬드 세팅', '경매중', '2024-04-10 16:48:52', 'Female', 'Tiffany', NULL),
	(95, 1, '티파니 HardWear ', 'themes/images/carousel/tiffany_item3.png', 'T1116', 95000000, 105000000, 100000000, 32, '그레듀에이티드 링크 네크리스, 18K 로즈 골드, 파베 다이아몬드 세팅', '경매중', '2024-04-10 16:48:52', 'Female', 'Tiffany', NULL),
	(96, 1, '티파니 빅토리아™', 'themes/images/carousel/tiffany_item4.png', 'T2003', 180000000, 200000000, 193000000, 63, '플래티늄, 다이아몬드 세팅, 바인 네크리스, 40.6cm', '경매중', '2024-04-10 16:48:52', 'Female', 'Tiffany', NULL),
	(97, 1, '티파니 락', 'themes/images/carousel/tiffany_item5.png', 'T1735', 150000000, 169000000, 156000000, 33, '뱅글 화이트 골드, 바게트 및 파베 다이아몬드 세팅', '경매중', '2024-04-10 16:48:52', 'Female', 'Tiffany', NULL),
	(98, 1, '티파니 Schlumberger by Tiffany & Co.™ ', 'themes/images/carousel/tiffany_item6.png', 'T1396', 110000000, 128000000, 123000000, 63, '나인티 투 스톤 네크리스 플래티늄 및 옐로우 골드', '경매중', '2024-04-10 16:48:52', 'Female', 'Tiffany', NULL),
	(99, 1, '티파니 HardWear', 'themes/images/carousel/tiffany_item7.png', 'T1259', 100000000, 119000000, 115000000, 98, '라지 링크 브레이슬릿, 화이트 골드, 파베 다이아몬드 세팅', '경매중', '2024-04-10 16:48:52', 'Female', 'Tiffany', NULL),
	(100, 1, '티파니 빅토리아™', 'themes/images/carousel/tiffany_item8.png', 'T1077', 89000000, 95000000, 93000000, 22, '클러스터 테니스 브레이슬릿, 플래티늄, 다이아몬드 세팅', '경매중', '2024-04-10 16:48:52', 'Female', 'Tiffany', NULL),
	(101, 1, '티파니 Tiffany & Co. Schlumberger', 'themes/images/carousel/tiffany_item9.png', 'T9410', 70000000, 88000000, 83000000, 63, '아폴로 브로치 옐로우 골드 및 플래티늄 소재에 다이아몬드 세팅', '경매중', '2024-04-10 16:48:52', 'Female', 'Tiffany', NULL),
	(102, 1, '티파니 빅토리아™', 'themes/images/carousel/tiffany_item10.png', 'T9235', 70000000, 86000000, 78000000, 22, '믹스드 클러스터 드롭 이어링', '경매중', '2024-04-10 16:48:52', 'Female', 'Tiffany', NULL),
	(103, 1, '버버리 미니 나이트 백', 'themes/images/carousel/burberry_item1.png', 'B6500', 4500000, 6000000, 5500000, 33, '송아지 스웨이드 소재로 이탈리아에서 제작된 구조적인 백. 수작업으로 배치된 크리스털 디테일이 특징. 기마상 디자인(Equestrian Knight Design, EKD)에서 영감을 받은 클립 하드웨어를 다른 후프 링에 부착해 숄더 백에서 토트 스타일로 조절 가능.', '경매중', '2024-04-10 16:50:33', 'Female', 'Burberry', NULL),
	(104, 1, '버버리 스닙 백', 'themes/images/carousel/burberry_item2.png', 'B6551', 4000000, 5800000, 5400000, 23, '폭신한 나파 가죽 소재로 이탈리아에서 제작된 퀼팅 가방. 버버리 기마상 디자인(Equestrian Knight Design, EKD)의 창에서 영감을 받은 체인 스트랩이 돋보이는 아이템. B 모양 하드웨어 및 가죽 안감이 특징.', '경매중', '2024-04-10 16:50:33', 'Female', 'Burberry', NULL),
	(105, 1, '버버리 크리스털 스팅레이 클로그', 'themes/images/carousel/burberry_item3.png', 'B7900', 5200000, 7000000, 6400000, 36, '이탈리아에서 제작된 클로그. 크리스털 장식이 특징. 펀칭 디테일의 상단과 탈부착 가능한 기마상 디자인(Equestrian Knight Design, EKD) 참이 특별함을 더하는 아이템.', '경매중', '2024-04-10 16:50:33', 'Male', 'Burberry', NULL),
	(106, 1, '버버리 래더 재킷', 'themes/images/carousel/burberry_item4.png', 'B7500', 5300000, 7200000, 6800000, 22, '부드러운 가죽 소재로 이탈리아에서 제작된 레귤러핏의 바이커 재킷. 측면 탭의 스냅 단추를 사용해 허리선 조절 가능.', '경매중', '2024-04-10 16:50:33', 'Male', 'Burberry', NULL),
	(107, 1, '버버리 롱 나이트 하드웨어 태피터 트렌치코트', 'themes/images/carousel/burberry_item5.png', 'B5500', 3400000, 4900000, 4500000, 63, '경량 페이퍼 및 비스코스 원사로 직조된 태피터 소재의 트렌치코트. 이탈리아에서 제작되었으며, 수작업으로 그린 후 프린트된 버버리 주얼리 및 가방 하드웨어 아트워크 프린트가 돋보입니다. 스냅 단추 여밈, 안감 처리되지 않은 슬림핏 실루엣 및 래글런 소매가 특징입니다.', '경매중', '2024-04-10 16:50:33', 'Male', 'Burberry', NULL),
	(108, 1, '버버리 롱 레더 트렌치코트', 'themes/images/carousel/burberry_item6.png', 'B9500', 7000000, 8900000, 8600000, 23, '부드러운 플롱제 가죽 소재로 이탈리아에서 제작된 트렌치코트. 자카드직 버버리 체크가 연출된 탈착식 칼라가 돋보입니다. 부분 안감 처리된 릴랙스핏 실루엣이며 B 모양 버클 벨트를 사용해 로우, 미드, 하이 웨이스트의 세 가지 스타일로 착용할 수 있습니다.', '경매중', '2024-04-10 16:50:33', 'Female', 'Burberry', NULL),
	(109, 1, '버버리 크리스털 하이랜드 뮬가격', 'themes/images/carousel/burberry_item7.png', 'B8500', 6100000, 8000000, 7500000, 63, '크리스털 장식이 돋보이는 고무 소재로 이탈리아에서 제작된 뮬. 버버리 기마상 디자인(Equestrian Knight Design, EKD) 모양의 실리콘 참 및 청키한 밑창에 연출된 아카이브 스타일의 버버리 레터링이 특징.', '경매중', '2024-04-10 16:50:33', 'Female', 'Burberry', NULL),
	(110, 1, '버버리 레더 재킷', 'themes/images/carousel/burberry_item8.png', 'B7750', 5600000, 7000000, 6300000, 36, '그레이니 가죽 소재로 이탈리아에서 제작된 릴랙스핏 재킷. 측면 탭의 스냅 단추를 사용해 허리선 조절 가능.', '경매중', '2024-04-10 16:50:33', 'Female', 'Burberry', NULL),
	(111, 1, '버버리 나이트 하드웨어 드레스', 'themes/images/carousel/burberry_item9.png', 'B6987', 4900000, 6300000, 6000000, 63, '이탈리아에서 제작된 민소매 드레스. 수작업으로 그린 후 프린트된 버버리 주얼리 및 가방 하드웨어 아트워크가 돋보이는 아이템. 카울넥 및 펑크 스타일의 아일렛 트리밍 디테일이 특징이며, 유려한 레귤러핏 실루엣과 행커치프 밑단이 특별함을 더하는 디자인.', '경매중', '2024-04-10 16:50:33', 'Female', 'Burberry', NULL),
	(112, 1, '버버리 브로드리 앙글레즈 캔버스 팬츠', 'themes/images/carousel/burberry_item10.png', 'B6655', 4000000, 5900000, 5000000, 69, '경량 페이퍼 및 비스코스 원사로 직조된 캔버스 소재의 팬츠. 레귤러핏 아이템이며, 브로드리 앙글레즈 자수로 연출된 버버리 나이트 백 하드웨어, 스피어 체인 및 로즈 모노그램 패턴이 특징.', '경매중', '2024-04-10 16:50:33', 'Female', 'Burberry', NULL),
	(113, 1, '프라다 엑스트라 라지 프라다 갤러리아 스터드 장식 가죽 백', 'themes/images/carousel/prada_item1.png', 'P1070', 8000000, 9800000, 9300000, 52, '우아하고 활용도 높은 프라다 갤러리아 백은 산업적 정밀함과 정교하고 세심한 장인정신을 깔끔하고 세련된 가죽 디자인에 담아냈습니다. 80여 개의 개별 피스를 수작업으로 조립한 3개의 수납공간이 있는 스타일로, 다면적이면서 보편성을 지니고 있어 항상 새로운 해석을 위한 완벽한 캔버스가 됩니다. 엑스트라 라지 버전으로 선보이는 3개의 수납공간이 있는 디자인으로, 전체에 장식된 메탈 스터드가 아이코닉한 액세서리에 개성과 유니크함을 더합니다.', '경매중', '2024-04-10 17:10:22', 'Female', 'Prada', NULL),
	(114, 1, '프라다 나파 가죽 패치워크 드레스', 'themes/images/carousel/prada_item2.png', 'P2010', 17500000, 19500000, 18600000, 22, '빈티지 효과를 연출하는 나파 가죽 소재의 세련된 디자인의 드레스로, 빈티지 감성의 패치워크 모티프가 생동감을 더합니다. 슬리브리스 스타일로, 비즈, 메탈 스터드, 라인석으로 장식된 매력적인 레트로 스타일의 자수가 돋보이는 깔끔한 스트레이트 라인이 특징입니다. 프라다 미학 특유의 이원적 요소와 미묘한 대비를 번갈아 연출해 현대적인 우아함과 세련미를 표현합니다.', '경매중', '2024-04-10 17:10:22', 'Female', 'Prada', NULL),
	(115, 1, '프라다 자수 조젯 드레스', 'themes/images/carousel/prada_item3.png', 'P2090', 17600000, 19300000, 18300000, 25, '레트로에서 받은 영감과 흐르는 듯한 라인이 세련된 디자인을 연출하는 가벼운 조젯 드레스입니다. 이 우아하고 섬세한 스타일은 크리스털 장식의 반짝이는 기하학적 자수가 특징입니다. 프라다 미학 특유의 이원적 대비를 연출하는 정교하고 강조된 어깨로 가벼운 의류와 균형을 이룹니다.', '검수중', '2024-04-10 17:10:22', 'Female', 'Prada', NULL),
	(116, 1, '프라다 싱글브레스트 가죽 코트', 'themes/images/carousel/prada_item4.png', 'P2610', 20000000, 24000000, 22500000, 12, '포멀한 우아함과 사토리얼의 세련미를 상징하는 싱글브레스트 코트로 부드러운 텍스처로 장식된 깔끔한 컷이 특징입니다. 스트레이트 핏의 아우터와 현대적인 비율 및 유행을 타지 않는 디테일이 조화를 이룹니다. 컨셉추얼 디자인으로 재해석된 가죽 트라이앵글 로고가 아이코닉한 감각을 더합니다.', '경매중', '2024-04-10 17:10:22', 'Male', 'Prada', NULL),
	(117, 1, '프라다 가죽 카방 재킷', 'themes/images/carousel/prada_item5.png', 'P1570', 12000000, 14500000, 13900000, 89, '클래식한 룩은 장인의 노하우를 표현한 새로운 비율과 텍스처로 강조된 현대적인 디자인 구조의 출발점이 됩니다. 넓고 구조적인 숄더가 특징인 재킷으로, 특별한 빈티지 효과의 가죽으로 제작되어 개성과 유니크함을 더합니다. 후드에 장식된 에나멜 메탈 트라이앵글 로고가 모던하고 세련된 의류에 아이코닉한 감각을 더합니다.', '경매중', '2024-04-10 17:10:22', 'Male', 'Prada', NULL),
	(118, 1, '프라다 리나일론 및 악어 가죽 스마트폰 케이스', 'themes/images/carousel/prada_item6.png', 'P7050', 5000000, 6600000, 6200000, 21, '재생 나일론 원사인 혁신적인 리나일론과 악어 가죽 디테일이 있어 기능적이면서도 세련된 디자인의 스마트폰 케이스입니다. 탈부착형 숄더 스트랩이 달린 액세서리로 카드 슬롯 3개와 가죽 소재의 전면 지퍼 포켓이 있습니다. 에나멜 메탈 트라이앵글 로고가 아이코닉한 감성을 더합니다. 제품의 지속적인 관리와 보존을 위해 제품을 너무 자주 세탁하지 마시고 사용 후 반드시 통풍 시켜 주시기 바랍니다. 아울러 환경에 미치는 영향을 줄이기 위해 환경 친화적인 전문 드라이클리닝 업체에 제품을 맡기는 것을 권유 드립니다. ', '경매중', '2024-04-10 17:10:22', 'Male', 'Prada', NULL),
	(119, 1, '프라다 벨트가 달린 프라다 버클 라지 가죽 핸드백', 'themes/images/carousel/prada_item7.png', 'P7900', 5600000, 7100000, 6500000, 36, '깔끔한 라인과 세련된 요소를 통해 단순함과 디테일, 기능성과 우아함 사이를 넘나드는 프라다의 이원적인 미학을 표현합니다. 실용적이면서도 세련된 디자인에 브랜드의 스타일 코드를 담아낸 나파 인테리어의 가죽 백입니다. 액세서리를 더욱 돋보이게 하는 독특하고 현대적인 감각의 교체 가능한 벨트 등 다양한 감성의 넉넉한 디자인이 특징입니다. 22캐럿 금박 엠보싱 레터링 로고가 모던하고 활용도 높은 스타일을 장식합니다.', '경매중', '2024-04-10 17:10:22', 'Female', 'Prada', NULL),
	(120, 1, '프라다 플로럴 아플리케 장식 라지 프라다 갤러리아 가죽 백', 'themes/images/carousel/prada_item8.png', 'P1120', 8600000, 10000000, 9500000, 75, '우수성을 향한 끊임없는 노력은 프라다 DNA와 세련된 라인 및 고급 소재로 제작된 제품에 내재되어 있습니다. 우아하고 활용도 높은 프라다 갤러리아 백은 산업적 정밀함과 정교하고 세심한 장인정신을 깔끔하고 세련된 가죽 디자인에 담아냈습니다. 80여 개의 개별 피스를 수작업으로 조립한 3개의 수납공간이 있는 스타일로, 다면적이면서 보편성을 지니고 있어 항상 새로운 해석을 위한 완벽한 캔버스가 됩니다. 세련된 가죽 플로럴 아플리케가 독특하고 스타일리시한 감성으로 아이코닉한 액세서리를 장식합니다.', '경매중', '2024-04-10 17:10:22', 'Female', 'Prada', NULL),
	(121, 1, '프라다 모놀리스 브러시드 가죽 첼시 부츠', 'themes/images/carousel/prada_item9.png', 'P2005', 1000000, 1800000, 1500000, 6, '브랜드 미학의 필수 요소인 이중성의 개념을 강조한 독특하고 대담한 슈즈입니다. 독특한 모놀리식의 디자인이 인상적인 모더니스트 스타일의 맥시한 밑창이 엄격한 룩과 광택 마감을 특징으로 하는 브러시드 가죽 갑피와의 대화를 만들어 냅니다. 하이브리드이면서 조화로운 소울이 특징인 모놀리식 라인은 정반대의 이미지와 결합하여 시대를 초월하는 실루엣을 연출합니다.', '경매중', '2024-04-10 17:10:22', 'Male', 'Prada', NULL),
	(122, 1, '프라다 핑퐁 패들', 'themes/images/carousel/prada_item10.png', 'P3000', 2000000, 2900000, 2600000, 26, '프라다는 스포츠 활동을 사랑하는 사람을 위해 디자인한 라이프 스타일 장비와 액세서리를 선보입니다. 브랜드의 독특하고 매끈한 미학이 특징인 핑퐁 패들로, 핑퐁 볼과 해양에서 수거한 재생 플라스틱 소재에서 얻은 프라다의 아이코닉한 패브릭인 리나일론 소재의 더블 케이스도 함께 제공됩니다.', '경매중', '2024-04-10 17:10:22', 'Male', 'Prada', NULL),
	(123, 1, '행겨', 'themes/images/products/다운로드.jpg', NULL, 24445, 55533, NULL, 0, '343', '검수중', '2024-04-12 02:11:34', NULL, 'Gucci', 12);

-- 테이블 LUX.reviews 구조 내보내기
CREATE TABLE IF NOT EXISTS `reviews` (
  `ReviewID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `AuthorID` int DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  `Content` text,
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `RPhoto` varchar(255) CHARACTER SET euckr COLLATE euckr_korean_ci DEFAULT NULL,
  `ReviewName` varchar(255) CHARACTER SET euckr COLLATE euckr_korean_ci DEFAULT NULL,
  PRIMARY KEY (`ReviewID`),
  KEY `ProductID` (`ProductID`),
  KEY `AuthorID` (`AuthorID`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`AuthorID`) REFERENCES `users` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=euckr;

-- 테이블 데이터 LUX.reviews:~9 rows (대략적) 내보내기
INSERT IGNORE INTO `reviews` (`ReviewID`, `ProductID`, `AuthorID`, `Rating`, `Content`, `CreatedAt`, `RPhoto`, `ReviewName`) VALUES
	(1, 1, 1, 5, '매우 만족합니다.', '2024-03-27 12:50:19', NULL, NULL),
	(2, 2, 2, 4, '좋아요, 다음에 또 구매할게요.', '2024-03-27 12:50:19', NULL, NULL),
	(8, NULL, NULL, 5, 'ㅈㄷㅈㄷ', '2024-04-11 09:48:03', 'themes/images/review/play.png', 'ㅈㄷㅈ'),
	(9, NULL, NULL, 4, 'ㅈㄷㅈ', '2024-04-11 09:54:18', 'themes/images/review/play.png', 'ㅈㄷ'),
	(10, NULL, NULL, 5, 'ㄱㄱㅈ', '2024-04-11 09:56:00', 'themes/images/review/메인페이지.png', 'ㅈㄷㅈㄱ'),
	(11, NULL, NULL, 5, 'ㅅㄷㅅㄷㅅ', '2024-04-11 09:56:41', 'themes/images/review/KakaoTalk_20240321_152232566.png', 'ㄷㅅㄷㅅㄷ'),
	(12, NULL, NULL, 5, 'ㅈㄷㅈㄷ', '2024-04-11 10:01:25', 'themes/images/review/KakaoTalk_20240321_152232566.png', '전현규'),
	(13, NULL, NULL, 5, 'ㄷㄳㄷ', '2024-04-11 10:16:09', 'themes/images/review/23.png', 'ㄷㄳㄷㄳ'),
	(14, NULL, NULL, 1, 'ㅈㅇㅈㅇ', '2024-04-11 10:17:56', 'themes/images/review/메인페이지.png', 'ㅇㅈㅇㅈ');

-- 테이블 LUX.users 구조 내보내기
CREATE TABLE IF NOT EXISTS `users` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `gender` enum('M','F','Other') NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `birthdate` date DEFAULT NULL,
  `balance` int DEFAULT '0',
  `postcode` varchar(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `detailaddress` varchar(255) DEFAULT NULL,
  `extraaddress` varchar(255) DEFAULT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userID`) USING BTREE,
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=euckr;

-- 테이블 데이터 LUX.users:~6 rows (대략적) 내보내기
INSERT IGNORE INTO `users` (`userID`, `username`, `password`, `email`, `name`, `gender`, `phone`, `created_at`, `birthdate`, `balance`, `postcode`, `address`, `detailaddress`, `extraaddress`, `isAdmin`) VALUES
	(1, 'jhk0004', '655d2dd7a6614c9970ed4eb02ebfc91ea1b5d4e4b0346d761dcd1be739997979', 'gusrb000416@gmail.com', '전현규', 'M', '010-8408-6634', '2024-04-10 06:46:19', '2017-02-09', 106800, NULL, NULL, NULL, NULL, 0),
	(2, 'aa2222', '655d2dd7a6614c9970ed4eb02ebfc91ea1b5d4e4b0346d761dcd1be739997979', 'gusrb000222@gmail.com', '전현규', 'M', '010-5353-3535', '2024-04-10 06:52:09', '2022-02-01', 100000, NULL, NULL, NULL, NULL, 0),
	(3, 'als2507', '655d2dd7a6614c9970ed4eb02ebfc91ea1b5d4e4b0346d761dcd1be739997979', 'gusrb0004@naver.com', '노영현', 'M', '010-8408-6634', '2024-04-10 12:18:44', '2000-04-14', 0, '48048', '부산 해운대구 해운대로76번길 55', '106동 2803호', '재송동, 센텀이편한세상아파트', 0),
	(4, 'jhk000416', '655d2dd7a6614c9970ed4eb02ebfc91ea1b5d4e4b0346d761dcd1be739997979', 'gusrb000424@naver.com', '전영진', 'M', '010-8408-6848', '2024-04-11 05:10:48', '2024-04-20', 0, '48048', '부산 해운대구 해운대로76번길 55', '204호', '재송동, 센텀이편한세상아파트', 0),
	(5, 'asd123', '6f83af1c18071d2ac0e93e42eecef1495f8f50747d33dca1094e5a366c1cc73e', 'asd@asd.com', '여동한', 'M', '010-6345-0179', '2024-04-11 17:47:58', '1999-04-23', 0, '46773', '부산 강서구 명지국제5로 60', '108-702', '명지동, 에일린의뜰', 0),
	(6, 'asd1234', 'ca1a487c81897fbf8629b8031a660ec833d259b67170a0c00d1375bd4f984287', 'ddd@asd.com', '김감자', 'M', '010-8888-7777', '2024-04-11 18:37:54', '2024-03-27', 8000000, '49419', '부산 사하구 비봉로 42', '102-1301', '신평동, 한신아파트', 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
