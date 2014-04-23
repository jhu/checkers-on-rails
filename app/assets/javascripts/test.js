(function ($) {
	var request = new XMLHttpRequest();
	//request.onload = callback;
	request.open("post", "http://localhost:3000/curl_example");
	var formData = new FormData();
	formData.append('my_data', "[[ 0,-1,0,-1,0,-1, 0,-1 ],[-1,0,-1,0,-1,0,-1,0],[0,-1,0,-1,0,-1,0,-1],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[1,0,1,0,1,0,1,0],[0,1,0,1,0,1,0,1],[1,0,1,0,1,0,1,0]]")
	request.send(formData);


	var request = new XMLHttpRequest();
request.open("post", "http://localhost:3000/curl_example");
request.setRequestHeader("Content-Type", "application/json");
var move = {};
move.turn = "black";
move.movetext = "22x32";
request.send(JSON.stringify(move));
})(jQuery);