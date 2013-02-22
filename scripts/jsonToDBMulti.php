<?php

$connection = mysql_connect('localhost', 'root', 'Praksa2012');

if(!$connection)
{
	echo "Error connecting to database!!!\n";
}
else
{
	$database = mysql_select_db('Praksa2012', $connection);
	
	if(!$database)
	{
		fwrite($logFile, "Error selecting database\n!!!");
	}
	else
	{
		$query = "SELECT Location from Path where Name='JsonFiles'";
		
		$result = mysql_query($query);
		
	    $row = mysql_fetch_array($result);
	    
	    $jsonFilesPath = $row["Location"];
	    
	    $query = "SELECT Location from Path where Name='Scripts'";
	    
	    $result = mysql_query($query);
	    
	    $row = mysql_fetch_array($result);
	    
	    $scriptsPath = $row["Location"];
		
		if ($handle = opendir($jsonFilesPath))
		{
			echo 'Directory opened<br/>';
			while($entry = readdir($handle))
			{
				echo $entry;
				if(strstr($entry, ".json"))
				{
					echo ' true <br/>';
					$DB =  shell_exec('/usr/bin/php5 -f ' . $scriptsPath . 'jsonToDB.php ' . $jsonFilesPath . $entry);
					if($DB)
						echo $DB . '</br>';
					else
						echo 'error in jsonToDB!';
					$EAV =  shell_exec('/usr/bin/php5 -f ' . $scriptsPath . 'jsonToEAV.php ' . $jsonFilesPath . $entry);
					if($EAV)
						echo $EAV;
					else
						echo 'error in jsonToEAV!';
				}
				else
					echo '<br/>';
			}
			closedir($handle);
		}
		
		else
		{
			echo "error opening directory";
		}
	}
}

exit(1);