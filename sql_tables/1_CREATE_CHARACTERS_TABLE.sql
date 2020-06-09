CREATE TABLE IF NOT EXISTS `characters` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(25) NOT NULL,
  `middlename` VARCHAR(25) NOT NULL,
  `lastname` VARCHAR(50) NOT NULL,
  `age` INT NOT NULL,
  `ismale` BOOLEAN NOT NULL,
  `player_id` INT NOT NULL,
  PRIMARY KEY (id),
  INDEX (player_id),
  FOREIGN KEY (player_id)
    REFERENCES players(id)
      ON UPDATE CASCADE
      ON DELETE RESTRICT
) COLLATE = 'utf8_unicode_ci'