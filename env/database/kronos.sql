DROP TABLE IF EXISTS `m_departments`;
DROP TABLE IF EXISTS `m_workers`;
DROP TABLE IF EXISTS `m_projects`;
DROP TABLE IF EXISTS `m_orders`;
DROP TABLE IF EXISTS `t_order_work_breakdowns`;
DROP TABLE IF EXISTS `t_worked_hours`;

-- -----------------------------------------------------
-- Table 部署マスタ
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m_departments` (
  `id` BIGINT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `path` VARCHAR(1000) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  UNIQUE INDEX `path_UNIQUE` (`path` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table 作業者マスタ
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m_workers` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `worker_number` VARCHAR(20) NOT NULL,
  `family_name` VARCHAR(50) NULL,
  `first_name` VARCHAR(50) NULL,
  `full_name` VARCHAR(100) DEFAULT NULL,
  `family_name_kana` VARCHAR(50) NULL,
  `first_name_kana` VARCHAR(50) NULL,
  `mail_address` VARCHAR(200) NULL,
  `birth_day` DATETIME NULL,
  `m_department_id` BIGINT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  INDEX `fk_m_workers_m_departments_idx` (`m_department_id` ASC),
  CONSTRAINT `fk_m_workers_m_departments`
    FOREIGN KEY (`m_department_id`)
    REFERENCES `m_departments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table プロジェクトマスタ
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m_projects` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `no` VARCHAR(20) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `m_account_id` BIGINT NULL,
  UNIQUE INDEX `path_UNIQUE` (`no` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table 受注マスタ
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m_orders` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `no` VARCHAR(20) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `m_projects_id` BIGINT NULL,
  `client_name` VARCHAR(100) NOT NULL,
  `sales_kind` INT NULL COMMENT '1:生産\n2:非生産',
  `estimate_worker_hours` DECIMAL(8,2) NULL COMMENT '見積作業時間',
  `order_worker_hours` DECIMAL(8,2) NULL,
  `order_volume` BIGINT NULL,
  `receiving_inspection_date` VARCHAR(45) NULL COMMENT '検収(予定)日',
  `status` INT NULL COMMENT '1:見積\n2:仮受注\n3:受注\n4:納品\n5:検収',
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX `path_UNIQUE` (`no` ASC),
  INDEX `fk_m_orders_m_projects1_idx` (`m_projects_id` ASC),
  CONSTRAINT `fk_m_orders_m_projects1`
    FOREIGN KEY (`m_projects_id`)
    REFERENCES `m_projects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table 受注別作業項目トラン
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t_order_work_breakdowns` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `m_orders_id` BIGINT NOT NULL,
  `work_name` VARCHAR(20) NOT NULL COMMENT '作業項目名',
  `estimate_worker_hours` DECIMAL(5,2) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  INDEX `fk_t_worked_hours_m_orders1_idx` (`m_orders_id` ASC),
  CONSTRAINT `fk_t_worked_hours_m_orders10`
    FOREIGN KEY (`m_orders_id`)
    REFERENCES `m_orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table 作業時間トラン
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t_worked_hours` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `m_workers_id` BIGINT NOT NULL,
  `m_orders_id` BIGINT NOT NULL,
  `t_order_work_breakdowns_id` BIGINT NULL,
  `work_day` DATETIME NULL,
  `work_hours` DECIMAL(5,2) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  INDEX `fk_t_worked_hours_m_workers1_idx` (`m_workers_id` ASC),
  INDEX `fk_t_worked_hours_m_orders1_idx` (`m_orders_id` ASC),
  INDEX `fk_t_worked_hours_t_order_work_breakdowns1_idx` (`t_order_work_breakdowns_id` ASC),
  CONSTRAINT `fk_t_worked_hours_m_workers1`
    FOREIGN KEY (`m_workers_id`)
    REFERENCES `m_workers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_t_worked_hours_m_orders1`
    FOREIGN KEY (`m_orders_id`)
    REFERENCES `m_orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_t_worked_hours_t_order_work_breakdowns1`
    FOREIGN KEY (`t_order_work_breakdowns_id`)
    REFERENCES `t_order_work_breakdowns` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

