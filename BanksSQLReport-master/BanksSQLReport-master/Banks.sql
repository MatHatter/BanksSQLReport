create table Citi_Earnings (RowNumber int IDENTITY(1,1) PRIMARY KEY, Filing_Quarter nvarchar(10), Commissions_and_Fees int, Administration_and_Other_Fiduciary_Fees int,
Investment_Banking int, Principal_Transactions int, Other int, Total_Non_Interest_Revenue int,
Net_Interest_Revenue_including_Dividends int, Total_Revenues_Net_of_Interest_Expense int,
Total_Operating_Expenses int, Provisions_for_Credit_Losses_and_for_Benefits_and_Claims int,
Income_from_Continuing_Operations_before_Taxes int, Income_Taxes int, Income_from_Continuing_Operations int,
Noncontrolling_Interests int, Net_Income int);

CREATE TABLE Goldman_Earnings (RowNumber int IDENTITY(1,1) PRIMARY KEY, Filing_Quarter nvarchar(10), Investment_banking int,
Investment_management int NULL, Trading_and_principle_investments int NULL, Asset_management_and_securities_services int NULL, Commissions_and_fees int NULL,
Market_making int NULL, Other_principle_transactions int NULL,
Total_non_interest_revenues int, Net_interest_income int,
Total_net_revenues int, Provision_for_credit_losses int NULL,
Total_operating_expenses int, Pre_tax_earnings int,
Provision_for_taxes int, Net_earnings int);

/* Checking if Total_Non_Interest_Revenue added up to its total */
SELECT Citi_Earnings.Filing_Quarter, Total_Non_Interest_Revenue, a.Total_Against, (a.Total_Against - Total_Non_Interest_Revenue) as Subtracted_total
FROM Citi_Earnings JOIN (SELECT Filing_Quarter, (Commissions_and_Fees + Administration_and_Other_Fiduciary_Fees + Investment_Banking + Principal_Transactions + Other) as Total_Against FROM Citi_Earnings)  a ON Citi_Earnings.Filing_Quarter = a.Filing_Quarter;
/* Checking if Total_Revenues_Net_of_Interest_Expense added up to its total */
SELECT Citi_Earnings.Filing_Quarter, Total_Revenues_Net_of_Interest_Expense, a.Total_Against, (a.Total_Against - Total_Revenues_Net_of_Interest_Expense) as Subtracted_total
FROM Citi_Earnings JOIN (SELECT Filing_Quarter, (Total_Non_Interest_Revenue + Net_Interest_Revenue_including_Dividends) as Total_Against FROM Citi_Earnings)  a ON Citi_Earnings.Filing_Quarter = a.Filing_Quarter;
/* Checking if Income_from_Continuing_Operations_before_Taxes added up to its total */
SELECT Citi_Earnings.Filing_Quarter, Income_from_Continuing_Operations_before_Taxes, a.Total_Against, (a.Total_Against - Income_from_Continuing_Operations_before_Taxes) as Subtracted_total
FROM Citi_Earnings JOIN (SELECT Filing_Quarter, (Total_Revenues_Net_of_Interest_Expense - Total_Operating_Expenses - Provisions_for_Credit_Losses_and_for_Benefits_and_Claims) as Total_Against FROM Citi_Earnings)  a ON Citi_Earnings.Filing_Quarter = a.Filing_Quarter;
/* Checking if Income_from_Continuing_Operations added up to its total */
SELECT Citi_Earnings.Filing_Quarter, Income_from_Continuing_Operations, a.Total_Against, (a.Total_Against - Income_from_Continuing_Operations) as Subtracted_total
FROM Citi_Earnings JOIN (SELECT Filing_Quarter, (Income_from_Continuing_Operations_before_Taxes - Income_Taxes) as Total_Against FROM Citi_Earnings)  a ON Citi_Earnings.Filing_Quarter = a.Filing_Quarter;
/* Checking if Net_Income added up to its total */
SELECT Citi_Earnings.Filing_Quarter, Net_Income, a.Total_Against, (a.Total_Against - Net_Income) as Subtracted_total
FROM Citi_Earnings JOIN (SELECT Filing_Quarter, (Income_from_Continuing_Operations - Noncontrolling_Interests) as Total_Against FROM Citi_Earnings)  a ON Citi_Earnings.Filing_Quarter = a.Filing_Quarter;

Insert into Citi_Earnings (Filing_Quarter, Commissions_and_Fees, Administration_and_Other_Fiduciary_Fees,
Investment_Banking, Principal_Transactions, Other, Total_Non_Interest_Revenue,
Net_Interest_Revenue_including_Dividends, Total_Revenues_Net_of_Interest_Expense,
Total_Operating_Expenses, Provisions_for_Credit_Losses_and_for_Benefits_and_Claims,
Income_from_Continuing_Operations_before_Taxes, Income_Taxes, Income_from_Continuing_Operations,
Noncontrolling_Interests, Net_Income)
VALUES 
('Q1 2008', 780, 1361, 869, 2997, 83, 6090, 4045, 10135, 5544, 90, 4501, 1184, 3317, 12, 3305), /* Reporting becomes different after Q4 2007*/
('Q2 2008', 735, 1390, 1396, 1952, -2, 5471, 4414, 9885, 5706, 424, 3755, 1313, 2442, 17, 2425),
('Q3 2008', 754, 1397, 740, 3116, -188, 5819, 4092, 9911, 4919, 426, 4566, 1410, 3156, 11, 3145),
('Q4 2008', 607, 1265, 324, -1521, -914, -239, 5189, 4950, 4786, 935, -771, -1161, 390, -22, 412),
('Q1 2009', 443, 1222, 940, 7152, 467, 10224, 4574, 14798, 3891, 385, 10522, 3424, 7098, -3, 7101),
('Q2 2009', 492, 1237, 1242, 1082, 760, 4813, 4542, 9355, 4358, 824, 4173, 1332, 2841, 3, 2838),
('Q3 2009', 565, 1258, 1063, -535, 556, 2907, 4443, 7350, 4634, 438, 2278, 584, 1694, 23, 1671),
('Q4 2009', 575, 1247, 1440, -1698, 188, 1752, 4180, 5932, 4685, 71, 1176, -79, 1255, 45, 1210),
('Q1 2010', 1108, 721, 953, 3307, 468, 6557, 3883, 10440, 4597, -85, 5928, 1812, 4116, 26, 4090),
('Q2 2010', 1086, 615, 592, 1777, 481, 4551, 3906, 8457, 5137, -210, 3530, 930, 2600, 20, 2580),
('Q3 2010', 1016, 672, 829, 1539, 347, 4403, 3725, 8128, 4841, 266, 3021, 719, 2302, 34, 2268),
('Q4 2010', 1056, 739, 1146, -1056, 382, 2267, 3826, 6093, 4999, -55, 1149, 24, 1125, 51, 1074),
('Q1 2011', 1132, 744, 793, 2260, -77, 4852, 3710, 8562, 5119, -182, 3625, 1075, 2550, 13, 2537),
('Q2 2011', 1132, 730, 1001, 1288, 252, 4403, 3731, 8134, 5288, 84, 2762, 703, 2059, 9, 2050),
('Q3 2011', 1159, 649, 590, 1665, 1528, 5591, 3846, 9437, 5025, 164, 4248, 1214, 3034, 5, 3029),
('Q4 2011', 1024, 648, 645, -340, 112, 2089, 3725, 5814, 5246, 82, 486, -156, 642, 29, 613),
('Q1 2012', 1141, 696, 811, 1916, -405, 4159, 3888, 8047, 5087, 89, 2871, 638, 2233, 60, 2173),
('Q2 2012', 1081, 742, 793, 1434, 326, 4376, 3862, 8238, 4979, 135, 3124, 760, 2364, 31, 2333),
('Q3 2012', 1011, 663, 1000, 731, 37, 3442, 4024, 7466, 4869, -32, 2629, 622, 2007, 14, 1993),
('Q4 2012', 1085, 689, 1014, 49, -41, 2796, 4183, 6979, 5264, 84, 1631, 142, 1489, 23, 1466),
('Q1 2013', 1179, 694, 1085, 2415, 359, 5732, 3852, 9584, 4988, 65, 4531, 1406, 3125, 50 , 3075), 
('Q2 2013', 1156, 696, 983, 2407, 368, 5610, 3963, 9573, 4937, -30, 4666, 1476, 3190, 23, 3167),
('Q3 2013', 1115, 637, 842, 814, 131, 3539, 3823, 7362, 4795, 139, 2428, 633, 1795, 19, 1776),
('Q4 2013', 1065, 648, 952, 674, -192, 3147, 3912, 7059, 5177, -96, 1978, 457, 1521, 18, 1503),
('Q1 2014', 1014, 624, 957, 2603, 139, 5337, 3817, 9154, 4858, 27, 4269, 1321, 2948, 26, 2922),
('Q2 2014', 992, 651, 1257, 1577, 104, 4581, 3821, 8402, 4743, -112, 3771, 1205, 2566, 19, 2547),
('Q3 2014', 1015, 626, 1047, 1396, 241, 4325, 4011, 8336, 4912, -21, 3445, 1102, 2343, 42, 2301),
('Q4 2014', 974, 619, 1008, 329, 177, 3107, 4053, 7160, 4878, 163, 2119, 442, 1677, 31, 1646),
('Q1 2015', 995, 608, 1134, 2198, 249, 5184, 3844, 9028, 4632, 74, 4322, 1358, 2964, 36, 2928),
('Q2 2015', 986, 658, 1120, 1797, 166, 4727, 4151, 8878, 4821, -95, 4152, 1317, 2835, 15, 2820),
('Q3 2015', 1015, 626, 1047, 1396, 241, 4325, 4011, 8336, 4912, -21, 3445, 1102, 2343, 42, 2301),
('Q4 2015', 920, 568, 1028, 620, 37, 3173, 4072, 7245, 4840, 641, 1764, 522, 1242, 7, 1235),
('Q1 2016', 1003, 597, 740, 1574, -8, 3906, 4130, 8036, 4869, 390, 2777, 818, 1959, 10, 1949),
('Q2 2016', 955, 638, 1029, 1911, 46, 4579, 4267, 8846, 4760, 82, 4004, 1289, 2715, 17, 2698),
('Q3 2016', 928, 610, 917, 2063, -126, 4392, 4236, 8628, 4680, -90, 4038, 1266, 2772, 19, 2753),
('Q4 2016', 968, 592, 969, 1782, -66, 4245, 4095, 8340, 4630, 104, 3606, 1124, 2482, 12, 2470),
('Q1 2017', 985, 644, 1044, 2668, -5, 5336, 3790, 9126, 4945, -205, 4386, 1375, 3011, 15, 2996),
('Q2 2017', 1020, 719, 1180, 2079, 240, 5238, 3975, 9213, 5019, 87, 4107, 1327, 2780, 18, 2762),
('Q3 2017', 1036, 710, 1099, 1757, 704, 5306, 3925, 9231, 4939, -164, 4456, 1394, 3062, 14, 3048),
('Q4 2017', 1072, 640, 1081, 1236, 221, 4250, 3847, 8097, 4705, 267, 3125, 2912, 213, 10, 203),
('Q1 2018', 1213, 694, 985, 2884, 418, 6194, 3654, 9848, 5503, -41, 4386, 1057, 3329, 15, 3314),
('Q2 2018', 1127, 713, 1246, 2358, 154, 5598, 4093, 9691, 5458, 25, 4208, 971, 3237, 12, 3225),
('Q3 2018', 1085, 686, 1029, 2447, -18, 5229, 4012, 9241, 5191, 71, 3979, 862, 3117, -6, 3123),
('Q4 2018', 1091, 662, 1092, 1163, 240, 4248, 3966, 8214, 4827, 129, 3258, 741, 2517, -4, 2521),
('Q1 2019', 1121, 670, 1112, 2631, 285, 5819, 3875, 9694, 5427, 21, 4246, 924, 3322, 11, 3311),
('Q2 2019', 1046, 696, 1100, 1930, 716, 5488, 4233, 9721, 5356, 103, 4262, 919, 3343, 10, 3333),
('Q3 2019', 1091, 693, 1044, 2578, 310, 5716, 3798, 9514, 5418, 91, 4005, 835, 3170, 8, 3162);

Declare @TableRowsCount Int
Select @TableRowsCount= COUNT(*) from Goldman_Earnings

Declare @N Int;
Set @N = 4;

SELECT *
FROM Goldman_Earnings JOIN (SELECT *
FROM  Goldman_Earnings As L
ORDER BY L.RowNumber DESC
OFFSET @TableRowsCount-@N ROWS
FETCH NEXT @N ROWS ONLY) a ON Goldman_Earnings.Filing_Quarter = a.Filing_Quarter ORDER BY a.RowNumber;

/* Checking if Total_non_interest_revenues added up to its total for rows 1-7*/
USE Banks
Go
create view Goldman_rows_1_7 
AS
SELECT Goldman_Earnings.Filing_Quarter, Total_non_interest_revenues, a.Total_Against, (a.Total_Against - Total_non_interest_revenues) as Subtracted_total
FROM Goldman_Earnings JOIN (SELECT Filing_Quarter, (Investment_banking + Trading_and_principle_investments + Asset_management_and_securities_services) as Total_Against FROM Goldman_Earnings) a ON Goldman_Earnings.Filing_Quarter = a.Filing_Quarter;

SELECT top 7 * From Goldman_rows_1_7;

Drop view Goldman_rows_1_7;

/* Checking if Total_non_interest_revenues added up to its total for rows 8 - 47*/
USE Banks
Go
create view Goldman_rows_8_47 
AS
SELECT Goldman_Earnings.RowNumber, Goldman_Earnings.Filing_Quarter, Total_non_interest_revenues, a.Total_Against, (a.Total_Against - Total_non_interest_revenues) as Subtracted_total
FROM Goldman_Earnings JOIN (SELECT Filing_Quarter, (Investment_banking + Investment_management + Commissions_and_fees + Market_making + Other_principle_transactions) as Total_Against FROM Goldman_Earnings) a ON Goldman_Earnings.Filing_Quarter = a.Filing_Quarter;
 
Declare @Number_of_rows int;
Set @Number_of_rows = 7;

SELECT * From Goldman_rows_8_47
Order by Goldman_rows_8_47.RowNumber
OFFSET @Number_of_rows ROWS;

Drop view Goldman_rows_8_47;

/* Checking if Total_net_revenues added up to its total*/
SELECT Goldman_Earnings.RowNumber, Goldman_Earnings.Filing_Quarter, Total_net_revenues, a.Total_Against, (a.Total_Against - Total_net_revenues) as Subtracted_total
FROM Goldman_Earnings JOIN (SELECT Filing_Quarter, (Total_non_interest_revenues + Net_interest_income) as Total_Against FROM Goldman_Earnings) a ON Goldman_Earnings.Filing_Quarter = a.Filing_Quarter;

/* Checking if Pre_tax_earnings added up to its total for rows 44-47*/
USE Banks
Go
create view Goldman_rows_44_47 
AS
SELECT Goldman_Earnings.RowNumber, Goldman_Earnings.Filing_Quarter, Pre_tax_earnings, a.Total_Against, (a.Total_Against - Pre_tax_earnings) as Subtracted_total
FROM Goldman_Earnings JOIN (SELECT Filing_Quarter, (Total_net_revenues - Provision_for_credit_losses - Total_operating_expenses) as Total_Against FROM Goldman_Earnings) a ON Goldman_Earnings.Filing_Quarter = a.Filing_Quarter;

Declare @Number_of_rows int;
Set @Number_of_rows = 43;

SELECT * From Goldman_rows_44_47
Order by Goldman_rows_44_47.RowNumber
OFFSET @Number_of_rows ROWS;

Drop view Goldman_rows_44_47;

/* Checking if Pre_tax_earnings added up to its total for rows 1-43*/
USE Banks
Go
create view Goldman_rows_1_43 
AS
SELECT Goldman_Earnings.RowNumber, Goldman_Earnings.Filing_Quarter, Pre_tax_earnings, a.Total_Against, (a.Total_Against - Pre_tax_earnings) as Subtracted_total
FROM Goldman_Earnings JOIN (SELECT Filing_Quarter, (Total_net_revenues - Total_operating_expenses) as Total_Against FROM Goldman_Earnings) a ON Goldman_Earnings.Filing_Quarter = a.Filing_Quarter;

SELECT top 43 * From Goldman_rows_1_43
Order by Goldman_rows_1_43.RowNumber;

Drop view Goldman_rows_1_43;

/* Checking if Net_earnings added up to its total*/
SELECT Goldman_Earnings.RowNumber, Goldman_Earnings.Filing_Quarter, Net_earnings, a.Total_Against, (a.Total_Against - Net_earnings) as Subtracted_total
FROM Goldman_Earnings JOIN (SELECT Filing_Quarter, (Pre_tax_earnings - Provision_for_taxes) as Total_Against FROM Goldman_Earnings) a ON Goldman_Earnings.Filing_Quarter = a.Filing_Quarter;


/* as of Q3 2017, Goldman Sachs did not report provisions on claims*/
/* The claims have been reported in Other princple transactions*/
Insert into Goldman_Earnings (Filing_Quarter, Investment_banking,
Trading_and_principle_investments, Asset_management_and_securities_services, Investment_management, Commissions_and_fees,
Market_making, Other_principle_transactions,
Total_non_interest_revenues, Net_interest_income,
Total_net_revenues, Provision_for_credit_losses,
Total_operating_expenses, Pre_tax_earnings,
Provision_for_taxes, Net_earnings)
VALUES 
('Q1 2008', 1166, 4877, 1341, NULL, NULL, NULL, NULL, 7384, 951, 8335, NULL, 6192, 2143, 632, 1511),
('Q2 2008', 1685, 5239, 1221, NULL, NULL, NULL, NULL, 8145, 1277, 9422, NULL, 6590, 2832, 745, 2087),
('Q3 2008', 1294, 2440, 1174, NULL, NULL, NULL, NULL, 4908, 1135, 6043, NULL, 5083, 960, 115, 845),
('Q4 2008', 1034, -4461, 936, NULL, NULL, NULL, NULL, -2491, 913, -1578, NULL, 2021, -3599, -1478, -2121),
('Q1 2009', 823, 5706, 989, NULL, NULL, NULL, NULL, 7518, 1907, 9425, NULL, 6796, 2629, 815, 1814),
('Q2 2009', 1440, 9322, 957, NULL, NULL, NULL, NULL, 11719, 2042, 13761, NULL, 8732, 5029, 1594, 3435),
('Q3 2009', 899, 8801, 982, NULL, NULL, NULL, NULL, 10682, 1690, 12372, NULL, 7578, 4794, 1606, 3188),
('Q4 2009', 1680, NULL, NULL, 1214, 916, 2784, 1253, 7847, 1768, 9615, NULL, 2238, 7377, 2429, 4948),
('Q1 2010', 1203, NULL, NULL, 1008, 880, 6385, 1881, 11357, 1418, 12775, NULL, 7616, 5159, 1703, 3456),
('Q2 2010', 941, NULL, NULL, 1046, 978, 2850, 1407, 7222, 1619, 8841, NULL, 7393, 1448, 835, 613), /*different way of reporting*/
('Q3 2010', 1159, NULL, NULL, 1200, 807, 2849, 1760, 7775, 1128, 8903, NULL, 6092, 2811, 913, 1898),
('Q4 2010', 1507, NULL, NULL, 1415, 904,  1594, 1884, 7304, 1338, 8642, NULL, 5168, 3474, 1087, 2387),
('Q1 2011', 1269, NULL, NULL, 1174, 1019, 4462, 2612, 10536, 1358, 11894, NULL, 7854, 4040, 1305, 2735),
('Q2 2011', 1448, NULL, NULL, 1188, 894, 1736, 602, 5868, 1413, 7281, NULL, 5669, 1612, 525, 1087),
('Q3 2011', 781, NULL, NULL, 1133, 1056, 1800,  -2539, 2231, 1356, 3587, NULL, 4317, -730, -337, -393),
('Q4 2011', 863, NULL, NULL, 1196, 804, 1289, 832, 4984, 1065, 6049, NULL, 4802, 1247, 234, 1013),
('Q1 2012', 1160, NULL, NULL, 1105, 860, 3905, 1938, 8968, 981, 9949, NULL, 6768, 3181, 1072, 2109),
('Q2 2012', 1206, NULL, NULL, 1266, 799, 2097, 169, 5537, 1090, 6627, NULL, 5212, 1415, 453, 962),
('Q3 2012', 1168, NULL, NULL, 1147, 748, 2650, 1802, 7515, 836, 8351, NULL, 6053, 2298, 786, 1512),
('Q4 2012', 1407, NULL, NULL, 1450, 754, 2696, 1956, 8263, 973, 9236, NULL, 4923, 4313, 1421, 2892),
('Q1 2013', 1568, NULL, NULL, 1250, 829, 3437, 2081, 9165, 925, 10090, NULL, 6717, 3373, 1113, 2260),
('Q2 2013', 1552, NULL, NULL, 1267, 873, 2692, 1402, 7786, 826, 8612, NULL, 5967, 2645, 714, 1931),
('Q3 2013', 1166, NULL, NULL, 1153, 765, 1364, 1434, 5882, 840, 6722, NULL, 4555, 2167, 650, 1517),
('Q4 2013', 1718, NULL, NULL, 1524, 788, 1875, 2076, 7981, 801, 8782, NULL, 5230, 3552, 1220, 2332), 
('Q1 2014', 1779, NULL, NULL, 1498, 872, 2639, 1503, 8291, 1037, 9328, NULL, 6307, 3021, 988, 2033),
('Q2 2014', 1781, NULL, NULL, 1378, 786, 2185, 1995, 8125, 1000, 9125, NULL, 6304, 2821, 784, 2037),
('Q3 2014', 1464, NULL, NULL, 1386, 783, 2087, 1618, 7338, 1049, 8387, NULL, 5082, 3305, 1064, 2241),
('Q4 2014', 1440, NULL, NULL, 1486, 875, 1454, 1472, 6727, 961, 7688, NULL, 4478, 3210, 1044, 2166),
('Q1 2015', 1905, NULL, NULL, 1503, 853, 3925, 1572, 9758, 859, 10617, NULL, 6683, 3934, 1090, 2844),
('Q2 2015', 2019, NULL, NULL, 1566, 805, 2309, 1707, 8406, 663, 9069, NULL, 7343, 1726, 678, 1048),
('Q3 2015', 1556, NULL, NULL, 1331, 859, 1730, 543, 6019, 842, 6861, NULL, 4815, 2046, 620, 1426),
('Q4 2015', 1547, NULL, NULL, 1468, 803, 1559, 1196, 6573, 700, 7273, NULL, 6201, 1072, 307, 765),
('Q1 2016', 1463, NULL, NULL, 1262, 917, 1862, -49, 5455, 883, 6338, NULL, 4762, 1576, 441, 1135),
('Q2 2016', 1787, NULL, NULL, 1260, 777, 2490, 864, 7178, 754, 7932, NULL, 5469, 2463, 641, 1822),
('Q3 2016', 1537, NULL, NULL, 1386, 753, 2715, 1163, 7554, 614, 8168, NULL, 5300, 2868, 774, 2094),
('Q4 2016', 1486, NULL, NULL, 1499, 761, 2866, 1222, 7834, 336, 8170, NULL, 4773, 3397, 1050, 2347),
('Q1 2017', 1703, NULL, NULL, 1397, 771, 2418, 1221, 7510, 516, 8026, NULL, 5487, 2539, 284, 2255),
('Q2 2017', 1730, NULL, NULL, 1433, 794, 1915, 1227, 7099, 788, 7887, NULL, 5378, 2509, 678, 1831),
('Q3 2017', 1797, NULL, NULL, 1419, 714, 2112, 1554, 7596, 730, 8326, NULL, 5350, 2976, 848, 2128),
('Q4 2017', 2141, NULL, NULL, 1554, 772, 1215, 1254, 6936, 898, 7834, NULL, 4726, 3108, 5036, -1928),
('Q1 2018', 1793, NULL, NULL, 1639, 862, 3204, 1620, 9118, 918, 10036, NULL, 6617, 3419, 587, 2832),
('Q2 2018', 2045, NULL, NULL, 1728, 795, 2546, 1286, 8400, 1002, 9402, NULL, 6126, 3276, 711, 2565),
('Q3 2018', 1980, NULL, NULL, 1580, 704, 2281, 1245, 7790, 856, 8646, NULL, 5568, 3078, 554, 2524),
('Q4 2018', 2044, NULL, NULL, 1567, 838, 1420, 1220, 7089, 991, 8080, 222, 5150, 2708, 170, 2538), /* beginning of providing the provision numbers*/
('Q1 2019', 1810, NULL, NULL, 1433, 743, 2539, 1064, 7589, 1218, 8807, 224, 5864, 2719, 468, 2251),
('Q2 2019', 1863, NULL, NULL, 1480, 807, 2423, 1817, 8390,  1071, 9461, 214, 6120, 3127, 706, 2421),
('Q3 2019', 1687, NULL, NULL, 1556, 758, 2384, 930, 7315, 1008, 8323, 291, 5616, 2416, 539, 1877);
 


  


Delete from Citi_Earnings WHERE Filing_Quarter = 'Q1 2016,';


Drop table Citi_Earnings;
Drop table Goldman_Earnings;

create view Citi AS
SELECT * FROM
Citi_Earnings;

SELECT * FROM
Goldman_Earnings;

SELECT * FROM
Citi_Earnings;

UPDATE Citi_Earnings
SET Total_Revenues_Net_of_Interest_Expense = 9437
WHERE Total_Revenues_Net_of_Interest_Expense = 9427;

UPDATE Goldman_Earnings
SET Net_interest_income = 840
WHERE Net_interest_income = 2398;

UPDATE Goldman_Earnings
SET Total_net_revenues = 6722
WHERE Total_net_revenues = 1558;

UPDATE Goldman_Earnings
SET Total_operating_expenses = 6717
WHERE Total_operating_expenses = 6716 and RowNumber = 21;

UPDATE Goldman_Earnings
SET Pre_tax_earnings = 3552
WHERE Pre_tax_earnings = 2332 and RowNumber = 24;

UPDATE Goldman_Earnings
SET Provision_for_taxes = 1220
WHERE Provision_for_taxes = 84 and RowNumber = 24;

UPDATE Goldman_Earnings
SET Net_earnings = 2332 
WHERE Net_earnings = 2248 and RowNumber = 24;


SELECT * FROM
Goldman_Earnings
WHERE RowNumber = 21;


Declare @TableRowsCount Int
Select @TableRowsCount= COUNT(*) from Goldman_Earnings

Declare @N Int;
Set @N = 4;

SELECT *
FROM  Goldman_Earnings As L
ORDER BY L.RowNumber
OFFSET @TableRowsCount-@N ROWS
FETCH NEXT @N ROWS ONLY;