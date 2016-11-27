-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 21, 2016 at 10:04 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `venturasecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `CategoryID` int(11) NOT NULL,
  `CategoryName` varchar(50) DEFAULT NULL,
  `CategoryDescription` tinytext,
  `Picture` varchar(255) DEFAULT NULL COMMENT 'Picture path/name',
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `manufactures`
--

CREATE TABLE IF NOT EXISTS `manufactures` (
  `ManufacturerID` int(11) NOT NULL,
  `ManufacturerName` varchar(45) DEFAULT NULL,
  `Details` tinytext,
  PRIMARY KEY (`ManufacturerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `OrderID` int(11) NOT NULL,
  `TotalAmount` decimal(18,2) DEFAULT NULL,
  `OrderDate` timestamp NULL DEFAULT NULL,
  `RequiredDate` date DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL COMMENT 'Ordered, Preparing to Deliver, Delivered, Cancelled',
  `Note` varchar(255) DEFAULT NULL,
  `ShipName` varchar(100) DEFAULT NULL,
  `ShipAddress` varchar(255) DEFAULT NULL,
  `ShipCity` varchar(45) DEFAULT NULL,
  `ShipState` varchar(45) DEFAULT NULL,
  `ShipZip` varchar(45) DEFAULT NULL,
  `ShipCountry` varchar(45) DEFAULT NULL,
  `Phone` varchar(45) DEFAULT NULL,
  `ShipDate` timestamp NULL DEFAULT NULL,
  `Freight` decimal(10,2) DEFAULT NULL,
  `PaymentID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  PRIMARY KEY (`OrderID`,`PaymentID`,`UserID`),
  KEY `fk_orders_payments1_idx` (`PaymentID`),
  KEY `fk_orders_users1_idx` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE IF NOT EXISTS `order_details` (
  `DetailsID` int(11) NOT NULL,
  `Price` decimal(18,2) DEFAULT NULL,
  `Quantity` int(8) DEFAULT NULL,
  `Total` decimal(18,2) DEFAULT NULL,
  `OrderID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  PRIMARY KEY (`DetailsID`,`OrderID`,`ProductID`),
  KEY `fk_order_details_orders1_idx` (`OrderID`),
  KEY `fk_order_details_products1_idx` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE IF NOT EXISTS `payments` (
  `PaymentID` int(11) NOT NULL,
  `Amount` decimal(18,2) DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `PayDate` timestamp NULL DEFAULT NULL,
  `Note` varchar(255) DEFAULT NULL,
  `CardNo` varchar(45) DEFAULT NULL,
  `CardExpMo` int(2) DEFAULT NULL,
  `CardExpYr` int(2) DEFAULT NULL,
  `CardHolderName` varchar(45) DEFAULT NULL,
  `Currency` varchar(45) DEFAULT NULL,
  `PaymentMethodID` int(11) NOT NULL,
  PRIMARY KEY (`PaymentID`,`PaymentMethodID`),
  KEY `fk_payments_payment_methods1_idx` (`PaymentMethodID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE IF NOT EXISTS `payment_methods` (
  `PaymentMethodID` int(11) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Details` text,
  PRIMARY KEY (`PaymentMethodID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `ProductID` int(11) NOT NULL,
  `ProductName` varchar(150) DEFAULT NULL,
  `ProductDescription` text,
  `ProductImages` varchar(200) DEFAULT NULL COMMENT 'add product images links,path/name.ext separated by comma.',
  `ProductPrice` decimal(18,2) DEFAULT NULL,
  `ProductStatus` varchar(45) DEFAULT NULL COMMENT 'Published/Public,\nPrivate,\nDraft',
  `ProductUpdated` timestamp NULL DEFAULT NULL,
  `SKU` varchar(45) DEFAULT NULL,
  `Availabe` varchar(45) DEFAULT NULL,
  `ManufacturerID` int(11) NOT NULL,
  PRIMARY KEY (`ProductID`),
  KEY `fk_products_manufactures_idx` (`ManufacturerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `products_categories`
--

CREATE TABLE IF NOT EXISTS `products_categories` (
  `ProductID` int(11) NOT NULL COMMENT 'Relation Table ',
  `CategoryID` int(11) NOT NULL COMMENT 'Relation Table ',
  PRIMARY KEY (`ProductID`,`CategoryID`),
  KEY `fk_products_has_categories_categories1_idx` (`CategoryID`),
  KEY `fk_products_has_categories_products1_idx` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `UserID` int(11) NOT NULL,
  `FirstName` varchar(45) DEFAULT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `UserName` varchar(45) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Role` varchar(45) DEFAULT NULL COMMENT 'Administrator, Contributor,  Editor, Public/Customer',
  `Registered` datetime DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `ActivationKey` varchar(100) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `Country` varchar(45) DEFAULT NULL,
  `Zip` varchar(45) DEFAULT NULL,
  `ContactNumber` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_payments1` FOREIGN KEY (`PaymentID`) REFERENCES `payments` (`PaymentID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_users1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `fk_order_details_orders1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_order_details_products1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_payment_methods1` FOREIGN KEY (`PaymentMethodID`) REFERENCES `payment_methods` (`PaymentMethodID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_manufactures` FOREIGN KEY (`ManufacturerID`) REFERENCES `manufactures` (`ManufacturerID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `products_categories`
--
ALTER TABLE `products_categories`
  ADD CONSTRAINT `fk_products_has_categories_products1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_products_has_categories_categories1` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
