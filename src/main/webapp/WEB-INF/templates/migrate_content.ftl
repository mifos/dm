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
span.debug {color:blue;}
</style>
<script type="text/javascript">
var t;
function loadResponse()
{	
	t=setTimeout("refreshResponse()",1000);
	document.getElementById("myButton").innerHTML='<button type="button" class="button" disabled="disabled" onclick="loadResponse()">Migrate</button>';
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
    }
  }
xmlhttp.open("GET","migrationHandle",true);
xmlhttp.send();
}

function refreshResponse() {
	var ta = document.getElementById("myDiv"); 
	t=setTimeout("refreshResponse()",1000);
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
	    if(!document.getElementById("scroll").checked)
			ta.scrollTop = ta.scrollHeight;	    
	    }
	  }
	xmlhttp.open("GET","logstream",true);
	xmlhttp.send();
}
</script>
</head>
<#switch isLocked>
	<#case "true">
		<body>
		<table>
			<tr><td><h3 style="color:#CC6601;font-family:Tahoma;">Migrate uploaded excel  </h3></td><td><div id="myButton"><button class="button" type="button" disabled="disabled" >Migration in progress</button></div></td></tr>
			<tr><td colspan=2><span class="error">Another action is in progress, wait till the current operation is completed</span></div></td></tr>
			<tr><td colspan=2><div class="contentBox" id="myDiv" ></div></td></tr>
			<tr><td></td><td align="right"><input type="checkbox" id="scroll" />Stop scroll</td>
		</table>
		<head>
		<script type="text/javascript">
		 window.onload=refreshResponse();
		</script>
		<#break>
	<#case "false">
		<body>
		<table>
			<tr><td><h3 style="color:#CC6601;font-family:Tahoma;">Migrate uploaded excel  </h3></td><td><div id="myButton"><button class="button" type="button" onclick="loadResponse()">Migrate</button></div></td></tr>
			<tr><td colspan=2><div class="contentBox" id="myDiv" ></div></td></tr>
			<tr><td></td><td align="right"><input type="checkbox" id="scroll" />Stop scroll</td>
		</table>
		<#break>
</#switch>