<?php

function getMonth($month)
{
	switch($month)
	{
		case 'Januar': return '01';
		case 'Februar': return '02';
		case 'Mart': return '03';
		case 'April': return '04';
		case 'Maj': return '05';
		case 'Jun': return '06';
		case 'Jul': return '07';
		case 'Avgust': return '08';
		case 'Septembar': return '09';
		case 'Oktobar': return '10';
		case 'Novembar': return '11';
		case 'Decembar': return '12';
		default: {
					$today = date_create(date('Y-m-d H:i:s'));//trenutni datum;
					return $today->format('m');
				}
		}
	}
include 'simplehtmldom_1_5/simple_html_dom.php';
$baseLink = "http://www.rtvpink.com/tvprogram/";
$today = date_create(date('Y-m-d H:i:s'));//trenutni datum;
$html = file_get_html($baseLink);

$refs = $html->find('a');
$links = Array();
foreach($refs as $ref)
{
	if(strstr($ref->href,'index.php?dan='))
	{
		array_push($links, $ref->href);
	}
}
foreach($links as $link)
{
$html = file_get_html($baseLink . $link);
$scripts = $html->find('script');
$json = array();

$json['TV'] = 'Pink';

$date = $html->find('.meniGlavniBeli',1);
$date->plaintext . "\n";
$date = explode(',', $date->plaintext);
$date = $date[1];
$date = explode('.',$date);
$date = $date[0] . '-' . getMonth($date[1]) . '-' .$today->format('Y');
$json['Date'] = trim($date);
$json['Shows'] = Array();

foreach($scripts as $script)
{
	if(strstr($script, 'TVProgram2=new'))
	{
		$arrays = explode('new', $script);
		$i=0;
		$shows = array();
		
		foreach($arrays as $array)
		{
			if($i>2)
			{
				$show = Array();
				$show['Attributes'] = Array();
				
				$string = str_replace(' Array(', '', $array);
				$string = str_replace("'", '', $string);
				$data = explode(',', $string);
				$show['Time'] = $data[6];
				$show['Type'] = "Show";
				
				$nameArray["AttributeName"] = "Name";
				$nameArray["AttributeSet"] = "General";
				$nameArray["AttributeValue"] = $data[0];
				array_push($show["Attributes"], $nameArray);
								
				array_push($json['Shows'], $show);
			}
			$i++;
		}
		array_push($json['Shows'], $shows);
		
	}
}
$connection = mysql_connect('localhost', 'root', 'Praksa2012');
$database = mysql_select_db('Praksa2012', $connection);
$query = "SELECT Location from Path where Name='JsonFiles'";
$result = mysql_query($query);
$row = mysql_fetch_array($result);
$jsonFilesPath = $row["Location"];

$file = fopen($jsonFilesPath . 'Pink' . trim($date) . '.json', 'w');
$encode = json_encode($json);
fwrite($file, $encode);
fclose($file);
}