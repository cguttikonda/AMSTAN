var bversion;
x=window.navigator.userAgent;
if(window.navigator.appName =="Microsoft Internet Explorer")
{
	bversion=x.substring(  (x.indexOf("MSIE ")+4), x.indexOf(";",(x.indexOf(";")+1)) );
}