CREATE TABLE IF NOT EXISTS `character_features` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `feature` INT NOT NULL,
  `scale` DECIMAL(2, 1) NOT NULL,
  `char_id` INT NOT NULL,
  PRIMARY KEY (id),
  INDEX (char_id),
  FOREIGN KEY (char_id)
    REFERENCES characters(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) COLLATE = 'utf8_unicode_ci'