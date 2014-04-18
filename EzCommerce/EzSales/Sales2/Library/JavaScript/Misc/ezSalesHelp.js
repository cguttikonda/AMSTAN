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
	var content ="<Table width=300 class=tablehelp align = center><Tr><Td class=tdhelp><Table WIDTH=100% CELLPADDING=2 CELLSPACING=2 class=tablesubhelp align = center><Tr><Td  class=tdhelp><font style='align:justify;font-family: verdana, arial;font-size: 11px;font-style: normal;'>"+msg+"</font></Td></TR></Table></Td></TR></Table>";
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

		if(screen.width>1000)
			poptext.left=-700
		else
			if(screen.width >= 800)
				poptext.left=-490
			else
				poptext.left=-400


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

function ezShowHelp()
{
	try{
		var docPath = "";
		if(top.main.display){
			docPath=top.main.display.document
		}else{
			docPath=top.main.document
		}
		divToPopUp=docPath.getElementById("ezPageHelp");
		listBoxIds=docPath.getElementsByTagName("select")
		if(listBoxIds!=null)
		{
			for(i=0;i<listBoxIds.length;i++)
			{
				if(listBoxIds[i].id=="ShowHelp")
				listBoxIds[i].style.width="0%"
			}
		}
		if(divToPopUp==null)
		{
			divToPopUp=docPath.createElement("DIV");
			with(divToPopUp)
			{
				id="ezPageHelp";
				style.position="absolute";
				innerHTML="EzCommerce";
				style.visibility="hidden";
			}
			if(docPath.getElementById("InnerBox1Div") != null){
				if(docPath.getElementById("buttonDiv") != null)
					docPath.body.appendChild(divToPopUp);

			}else{
				docPath.body.appendChild(divToPopUp);
			}

		}
		myUrl=docPath.location.href;
		myUrl=myUrl.substring(myUrl.lastIndexOf("/",myUrl.indexOf(".",myUrl.indexOf("EzCommerce")))+1,myUrl.length);
		myURL1=myUrl.substring(myUrl.lastIndexOf("/",myUrl.indexOf("."))+1,myUrl.indexOf("."));
		flag=true
		for(i=0;i<myKeys.length;i++)
		{
			if(myKeys[i].helpKey.toUpperCase()==myURL1.toUpperCase())
			{
				myMsg=myKeys[i].helpText
				flag=false
				break;
			}
		}
		if(flag)
		{
			myMsg=ezPageHelp;
		}
		ezPOPUp(myMsg,divToPopUp);
	}catch(myerror){
	}
}
function ezShowHelpOut()
{
	try{
		ezPOPOut()
	}catch(myerror) { }
}
function formSubmit()
{
	document.footer.submit();
}