var browse="ie"
if (window.navigator.appName=="Microsoft Internet Explorer")
	browse="ie"
else
	browse="ns"

//*******************Menu Script Don't touch*****************

//EZ_MenuWidth          = 150;
EZ_FontFamily         = "verdana";
EZ_FontSize           = 9;
EZ_FontBold           = true;
EZ_FontItalic         = false;
EZ_FontWeight	      = "bold";	
//EZ_FontColor          = "white"	
//EZ_FontColorOver      = "black"	
//EZ_BGColor            = "#336699";   
//EZ_BGColorOver        = "skyblue" 
EZ_ItemPadding        = 3;
EZ_ItemHeight 	      = 15
EZ_ItemWidth	      = 125
EZ_ItemTop	      =0
EZ_ItemLeft	      =0
EZ_SeparatorSize      =0
//EZ_SeparatorColor     = "#0066FF"
//EZ_SeparatorColor1    = "#0066FF"

EZ_ArrowColorOver 	="#336699"
EZ_ArrowColorOut	="#FFFFFF"

Ez_RightGif   	      ='<img src="../../Images/Common/yellowarrow.gif">'
Ez_LeftGif	      ='<img src="../../Images/Common/yellowarrow1.gif">'


EzMenuStyle=5

EzHideAllTimer=null
EzPrevOver=null
EzPrevOver1=null
EzPrevParent=null
EzMenuDirection=1  //forwardDirection
EzLeftLevelCtr=0
EzChangeBgColor=true

var EzMaxItemLength=0

parent.parent.banner.document.onmouseover=ezHideAll

function ezClearDivs()
{
	var divIds=new Array()
try{

	if(parent.display.document)
	{
		divIds1=parent.display.document.getElementsByTagName("div");
		if(divIds1 != null)
		{
	    		var x=0;
		    	for(var j=0;j<divIds1.length;j++)
		    	{
	    			if((divIds1[j].id.indexOf("ezDiv")>=0)&&(divIds1[j].id.indexOf("__")<0))
	    			{
		    			divIds[x]=divIds1[j];
		    			x++;
	    			}
	    		}
	    		if(divIds != null)
	    		{
				for(var i=0;i<divIds.length;i++)
				{
					if((divIds[i].id.indexOf("ezDiv")>=0)&&(divIds[i].id.indexOf("__")<0))
					{
						var chNodes=divIds[i].childNodes
						if(chNodes != null)
						{
							for(var k=0;k<chNodes.length;k++)
							{
								divIds[i].removeChild(chNodes[k]);
							}
						}
						parent.display.document.body.removeChild(divIds[i]);
					}
				}
	    		}
		}
	}
   }catch(myerror){}
}

function ezMakeMenus()
{
	ezClearDivs();

	try{
		if(top.main.display.document)
		{
			var mObj=eval("top.main.display.document.body");
			if((mObj!=null)&&(mObj!='undefined'))
			{
				for(menusToBuild=1;menusToBuild<=EZ_NoOfMenusToBuild;menusToBuild++)
				{
					ezMakeDiv(menusToBuild);
	        		}
			}
		}
	}catch(myerror){
	}
}


function ezMakeDiv(menuNo)
{
	var aDom	= new ActiveXObject("MSXML.DOMDocument");
	aDom.async	= false;
	var file 	= "";
	if("CU" == userroles)
	{
		file = "ezSalesCUMenu.xml"
	}
	else if("LF" == userroles)
	{
		file = "ezSalesLFMenu.xml"
	}
	else if("CM" == userroles)
	{
		//file = "ezSalesCMMenu.xml"
		file = "ezSalesCUMenu.xml"
	}
	else if("RM" == userroles)
	{
		file = "ezVendIntMenu.xml"
	}
	else
	{
		file = "ezSalesCUMenu.xml"
	}
	aDom.load("../../../../EzAdmin/EzAdmin4/Admin1/JSPs/Config/"+file);
	
	var h		= aDom.documentElement;	
	var currentArray= h.getElementsByTagName("EZ_SALES"+menuNo);
	
	var currenArr;
	var curArray;
try{
	if(top.main.display.document)
	{

		var ezDiv=""
		ezDiv=parent.display.document.createElement("DIV");

		var docPath=top.main.display.document

		if(docPath.getElementById("InnerBox1Div") != null){
			if(docPath.getElementById("buttonDiv") != null)
				docPath.body.appendChild(ezDiv);
		}else{
			docPath.body.appendChild(ezDiv);
		}
		var divId="ezDiv"+menuNo
		with(ezDiv)
		{
			id=divId
			style.position="absolute"
			style.visibility="hidden";
			style.zindex="50";
			style.top="0px"
		}

		ezDiv.onmouseout=ezMenuOut;
		ezDiv.onmouseover=ezMenuOver;
		var len=1;
		
		for(var k=0; k<currentArray.length; k++)
		{
			currenArr	= currentArray.item(k)
			curArray	= currenArr.childNodes;	

			var isLast=false
			if(k==currentArray.length-1)
			{
				isLast=true
			}

			if(currenArr.getAttribute("status")=='Y')
			{
				if(curArray.item(2).firstChild.nodeValue==1)
				{	
					var nextSub=divId+"_"+len
					ezAddMenuItem(divId,currenArr,k,isLast,nextSub)
					ezMakeDiv(menuNo+"_"+len);
					len=len+1;
				}
				else
				{
					ezAddMenuItem(divId,currenArr,k,isLast,0)

				}
			}	
		}

	}
}catch(myerror)
{
	//alert("myerror::"+myerror);
}
}


function ezAddMenuItem(divId1,currArray,arrSubscr,isLast,nextSub)
{	

try{
	var currentArray=currArray.childNodes;
	
	if(currentArray.item(0).hasChildNodes)
	{
		itemVal=currentArray.item(0).firstChild.nodeValue
	}
	if(currentArray.item(1).hasChildNodes)
	{
		itemLink=currentArray.item(1).firstChild.nodeValue
	}
	else
	itemLink="";
	if(currentArray.item(2).hasChildNodes)
	{
		hasSub=currentArray.item(2).firstChild.nodeValue
	}
	if(currentArray.item(3).hasChildNodes)
	{
		itemTarget=currentArray.item(3).firstChild.nodeValue
	}
	if(currentArray.item(4).hasChildNodes)
	{
		itemURL=currentArray.item(4).firstChild.nodeValue
	}
	else
	itemURL="";
	
	
	divId=parent.display.document.getElementById(divId1)

	EZ_SeparatorString	= EZ_SeparatorColor+" 1px inset";
	EZ_SeparatorString1	= EZ_SeparatorColor1+" 1px inset";
	EZ_ItemTop		= 0
	var backUpItemVal	= itemVal

	divItemElement	= parent.display.document.createElement("DIV");
	
	divItemElement.id	= divId1+"__"+arrSubscr;
	divItemElement.style.top= EZ_ItemTop + "px";
	divItemElement.style.left= EZ_ItemLeft +"px";
	if(browse=="ie")
		divItemElement.style.cursor="hand"
	else
		divItemElement.style.cursor="pointer"

	if(!isLast)
		divItemElement.style.borderBottom=0
	else
		divItemElement.style.borderBottom=EZ_SeparatorString1
		
		
	divItemElement.style.borderLeft=EZ_SeparatorString
	
	divItemElement.style.borderRight=EZ_SeparatorString1
	
	divItemElement.style.borderTop=EZ_SeparatorString
	
	var	tabStyle='style="background:'
		tabStyle += EZ_BGColor
		tabStyle += ';font-family:'
		tabStyle += EZ_FontFamily
		tabStyle += ';font-size:'
		tabStyle += EZ_FontSize+'px'
		tabStyle += ';color:'
		tabStyle += EZ_FontColor+';"'
		tabStyle += 'font-weight:'
		tabStyle += EZ_FontWeight+';"'


	var strTab='<table ID=tabDiv cellPadding=0 cellSpacing=0 '+ tabStyle+ ' width='+EZ_ItemWidth+' valign=top><tr height="15">'
	var endTab='</table></tr></table>'

	if(hasSub==1)
	{
		divItemElement.innerHTML =strTab+'<td width="98%" '+ tabStyle+ '  ><b>'+ itemVal+'</td><td width=2% '+ tabStyle+ ' align=right>'+Ez_RightGif+'</b></td>'+endTab
	}	
	else 
	{
		divItemElement.innerHTML=strTab+'<td width="100%" '+ tabStyle+ ' ><b>'+itemVal+'</b></td>'+endTab
	}

	var linkTxt="";          
	for(var tri=0;tri<itemLink.length;tri++)
	{
		if(itemLink.charCodeAt(tri)!=32)
			linkTxt+=itemLink.charAt(tri);
	}
	itemLink=linkTxt;	 
	if(itemLink=="")
		divItemElement.ezLinkText="javascript:void(0)"
	else	
   		divItemElement.ezLinkText=itemLink
   	
   	
	divItemElement.ezTarget=itemTarget
	divItemElement.ezUrl=itemURL
		
	divItemElement.onmousedown=ezShowLink
	divItemElement.onmouseover=ezItemOver
	divItemElement.onclick=ezHideAll
	divItemElement.hasSub1=hasSub
	divItemElement.nextSub1=nextSub	   
	divItemElement.parent=divId1
	divItemElement.itemIndex=arrSubscr
	divItemElement.itemVal1=backUpItemVal
	divItemElement.onmouseout=ezItemOut
	divId.appendChild(divItemElement)
	divItemElement.setProperties=ezSetProperties;
	divItemElement.setProperties();
	
}catch(myerror){}
}

function ezSetProperties()
{

	with(this.style)
	{
		backgroundColor =  EZ_BGColor
		color = EZ_FontColor
		padding = EZ_ItemPadding +"px";
		
		font = ((EZ_FontBold) ? "bold " : "normal ") + EZ_FontSize + "px " + EZ_FontFamily;
		fontStyle = (EZ_FontItalic) ? "italic" : "normal";		
	}
}

function ezShowLink()
{
try{
      
		if(this.ezTarget==2)
		 	open(this.ezLinkText,"EzSo","menubar=no,personalbar=no,toolbar=no,width=775,height=500,left=10,top=20");
		else 
		    if(this.ezTarget==3)
		    {
			
			document.msnForm.pageUrl.value = this.ezUrl
			document.msnForm.target = "_parent"
			//document.msnForm.target = "_top"
			document.msnForm.action = this.ezLinkText
			document.msnForm.submit()

		     }
		else
			 parent.display.location.href=this.ezLinkText
		
	}
	catch(myerror){
		
	}
	
	 
	 
}

function ezMenuOver()
{
	if(EzHideAllTimer)
		clearTimeout(EzHideAllTimer)
		
}

function ezMenuOut()
{
	 EzHideAllTimer=setTimeout("ezHideAll()",300)
}

var EzLocalFlag=0;   

function ezItemOver()
{
   ezSetBackgroundColorOver(this);  
   par=parent.display.document.getElementById(this.parent)

   if(EzPrevOver != null)        
   {
       	var prev=EzPrevOver.substring(0,EzPrevOver.length-3)
   	var cur=this.id.substring(0,this.id.length-5)
   	if(prev==cur) 
   	{
   		var ob1=parent.display.document.getElementById(EzPrevOver);
   		ezSetBackgroundColorOver(ob1)
   	
      	}	
   }				 
 
    if(this.id != EzPrevOver)	
   	ezHideChilds(this);
     EzPrevOver=this.id 	
     
   if(this.hasSub1==1)
   {
     //var tp = (this.itemIndex * EZ_ItemHeight) + (EZ_SeparatorSize * this.itemIndex) + par.offsetTop + (EZ_ItemPadding*this.itemIndex)
     var tp = (this.itemIndex * EZ_ItemHeight) + (EZ_SeparatorSize * this.itemIndex) + par.offsetTop + (EZ_ItemPadding*this.itemIndex)+(this.itemIndex*4)
     var lft=this.offsetWidth+par.offsetLeft-1
     
      var EzLevelCtr=0;		
      for(p=0;p<par.id.length;p++)
      {
     	 if(par.id.charAt(p)=="_")
     		EzLevelCtr++;
      }
      if(EzLeftLevelCtr <= EzLevelCtr)
      {      	
            	if(EzLocalFlag)
		     EzMenuDirection=0;
		else
		     EzMenuDirection=1;
      }
      else
      {
      		EzMenuDirection=1;
      		EzLocalFlag=0;
      }				
 	EzMenuDirection=1    
      if(EzMenuDirection==1) 
      {
      	if((lft+this.offsetWidth) > screen.width-20)
      	{
      		ezInsertLeftInnerText(this.nextSub1)      		
      		lft=lft-(2*this.offsetWidth)
      		EzMenuDirection=0;	
      		EzLeftLevelCtr=EzLevelCtr;
      		EzLocalFlag=1;
       	}	
      }
      else if(EzMenuDirection==0)
      {
      
      	if((lft-(2*this.offsetWidth)) < 0)
      	{
       		EzMenuDirection=1
      	}
      	else
      	{
		ezInsertLeftInnerText(this.nextSub1)      		
		lft=lft-(2*this.offsetWidth)      	
      	}
      }
      ezShowMenu(this.nextSub1,lft,tp,this.itemIndex)  
   }
}

function ezItemOut()
{
	ezSetBackgroundColorOut(this);
}

function ezShowMenu(showId,lft,tp,itemIndex)
{
try{
	//parent.display.document.onmousedown=ezHideAll
	
	divToPopUp=parent.display.document.getElementById(showId)
	if(divToPopUp==null)
	{
		var MenuNo_New=showId.substring(5,showId.length)
		ezMakeDiv(MenuNo_New)
		divToPopUp=parent.display.document.getElementById(showId)
	}
	
	if(divToPopUp.style.visibility=="visible")
		return
	divToPopUp.style.visibility="visible"
	
	if(itemIndex==-1)
	{
		divToPopUp.style.left=lft
		divToPopUp.style.top=tp	
	}	
	else
	{
		divToPopUp.style.left=lft+1
		divToPopUp.style.top=tp
	}
	
	//listbox hiding
	
	listBoxId=parent.display.document.getElementById("listBoxDiv")
	
	if(listBoxId!=null) 
	{
		
		listBoxId.style.visibility="hidden"
		
	}
	
	listBoxId0=parent.display.document.getElementById("listBoxDiv0")
			
	if(listBoxId0!=null) 
	{
				
				listBoxId0.style.visibility="hidden"
				
	}
	
	listBoxId1=parent.display.document.getElementById("listBoxDiv1")
		
	if(listBoxId1!=null) 
	{
			
			listBoxId1.style.visibility="hidden"
			
	}
	
	listBoxId2=parent.display.document.getElementById("listBoxDiv2")
		
	if(listBoxId2!=null) 
	{
			
			listBoxId2.style.visibility="hidden"
			
	}
	
	listBoxId3=parent.display.document.getElementById("listBoxDiv3")
			
	if(listBoxId3!=null) 
	{
				
				listBoxId3.style.visibility="hidden"
				
	}
	
	listBoxId4=parent.display.document.getElementById("listBoxDiv4")
				
	if(listBoxId4!=null) 
	{
					
					listBoxId4.style.visibility="hidden"
					
	}
}catch(myerror){}
}

function ezHideAll()
{
try{
	listBoxId=parent.display.document.getElementById("listBoxDiv")
	listBoxId0=parent.display.document.getElementById("listBoxDiv0")
	listBoxId1=parent.display.document.getElementById("listBoxDiv1")
	listBoxId2=parent.display.document.getElementById("listBoxDiv2")
	listBoxId3=parent.display.document.getElementById("listBoxDiv3")
	listBoxId4=parent.display.document.getElementById("listBoxDiv4")
	if(listBoxId!=null)
	{
		
		listBoxId.style.visibility="visible"
		
	}
	if(listBoxId0!=null)
	{
			
			listBoxId0.style.visibility="visible"
			
	}
	if(listBoxId1!=null)
	{
			
			listBoxId1.style.visibility="visible"
			
	}
	if(listBoxId2!=null)
	{
			
			listBoxId2.style.visibility="visible"
			
	}
	if(listBoxId3!=null)
	{
			
			listBoxId3.style.visibility="visible"
			
	}
	if(listBoxId4!=null)
	{
			
			listBoxId4.style.visibility="visible"
			
	}
	var divIds=parent.display.document.getElementsByTagName("div")
	for(var j=0;j<divIds.length;j++)
	{
		if(((divIds[j].id).indexOf("ezDiv")>=0)&&((divIds[j].id).indexOf("__")<=0))
			divIds[j].style.visibility="hidden"
		if((divIds[j].id).indexOf("__")>=0)
		{
			ezSetBackgroundColorOut(divIds[j]);
		}	
	}
	EzPrevOver=null;
	
}catch(myerror){}	
}

function ezHideChilds(obj1)
{
	var pare=obj1.parent;
	var divIds=parent.display.document.getElementsByTagName("div");
	for(var j=0;j<divIds.length;j++)
	{
		if(((divIds[j].id).indexOf(pare+"_")>=0) && ((divIds[j].id).indexOf("__")<=0))
			divIds[j].style.visibility="hidden"
			
		
	}
	
	var chElements=parent.display.document.getElementById(pare).childNodes;
	for(var k=0;k<chElements.length;k++)
	{
		if(obj1.id != chElements[k].id)
			ezSetBackgroundColorOut(chElements[k]);
	}
}

function ezInsertLeftInnerText(nextmenu)
{
	divIds=parent.display.document.getElementsByTagName("div")
	
	for(var k=0;k<divIds.length;k++)
	{
	  if(divIds[k].id.indexOf(nextmenu+"__") >=0 )
	  {
	  	var itemVal=divIds[k].itemVal1
			  	var	tabStyle='style="background:'
					tabStyle += EZ_BGColor
					tabStyle += ';font-family:'
					tabStyle += EZ_FontFamily
					tabStyle += ';font-size:'
					tabStyle += EZ_FontSize+'px'
					tabStyle += ';color:'
					tabStyle += EZ_FontColor+';"'
					
			
			  	var strTab='<table ID=tabDiv cellPadding=0 cellSpacing=0 '+ tabStyle+ ' width='+EZ_ItemWidth+'><tr>'		
				var endTab='</tr></table>'
				if(divIds[k].hasSub1==1)
				{
					divIds[k].innerHTML =strTab + '<td width=2% ' + tabStyle+ ' align=left>'+ Ez_LeftGif + '</td><td width="98%" align=right '+ tabStyle+ '>'+ itemVal+'</td>'+endTab
				}	
				else 
				{
					divIds[k].innerHTML=strTab+'<td align=right width="100%" '+ tabStyle+ '>'+itemVal+'</td>'+endTab
				}
	   }		
	}	
}
/*
function ezSetBackgroundColorOver(obj)
{
	var tdArr=obj.childNodes[0].getElementsByTagName("td")
	
	for(var s=0;s<tdArr.length;s++)
	{
		tdArr[s].style.backgroundColor=EZ_BGColorOver;
		tdArr[s].style.color=EZ_FontColorOver
		if(tdArr.length==2)
		{
			myUrl=tdArr[1].childNodes[0].src
			myUrl1=myUrl.substring(0,myUrl.lastIndexOf("/",myUrl.indexOf(".",myUrl.indexOf("EzCommerce")))+1)
			myUrl1=myUrl1+"/blackarrow.gif"
			
			tdArr[1].childNodes[0].src=myUrl1
			
		}
		
	}
	obj.style.backgroundColor=EZ_BGColorOver;
	obj.style.color=EZ_FontColorOver
}

function ezSetBackgroundColorOut(obj)
{
	var tdArr=obj.childNodes[0].getElementsByTagName("td")
	for(var s=0;s<tdArr.length;s++)
	{
		tdArr[s].style.backgroundColor=EZ_BGColor;
		tdArr[s].style.color=EZ_FontColor
		if(tdArr.length==2)
		{
					myUrl=tdArr[1].childNodes[0].src
					myUrl1=myUrl.substring(0,myUrl.lastIndexOf("/",myUrl.indexOf(".",myUrl.indexOf("EzCommerce")))+1)
					myUrl1=myUrl1+"/yellowarrow.gif"
					tdArr[1].childNodes[0].src=myUrl1
					
		}
	}
	obj.style.backgroundColor=EZ_BGColor;
	obj.style.color=EZ_FontColor;
}*/
function ezSetBackgroundColorOver(obj)
{
	var tdArr=obj.childNodes[0].getElementsByTagName("td")
	var dFlag=true;
	for(var s=0;s<tdArr.length;s++)
	{
		tdArr[s].style.backgroundColor=EZ_BGColorOver;
		tdArr[s].style.color=EZ_FontColorOver

		if((tdArr.length==2)&&(dFlag))
		{
			dFlag=false;
			sp1=tdArr[1].childNodes[0];
			sp2=tdArr[1].childNodes[1];
			sp1.style.color=EZ_ArrowColorOver
			sp2.style.color=EZ_ArrowColorOver
		}
	}
	obj.style.backgroundColor=EZ_BGColorOver;
	obj.style.color=EZ_FontColorOver
}

function ezSetBackgroundColorOut(obj)
{
	var tdArr=obj.childNodes[0].getElementsByTagName("td")
	var dFlag=true;
	for(var s=0;s<tdArr.length;s++)
	{
		tdArr[s].style.backgroundColor=EZ_BGColor;
		tdArr[s].style.color=EZ_FontColor
		if((tdArr.length==2)&&(dFlag))
		{
			dFlag=false;
			sp1=tdArr[1].childNodes[0];
			sp2=tdArr[1].childNodes[1];
			sp1.style.color=EZ_ArrowColorOut
			sp2.style.color=EZ_ArrowColorOut
		}
	}
	obj.style.backgroundColor=EZ_BGColor;
	obj.style.color=EZ_FontColor;
	
}	