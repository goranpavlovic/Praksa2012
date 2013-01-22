DELIMITER $$
 
DROP FUNCTION IF EXISTS `GenerateGUID`$$
 
CREATE FUNCTION `GenerateGUID`() 
RETURNS CHAR(32)
    DETERMINISTIC
BEGIN
	-- Function logic here
        DECLARE var_char CHAR(1);
        DECLARE var_time CHAR(4) DEFAULT '0000';
        DECLARE var_count INT DEFAULT 28;
        DECLARE var_guid CHAR(32) DEFAULT '';
        
        
	/*DECLARE run TINYINT DEFAULT 0;*/
        WHILE var_count > 0 DO
        SET var_char = HEX(FLOOR(RAND() * 16));
        IF(var_count = 24 OR var_count = 20 OR var_count = 16 OR var_count = 12) THEN
        SET var_guid = CONCAT(var_guid, "-");
        END IF;
        SET var_guid = CONCAT(var_guid, LOWER(var_char));
        SET var_count = var_count - 1;
        END WHILE;
        
        RETURN var_guid;
        
        /*
        
	IF (a+b) > 100 THEN
		SET run = 1;
	ELSE
		SET run = 2;
	END IF;
	RETURN run;
        
        */
        
    END$$
 
DELIMITER ;

DROP TRIGGER IF EXISTS NewEavEntityGuid;

CREATE TRIGGER NewEavEntityGuid BEFORE INSERT ON EAVEntity FOR EACH ROW SET NEW.EntityId = GenerateGuid();

DROP TRIGGER IF EXISTS NewEAVAttributeValueGuid;

CREATE TRIGGER NewEAVAttributeValueGuid BEFORE INSERT ON EAVAttributeValue FOR EACH ROW SET NEW.ValueId = GenerateGuid();

