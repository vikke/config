/* Rename me to update.js
   Double Click in Explorer to run 

Script by Otto - http://ottodestruct.com       */


var iTunesApp = WScript.CreateObject("iTunes.Application");
var tracks    = iTunesApp.LibraryPlaylist.Tracks;
var numTracks = tracks.Count;
var i;
for (i = 1; i <= numTracks; i++)
{
	var currTrack = tracks.Item(i);
	currTrack.UpdateInfoFromFile();
	WScript.StdOut.WriteLine( i + " / " + numTracks + "  " + currTrack.name);
}

