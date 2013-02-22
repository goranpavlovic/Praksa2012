<?php

include 'simplehtmldom_1_5/simple_html_dom.php';

function resolveDate( $paramday ,$url)
{
	$day = date("D");
	$date = date("Y-m-d");
	$count = 0;
	while($count < 7)
	{
		$add_day = "+" . $count . " day";
		//echo $add_day;
		$today_date = date( "d-m-Y",strtotime($add_day, strtotime($date)));
		$today_day = date( "D",strtotime($add_day, strtotime($date)));
		if($today_day === $paramday)
		{
			return $today_date;
		}
		$count = $count + 1;
	}
	return null;
}

$urls = Array(
		"Mon" => "http://www.rtvzona.com/program-ponedeljak.html",
		"Tue" => "http://www.rtvzona.com/program-utorak.html",
		"Wed" => "http://www.rtvzona.com/program-sreda.html",
		"Thu" => "http://www.rtvzona.com/program-cetvrtak.html",
		"Fri" => "http://www.rtvzona.com/program-petak.html",
		"Sat" => "http://www.rtvzona.com/program-subota.html",
		"Sun" => "http://www.rtvzona.com/program-nedelja.html"
		);


foreach($urls as $day => $url)
{
	$html = file_get_html($url);
	$date = resolveDate( $day ,$url);
	
	$jsonArray = Array();
	
	$jsonArray["TV"] = "TV Zona";
	$jsonArray["Date"] = $date;
	
	$tvProgramDiv = $html->find("div[class=tv-program week]", 0);
	$tvProgli = $tvProgramDiv->find("li");
	
	$jsonArray["Shows"] = Array();
	
	foreach($tvProgli as $li)
	{
		$timeDiv = $li->find("div[class=time]", 0);
		$programDiv = $li->find("div[class=program]", 0);
		$programName = $programDiv->find('label', 0);
		$show = Array();
		$nameArr = Array();
		$nameArr["AttributeName"] = "Name";
		$nameArr["AttributeSet"] = "General";
		$nameArr["AttributeValue"] = html_entity_decode($programName->innertext,ENT_COMPAT | ENT_HTML401,'utf-8');
		$show["Time"] = $timeDiv->innertext;
		if(strstr($programName->innertext, "Serija"))
		{
			$show["Type"] = "TV Show";
		}
		else if(strstr($programName->innertext, "Crtani"))
		{
			$show["Type"] = "Cartoon";
		}
		else if(strstr($programName->innertext, "Film"))
		{
			$show["Type"] = "Movie";
		}
		else if(strstr($programName->innertext, "Vest"))
		{
			$show["Type"] = "Broadcast";
		}
		else
		{
			$show["Type"] = "Show";
		}
		$show["Attributes"] = Array();
		
		array_push($show["Attributes"], $nameArr);
		array_push($jsonArray["Shows"], $show);
	}
	
	$connection = mysql_connect('localhost', 'root', 'Praksa2012');
	
	$database = mysql_select_db('Praksa2012', $connection);
	
	$query = "SELECT Location from Path where Name='JsonFiles'";
	
	$result = mysql_query($query);
	
	$row = mysql_fetch_array($result);
	
	$jsonFilesPath = $row["Location"];
	
	$fileNamePath = $jsonFilesPath . "ParserZona" . $day . ".json";
	
	$jsonFile = json_encode($jsonArray);
	
	$file = fopen($fileNamePath, "w");
	fwrite($file, $jsonFile);
	fclose($file);
}

?>