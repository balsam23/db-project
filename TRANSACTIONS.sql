SELECT * FROM littlelemondb.bookings;
INSERT INTO Bookings (BookingID, Date , TableNb , CustomerID, StaffID, MenuID)
VALUES (1, '2022-10-10', 5,1, 1, 5);

DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN bookingDate DATE,
    IN table_number INT
)
BEGIN
    DECLARE existing_booking_count INT;

    START TRANSACTION;

    -- Check if the table is already booked on the given date
    SELECT COUNT(*) INTO existing_booking_count
    FROM Bookings
    WHERE Date = bookingDate AND TableNb = table_number;

    -- If the table is already booked, rollback the transaction
    IF existing_booking_count > 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Table is already booked for the selected date. Booking declined.';
    ELSE
        -- Insert the new booking record
        INSERT INTO Bookings (Date, TableNb)
        VALUES (bookingDate, table_number);
        
        -- Commit the transaction if successful
        COMMIT;
    END IF;
END //

DELIMITER ;

DROP PROCEDURE AddValidBooking;

DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN bookingDate DATE,
    IN table_number INT
)
BEGIN
    DECLARE existing_booking_count INT;

    START TRANSACTION;

    -- Check if the table is already booked on the given date
    SELECT COUNT(*) INTO existing_booking_count
    FROM Bookings
    WHERE Date = bookingDate AND TableNb = table_number;

    -- If the table is already booked, rollback the transaction
    IF existing_booking_count > 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Table is already booked for the selected date. Booking declined.';
    ELSE
        -- Insert the new booking record
        INSERT INTO Bookings (Date, TableNb)
        VALUES (bookingDate, table_number);
        
        -- Commit the transaction if successful
        COMMIT;
    END IF;
END //

DELIMITER ;


CALL AddValidBooking('2022-12-11', 5);

DELIMITER //

CREATE PROCEDURE AddBooking(
    IN p_booking_id INT,
    IN p_customer_id INT,
    IN p_bookingDate DATE,
    IN p_table_number INT,
    IN p_StaffID INT,
    IN p_MenuID INT
)
BEGIN
    -- Insert the new booking record
    INSERT INTO Bookings (BookingID, CustomerID, Date, TableNb, StaffID ,MenuID)
    VALUES (p_booking_id, p_customer_id, p_booking_date, p_table_number , p_StaffID , p_MenuID );
    
    -- Check if the insertion was successful
    IF ROW_COUNT() > 0 THEN
        SELECT 'Booking added successfully' AS Message;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Failed to add booking';
    END IF;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN p_BookingID INT,
    IN p_BookingDate DATE
)
BEGIN
    DECLARE rows_affected INT;

    -- Update the booking record
    UPDATE Bookings
    SET Date = p_BookingDate
    WHERE BookingID = p_BookingID;

    -- Check if the update was successful
    SET rows_affected = ROW_COUNT();

    IF rows_affected > 0 THEN
        SELECT CONCAT('Booking with ID ', p_BookingID, ' updated successfully.') AS Message;
    ELSE
           SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No booking found with ID ';
    END IF;
END //

DELIMITER ;

CALL UpdateBooking(4, '2022-12-17');

DELIMITER //

CREATE PROCEDURE CancelBooking(
    IN p_booking_id INT
)
BEGIN
    DECLARE rows_affected INT;

    -- Delete the booking record
    DELETE FROM Bookings
    WHERE BookingID = p_booking_id;

    -- Check if the delete was successful
    SET rows_affected = ROW_COUNT();

    IF rows_affected > 0 THEN
        SELECT CONCAT('Booking with ID ', p_booking_id, ' cancelled successfully.') AS Message;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No booking found with ID ';
    END IF;
END //

DELIMITER ;

CALL CancelBooking(4);
