<?php 
require_once '../includes/db.php'; // The mysql database connection script

if(isset($_GET['menu_select'])){
	$selection = $mysqli->real_escape_string($_GET['menu_select']);
}
$query="SELECT menus.menu_name, menu_categories.category_id, menu_categories.category_name, menu_items.id, menu_items.item, menu_items.item_description, menu_items.item_price, menu_items.status, menu_items.created_at from menus left join menu_categories on menus.menu_id = menu_categories.menu_id left join menu_items on menu_categories.category_id = menu_items.category_id where menu_items.item IS NOT NULL and menu_items.menu_id = '$selection'";
$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

/*$arr = array();
$smallarr = array();

if($smallresult->num_rows > 0) {
	while($row = $smallresult->fetch_assoc()) {
		$smallarr[] = $row;
	}
}

$firstrow = array();
$firstrow = $result->fetch_assoc();
# $firstcategory = $firstrow['category_name'];
$category = "";*/
$mainArr = array();
$catArr = array();
$itemArr = array();
$tempCat = "";

if($result->num_rows > 0) {
	while($row = $result->fetch_array()) { // while not out of rows to fetch
		if($tempCat <> $row['category_name']) { // new category name
			if($tempCat <> "") { // not first time in loop
				$catArr['menu_items'] = $itemArr; // add item details array to category array
				unset($itemArr); // clear out item details
				$mainArr[] = $catArr; // add category + items to main array
				$catArr = array(); // clear out category
			}
			$catArr['category_name'] = $row['category_name']; // add category to category array
			$tempCat = $row['category_name']; // save new category for comparison
		}
		$itemArr[] = $row; // save item details to item array
	}
	if(count($itemArr) > 0) { // if there are items
		$catArr['menu_items'] = $itemArr; // add remaining item details array to category array
		$mainArr[] = $catArr; // add remaining category + items to main array
		$catArr = array(); // clear
		$itemArr = array(); // clear
	}
};

/* Hard code a test array to see if JSON encoding matches what I can work with - then get my array to be built like this.
$test = array (
	0 => array (
		'category_name' => 'Appetizers',
		'menu_item' => array (
			array ('item' => 'Calamari', 'item_description' => 'fried...', 'item_price' => '9.00'),
			array ('item' => 'Bruschetta', 'item_description' => 'fresh...', 'item_price' => '7.00')
		),
	),
	1 => array (
		'category_name' => 'Salads',
		'menu_item' => array (
			array ('item' => 'Wedge', 'item_description' => 'fried...', 'item_price' => '9.00'),
			array ('item' => 'Caesar', 'item_description' => 'fresh...', 'item_price' => '7.00')
		),
	)
);

$testdata = json_encode($test);

// Dump $testdata to see what the JSON encoded file looks like
$var_test = var_export($testdata, true);
$var1 = "<?php\n\n\$text = $var_test;\n\n?>";
file_put_contents('dump-test.php', $var1);
*/

// JSON-encode the response
echo $json_response = json_encode($mainArr);

// Dump $mainArr to see what it looks like
$var_str = var_export($mainArr, true);
$var = "<?php\n\n\$text = $var_str;\n\n?>";
file_put_contents('dump.php', $var);

// Dump $json_response to a file to see what it looks like
$var_str2 = var_export($json_response, true);
$var2 = "<?php\n\n\$text = $var_str2;\n\n?>";
file_put_contents('dump_json_encode.php', $var2);

?>