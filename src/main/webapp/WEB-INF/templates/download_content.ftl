<head>
<style>
.contentBox {
	display:block;
	border-width: 1px;
	border-style: solid;
	border-color: 000;
	padding:5px;
	margin-top:5px;
	width:750px;
	height:450px;
	overflow:scroll;
	overflow-x: hidden;
	}
span.info {color:black;}
span.error {color:red;}

</style>
<script type="text/javascript">
function loadResponse()
{	
	var t=setTimeout("refreshResponse()",1000);
	document.getElementById("myButton").innerHTML='<button type="button" class="button" disabled="disabled" onclick="loadResponse()">Download Template</button>';
    var elemIF = document.createElement("iframe"); 
  	elemIF.src = "generateExcel"; 
  	elemIF.style.display = "none"; 
  	document.body.appendChild(elemIF); 
}

function refreshResponse() {
	var ta = document.getElementById("myDiv"); 
	var t=setTimeout("refreshResponse()",1000);
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	    document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
	    ta.scrollTop = ta.scrollHeight;	    
	    }
	  }
	xmlhttp.open("GET","logstream",true);
	xmlhttp.send();
}
</script>
<link rel="stylesheet" href="style.css" type="text/css">
</head>
<body>
<table>
	<tr><td><h3 style="color:#CC6601;font-family:Tahoma;">Download Excel Template</h3></td><td><div id="myButton"><button class="button" type="button" onclick="loadResponse()">Download Template</button></div></td></tr>
<tr><td colspan=2><div class="contentBox" id="myDiv" ></div></td></tr>
</table>
