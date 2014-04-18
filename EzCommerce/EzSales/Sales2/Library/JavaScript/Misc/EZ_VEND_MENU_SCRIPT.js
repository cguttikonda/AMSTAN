
var browse="ie"
if (window.navigator.appName=="Microsoft Internet Explorer")
	browse="ie"
else
	browse="ns"
//*******************Menu Scripx Don't touch*****************

//EZ_MenuWidth          = 150;
EZ_FontFamily         = "verdana,arial,sans-serif";
EZ_FontSize           = 10;
EZ_FontBold           = true;
EZ_FontItalic         = false;
//EZ_FontColor          = "white"	//"yellow";
//EZ_FontColorOver      = "black"	//"yellow" //"red"	//"black";
//EZ_BGColor            = "#336699";   //"#0ea9e2" "#4061A4"
//EZ_BGColorOver        = "skyblue"
EZ_ItemPadding        = 4;
EZ_ItemHeight 	      = 15
EZ_ItemWidth	      = 125
EZ_ItemTop	      =0
EZ_ItemLeft	      =0
EZ_SeparatorSize      =1
EZ_SeparatorColor     =	"black"  //"#FFBDBD"	//"Yellow"
//EZ_SeparatorColor1    = "black"

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
//parent.display.document.onmousedown=ezHideAll
parent.parent.banner.document.onmouseover=ezHideAll

function ezClearDivs()
{

  try{
	var divIds=new Array()
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
	
   }catch(myerror){}	
}

function ezMakeMenus()
{
  try
  {
	ezClearDivs();
	for(menusToBuild=1;menusToBuild<=EZ_NoOfMenusToBuild;menusToBuild++)
	{
		ezMakeDiv(menusToBuild);
        }
  }catch(myerror){}	        
}


function ezMakeDiv(menuNo)
{
   try
   {
	var ezDiv=parent.display.document.createElement("DIV");
	parent.display.document.body.appendChild(ezDiv);
	var divId="ezDiv"+menuNo
	with(ezDiv)
	{
		id=divId
		style.position="absolute"
		style.top="0px"
	}
	
	ezDiv.style.visibility="hidden";
	
	ezDiv.onmouseout=ezMenuOut;
	ezDiv.onmouseover=ezMenuOver;
	ezDiv.style.position="absolute";
	ezDiv.style.visibility="hidden"

	var len=1;
	var currentArray=eval("EZ_SALES"+menuNo)
	
	for(var k=0;k<currentArray.length;k++)
	{
		var isLast=false
		if(k==currentArray.length-1)
			isLast=true
	
		if(currentArray[k][2]==1)
		{
			var nextSub=divId+"_"+len
			ezAddMenuItem(divId,currentArray,k,isLast,nextSub)
			ezMakeDiv(menuNo+"_"+len);
			len=len+1;
		}
		else
		{
			ezAddMenuItem(divId,currentArray,k,isLast,0) 
		}
	}
   }catch(myerror){}	        	
}

function ezAddMenuItem(divId1,currentArray,arrSubscr,isLast,nextSub)
{
   try
   {
	itemVal=currentArray[arrSubscr][0]
	itemLink=currentArray[arrSubscr][1]
	hasSub=currentArray[arrSubscr][2]
	itemTarget=currentArray[arrSubscr][3]
	itemURL=currentArray[arrSubscr][4]
	
	divId=parent.display.document.getElementById(divId1)
	EZ_SeparatorString = EZ_SeparatorSize + "px solid " + EZ_SeparatorColor
	EZ_SeparatorString1 = EZ_SeparatorSize + "px solid " + EZ_SeparatorColor1	
	EZ_ItemTop=0
	var backUpItemVal=itemVal

	divItemElement=parent.display.document.createElement("DIV");
	divItemElement.id=divId1+"__"+arrSubscr;
	divItemElement.style.top =EZ_ItemTop + "px";
	divItemElement.style.left =EZ_ItemLeft +"px";
	if(browse=="ie")
		divItemElement.style.cursor="hand"
	else
		divItemElement.style.cursor="pointer"

	
	/*if(!isLast)
		divItemElement.style.borderBottom=EZ_SeparatorString1
	else
		divItemElement.style.borderBottom="1px outset " + EZ_SeparatorColor
	divItemElement.style.borderLeft="0px outset " + EZ_SeparatorColor
	divItemElement.style.borderRight="1px inset black"
	divItemElement.style.borderTop=EZ_SeparatorString
	*/
	
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
	
		
	var strTab='<table ID=tabDiv cellPadding=0 cellSpacing=0 '+ tabStyle+ ' width='+EZ_ItemWidth+' valign=top><tr>'		
	var endTab='</tr></table>'

	if(hasSub==1)
	{	
		divItemElement.innerHTML =strTab+'<td width="98%" '+ tabStyle+ '  ><b>'+ itemVal+'</b></td><td width=2% '+ tabStyle+ ' align=right>'+Ez_RightGif+'</td>'+endTab
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
   try
   {
	with(this.style)
	{
		backgroundColor =  EZ_BGColor
		color = EZ_FontColor
		padding = EZ_ItemPadding +"px";
		font = ((EZ_FontBold) ? "bold " : "normal ") + EZ_FontSize + "px " + EZ_FontFamily;
		fontStyle = (EZ_FontItalic) ? "italic" : "normal";
	}
   }catch(myerror){}	        	
}

function ezShowLink()
{
	try{
	    if(this.ezTarget==3)
	    {
		document.msnForm.pageUrl.value = this.ezUrl
		document.msnForm.target = "_top"
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

if(EzHideAll!=0)
	clearTimeout(EzHideAll)	

   try{
	if(EzHideAllTimer)
		clearTimeout(EzHideAllTimer)
    }catch(myerror){}	        		
}

function ezMenuOut()
{ 
	try{ 
	 EzHideAllTimer=setTimeout("ezHideAll()",300)
	}catch(myerror){}	        	 
}

var EzLocalFlag=0;   

function ezItemOver()
{
  try{
  
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
     var tp = (this.itemIndex * EZ_ItemHeight) + (EZ_SeparatorSize * this.itemIndex) + par.offsetTop + (EZ_ItemPadding*this.itemIndex)
     var lft=this.offsetWidth+par.offsetLeft-1
     
//alert(tp)
      if (tp>(12*13)) tp=tp-26;
      else
      if (tp>(12*12)) tp=tp-23;
      else
      if (tp>(12*11)) tp=tp-20;
      else
      if (tp>(12*10)) tp=tp-18;
      else
      if (tp>(12*9)) tp=tp-16;
      else
      if (tp>(12*8)) tp=tp-14;
      else
      if (tp>(12*7)) tp=tp-12;
      else
      if (tp>(12*6)) tp=tp-10;
      else
      if (tp>(12*5)) tp=tp-8;
      else
      if (tp>(12*4)) tp=tp-6;
      else
      if (tp>(12*3)) tp=tp-4;
      else
      if (tp>(12*2)) tp=tp-2;
      
    //alert(tp)  
      
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
  
  }catch(myerror){}	        
}

function ezItemOut()
{

	ezSetBackgroundColorOut(this);
}

function ezShowMenu(showId,lft,tp,itemIndex)
{
   try
   {
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
		divToPopUp.style.top=tp+(itemIndex*2)
		
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
	//alert("#listBoxId--->"+listBoxId+"#listBoxId1--->"+listBoxId1+"@listBoxId2--->"+listBoxId2)
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
	//alert(obj1.id)
	//alert(chElements[0].id)
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
																				
					divIds[k].innerHTML =strTab + '<td width=2% ' + tabStyle+ ' align=left>'+ Ez_LeftGif + '</td><td width="98%" align=right '+ tabStyle+ '><b>'+ itemVal+'</b></td>'+endTab
				}	
				else 
				{
					divIds[k].innerHTML=strTab+'<td align=right width="100%" '+ tabStyle+ '><b>'+itemVal+'</b></td>'+endTab
				}
	   }		
	}	
}

function ezSetBackgroundColorOver(obj)
{
	var tdArr=obj.childNodes[0].getElementsByTagName("td")
	for(var s=0;s<tdArr.length;s++)
	{
		tdArr[s].style.backgroundColor=EZ_BGColorOver;
		tdArr[s].style.color=EZ_FontColorOver
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
	}
	obj.style.backgroundColor=EZ_BGColor;
	obj.style.color=EZ_FontColor;
}
