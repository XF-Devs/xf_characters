CREATE TABLE IF NOT EXISTS `character_overlays` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `overlay` INT NOT NULL,
  `index` INT NOT NULL,
  `opacity` DECIMAL(2, 1) NOT NULL,
  `colorType` INT NOT NULL,
  `color` INT NOT NULL,
  `color_two` INT NOT NULL,
  `char_id` INT NOT NULL,
  PRIMARY KEY (id),
  INDEX (char_id),
  FOREIGN KEY (char_id)
    REFERENCES characters(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) COLLATE = 'utf8_unicode_ci'