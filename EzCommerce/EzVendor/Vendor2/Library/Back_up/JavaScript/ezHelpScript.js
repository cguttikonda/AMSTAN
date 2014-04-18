function EzHelpKeywords(aKey,aText)
{
	this.helpKey=aKey;
	this.helpText=aText
}

function BrowserCheck() {
	var b = navigator.appName
	if (b=="Netscape") this.b = "ns"
	else if (b=="Microsoft Internet Explorer") this.b = "ie"
	     else this.b = b
	this.version = navigator.appVersion
	this.v = parseInt(this.version)
	this.ns = (this.b=="ns" && this.v>=4)
	this.ns4 = (this.b=="ns" && this.v==4)
	this.ns5 = (this.b=="ns" && this.v==5)
	this.ie = (this.b=="ie" && this.v>=4)
	this.ie4 = (this.version.indexOf('MSIE 4')>0)
	this.ie5 = (this.version.indexOf('MSIE 5')>0)
	this.min = (this.ns||this.ie)

 }
 is = new BrowserCheck();

var poptext
function ezPOPUp(msg,myDIV)
{
	poptext = myDIV.style;
	var docPath = "";
	var winHeight=0;
	
	if(top.display){
		docPath=top.display.document
		winHeight=top.display.window.innerHeight
	}else
		if(top.main.display){
			docPath=top.main.display.document
			winHeight=top.main.display.window.innerHeight
		}else{
			docPath=top.main.document
			winHeight=top.main.window.innerHeight
		}
	var content ="<Table width=300 class=tablehelp align = center><Tr><Td class=tdhelp><Table WIDTH=100% CELLPADDING=2 CELLSPACING=2 class=tablesubhelp align = center><Tr><Td  class=tdhelp><p style='align:justify'>"+msg+"</p></Td></TR></Table></Td></TR></Table>";
	if (is.ns4)
	{
	    poptext.document.write(content);
	    poptext.document.close();
	    poptext.visibility = "visible";
  	}
   	else if (is.ie || is.ns)
	{

	  myDIV.innerHTML = content;
	 if (is.ns){
	  	poptext.top =winHeight+2  - myDIV.scrollHeight;
		poptext.left=-490
	 }else{
	  	poptext.top =docPath.body.clientHeight  - myDIV.scrollHeight;
	}
     	 poptext.visibility = "visible";
  	}

}
function ezPOPOut()
{
	if (!(top.display)){
		listBoxHide()
	}
	poptext.visibility = "hidden";
}

function listBoxHide(){
  if(top.main.display)
  		docPath=top.main.display.document
  	else
		docPath=top.main.document

  	listBoxIds=docPath.getElementsByTagName("select")
  	if(listBoxIds!=null)
  	{
  		 for(i=0;i<listBoxIds.length;i++)
  		 {
  		      if(listBoxIds[i].id=="ShowHelp")
  			     listBoxIds[i].style.width="100%"
  			 }
	}

}

