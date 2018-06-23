<?php
	include 'conn.php';
    
    $page = isset($_POST['page']) ? intval($_POST['page']) : 1;
    $rows = isset($_POST['rows']) ? intval($_POST['rows']) : 10;
    $firstname = isset($_POST['firstname']) ? mysql_real_escape_string($_POST['firstname']) : '';
    $lastname = isset($_POST['lastname']) ? mysql_real_escape_string($_POST['lastname']) : '';
    
    $sort = isset($_POST['sort']) ? strval($_POST['sort']) : 'firstname';
    $order = isset($_POST['order']) ? strval($_POST['order']) : 'asc';

    $offset = ($page-1)*$rows;
    
    $result = array();
    
    $where = "firstname like '%$firstname%' and lastname like '%$lastname%'";

    $rs = mysql_query("select count(*) from users where " . $where);
    $row = mysql_fetch_row($rs);
    $result["total"] = $row[0];
    
    $rs = mysql_query("select * from users where " . $where . " order by $sort $order limit $offset,$rows");
    
    $items = array();
    while($row = mysql_fetch_object($rs)){
        array_push($items, $row);
    }
    $result["rows"] = $items;
    
    echo json_encode($result);
?>