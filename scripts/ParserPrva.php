<?php

include 'simplehtmldom_1_5/simple_html_dom.php';


function PrvaMonthToNumber($month)
{

	$result = null;
	switch($month) 
	{
		case 'januar':
			$result = '01';
			break;
		case 'februar':
			$result = '02';
			break;
		case 'mart':
			$result = '03';
			break;
		case 'april':
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
		case 'avgust':
			$result = '08';
			break;
		case 'septembar':
			$result = '09';
			break;
		case 'oktobar':
			$result = '10';
			break;
		case 'novembar':
			$result = '11';
			break;
		case 'decembar':
			$result = '12';
			break;
	}

	return $result;
			
}

$baseLink = "http://www.prva.rs/sr/program/tvGuide.html?day=";

//$html = file_get_html('http://www.prva.rs/sr/program/tvGuide.html?day=0');

$counter = 0;

$requestLink = $baseLink . $counter;

echo $requestLink;
echo "\n";

$html = file_get_html($requestLink);

	$dateTag = $html->find('div[class=currentDate]', 0);

	$date = strstr($dateTag->innertext, ',');

	$date = substr($date, 2, strlen($date));

	$dateArray = explode('.', $date);

	$day = $dateArray[0];

	$monthyear = $dateArray[1];

	$monthYearArray = explode(' ', $dateArray[1]);

	$month = $monthYearArray[1];

	$month = PrvaMonthToNumber($month);

	$year = $monthYearArray[2];

	$date = $day . '-' . $month . '-' . $year;
	
	$year = $monthYearArray[2];
	
while($html && $counter < 7)
{
	$JsonFile = Array();
	
	$JsonFile["Date"] = $date;
	
	$JsonFile["TV"] = "Prva TV";
	
	$JsonFile["Shows"] = Array();
	
	
	$tvTable = $html->find('div[class=tabs-container fix]', 0);

	$i = 0;


	$children = $tvTable->children();
	
	$connection = mysql_connect('localhost', 'root', 'Praksa2012');
	
	$database = mysql_select_db('Praksa2012', $connection);
	
	$query = "SELECT Location from Path where Name='JsonFiles'";

	$result = mysql_query($query);

	$row = mysql_fetch_array($result);
	 
	$jsonFilesPath = $row["Location"];

	$fileName = $jsonFilesPath . "ParserPrvaDay" . $counter . ".json";

	$file = fopen($fileName,'w');
	if(!$file)
		echo 'error opening file';

	foreach($children as $child)
	{
		$show = Array();
		$show["Attributes"] = Array();
		
		$typeTag = $child->find('p[class=guideIcon]', 0);

		$typeImgTag = $typeTag->find('img', 0);

		$type = '';

		$attributes = array();

		$attributes['Date'] = $date;
		
		$titleTag = $child->find('p[class=time_title]', 0);

		$attributes['Time'] = $titleTag->find('span[class=time]', 0)->innertext . ':00';
		
		$show['Time'] = $titleTag->find('span[class=time]', 0)->innertext . ':00';

		$attributes['TV'] = "Prva TV";

		if($titleTag->find('span[class=title]', 0)->find('a', 0))
		{
			$connection = mysql_connect('localhost', 'root', 'Praksa2012');
			
			$database = mysql_select_db('Praksa2012', $connection);
			
			$name = trim($titleTag->find('span[class=title]', 0)->find('a', 0)->innertext);

			$name = str_replace("\t", '', $name);
			
			$name = str_replace("'", "", $name);
			
			$name = str_replace('"', "", $name);
			
			$nameArray = Array();
			$nameArray["AttributeName"] = "Name";
			$nameArray["AttributeSet"] = "General";
			$nameArray["AttributeValue"] = $name;
			array_push($show["Attributes"], $nameArray);

			$details = 'http://www.prva.rs' . $titleTag->find('span[class=title]', 0)->find('a', 0)->href;

			$detailsResponse = file_get_html($details);

			$boxFixDiv = $detailsResponse->find('div[class=boxBG fix"]', 0);

			$title = $boxFixDiv->find('h1', 0);

			$attributes['Synopsis'] = $boxFixDiv->find('p[class=lead]', 0)->plaintext;
			
			$synopsis = Array();
			$synopsis["AttributeName"] = "Synopsis";
			$synopsis["AttributeSet"] = "General";
			$synopsis["AttributeValue"] = $boxFixDiv->find('p[class=lead]', 0)->plaintext;
			array_push($show["Attributes"], $synopsis);

			$boxFullElements = $boxFixDiv->find('div[class=boxFull]');
			foreach($boxFullElements as $element)
			{
				$boxFileDiv = $element->find('div[class=boxFiles]', 0);
				if($boxFileDiv)
				{
					$embedTag = $boxFileDiv->find('embed', 0);
					if($embedTag)
					{
						if($embedTag->flashvars)
						{
							$videoLink = str_replace('file=', '', $embedTag->flashvars);
							$videoLinkArray = explode('&',$videoLink);
							$videoLink = $videoLinkArray[0];
							$videoLink = 'http://www.prva.rs' . $videoLink;
							$ext = pathinfo($videoLink, PATHINFO_EXTENSION);
							if(
									$ext === '3gp' ||
									$ext === 'avi' ||
									$ext === 'flv' ||
									$ext === 'wmv' ||
									$ext === 'mp4'
							)
							{
								$attributes['Link'] = $videoLink;
								$link = Array();
								$link["AttributeName"] = "Link";
								$link["AttributeSet"] = "General";
								$link["AttributeValue"] = $boxFixDiv->find('p[class=lead]', 0)->plaintext;
								array_push($show["Attributes"], $link);
							}
						}
					}
				}
				$boxImageDiv = $element->find('div[class=boxImage]', 0);
				if($boxImageDiv)
				{
					$imageTag = $boxImageDiv->find('img', 0);
					if($imageTag)
					{
						$attributes['Picture'] = 'http://www.prva.rs' . $imageTag->src;
						$picture = Array();
						$picture["AttributeName"] = "Picture";
						$picture["AttributeSet"] = "General";
						$picture["AttributeValue"] = $boxFixDiv->find('p[class=lead]', 0)->plaintext;
						array_push($show["Attributes"], $picture);
					}
				}
			}

			$body = $detailsResponse->find('div[class=bodyWrap]', 0);

			$description = $body->plaintext;

			foreach($body->find('div[class=boxFull]') as $element)
			{
				$description = str_replace( $element->plaintext, '', $description);
			}
			$description = str_replace("'", "", $description);
			$description = str_replace('"', "", $description);
			$attributes['Description'] = $description;
			
			$descrArray = Array();
			$descrArray["AttributeName"] = "Description";
			$descrArray["AttributeSet"] = "General";
			$descrArray["AttributeValue"] = $description;
			array_push($show["Attributes"], $descrArray);
		}
		else
		{
			$name = $titleTag->find('span[class=title]', 0)->innertext;
		
			$name = str_replace("\t", '', $name);
			
			$name = str_replace("'", "", $name);
			
			$name = str_replace('"', "", $name);
		
			$attributes['Name'] = $name;
			$nameArray = Array();
			$nameArray["AttributeName"] = "Name";
			$nameArray["AttributeSet"] = "General";
			$nameArray["AttributeValue"] = $name;
			array_push($show["Attributes"], $nameArray);
		}

		if($typeImgTag->title === 'Emisija')
		{
			$type = 'Show';
		}
		else if($typeImgTag->title === 'Sport')
		{
			$type = 'Sports Event';
		}
		else if($typeImgTag->title === 'Serija')
		{
			$type = 'TV Show';
		}
		else if($typeImgTag->title === 'Film')
		{
			$type = 'Movie';
		}
		else if($typeImgTag->title === 'Info')
		{
			$type = 'Broadcast';
		}
		else
		{
			$type = 'Other';
		}

		$attributes['Type'] = $type;
		$show["Type"] = $type;
		
		array_push($JsonFile["Shows"], $show);
	}
	$json = json_encode($JsonFile);
	fwrite($file, $json);
	fclose($file);
	
	$date = date( "d-m-Y",strtotime("+1 day", strtotime($date)));
	
	echo 'file closed\n';

	$counter++;

	$requestLink = $baseLink . $counter;
	
	echo $requestLink;
	echo "\n";

	$html = file_get_html($requestLink);

}





?>
