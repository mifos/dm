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
div.validation {color:red;}
</style>
<script type="text/javascript">
var x;
var t;
function processForm() {
document.getElementById("validationMesgBox").innerHTML ="";
var flag = checkMimeType();
if(flag) {
 document.forms["uploadForm"].submit();
 document.getElementById("myButton").innerHTML='<input disabled="disabled" class="button" type="button" value="Upload File" onclick="processForm()">';
 t=setTimeout("refreshResponse()",1000);
} else {
 document.getElementById("validationMesgBox").innerHTML ="Please choose a valid xlsx file";
}
}
function checkMimeType() {
x= "false";
if(document.getElementById('file1').files[0].type=="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
return true;
}
return false;
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
		<span class="error">Another action is in progress, wait till the current operation is completed</span>
		<#break>
	<#case "false">
	<table>
			<tr><td><h3 style="color:#CC6601;font-family:Tahoma;">Upload the excel sheet</h3></td><td><form action="Commonsfileuploadservlet" target="hiddenIframe" id="uploadForm" enctype="multipart/form-data" method="POST"><div id="myButton"><input type="file" name="file1" id="file1"/><input type="button" class="button" value="Upload File" onclick="processForm()"></div></form></td></tr>
			<tr><td colspan=2><div class="validation" id="validationMesgBox"></div></div></td></tr>
			<tr><td colspan=2><div class="contentBox" id="myDiv" ></div></td></tr>
			<tr><td></td><td align="right"><input type="checkbox" id="scroll" />Stop scroll</td>
	</table>
	<div hidden><iframe display="none" id="hiddenIframe" ></iframe></div>
		<#break>
</#switch>