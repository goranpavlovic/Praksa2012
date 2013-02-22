<?php

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
if(!$file = fopen($argv[1],'r'))
{
	echo 'error opening file';
	break;
}

$file_contents = fread($file, filesize($argv[1]));

$jsonObject = json_decode($file_contents);

$date = $jsonObject->{'Date'};

foreach($jsonObject->{'Shows'} as $data)
{
	
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
		$query = 'SELECT TvId FROM TVStation WHERE TvName = "' . $jsonObject->{'TV'} . '";';
		$res = mysql_query($query);
		$fetch= mysql_fetch_array($res);
		$tvid = $fetch['TvId'];
		foreach($data->{'Attributes'} as $attrib)
		{
			$key = $attrib->{'AttributeName'};
			$value = $attrib->{'AttributeValue'};
			$attributeSet = $attrib->{'AttributeSet'};
		    utf8_encode($value);

			if($key !== 'TV' && $key !== 'Date' && $key !== 'Time' && $key !== 'Type')
			{
			    //Get EntityId
				$dateString = explode('-',$date);
				$query = 'SELECT EntityId FROM EAVEntity 
						WHERE DateTime = "' . $dateString[2]. '-' . $dateString[1]. '-' . $dateString[0] . ' ' . $data->{'Time'} . '" AND TvStation = ' . $tvid . ';';
				$result = mysql_query($query);
				if(!$result)
				    echo 'Error executing: ' . $query . '<br />' . "\n";
				$row = mysql_fetch_array($result); 
				if(!$row)
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
					echo 'No record of: ' . $nameAttr->{'AttributeValue'} . ' on: ' . $data->{'Time'} . ' ' . $date . ' in database ' . $query .'<br/>' . "\n";
				}
				else
				{
				    //Get AttributeId
					$entity = $row["EntityId"];
					$result = mysql_query('SELECT AttributeId FROM MetaEAVAttribute WHERE AttributeName LIKE ("' . $key . '");');
					if(!($row = mysql_fetch_array($result, MYSQL_ASSOC)))
					{
						echo 'error! No Attribute named ' . $key . ' in MetaEavAttribute' . '<br/>' . "\n";
					}
					else
					{
						$attribute = $row['AttributeId'];
						$result = mysql_query('SELECT AttributeSetId FROM MetaEAVAttributeSet WHERE AttributeSetName LIKE ("' . $attributeSet . '");');
						$row = mysql_fetch_array($result);
						if(!$row)
						{
							echo "error! Attribute set " . $attributeSet . " does not exist!!!";
						}
						else
						{
							$attributeSetId = $row['AttributeSetId'];
							$query = "INSERT INTO EAVAttributeValue (AttributeId,Value,EntityId, AttributeSetId) 
										VALUES (" . $attribute . ",'" . $value . "','" . $entity . "','" . $attributeSetId . "');";
							if(mysql_query($query))
								echo 'Succesfully inserted value: ' . $value . '<br/>' . "\n";
							else
								echo 'error inserting... ' . $query . '<br/>' . "\n";
						}
					}
				}
			}
		}
	}
}
mysql_close($con);
fclose($file);
exit();
