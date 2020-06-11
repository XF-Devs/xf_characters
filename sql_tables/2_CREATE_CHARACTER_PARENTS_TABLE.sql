CREATE TABLE IF NOT EXISTS `character_parents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mother` INT NOT NULL,
  `father` INT NOT NULL,
  `mix` DECIMAL(2, 1) NOT NULL,
  `char_id` INT NOT NULL,
  PRIMARY KEY (id),
  INDEX (char_id),
  FOREIGN KEY (char_id)
    REFERENCES characters(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) COLLATE = 'utf8_unicode_ci'