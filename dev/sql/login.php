<html>
<body>
    <?php 
    $conn = pg_connect("host=localhost dbname=teste user=dba password=dba123");
    if (!$conn) {
	echo "Could not connect to database!";
	exit;
    }
    $res = pg_query($conn, "SELECT * FROM login WHERE username='". $_POST["username"]
			 . "' AND password='". $_POST["password"] . "'");
	
   if (!$res) {
	echo "ERROR: problems with query!";
        exit;
   }
	
    $rows = pg_num_rows($res);
    
    if ($rows) {
	echo "Successful authentication!";
    } else {
	echo "Wrong user name or password!";
    }
    ?>
</body>
</html>
