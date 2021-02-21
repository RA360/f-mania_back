-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 28, 2020 at 12:10 AM
-- Server version: 10.3.22-MariaDB
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `f-mania`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `color_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `product_id`, `color_id`, `size_id`, `quantity`) VALUES
(24, 12, 1, 1, 1, 1),
(31, 38, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `title`) VALUES
(1, 'Suits'),
(2, 'Shirts'),
(3, 'Trousers'),
(4, 'Weddings'),
(5, 'Jackets');

-- --------------------------------------------------------

--
-- Table structure for table `colors`
--

CREATE TABLE `colors` (
  `id` int(11) NOT NULL,
  `color` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `colors`
--

INSERT INTO `colors` (`id`, `color`) VALUES
(1, 'Black'),
(2, 'Orange'),
(3, 'Blue'),
(4, 'Brown'),
(5, 'Dark Green');

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `img` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `product_id`, `img`) VALUES
(1, 1, 'goods1.jpg'),
(7, 2, 'goods2.jpg'),
(8, 3, 'goods3.jpg'),
(9, 4, 'goods4.jpg'),
(10, 5, 'goods5.jpg'),
(11, 6, 'goods6.jpg'),
(12, 7, 'goods7.jpg'),
(13, 8, 'goods8.jpg'),
(14, 9, 'goods9.jpg'),
(15, 10, 'goods10.jpg'),
(16, 11, 'goods11.jpg'),
(17, 12, 'goods12.jpg'),
(18, 13, 'goods13.jpg'),
(19, 14, 'goods14.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `color_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `offers`
--

INSERT INTO `offers` (`id`, `product_id`, `color_id`, `size_id`, `quantity`) VALUES
(1, 1, 1, 1, 12),
(2, 1, 2, 3, 113),
(4, 1, 1, 3, 12),
(5, 1, 3, 1, 12),
(6, 1, 4, 3, 113),
(7, 1, 5, 4, 43),
(8, 1, 5, 3, 12),
(9, 1, 5, 5, 43),
(10, 1, 5, 6, 12),
(11, 2, 1, 1, 12),
(12, 2, 2, 3, 113),
(13, 2, 1, 3, 12),
(14, 2, 3, 1, 12),
(15, 2, 4, 3, 113),
(16, 2, 5, 4, 43),
(17, 2, 5, 3, 12),
(18, 2, 5, 5, 43),
(19, 2, 5, 6, 12),
(20, 3, 1, 1, 12),
(21, 3, 2, 3, 113),
(22, 3, 1, 3, 12),
(23, 3, 3, 1, 12),
(24, 3, 4, 3, 113),
(25, 3, 5, 4, 43),
(26, 3, 5, 3, 12),
(27, 3, 5, 5, 43),
(28, 3, 5, 6, 12),
(29, 4, 1, 1, 12),
(30, 4, 2, 3, 113),
(31, 4, 1, 3, 12),
(32, 4, 3, 1, 12),
(33, 4, 4, 3, 113),
(34, 4, 5, 4, 43),
(35, 4, 5, 3, 12),
(36, 4, 5, 5, 43),
(37, 4, 5, 6, 12),
(38, 5, 1, 1, 12),
(39, 5, 2, 3, 113),
(40, 5, 1, 3, 12),
(41, 5, 3, 1, 12),
(42, 5, 4, 3, 113),
(43, 5, 5, 4, 43),
(44, 5, 5, 3, 12),
(45, 5, 5, 5, 43),
(46, 5, 5, 6, 12),
(47, 6, 1, 1, 12),
(48, 6, 2, 3, 113),
(49, 6, 1, 3, 12),
(50, 6, 3, 1, 12),
(51, 6, 4, 3, 113),
(52, 6, 5, 4, 43),
(53, 6, 5, 3, 12),
(54, 6, 5, 5, 43),
(55, 6, 5, 6, 12),
(56, 7, 1, 1, 12),
(57, 7, 2, 3, 113),
(58, 7, 1, 3, 12),
(59, 7, 3, 1, 12),
(60, 7, 4, 3, 113),
(61, 7, 5, 4, 43),
(62, 7, 5, 3, 12),
(63, 7, 5, 5, 43),
(64, 7, 5, 6, 12),
(65, 8, 1, 1, 12),
(66, 8, 2, 3, 113),
(67, 8, 1, 3, 12),
(68, 8, 3, 1, 12),
(69, 8, 4, 3, 113),
(70, 8, 5, 4, 43),
(71, 8, 5, 3, 12),
(72, 8, 5, 5, 43),
(73, 8, 5, 6, 12),
(74, 9, 1, 1, 12),
(75, 9, 2, 3, 113),
(76, 9, 1, 3, 12),
(77, 9, 3, 1, 12),
(78, 9, 4, 3, 113),
(79, 9, 5, 4, 43),
(80, 9, 5, 3, 12),
(81, 9, 5, 5, 43),
(82, 9, 5, 6, 12),
(83, 10, 1, 1, 12),
(84, 10, 2, 3, 113),
(85, 10, 1, 3, 12),
(86, 10, 3, 1, 12),
(87, 10, 4, 3, 113),
(88, 10, 5, 4, 43),
(89, 10, 5, 3, 12),
(90, 10, 5, 5, 43),
(91, 10, 5, 6, 12),
(92, 11, 1, 1, 12),
(93, 11, 2, 3, 113),
(94, 11, 1, 3, 12),
(95, 11, 3, 1, 12),
(96, 11, 4, 3, 113),
(97, 11, 5, 4, 43),
(98, 11, 5, 3, 12),
(99, 11, 5, 5, 43),
(100, 11, 5, 6, 12),
(101, 12, 1, 1, 12),
(102, 12, 2, 3, 113),
(103, 12, 1, 3, 12),
(104, 12, 3, 1, 12),
(105, 12, 4, 3, 113),
(106, 12, 5, 4, 43),
(107, 12, 5, 3, 12),
(108, 12, 5, 5, 43),
(109, 12, 5, 6, 12),
(110, 13, 1, 1, 12),
(111, 13, 2, 3, 113),
(112, 13, 1, 3, 12),
(113, 13, 3, 1, 12),
(114, 13, 4, 3, 113),
(115, 13, 5, 4, 43),
(116, 13, 5, 3, 12),
(117, 13, 5, 5, 43),
(118, 13, 5, 6, 12),
(119, 14, 1, 1, 12),
(120, 14, 2, 3, 113),
(121, 14, 1, 3, 12),
(122, 14, 3, 1, 12),
(123, 14, 4, 3, 113),
(124, 14, 5, 4, 43),
(125, 14, 5, 3, 12),
(126, 14, 5, 5, 43),
(127, 14, 5, 6, 12);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `color_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `product_id`, `color_id`, `size_id`, `date`) VALUES
(1, 12, 1, 2, 3, '2020-09-01'),
(2, 12, 1, 1, 2, '2020-09-01'),
(3, 12, 3, 1, 2, '2020-09-01'),
(4, 12, 3, 1, 3, '2020-09-01'),
(5, 12, 2, 3, 1, '2020-09-01'),
(6, 12, 4, 4, 3, '2020-09-01'),
(7, 12, 5, 3, 1, '2020-09-01');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `price` decimal(11,2) NOT NULL,
  `category_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `text`, `price`, `category_id`) VALUES
(1, 'Magnoom Slim Women Blue Jeans', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '199.00', '3'),
(2, 'Net Semi-stitched Suits', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '23.00', '1'),
(3, 'Net Semi-stitched Jacket', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '98.00', '5'),
(4, 'Net Semi-stitched Wedding', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '45.00', '4'),
(5, 'Net Semi-stitched Shirts', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '764.56', '2'),
(6, 'Magnoom Slim Women Blue Jeans', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '65.00', '3'),
(7, 'Net Semi-stitched Shirts', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '67.00', '2'),
(8, 'Net Semi-stitched Shirts', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '232.00', '5'),
(9, 'Net Semi-stitched Suits', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '123.00', '1'),
(10, 'Net Semi-stitched Jacket', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '98.00', '5'),
(11, 'Net Semi-stitched Wedding', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '45.00', '4'),
(12, 'Net Semi-stitched Shirts', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '764.00', '2'),
(13, 'Magnoom Slim Women Blue Jeans', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '65.00', '3'),
(14, 'Net Semi-stitched Shirts', 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.', '67.00', '2');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `rating` varchar(1) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `product_id`, `text`, `rating`, `date`) VALUES
(1, 12, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque feugiat metus lorem, quis aliquam quam lacinia id. Aenean arcu leo, viverra sit amet justo id, porttitor vulputate justo. Sed ultricies facilisis consequat. ', '4', '2020-07-13'),
(2, 12, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque feugiat metus lorem, quis aliquam quam lacinia id. Aenean arcu leo, viverra sit amet justo id, porttitor vulputate justo. Sed ultricies facilisis consequat. ', '3', '2020-07-13'),
(13, 38, 1, 'asa', '4', '2020-09-19'),
(14, 38, 1, 'asa', '4', '2020-09-19');

-- --------------------------------------------------------

--
-- Table structure for table `sizes`
--

CREATE TABLE `sizes` (
  `id` int(11) NOT NULL,
  `size` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sizes`
--

INSERT INTO `sizes` (`id`, `size`) VALUES
(1, '2XS'),
(2, 'XS'),
(3, 'S'),
(4, 'M'),
(5, 'L'),
(6, 'XL'),
(7, '2XL'),
(8, '3XL');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `subscribers`
--

INSERT INTO `subscribers` (`id`, `email`) VALUES
(8, 'adqiuofdbdq@mail.ru'),
(9, 'askerov.ibraqim@mail.ru'),
(7, 'sadqiuofdbdq@mail.ru');

-- --------------------------------------------------------

--
-- Table structure for table `thumbs`
--

CREATE TABLE `thumbs` (
  `id` int(11) NOT NULL,
  `img_id` int(11) NOT NULL,
  `thumb` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `thumbs`
--

INSERT INTO `thumbs` (`id`, `img_id`, `thumb`) VALUES
(8, 7, 'goods2-thumb1.jpg'),
(9, 8, 'goods3-thumb1.jpg'),
(10, 9, 'goods4-thumb1.jpg'),
(11, 10, 'goods5-thumb1.jpg'),
(12, 11, 'goods6-thumb1.jpg'),
(13, 12, 'goods7-thumb1.jpg'),
(14, 13, 'goods8-thumb1.jpg'),
(15, 14, 'goods9-thumb1.jpg'),
(16, 15, 'goods10-thumb1.jpg'),
(17, 16, 'goods11-thumb1.jpg'),
(18, 17, 'goods12-thumb1.jpg'),
(19, 18, 'goods13-thumb1.jpg'),
(20, 1, 'goods1-thumb1.jpg'),
(21, 19, 'goods14-thumb1.jpg'),
(22, 1, 'goods1-thumb1.jpg'),
(23, 1, 'goods1-thumb1.jpg'),
(24, 1, 'goods1-thumb1.jpg'),
(25, 1, 'goods1-thumb1.jpg'),
(26, 1, 'goods1-thumb1.jpg'),
(27, 7, 'goods2-thumb1.jpg'),
(28, 8, 'goods3-thumb1.jpg'),
(29, 9, 'goods4-thumb1.jpg'),
(30, 10, 'goods5-thumb1.jpg'),
(31, 11, 'goods6-thumb1.jpg'),
(32, 12, 'goods7-thumb1.jpg'),
(33, 13, 'goods8-thumb1.jpg'),
(34, 14, 'goods9-thumb1.jpg'),
(35, 15, 'goods10-thumb1.jpg'),
(36, 16, 'goods11-thumb1.jpg'),
(37, 17, 'goods12-thumb1.jpg'),
(38, 18, 'goods13-thumb1.jpg'),
(39, 19, 'goods14-thumb1.jpg'),
(40, 7, 'goods2-thumb1.jpg'),
(41, 8, 'goods3-thumb1.jpg'),
(42, 9, 'goods4-thumb1.jpg'),
(43, 10, 'goods5-thumb1.jpg'),
(44, 11, 'goods6-thumb1.jpg'),
(45, 12, 'goods7-thumb1.jpg'),
(46, 13, 'goods8-thumb1.jpg'),
(47, 14, 'goods9-thumb1.jpg'),
(48, 15, 'goods10-thumb1.jpg'),
(49, 16, 'goods11-thumb1.jpg'),
(50, 17, 'goods12-thumb1.jpg'),
(51, 18, 'goods13-thumb1.jpg'),
(52, 19, 'goods14-thumb1.jpg'),
(53, 7, 'goods2-thumb1.jpg'),
(54, 8, 'goods3-thumb1.jpg'),
(55, 9, 'goods4-thumb1.jpg'),
(56, 10, 'goods5-thumb1.jpg'),
(57, 11, 'goods6-thumb1.jpg'),
(58, 12, 'goods7-thumb1.jpg'),
(59, 13, 'goods8-thumb1.jpg'),
(60, 14, 'goods9-thumb1.jpg'),
(61, 15, 'goods10-thumb1.jpg'),
(62, 16, 'goods11-thumb1.jpg'),
(63, 17, 'goods12-thumb1.jpg'),
(64, 18, 'goods13-thumb1.jpg'),
(65, 19, 'goods14-thumb1.jpg'),
(66, 7, 'goods2-thumb1.jpg'),
(67, 8, 'goods3-thumb1.jpg'),
(68, 9, 'goods4-thumb1.jpg'),
(69, 10, 'goods5-thumb1.jpg'),
(70, 11, 'goods6-thumb1.jpg'),
(71, 12, 'goods7-thumb1.jpg'),
(72, 13, 'goods8-thumb1.jpg'),
(73, 14, 'goods9-thumb1.jpg'),
(74, 15, 'goods10-thumb1.jpg'),
(75, 16, 'goods11-thumb1.jpg'),
(76, 17, 'goods12-thumb1.jpg'),
(77, 18, 'goods13-thumb1.jpg'),
(78, 19, 'goods14-thumb1.jpg'),
(79, 7, 'goods2-thumb1.jpg'),
(80, 8, 'goods3-thumb1.jpg'),
(81, 9, 'goods4-thumb1.jpg'),
(82, 10, 'goods5-thumb1.jpg'),
(83, 11, 'goods6-thumb1.jpg'),
(84, 12, 'goods7-thumb1.jpg'),
(85, 13, 'goods8-thumb1.jpg'),
(86, 14, 'goods9-thumb1.jpg'),
(87, 15, 'goods10-thumb1.jpg'),
(88, 16, 'goods11-thumb1.jpg'),
(89, 17, 'goods12-thumb1.jpg'),
(90, 18, 'goods13-thumb1.jpg'),
(91, 19, 'goods14-thumb1.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstName`, `lastName`, `email`, `phone`, `password`) VALUES
(12, 'John', 'Doe', 'tester@mail.ru', '98845645', '$argon2i$v=19$m=65536,t=4,p=1$ME0yM3ozY0R4Ly5BcXM3aw$VCTVT2Ic0D9s46Dm4xJ6umdqMCB7vf3nYp2oOKJwZ4c'),
(38, 'Ibrahim', 'Askarov', 'askerov.ibraqim@mail.ru', NULL, '$argon2i$v=19$m=65536,t=4,p=1$VG52VnM1V3Y5cDZ2RjhGcw$W/oZFfGKATgyf2XINJ30yA1Glaa1+zkw5E2N/TB8W7g');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`id`, `user_id`, `product_id`) VALUES
(8, 12, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `info` (`user_id`,`product_id`,`color_id`,`size_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `colors`
--
ALTER TABLE `colors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sizes`
--
ALTER TABLE `sizes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `thumbs`
--
ALTER TABLE `thumbs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `info` (`user_id`,`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `colors`
--
ALTER TABLE `colors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `offers`
--
ALTER TABLE `offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `sizes`
--
ALTER TABLE `sizes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `thumbs`
--
ALTER TABLE `thumbs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
