<?php
require 'db.php';


$sql = "SELECT u.name, u.email, r.role_name FROM users u
    JOIN roles r ON u.role_id = r.role_id";


if (isset($_GET['role_id']) && $_GET['role_id'] != '') {
    $sql .= " WHERE u.role_id = :role_id";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':role_id', $_GET['role_id'], PDO::PARAM_INT);
} else {
    $stmt = $conn->prepare($sql);
}

$stmt->execute();
$users = $stmt->fetchAll(PDO::FETCH_ASSOC);

header('Content-Type: application/json');
echo json_encode($users);
?>