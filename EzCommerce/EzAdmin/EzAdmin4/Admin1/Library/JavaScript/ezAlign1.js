
var bversion;
x=window.navigator.userAgent;
if(window.navigator.appName =="Microsoft Internet Explorer")
{
	bversion=x.substring(  (x.indexOf("MSIE ")+4), x.indexOf(";",(x.indexOf(";")+1)) );
}

bversion=parseFloat(bversion)

var start1;
var end1;
var ok;
if( (document.all)||(document.getElementById))
{
	start1="<div id='Div1' align='center' STYLE='overflow:auto;Position:Absolute;Left:6%;width:90%;height:60%' onresize='chkBrowser1()'>"
	end1="</div>"
	ok=1
}	


function chkBrowser()
{    
	
	if(document.getElementById("Div1")!=null &&  document.getElementById("Table1")!=null) 
	{
	   
	   
	   if(bversion == 6.0 || bversion==6)
	   {
		
		
		document.getElementById("Div1").style.width="100%"
		document.getElementById("Div1").style.left="1%"

	   }
	   else if(bversion == 5.5)
	   {
		
		document.getElementById("Div1").style.width="100%"
		document.getElementById("Div1").style.left="1%"
		document.getElementById("Table1").style.width="98%"

	   }
	   else if(bversion == 5.0)
	   {
		
		document.getElementById("Div1").style.width="98%"
		document.getElementById("Div1").style.left="3%"

	   }
	

	}
}
function chkBrowser1()
{    
	
	if(document.getElementById("Div1")!=null &&  document.getElementById("Table1")!=null) 
	{
		if(document.forms[0].chkField.value=="1")
		{
			   if(bversion == 5.5)
			   {

		   		//document.getElementById("Div1").style.width="100%"
				//document.getElementById("Div1").style.left="2%"
		   		//document.getElementById("Table1").style.width="98%"
				
			   }
		}document.forms[0].chkField.value="1"
	}
}
