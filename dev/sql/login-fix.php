<html>
	<body>
		<?php 
$conn = pg_connect("host=localhost dbname=teste user=dba password=dba123");
if (!$conn) {
    echo "Could not connect to database!";
    exit;
}
		
$res0 = pg_prepare($conn, "auth", "SELECT * FROM login WHERE username=$1 AND password=$2");
$res1 = pg_execute($conn, "auth",  array($_POST["username"], $_POST["password"]));
$rows = pg_num_rows($res1);

if ($rows) {
    echo 'Successful authentication!';
} else {
    echo 'Wrong username or password!';
}
?>
</body>
</html>
