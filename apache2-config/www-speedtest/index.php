<html>
<head><meta http-equiv="refresh" content="300"></head>
<boady>
<table>
<tr>
        <td></td>
        <td align="center">
	<a href="../resources/index.php"><img src="resource.jpg" align="left" height="42" width="42"></a>
        <img src="<?php require_once("lastlink2pic");?>">
        </td>
        <td></td>
</tr>
<?php
$PARAMS_ARRAY=array(" "," --end now --start end-3600s "," --end now --start end-3600s "," --end now --start end-28800s "," --end now --start end-86400s "," --end now --start end-604800s "," --end now --start end-2419200s "," --end now --start end-3153600s ");
$TITLE_ARRAY=array(" ","Last hour","Last 12","Last 24h","Last week","Last month","Last year");
$FILENAME_ARRAY=array("1h","12h","24h","week","month","year");

for ($jj = 0; $jj<=5; $jj++) {
echo "<tr>\n";
echo "\t<td><img src=\"my-ping-".$FILENAME_ARRAY[$jj].".png\"></td>\n";
echo "\t<td><img src=\"my-uplink-".$FILENAME_ARRAY[$jj].".png\"></td>\n";
echo "\t<td><img src=\"my-downlink-".$FILENAME_ARRAY[$jj].".png\"></td>\n";
echo "</tr>\n";
}
?>
</boady>
</html>
