<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Search User using AJAX</title>
	<script type="text/javascript">
		var ajax = new SMLHttpRequest;

		function t(){
			ajax.open("GET", "ajax_scorelog_user.php?username=" + document.getElementBy ID("username").value, false);
			ajax.send();

			document.getElementById("container").innerHTML = ajax.responseText;
		}
	</script>
</head>
<body>
	<h2>Search Yser using AJAX</h2>
	<input id = "username" type="text" onkeyup="javascript:t()"/>
	<div id = "container">
	</div>
</body>
</html>