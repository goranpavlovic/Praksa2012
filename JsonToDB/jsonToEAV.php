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
		foreach($data as $key => $value)
		{
			if($key !== 'TV' && $key !== 'Date' && $key !== 'Time' && $key !== 'Type')
			{
				$dateString = explode('-',$data->{'Date'});
				$query = 'SELECT EntityId FROM EAVEntity 
						WHERE DateTime = "' . $dateString[2]. '-' . $dateString[1]. '-' . $dateString[0] . ' ' . $data->{'Time'} . '";';
				$result = mysql_query($query);
				if(!($row = mysql_fetch_array($result, MYSQL_ASSOC)))
				{
					echo 'No record of: ' . $data->{'Name'} . ' on: ' . $data->{'Time'} . ' ' . $data->{'Date'} . ' in database ' . $query .'<br/>';
				}
				else
				{
					$entity = $row["EntityId"];
					$result = mysql_query('SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName LIKE ("' . $key . '");');
					if(!($row = mysql_fetch_array($result, MYSQL_ASSOC)))
					{
						echo 'error! No Attribute named ' . $key . ' in MetaEavAttribute' . '<br/>';
					}
					else
					{
						$attribute = $row['AttributeId'];
						$query = 'INSERT INTO EAVAttributeValue (AttributeId,Value,EntityId) 
								VALUES (' . $attribute . ',"' . $value . '",' . $entity . ');';
						//echo 'inserting... ' . $query . '<br/>';
						if(mysql_query($query))
							echo 'Succesfully inserted value: ' . $value . '<br/>';
						else
							echo 'error inserting... ' . $query . '<br/>';
					}
				}
			}
		}
	}
}
mysql_close($con);
fclose($file);
