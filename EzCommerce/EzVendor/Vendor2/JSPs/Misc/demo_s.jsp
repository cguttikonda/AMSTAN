
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<Html>
<Head>
<Title>Welcome to EzCommerce Suite</Title>
<script type="text/javascript">


var nVer = navigator.appVersion;
var nAgt = navigator.userAgent;
var browserName  = navigator.appName;
var fullVersion  = ''+parseFloat(navigator.appVersion);
var majorVersion = parseInt(navigator.appVersion,10);
var nameOffset,verOffset,ix;

// In Opera, the true version is after "Opera" or after "Version"
if ((verOffset=nAgt.indexOf("Opera"))!=-1) {
 browserName = "Opera";
 fullVersion = nAgt.substring(verOffset+6);
 if ((verOffset=nAgt.indexOf("Version"))!=-1)
   fullVersion = nAgt.substring(verOffset+8);
}
// In MSIE, the true version is after "MSIE" in userAgent
else if ((verOffset=nAgt.indexOf("MSIE"))!=-1) {
 browserName = "Microsoft Internet Explorer";
 fullVersion = nAgt.substring(verOffset+5);
}
// In Chrome, the true version is after "Chrome"
else if ((verOffset=nAgt.indexOf("Chrome"))!=-1) {
 browserName = "Chrome";
 fullVersion = nAgt.substring(verOffset+7);
}
// In Safari, the true version is after "Safari" or after "Version"
else if ((verOffset=nAgt.indexOf("Safari"))!=-1) {
 browserName = "Safari";
 fullVersion = nAgt.substring(verOffset+7);
 if ((verOffset=nAgt.indexOf("Version"))!=-1)
   fullVersion = nAgt.substring(verOffset+8);
}
// In Firefox, the true version is after "Firefox"
else if ((verOffset=nAgt.indexOf("Firefox"))!=-1) {
 browserName = "Firefox";
 fullVersion = nAgt.substring(verOffset+8);
}
// In most other browsers, "name/version" is at the end of userAgent
else if ( (nameOffset=nAgt.lastIndexOf(' ')+1) <
          (verOffset=nAgt.lastIndexOf('/')) )
{
 browserName = nAgt.substring(nameOffset,verOffset);
 fullVersion = nAgt.substring(verOffset+1);
 if (browserName.toLowerCase()==browserName.toUpperCase()) {
  browserName = navigator.appName;
 }
}
// trim the fullVersion string at semicolon/space if present
if ((ix=fullVersion.indexOf(";"))!=-1)
   fullVersion=fullVersion.substring(0,ix);
if ((ix=fullVersion.indexOf(" "))!=-1)
   fullVersion=fullVersion.substring(0,ix);

majorVersion = parseInt(''+fullVersion,10);
if (isNaN(majorVersion)) {
 fullVersion  = ''+parseFloat(navigator.appVersion);
 majorVersion = parseInt(navigator.appVersion,10);
}

//document.write('' +'Browser name  = '+browserName+'<br>')



			close_img = new Image();
			close_img.src="close.jpg";

			open_img = new Image();
			open_img.src="open.jpg";

			var show="1";

			function resizeFrame()
			{
				imgObj = document.getElementById("img_id");


				if(browserName == "Firefox")
				{
					if(show=="1")
					{
						 document.getElementById("tdTree").style.width="0%";
						 document.getElementById("tdGrid").style.width="100%";

						 imgObj.src=open_img.src;
						 show="0";
					}
				   else
				   {
						document.getElementById("tdTree").style.width="15%";
						document.getElementById("tdGrid").style.width="85%";
						imgObj.src=close_img.src;
						show="1";
				   }


				}
				else
				{
					if(show=="1")
					{
						 document.getElementById("tdTree").style.display="none";
						 document.getElementById("tdGrid").style.width="100%";

						 imgObj.src=open_img.src;
						 show="0";
					}
				   else
				   {
						document.getElementById("tdTree").style.display="block";
						document.getElementById("tdGrid").style.width="85%";
						imgObj.src=close_img.src;
						show="1";
				   }
				}
			}
			function onLoad()
			{
					document.getElementById("tdTree").style.width="15%";
					document.getElementById("tdGrid").style.width="85%";
			}
		</script>
</Head>




<Frameset rows="60,*,5%" cols="*" framespacing="0" frameborder="no" border=no scrolling="no">

<Frame name="banner" src="ezLoginBanner_s.jsp?callPreWelcomePage=Y&INIT=FIRST" scrolling="No" border=no marginwidth="0" marginheight="0" noresize>
<Frame  name="footer" src="../jquerys/menuFrame_s.jsp"  border=no scrolling=no noresize>

	
<Frame  name="footer" src="ezFooter_s.jsp"  border=no scrolling=no noresize>
</Frameset>
</Html>