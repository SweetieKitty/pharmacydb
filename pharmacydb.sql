-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Дек 23 2024 г., 06:45
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `pharmacydb`
--

-- --------------------------------------------------------

--
-- Структура таблицы `customers`
--

CREATE TABLE `customers` (
  `CustomerID` int(11) NOT NULL,
  `FullName` varchar(100) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `customers`
--

INSERT INTO `customers` (`CustomerID`, `FullName`, `Phone`, `Email`, `Address`) VALUES
(1, 'Alice Johnson', '321654987', 'alice.johnson@gmail.com', '123 Maple Street'),
(2, 'Bob Carter', '654987321', 'bob.carter@gmail.com', '456 Oak Avenue'),
(3, 'Clara Wilson', '789123456', 'clara.wilson@gmail.com', '789 Pine Road');

-- --------------------------------------------------------

--
-- Структура таблицы `medicines`
--

CREATE TABLE `medicines` (
  `MedicineID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Brand` varchar(100) DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `ExpiryDate` date DEFAULT NULL,
  `SupplierID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `medicines`
--

INSERT INTO `medicines` (`MedicineID`, `Name`, `Brand`, `Price`, `Quantity`, `ExpiryDate`, `SupplierID`) VALUES
(1, 'Paracetamol', 'PharmaCorp', 2.50, 100, '2025-06-30', 1),
(2, 'Ibuprofen', 'HealthSupplies', 3.20, 150, '2025-12-15', 2),
(3, 'Cough Syrup', 'MediGlobal', 4.75, 50, '2024-09-01', 3),
(4, 'Vitamin C', 'PharmaCorp', 1.20, 200, '2026-03-20', 1),
(5, 'Antibiotic Ointment', 'HealthSupplies', 5.50, 80, '2025-08-10', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `OrderDate` date DEFAULT curdate(),
  `TotalAmount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`OrderID`, `CustomerID`, `OrderDate`, `TotalAmount`) VALUES
(1, 1, '2024-12-16', 12.50),
(2, 2, '2024-12-16', 9.75),
(3, 3, '2024-12-16', 5.50);

-- --------------------------------------------------------

--
-- Структура таблицы `order_items`
--

CREATE TABLE `order_items` (
  `OrderItemID` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `MedicineID` int(11) DEFAULT NULL,
  `Quantity` int(11) NOT NULL,
  `Price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `order_items`
--

INSERT INTO `order_items` (`OrderItemID`, `OrderID`, `MedicineID`, `Quantity`, `Price`) VALUES
(1, 1, 1, 2, 5.00),
(2, 1, 4, 5, 6.00),
(3, 2, 2, 3, 9.60),
(4, 3, 5, 1, 5.50);

-- --------------------------------------------------------

--
-- Структура таблицы `suppliers`
--

CREATE TABLE `suppliers` (
  `SupplierID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `ContactName` varchar(100) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `suppliers`
--

INSERT INTO `suppliers` (`SupplierID`, `Name`, `ContactName`, `Phone`, `Email`) VALUES
(1, 'PharmaCorp', 'John Doe', '123456789', 'john@pharmacorp.com'),
(2, 'HealthSupplies', 'Jane Smith', '987654321', 'jane@healthsupplies.com'),
(3, 'MediGlobal', 'Robert Brown', '555666777', 'robert@mediglobal.com');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Индексы таблицы `medicines`
--
ALTER TABLE `medicines`
  ADD PRIMARY KEY (`MedicineID`),
  ADD KEY `idx_medicine_supplier` (`SupplierID`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `idx_order_customer` (`CustomerID`);

--
-- Индексы таблицы `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`OrderItemID`),
  ADD KEY `idx_order_item_order` (`OrderID`),
  ADD KEY `idx_order_item_medicine` (`MedicineID`);

--
-- Индексы таблицы `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`SupplierID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `customers`
--
ALTER TABLE `customers`
  MODIFY `CustomerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `medicines`
--
ALTER TABLE `medicines`
  MODIFY `MedicineID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `order_items`
--
ALTER TABLE `order_items`
  MODIFY `OrderItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `SupplierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `medicines`
--
ALTER TABLE `medicines`
  ADD CONSTRAINT `FK_medicines_supplier` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK_orders_customer` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `FK_order_items_medicine` FOREIGN KEY (`MedicineID`) REFERENCES `medicines` (`MedicineID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_order_items_order` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
