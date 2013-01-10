 <?php
	if(!$con = mysql_connect("localhost","root","Praksa2012"))
	{
		echo 'error connecting to database';
		break;
	}
	if(!mysql_select_db('test', $con))
	{
		echo 'error selecting database';
		break;
	}
	if(!$file = fopen($_GET["file"],'r'))
	{
		echo 'error opening file';
		break;
	}
while(!feof($file))
{
	$json = '';
	while(($input = fgetc($file)) !== '}')
	{
		$json = $json . $input;
	}
	$json = $json . '}';
	//$json = fgets($file);
	$data = json_decode($json);
	if( $data === null)
	{
		echo 'error';
		switch (json_last_error()) 
			{
			case JSON_ERROR_NONE:
			    echo ' - No errors';
			break;
			case JSON_ERROR_DEPTH:
			    echo ' - Maximum stack depth exceeded';
			break;
			case JSON_ERROR_STATE_MISMATCH:
			    echo ' - Underflow or the modes mismatch';
			break;
			case JSON_ERROR_CTRL_CHAR:
			    echo ' - Unexpected control character found';
			break;
			case JSON_ERROR_SYNTAX:
			    echo ' - Syntax error, malformed JSON';
			break;
			case JSON_ERROR_UTF8:
			    echo ' - Malformed UTF-8 characters, possibly incorrectly encoded';
			break;
			default:
			    echo ' - Unknown error';
			break;
	    		}
	}
	else
	{
		//echo print_r($data);
		//$upit ='INSERT INTO Broadcast (Date,Time,Name) VALUES ("'. $data->{'Date'} . '","' . $data->{'Time'} . '","' . $data->{'Name'} . '");';
		$var = $data->{'Date'} . $data->{'Time'};
		$DateTime = date("Y-m-d H-i-s",strtotime($var));
		$result = mysql_fetch_array(mysql_query('SELECT TVid FROM TVStation WHERE TVName LIKE ("' . $data->{'TV'} .'")'),MYSQL_ASSOC);
		if(!$result)
		{
			echo 'error! No such TV<br/>';
		}
		else
		{
			$tvID = $result['TVid'];
			$result = mysql_fetch_array(mysql_query('SELECT EntityTypeId FROM MetaEAVEntityType 
								WHERE EntityTypeName LIKE ("' . $data->{'Type'} . '");'),MYSQL_ASSOC);
			if($result)
			{
				$EntID = $result['EntityTypeId'];
				$upit ='INSERT INTO EAVEntity (DateTime,EntityTypeId,TVStation) VALUES ("'. $DateTime . '",' . $EntID . ',' . $tvID . ');';
				if(mysql_query($upit))
					echo 'Successfully inserted ' . $DateTime . '","' . $data->{'Name'} . ' ' .$upit . '<br/>';
				else
					echo 'Error inserting  ' . $DateTime . '","' . $data->{'Name'} . $upit . '<br/>';
			}
			else
				echo 'No Entity Type named: ' . $data->{'Type'} . '<br/>';
		}
	}
}
mysql_close($con);
fclose($file);
?>
