SELECT * FROM littlelemondb.orders;
CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost
FROM Orders
WHERE Quantity > 2;
SELECT * FROM OrdersView;
SELECT c.CustomerID, c.CustomerName AS FullName,
       o.OrderID, o.TotalCost,
       m.Cuisines,
       mi.Courses, mi.Starters
FROM Orders o
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN menu m ON o.MenuID = m.MenuID
JOIN menuitems mi ON o.MenuItemsID = mi.MenuItemsID
WHERE o.TotalCost > 150
ORDER BY o.TotalCost ASC;

SELECT Cuisines
FROM menu
WHERE MenuID IN (
    SELECT MenuID
    FROM Orders
    GROUP BY MenuID
    HAVING COUNT(*) > 2
);