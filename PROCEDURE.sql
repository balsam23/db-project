SELECT * FROM littlelemondb.menuitems;

-- Create a procedure to display the maximum ordered quantity
DELIMITER //

CREATE PROCEDURE GetMaxOrderedQuantity()
BEGIN
    DECLARE max_quantity INT;

    -- Find the maximum quantity using a SELECT INTO statement
    SELECT MAX(Quantity) INTO max_quantity
    FROM Orders;

    -- Display the maximum quantity
    SELECT max_quantity AS 'Maximum Ordered Quantity';
END //

DELIMITER ;

CALL GetMaxOrderedQuantity();

-- Create the prepared statement
SET @stmt = 'CREATE PROCEDURE GetOrderDetail(IN cust_id INT)
             BEGIN
                 SELECT OrderID, Quantity, Cost
                 FROM Orders
                 WHERE CustomerID = cust_id;
             END';
  -- Set the variable id to 1
SET @id = 1;




CREATE PROCEDURE GetOrderDetail(IN cust_id INT)
BEGIN
    SELECT OrderID, Quantity, TotalCost
    FROM Orders
    WHERE CustomerID = cust_id;
END //

DELIMITER ;

-- Set the variable id to 1
SET @id = 1;

PREPARE stmt FROM 'CALL GetOrderDetail(?)';
EXECUTE stmt USING @id;
DROP PROCEDURE GetOrderDetail;

DELIMITER //

CREATE PROCEDURE GetOrderDetail(IN cust_id INT)
BEGIN
    SELECT OrderID, Quantity, TotalCost
    FROM Orders
    WHERE CustomerID = cust_id;
END //

DELIMITER ;

-- Set the variable id to 1
SET @id = 1;

PREPARE stmt FROM 'CALL GetOrderDetail(?)';
EXECUTE stmt USING @id;
DEALLOCATE PREPARE stmt;

DELIMITER //

CREATE PROCEDURE CancelOrder(IN orderId INT)
BEGIN
    DELETE FROM Orders
    WHERE OrderID = orderId;
END //

DELIMITER ;

SET SQL_SAFE_UPDATES = 0;
CALL CancelOrder(5);
