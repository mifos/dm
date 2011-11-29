<link rel="stylesheet" href="style.css" type="text/css">
<script type="text/javascript" src="jquery.min.js"></script> 
    <script type="text/javascript"> 
        $(function() {
          if ($.browser.msie && $.browser.version.substr(0,1)<7)
          {
			$('li').has('ul').mouseover(function(){
				$(this).children('ul').show();
				}).mouseout(function(){
				$(this).children('ul').hide();
				})
          }
        });        
</script>

<ul id="menu">
        <li><a href="?action=download">Download</a></li>
        <li>
                <a href="#">Migration</a>
                <ul>
                        <li><a href="?action=upload">UPLOAD EXCEL</a></li>
                        <li><a href="?action=migrate">MIGRATE UPLOADED EXCEL</a></li>
                </ul>
        </li>
        <li><a href="?action=info">Info</a></li>
        <li><a href="?action=help">Help</a></li>
</ul>
<br>