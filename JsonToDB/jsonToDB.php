 <?php
	$con = mysql_connect("localhost","root","RSTcd489CCCisco");
	mysql_select_db("test", $con);
	
	$file = fopen($_GET["file"],'r');
while(!feof($file))
{
	$json = '';
	while(($input = fgetc($file)) !== '}')
	{
		$json = $json . $input;
	}
	$json = $json . '}';
	$json;
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
		$upit ='INSERT INTO Broadcast (Date,Time,Name) VALUES ("'. $data->{'Date'} . '","' . $data->{'Time'} . '","' . $data->{'Name'} . '");';
		mysql_query($upit);
		echo $upit . '<br/>';
	}
}
mysql_close($con);
fclose($file);
?>
