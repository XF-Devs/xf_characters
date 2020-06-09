CREATE TABLE IF NOT EXISTS `character_props` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `prop` INT NOT NULL,
  `drawable` INT NOT NULL,
  `texture` INT NOT NULL,
  `char_id` INT NOT NULL,
  PRIMARY KEY (id),
  INDEX (char_id),
  FOREIGN KEY (char_id)
    REFERENCES characters(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) COLLATE = 'utf8_unicode_ci'