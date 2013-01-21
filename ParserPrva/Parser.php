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


$html = file_get_html('http://www.prva.rs/sr/program/tvGuide.html?day=0');

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

$tvTable = $html->find('div[class=tabs-container fix]', 0);

$i = 0;


$children = $tvTable->children();

$file = fopen('ParsePrva.json','w');
if(!$file)
	echo 'error opening file';

foreach($children as $child)
{
	
	$typeTag = $child->find('p[class=guideIcon]', 0);

	$typeImgTag = $typeTag->find('img', 0);

	$type = '';

	$attributes = array();

	$attributes['Date'] = $date;

	$titleTag = $child->find('p[class=time_title]', 0);

	$attributes['Time'] = $titleTag->find('span[class=time]', 0)->innertext . ':00';

	$attributes['TV'] = "Prva TV";

	if($titleTag->find('span[class=title]', 0)->find('a', 0))
	{
		$name = trim($titleTag->find('span[class=title]', 0)->find('a', 0)->innertext);

		$name = str_replace("\t", '', $name);

		$attributes['Name'] = $name;

		$details = 'http://www.prva.rs' . $titleTag->find('span[class=title]', 0)->find('a', 0)->href;

		$detailsResponse = file_get_html($details);

		$boxFixDiv = $detailsResponse->find('div[class=boxBG fix"]', 0);

		$title = $boxFixDiv->find('h1', 0);

		$attributes['Synopsis'] = $boxFixDiv->find('p[class=lead]', 0)->plaintext;

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
				}
			}
		}

		$body = $detailsResponse->find('div[class=bodyWrap]', 0);

		$description = $body->plaintext;

		foreach($body->find('div[class=boxFull]') as $element)
		{
			$description = str_replace( $element->plaintext, '', $description);
		}
		$attributes['Description'] = $description;
	}
	else
	{
		$name = $titleTag->find('span[class=title]', 0)->innertext;
		
		$name = str_replace("\t", '', $name);
		
		$attributes['Name'] = $name;
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

	$json = json_encode($attributes);
	fwrite($file,$json);
}

fclose($file);

echo 'file closed';

?>
