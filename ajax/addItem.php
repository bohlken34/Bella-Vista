<?php 
require_once '../includes/db.php'; // The mysql database connection script
if(isset($_GET['item'])){
	$menu_id = $mysqli->real_escape_string($_GET['menu_id']);
	$category_id = $mysqli->real_escape_string($_GET['category_id']);
	$item = $mysqli->real_escape_string($_GET['item']);
	$item_description = $mysqli->real_escape_string($_GET['item_description']);
	$item_price = $mysqli->real_escape_string($_GET['item_price']);
	$status = "0";
	$created = date("Y-m-d", strtotime("now"));

	$query="INSERT INTO menu_items(menu_id,category_id,item,item_description,item_price,status,created_at)  VALUES ('$menu_id', '$category_id', '$item','$item_description','$item_price', '$status', '$created')";
	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

	$result = $mysqli->affected_rows;

	echo $json_response = json_encode($result);
	}
?>