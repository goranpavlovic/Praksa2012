<?php
include 'simplehtmldom_1_5/simple_html_dom.php';

function RTSDatumi($mesec)
{

$result = null;
	switch($mesec) {
		case 'jan':
			$result = '01';
			break;
		case 'feb':
			$result = '02';
			break;
		case 'mar':
			$result = '03';
			break;
		case 'apr':
			$result = '04';
			break;
		case 'maj':
			$result = '05';
			break;
		case 'jun':
			$result = '06';
			break;
		case 'jul':
			$result = '07';
			break;
		case 'avg':
			$result = '08';
			break;
		case 'sep':
			$result = '09';
			break;
		case 'okt':
			$result = '10';
			break;
		case 'nov':
			$result = '11';
			break;
		case 'dec':
			$result = '12';
			break;
}

return $result;
			
}

$todayDate = date("Y-m-d");

//$date = strtotime("+1 day", strtotime($today));

//$baseLink = "http://www.rts.rs/page/tv/sr/broadcast/20/RTS+1.html?month=1&year=2013&day=24&";
$baseLink = "http://www.rts.rs/page/tv/sr/broadcast/20/RTS+1.html?";

$requestDay = date("j", strtotime($todayDate));
$requestMonth = date("n", strtotime($todayDate));
$requestYear = date("Y", strtotime($todayDate));

$extended = "month=" . $requestMonth . "&year=" . $requestYear . "&day=" . $requestDay . "&";

$requestLink = $baseLink . $extended;

echo $requestLink;
echo "\n";

//$html = file_get_html('http://www.rts.rs/page/tv/ci/broadcast/17/%D0%A0%D0%A2%D0%A1+1.html?month=1&year=2013&day=24&');

$html = file_get_html($requestLink);

$tv = "RTS1";

$counter = 0;

while($html && $counter < 30)
{
	$JsonFile = Array();
	$JsonFile ["TV"] = $tv;
	
	echo "\n" . $todayDate . "\n";
	
	//$html = file_get_html('http://www.rts.rs/page/tv/sr/broadcast/20/RTS+1.html');

	$datum = $html->find('div[id=center]',0)->find('h1',0)->plaintext;

	$datum = strstr($datum, ',');

	$datum = str_replace('&nbsp;', ' ',$datum);

	$niz = explode(' ',$datum);
	$dan  = str_replace('.','',$niz[1]);	//dan
	$mesec = RTSDatumi($niz[2]);//mesec
	$godina = $niz[3];//godina
	
	$date = $dan . '-' . $mesec . '-' . $godina;
	
	$JsonFile["Date"] = $date;

	$tabela = $html->find('div[id=ProgramskaSemaContainer]',0);
	
	$connection = mysql_connect('localhost', 'root', 'Praksa2012');
	
	$database = mysql_select_db('Praksa2012', $connection);
	
	$query = "SELECT Location from Path where Name='JsonFiles'";
	
	$result = mysql_query($query);
	
	$row = mysql_fetch_array($result);
	
	$jsonFilesPath = $row["Location"];
	
	$fileNamePath = $jsonFilesPath . "ParserRTS1" . $requestDay . "-" . $requestMonth . "-" . $requestYear . "" . ".json";
	
	$file = fopen($fileNamePath, 'w');
	
	$JsonFile["Shows"] = Array();

	if(!$file)
		echo 'error opening file';
	else
	{	
		foreach($tabela->children() as $child)
		{
			$Show = Array();
			
			$time = trim($child->find('div[class=ProgramTime]',0)->plaintext);
			//echo mb_detect_encoding(trim($child->find('div[class=ProgramName]',0)->plaintext));
			$name = trim($child->find('div[class=ProgramName]',0)->plaintext);
			$age = trim($child->find('div[class=ProgramAge]',0)->first_child()->alt);
			$age = str_replace('pg','',$age);
			//echo '<br/>';

			$type = '';
			if($child->find('div[class=ProgramType ColorVesti]', 0))
			{
				$type = 'Broadcast';
			}
			else if($child->find('div[class=ProgramType ColorSport]', 0))
			{
				$type = 'Sports Event';
			}
			else if($child->find('div[class=ProgramType ColorSerije]', 0))
			{
				$type = 'TV Show';
			}
			else if($child->find('div[class=ProgramType ColorFilmovi]', 0))
			{
				$type = 'Movie';
			}
			else
			{
				$type = 'Show';
			}
			$string = trim($time) .' ' . trim($name) .' '. trim($age) . "\n";
			$name = str_replace("'", "", $name);
			$name = str_replace('"', "", $name);
			
			$nameArr = Array();
			$nameArr["AttributeName"] = "Name";
			$nameArr["AttributeSet"] = "General";
			$nameArr["AttributeValue"] = $name;
			
			$ageArray = Array();
			$ageArray["AttributeName"] = "Age";
			$ageArray["AttributeSet"] = "General";
			$ageArray["AttributeValue"] = $age;
			$Show["Time"] = $time;
			$Show["Type"] = $type;
			$Show["Attributes"] = Array();
			array_push($Show["Attributes"], $nameArr);
			array_push($Show["Attributes"], $ageArray);
			array_push($JsonFile["Shows"], $Show);
		}
		$json = json_encode($JsonFile);
		fwrite($file, $json);
	}
	fclose($file);
	echo 'file closed';

	$todayDate = date( "Y-m-d",strtotime("+1 day", strtotime($todayDate)));

	$requestDay = date("j", strtotime($todayDate));
	$requestMonth = date("n", strtotime($todayDate));
	$requestYear = date("Y", strtotime($todayDate));
	
	$extended = "month=" . $requestMonth . "&year=" . $requestYear . "&day=" . $requestDay . "&";

	$requestLink = $baseLink . $extended;

	echo $requestLink;
	echo "\n";

	$html = file_get_html($requestLink);

	$counter++;
}
?>
