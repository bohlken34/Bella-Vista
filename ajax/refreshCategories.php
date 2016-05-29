<?php 
require_once '../includes/db.php'; // The mysql database connection script

if(isset($_GET['selection'])){
	$selection = $mysqli->real_escape_string($_GET['selection']);
}
$query="SELECT CATEGORY_ID, CATEGORY_NAME, CATEGORY_DESCRIPTION from menu_categories where menu_id = '$selection' order by category_id asc";
$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

$arr = array();
if($result->num_rows > 0) {
	while($row = $result->fetch_assoc()) {
		$arr[] = $row;	
	}
}

# JSON-encode the response
echo $json_response = json_encode($arr);
?>