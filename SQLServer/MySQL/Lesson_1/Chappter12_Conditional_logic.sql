show databases;
use european_sales;    

-- Multiuser databases
-- A customer rents a film.
-- A customer returns a film after the due date and pays a late fee
-- Five new films are addded to inventory 

-- Locking
-- lock granularities
-- What is a transaction


-- Starting  a transaction
SET AUTOCOMMIT = 0;

-- Ending a Transaction
-- Transaction Savepoint
show table status like 'customer' ; 

SAVEPOINT my_savepoint;
ROLLBACK TO SAVEPOINT my_savepoint;

-- example of how savepoints may be used:

CREATE TABLE Account (
account_id smallint,
avail_balance smallint, 
last_activity_date timestamp,
CONSTRAINT account_id_key PRIMARY KEY(account_id)
);

CREATE TABLE Transaction (
txn_id smallint auto_increment,
txn_date date,
account_id smallint,
txn_type_cd char(1),
amount smallint,
CONSTRAINT txn_id_key PRIMARY KEY(txn_id),
CONSTRAINT account_id_fk FOREIGN KEY (account_id) REFERENCES Account(account_id)
);


START TRANSACTION;
UPDATE product
SET date_retired =  CURRENT_TIMESTAMP()
WHERE product_cd = 'xyz';

SAVEPOINT before_close_accounts;
UPDATE account
SET status = 'CLOSED', close_date =  CURRENT_TIMESTAMP(),
last_activity_date = CURRENT_TIMESTAMP()
WHERE product_cd = 'XYZ';
ROLLBACK TO SAVEPOINT before_close_account;
COMMIT;

START TRANSACTION;
INSERT INTO Transaction(txn_id, txn_date, account_id, txn_type_cd, amount) 
VALUES (null, now(), 123, 'D', 50);


INSERT INTO Transaction(txn_id, txn_date, account_id, txn_type_cd, amount) 
VALUES (null, now(), 789, 'C', 50);

SELECT * FROM Transaction;
SELECT * FROM Account;
UPDATE account
SET avail_balance = avail_balance - 50,
last_activity_date = now()
WHERE account_id = 123;

UPDATE account
SET avail_balance = avail_balance + 50,
last_activity_date = now()
WHERE account_id = 789;

COMMIT;

