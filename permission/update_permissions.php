
<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");

header('Content-Type: application/json; charset=UTF-8');

require 'db.php';


if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    echo json_encode(["success" => true, "message" => "Preflight OK"]);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (!isset($_GET['role_id'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Missing role_id']);
        exit();
    }
    $role_id = (int) $_GET['role_id'];
    $stmt = $conn->prepare("SELECT perm_id, is_allowed FROM role_permissions WHERE role_id = :role_id");
    $stmt->execute([':role_id' => $role_id]);
    $permissions = $stmt->fetchAll(PDO::FETCH_ASSOC);
    http_response_code(200);
    echo json_encode(['success' => true, 'permissions' => $permissions]);
    exit();
}


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);

    if (!isset($input['role_id']) || !isset($input['updates']) || !is_array($input['updates'])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'message' => 'Invalid input']);
        exit();
    }

    $role_id = (int) $input['role_id'];
    $updates = $input['updates'];

    try {
        $conn->beginTransaction();

        foreach ($updates as $perm_id => $is_allowed) {
            $perm_id = (int) $perm_id;
            $is_allowed = (int) $is_allowed;

           
            $stmt = $conn->prepare("SELECT id FROM role_permissions WHERE role_id = :role_id AND perm_id = :perm_id");
            $stmt->execute([':role_id' => $role_id, ':perm_id' => $perm_id]);
            $exists = $stmt->fetch();

            if ($exists) {
               
                $stmt = $conn->prepare("UPDATE role_permissions SET is_allowed = :is_allowed WHERE role_id = :role_id AND perm_id = :perm_id");
                $stmt->execute([
                    ':role_id' => $role_id,
                    ':perm_id' => $perm_id,
                    ':is_allowed' => $is_allowed
                ]);
            } else {
               
                $stmt = $conn->prepare("INSERT INTO role_permissions (role_id, perm_id, is_allowed) VALUES (:role_id, :perm_id, :is_allowed)");
                $stmt->execute([    ':role_id' => $role_id,
                    ':perm_id' => $perm_id,
                    ':is_allowed' => $is_allowed
                ]);
            }
        }

        $conn->commit();
        http_response_code(200);
        echo json_encode(['success' => true, 'message' => 'Permissions updated successfully!']);

    } catch (PDOException $e) {
        $conn->rollBack();
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'message' => 'Database error',
            'error'   => $e->getMessage()
        ]);
    }
    exit();
}

http_response_code(405);
echo json_encode(['success' => false, 'message' => 'Method Not Allowed']);
?>

