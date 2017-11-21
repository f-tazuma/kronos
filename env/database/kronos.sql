SET FOREIGN_KEY_CHECKS=0;

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
  `worker_number` VARCHAR(20) NOT NULL UNIQUE,
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
  UNIQUE INDEX `worker_number_UNIQUE` (`worker_number` ASC),
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
  `project_no` VARCHAR(20) NOT NULL UNIQUE,
  `name` VARCHAR(100) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `work_start_date` DATETIME NULL,
  `work_end_date` DATETIME NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  UNIQUE INDEX `project_no_UNIQUE` (`project_no` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table 受注マスタ
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m_orders` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `order_no` VARCHAR(20) NOT NULL UNIQUE,
  `name` VARCHAR(100) NOT NULL,
  `client_name` VARCHAR(100) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `ordered_date` DATETIME NULL,
  `m_projects_id` BIGINT NULL,
  `receiving_inspection_date` DATETIME NULL COMMENT '検収(予定)日',
  `order_kind` VARCHAR(50) NULL COMMENT '開発、保守',
  `sales_kind` VARCHAR(50) NULL COMMENT '売上,非売上',
  `estimate_work_hours` DECIMAL(8,2) NULL COMMENT '見積作業時間',
  `ordered_work_hours` DECIMAL(8,2) NULL,
  `ordered_volume` BIGINT NULL,
  `status` VARCHAR(50) NULL COMMENT '見積,仮受注,受注,納品,検収',
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX `path_UNIQUE` (`order_no` ASC),
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
  `worker_number` VARCHAR(20) NOT NULL,
  `order_no` VARCHAR(20) NOT NULL,
  `t_order_work_breakdowns_id` BIGINT NULL,
  `work_day` DATETIME NULL,
  `work_hours` DECIMAL(5,2) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  INDEX `fk_t_worked_hours_worker_number1_idx` (`worker_number` ASC),
  INDEX `fk_t_worked_hours_order_no_idx` (`order_no` ASC),
  INDEX `fk_t_worked_hours_t_order_work_breakdowns1_idx` (`t_order_work_breakdowns_id` ASC),
  INDEX `t_worked_hours_work_day1_idx` (`work_day` ASC)
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table 作業予定時間トラン
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t_planed_work_hours` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `worker_number` VARCHAR(20) NOT NULL,
  `m_projects_id` BIGINT NULL,
  `t_order_work_breakdowns_id` BIGINT NULL,
  `work_plan_day` DATETIME NULL,
  `work_hours` DECIMAL(5,2) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  INDEX `fk_t_plan_work_hours_worker_number1_idx` (`worker_number` ASC),
  INDEX `fk_t_plan_work_hours_m_projects_id_idx` (`m_projects_id` ASC),
  INDEX `fk_t_plan_work_hours_t_order_work_breakdowns1_idx` (`t_order_work_breakdowns_id` ASC),
  INDEX `t_plan_work_hours_work_plan_day1_idx` (`work_plan_day` ASC)
)
ENGINE = InnoDB;
