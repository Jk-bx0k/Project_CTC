-- ฐานข้อมูลระบบขอยื่นคำร้องใบจบการศึกษา
-- วิทยาลัยเทคโนโลยีชลบุรี

CREATE DATABASE IF NOT EXISTS cmt_graduate_system
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE cmt_graduate_system;

CREATE TABLE IF NOT EXISTS requests (
    id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ref_number    VARCHAR(20)  NOT NULL UNIQUE,

    -- ข้อมูลผู้ยื่นคำร้อง
    fullname      VARCHAR(255) NOT NULL,
    student_id    CHAR(11)     NOT NULL,
    edu_level     VARCHAR(10)  NOT NULL,          -- ปวช. / ปวส.
    category      VARCHAR(100) NOT NULL,          -- ประเภทวิชา เช่น บริหารธุรกิจ
    major         VARCHAR(255) NOT NULL,          -- สาขาวิชา
    phone         VARCHAR(15)  NOT NULL,
    email         VARCHAR(255) NULL,

    -- รายละเอียดคำร้อง
    request_type  VARCHAR(255) NOT NULL,
    note          TEXT NULL,

    -- ไฟล์แนบ
    file_name     VARCHAR(255) NULL,
    file_path     VARCHAR(255) NULL,

    -- สถานะคำร้อง
    status        ENUM('pending','processing','approved','rejected')
                  NOT NULL DEFAULT 'pending',
    status_note   VARCHAR(500) NULL,              -- หมายเหตุจากเจ้าหน้าที่ (ถ้ามี)

    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
                  ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_student_id (student_id),
    INDEX idx_ref_number (ref_number)
) ENGINE=InnoDB;
