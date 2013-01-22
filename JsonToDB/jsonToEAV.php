<?php
//ini_set( 'default_charset', 'UTF-8' );
//header("Content-type: text/html; charset=utf-8");

function checkIfExists($attribute,$entity)
{
	mysql_select_db('Praksa2012',mysql_connect("localhost","root","Praksa2012"));
	$query = 'SELECT * FROM EAVAttributeValue WHERE AttributeId = ' . $attribute . ' AND EntityId = "' . $entity . '";';
	//echo $query . '<br/>';
	$result = mysql_query($query);
	if(mysql_fetch_array($result))
		return TRUE;
	else
		return FALSE;
}

if(!$con = mysql_connect("localhost","root","Praksa2012"))
{
	echo 'error connecting to database';
	break;
}
if(!mysql_select_db('Praksa2012', $con))
{
	echo 'error selecting database';
	break;
}
if(mysql_set_charset('utf8', $con))
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
	    //Get TvId
		$query = 'SELECT TvId FROM TVStation WHERE TvName = "' . $data->{'TV'} . '";';
		//echo $query;
		$res = mysql_query($query);
		$fetch= mysql_fetch_array($res);
		$tvid = $fetch['TvId'];
		//echo 'tv id = ' . $tvid . '<br/>';
		foreach($data as $key => $value)
		{
		    utf8_encode($value);
		    //iconv(mb_detect_encoding($value), 'utf-8', $value);
			if($key !== 'TV' && $key !== 'Date' && $key !== 'Time' && $key !== 'Type')
			{
			    //Get EntityId
				$dateString = explode('-',$data->{'Date'});
				$query = 'SELECT EntityId FROM EAVEntity 
						WHERE DateTime = "' . $dateString[2]. '-' . $dateString[1]. '-' . $dateString[0] . ' ' . $data->{'Time'} . '" AND TvStation = ' . $tvid . ';';
				if(!$result = mysql_query($query))
				    echo 'Error executing: ' . $query . '<br />'; 
				if(!($row = mysql_fetch_array($result, MYSQL_ASSOC)))
				{
					echo 'No record of: ' . $data->{'Name'} . ' on: ' . $data->{'Time'} . ' ' . $data->{'Date'} . ' in database ' . $query .'<br/>';
				}
				else
				{
				    //Get AttributeId
					$entity = $row["EntityId"];
					$result = mysql_query('SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName LIKE ("' . $key . '");');
					if(!($row = mysql_fetch_array($result, MYSQL_ASSOC)))
					{
						echo 'error! No Attribute named ' . $key . ' in MetaEavAttribute' . '<br/>';
					}
					else
					{
						$attribute = $row['AttributeId'];
						if(!checkIfExists($attribute,$entity))
						{
							$query = "INSERT INTO EAVAttributeValue (AttributeId,Value,EntityId) 
									VALUES (" . $attribute . ",'" . $value . "','" . $entity . "');";
							//echo 'inserting... ' . $query . '<br/>';
							if(mysql_query($query))
								echo 'Succesfully inserted value: ' . $value . '<br/>';
							else
								echo 'error inserting... ' . $query . '<br/>';
						}
						else
						{
							$query = "UPDATE EAVAttributeValue SET 
							Value = '" . $value . 
							"' WHERE AttributeId = " . $attribute . " AND EntityId LIKE '" . $entity . "';";
							if(mysql_query($query))
								echo 'Updated Attribute: ' . $attribute . ' Entity: ' . $entity . 
									'with value: ' . $value . '<br/>';
							else
								echo 'Error updating' . $query . '<br/>';
						}
					}
				}
			}
		}
	}
}
mysql_close($con);
fclose($file);
