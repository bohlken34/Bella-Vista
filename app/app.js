//Define an angular module for our app
var app = angular.module('shopApp', ['as.sortable']);

app.controller('shopController', function($scope, $http) {
	
  $scope.editedItem = {};

  getMenu(); // Load all available menus
  
  function getMenu(){
    $http.post("ajax/getMenu.php").success(function(data){
      $scope.menus = data;
      console.log($scope.menus);
    });
  };

  getItem(); // Load all available items 
  
  function getItem(){ // Loads all items into array "Items"
  $http.post("ajax/getItem.php").success(function(data){
        $scope.items = data;
        console.log($scope.items);
       });
  };

  $scope.refreshCategories = function(selection) { // Loads categories for a particular menu into select box
    $http.post("ajax/refreshCategories.php?selection="+selection).success(function(data){
      $scope.categories = data;
      console.log($scope.categories);
    });
  };

  $scope.refreshItem = function(menu_select) { // Reloads items
    $http.post("ajax/refreshItem.php?menu_select="+menu_select).success(function(data){
      $scope.items = data;
      console.log($scope.items); // Helps me debug
    });
  };
  
  $scope.addItem = function (menu, category, item, itemdescription, itemprice) {
    $http.post("ajax/addItem.php?menu_id="+menu+"&category_id="+category+"&item="+item+"&item_description="+itemdescription+"&item_price="+itemprice).success(function(data){
        $scope.refreshItem(menu);
        console.log("ajax/addItem.php?menu_id="+menu+"&category_id="+category+"&item="+item+"&item_description="+itemdescription+"&item_price="+itemprice);
        $scope.itemInput = "";
        $scope.itemDescription = "";
        $scope.itemPrice = "";
      });
  };
  
  $scope.deleteItem = function (menu, item) {
    if(confirm("Are you sure to delete this item?")){
    $http.post("ajax/deleteItem.php?itemID="+item).success(function(data){

        $scope.refreshItem(menu);
      });
    }
  };

  $scope.clearItem = function () {
    if(confirm("Delete all checked items?")){
    $http.post("ajax/clearItem.php").success(function(data){
        getItem();
      });
    }
  };  

  $scope.changeStatus = function(item, status, task) {
    if(status=='2'){status='0';}else{status='2';}
      $http.post("ajax/updateItem.php?itemID="+item+"&status="+status).success(function(data){
        getItem();
      });
  };

  $scope.editRow = function($index) {
   alert($index);
    $scope.istrue = true;
    $scope.$index = $index;
   // console.log(category);
    angular.copy($scope.items[$index], $scope.editedItem);
  }

  $scope.save = function() {
    $scope.istrue=false;
    console.log($scope.editedItem);
    angular.copy($scope.editedItem, $scope.items[$scope.$index]);
  }

  $scope.dragControlListeners = {
    accept: function(sourceItemHandleScope, destSortableScope) {
      return sourceItemHandleScope.itemScope.sortableScope.$id === destSortableScope.$id;
    },
    itemMoved: function (event) {
    }, //Do what you want
    orderChanged: function (event) {}, //Do what you want
  };
});
