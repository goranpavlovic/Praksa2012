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


		if ($handle = opendir($jsonFilesPath)) {
			echo "Directory handle: $handle\n";
			echo "Entries:\n";
		
					/* This is the correct way to loop over the directory. */
					while (false !== ($entry = readdir($handle))) {
						
						
						if($entry !== "." && $entry !== "..")
						{
							$file = $jsonFilesPath . $entry;
							unlink($file);
						}
					}
		
					closedir($handle);
		}
	}
}

