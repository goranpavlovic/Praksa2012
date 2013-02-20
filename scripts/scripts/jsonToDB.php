 <?php
function checkIfExists($timestamp,$tv)
{
	mysql_select_db('Praksa2012',mysql_connect("localhost","root","Praksa2012"));
	$query = 'SELECT EntityId FROM EAVEntity WHERE DateTime LIKE ("' . $timestamp . '%") AND TvStation = ' . $tv . ';';
	//echo $query . '<br/>' . "\n";
	$result = mysql_query($query);
	if(mysql_fetch_array($result))
		return TRUE;
	else
		return FALSE;
}

if(!$con = mysql_connect("localhost","root","Praksa2012"))
{
	echo 'error connecting to database';
	exit();
}
if(!mysql_select_db('Praksa2012', $con))
{
	echo 'error selecting database';
	exit();
}
if(mysql_set_charset('utf8', $con)){}
//if(!$file = fopen($_GET["file"],'r'))
echo $argv[1];
if(!$file = fopen($argv[1],'r'))
{
	echo 'error opening file: ' . $argv[1];
	exit();
}
$haveYouDeleted = FALSE;

$file_contents = fread($file, filesize($argv[1]));

$jsonObject = json_decode($file_contents);

$date = $jsonObject->{'Date'};

$tv = $jsonObject->{'TV'};

echo "\n" . $date . "\n";

foreach($jsonObject->{'Shows'} as $data)
{
	if( $data === null)
	{
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
		//$var = $data->{'Date'} . $data->{'Time'};
		$var = $date . $data->{'Time'};
		$DateTime = date("Y-m-d H-i-s",strtotime($var));
		$result = mysql_fetch_array(mysql_query('SELECT TVid FROM TVStation WHERE TVName LIKE ("' . $tv .'")'),MYSQL_ASSOC);
		if(!$result)
		{
			echo 'error! No such TV<br/>' . "\n";
		}
		else
		{
			$tvID = $result['TVid'];
			$dateString = explode('-',$date);
			$currentDate = $dateString[2]. '-' . $dateString[1]. '-' . $dateString[0];
			if(checkIfExists($currentDate, $tvID) && !$haveYouDeleted)//ako postoji obrisi sve iz baze na taj datum
			{
				$deleteQuery = 'DELETE FROM EAVAttributeValue WHERE EntityId IN' .
								'(SELECT EntityId FROM EAVEntity WHERE Datetime LIKE ("' . $currentDate . '%")' .
										'AND TvStation = ' . $tvID . ');';
				if(mysql_query($deleteQuery))
				{
					echo 'Deleted: ' . $deleteQuery . "\n";
					$deleteQuery = 'DELETE FROM EAVEntity WHERE Datetime LIKE ("' . $currentDate . '%")
															AND TvStation = ' . $tvID . ';';
					if(!mysql_query($deleteQuery))
					{
						echo 'error deleting from EAVEntity: ' . $deleteQuery . "\n";
					}
					else
					{
						echo 'Deleted: ' . $deleteQuery . "\n";
						$haveYouDeleted = TRUE;
					}
				}
				else
				{
					echo 'error deleting from EAVAttributeValue: ' . $deleteQuery . "\n";
				}
			}
			else
				echo 'nothing to delete';
			
			$result = mysql_fetch_array(mysql_query('SELECT EntityTypeId FROM MetaEAVEntityType 
								WHERE EntityTypeName LIKE ("' . $data->{'Type'} . '");'),MYSQL_ASSOC);
			if($result)
			{
				$EntID = $result['EntityTypeId'];
					$upit ='INSERT INTO EAVEntity (DateTime,EntityTypeId,TVStation) 
							VALUES ("'. $DateTime . '",' . $EntID . ',' . $tvID . ');';
					if(mysql_query($upit))
					{
						$nameAttr = null;
						foreach($data->{'Attributes'} as $attr)
						{
							if($attr->{'AttributeName'} === "Name" && $attr->{'AttributeSet'} === "General")
							{
								$nameAttr = $attr;
								break;
							}
						}
						echo 'Successfully inserted ' . $DateTime . '","' . $nameAttr->{'AttributeValue'} . ' ' .$upit . '<br/>' . "\n";
					}
					else
					{
						$nameAttr = null;
						foreach($data->{'Attributes'} as $attr)
						{
							if($attr->{'AttributeName'} === "Name" && $attr->{'AttributeSet'} === "General")
							{
								$nameAttr = $attr;
								break;
							}
						}
						echo 'Error inserting  ' . $DateTime . '","' . $nameAttr->{'AttributeValue'} . $upit . '<br/>' . "\n";	
					}
			}
			else
				echo 'No Entity Type named: ' . $data->{'Type'} . '<br/>' . "\n";
		}
	}
}
echo 'closing database connection..';
mysql_close($con);
echo 'closing file..';
fclose($file);
echo 'exiting....';
exit();
?>
