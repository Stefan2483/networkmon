<html>
<head><meta http-equiv="refresh" content="300"></head>
<boady>
<table>
<tr>
        <td></td>
        <td align="center">
       <p align="center"> RESOURCE MONITOR </p> 
	<a href="../speedtest/index.php"><img src="speedtest.jpg" align="left" height="42" width="42"></a>
	</td>
        <td></td>
</tr>
<?php
$PARAMS_ARRAY=array(" "," --end now --start end-3600s "," --end now --start end-3600s "," --end now --start end-28800s "," --end now --start end-86400s "," --end now --start end-604800s "," --end now --start end-2419200s "," --end now --start end-3153600s ");
$TITLE_ARRAY=array(" ","Last hour","Last 12","Last 24h","Last week","Last month","Last year");
$FILENAME_ARRAY=array("1h","12h","24h","week","month","year");

for ($jj = 0; $jj<=5; $jj++) {
echo "<tr>\n";
echo "\t<td><img src=\"pi-temp-".$FILENAME_ARRAY[$jj].".png\"></td>\n";
echo "\t<td><img src=\"CPU-".$FILENAME_ARRAY[$jj].".png\"></td>\n";
echo "\t<td><img src=\"MEM-".$FILENAME_ARRAY[$jj].".png\"></td>\n";
echo "\t<td><img src=\"FS-".$FILENAME_ARRAY[$jj].".png\"></td>\n";
echo "\t<td><img src=\"PROC-".$FILENAME_ARRAY[$jj].".png\"></td>\n";
echo "\t<td><img src=\"NETSTAT-".$FILENAME_ARRAY[$jj].".png\"></td>\n";
echo "</tr>\n";
}
?>
</boady>
</html>
