<?php
require 'db.php';


$stmt = $conn->prepare("SELECT role_id, role_name FROM roles");
$stmt->execute();
$roles = $stmt->fetchAll(PDO::FETCH_ASSOC);


$stmt = $conn->prepare("SELECT perm_id, perm_name FROM permissions");
$stmt->execute();
$permissions = $stmt->fetchAll(PDO::FETCH_ASSOC);

$stmt = $conn->prepare("SELECT role_id, perm_id, is_allowed FROM role_permissions");
$stmt->execute();
$role_permissions = $stmt->fetchAll(PDO::FETCH_ASSOC);

$data = [
    'roles' => $roles,
    'permissions' => $permissions,
    'matrix' => [] 
];

foreach ($roles as $role) {
    $data['matrix'][$role['role_id']] = [];
    foreach ($permissions as $permission) {
        $data['matrix'][$role['role_id']][$permission['perm_id']] = [
            'is_allowed' => false
        ];
    }
}

foreach ($role_permissions as $rp) {
    if (isset($data['matrix'][$rp['role_id']][$rp['perm_id']])) {
        $data['matrix'][$rp['role_id']][$rp['perm_id']]['is_allowed'] = (bool)$rp['is_allowed'];
    }
}


header('Content-Type: application/json');
echo json_encode($data);
?>