<?php

echo "\n";
echo "test\n";

$connection = mysql_connect('localhost', 'root', 'Praksa2012');

$logFile = fopen("phpmainlog.txt", "a+");
fwrite($logFile,"\n");
$today = date("d.m.y");
fwrite($logFile,$today);
fwrite($logFile,"\n");

if(!$connection)
{
	fwrite($logFile, "Error connecting to database!!!\n");
}
else
{
	fwrite($logFile, "Connection succesfull!!!\n");
	
	$database = mysql_select_db('Praksa2012', $connection);
	if(!$database)
	{
		fwrite($logFile, "Error selecting database\n!!!");
	}
	else
	{
		$todayDate = date("Y-m-d H:i:s");
		
		echo date("Y-m-d H:i:s", strtotime($todayDate));
		echo "\n";
		
		fwrite($logFile, "Database selecting successfully!!!\n");
		$query = "SELECT ScriptId, Path, LastRun, RunTime from Script";
		
		$result = mysql_query($query);
		
		if(!$result)
		{
			fwrite($logFile, "Error executing query!!!\n");
		}
		else
		{
			while($row = mysql_fetch_assoc($result))
			{
				echo $row["ScriptId"] . "\n";
				echo $row["Path"] . "\n";
				echo $row["LastRun"] . "\n";
				echo $row["RunTime"] . "\n";
			}
		}
	}
	mysql_close($connection);
}

echo "\n";

?>