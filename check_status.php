<?php
// check_status.php
// รับรหัสนักศึกษา แล้วส่งกลับสถานะคำร้องล่าสุดของนักศึกษาคนนั้น

header('Content-Type: application/json; charset=utf-8');
require_once __DIR__ . '/config.php';

$studentId = trim($_GET['studentid'] ?? '');

if (!preg_match('/^[0-9]{11}$/', $studentId)) {
    http_response_code(422);
    echo json_encode(['found' => false, 'message' => 'รหัสนักศึกษาไม่ถูกต้อง']);
    exit;
}

try {
    $stmt = $pdo->prepare("
        SELECT ref_number, request_type, status, status_note, created_at
        FROM requests
        WHERE student_id = :student_id
        ORDER BY created_at DESC
        LIMIT 1
    ");
    $stmt->execute([':student_id' => $studentId]);
    $row = $stmt->fetch();

    if (!$row) {
        echo json_encode(['found' => false]);
        exit;
    }

    echo json_encode([
        'found'        => true,
        'ref_number'   => $row['ref_number'],
        'request_type' => $row['request_type'],
        'status'       => $row['status'],          // pending | processing | approved | rejected
        'status_note'  => $row['status_note'],
        'created_at'   => date('d/m/Y H:i', strtotime($row['created_at'])),
    ]);

} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['found' => false, 'message' => 'เกิดข้อผิดพลาดในการตรวจสอบข้อมูล']);
}
