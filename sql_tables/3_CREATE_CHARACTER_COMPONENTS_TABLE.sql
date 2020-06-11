CREATE TABLE IF NOT EXISTS `character_components` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `component` INT NOT NULL,
  `drawable` INT NOT NULL,
  `texture` INT NOT NULL,
  `primaryColor` INT DEFAULT NULL,
  `secondaryColor` INT DEFAULT NULL,
  `char_id` INT NOT NULL,
  PRIMARY KEY (id),
  INDEX (char_id),
  FOREIGN KEY (char_id)
    REFERENCES characters(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) COLLATE = 'utf8_unicode_ci'