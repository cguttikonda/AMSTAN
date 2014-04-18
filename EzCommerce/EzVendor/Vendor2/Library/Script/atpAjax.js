
function chkqtyprod()
{
    var bool='Y'
    var atpfor = document.myForm.atpfor.value;
    var atpqty = document.myForm.atpqty.value;
    
    if(atpfor=="" || atpfor == "Search")
    {
    	bool='N'
    	alert("Please enter Product code to check the ATP.");
    	return false;
    }
    
    if(atpqty<=0)
    {
    	bool='N'
	alert("Please enter Quantity 1 or more.");
	return false;
    }
    if(bool=='Y')
    {
    	loadContent();
    }

}
var xmlhttp
 
function loadContent()
{

 xmlhttp=GetXmlHttpObject();

  if (xmlhttp==null)
  {
   alert ("Your browser does not support Ajax HTTP");
   return;
  }

    var atpfor = document.myForm.atpfor.value;   
    var atpqty = document.myForm.atpqty.value;    
    var atpon  = document.myForm.atpon.value;
    var stAtp  = document.myForm.stAtp.value;

  
    var url="ezATPAjaxLightBox.jsp";
    url=url+"?atpfor="+atpfor+"&atpon="+atpon+"&atpqty="+atpqty+"&stAtp="+stAtp;
    

    xmlhttp.onreadystatechange=getOutput;
    xmlhttp.open("GET",url,true);
    xmlhttp.send(null);
    
}

function getOutput()
{
  if (xmlhttp.readyState==4)
  {
  	document.getElementById("ajaxid").innerHTML=xmlhttp.responseText;
  }
}

function GetXmlHttpObject()
{
    if (window.XMLHttpRequest)
    {
       return new XMLHttpRequest();
    }
    if (window.ActiveXObject)
    {
      return new ActiveXObject("Microsoft.XMLHTTP");
    }
 return null;
}