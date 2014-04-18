<%@ include file="../../../Includes/JSPs/Lables/iSalesMenu_Lables.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iSalesMenuOptions_Lables.jsp" %>
<%@ page import="java.util.*" %>
<html>
<head>
<style>
.dynamicDiv 
 { 
	width:450px;
	height:60%;
	border:solid 1px #c0c0c0;
	background-color:#F5F5F5;
	font-size:11px;
	font-family:verdana;
	color:#000;
	padding:5px; 
  } 	
</style>

	<base target="display">
	<%@ include file="../../../Includes/Lib/ezAFAddMenuDir.jsp"%>   
	<script>
	var EZ_NoOfMenusToBuild=6
	</script>

<script src="../../Library/JavaScript/Misc/EZ_VEND_MENU_SCRIPT.js"></script>    
 
<script>
var EzHideAll=0

	function ezMouseOver1(mDivId,left)  
	{
		/*parent.frames.display.scroll(0,0)
		if(EzPrevOver1 != mDivId)
		{	
			ezHideAll()
		}
		EzPrevOver1=mDivId; 
		ezShowMenu(mDivId,left+"%",0,-1)*/  
		 
		var welcomeMenu = null
		if(parent.display != null)
			welcomeMenu = parent.display.document.getElementById("MenuSol");  
		if(welcomeMenu != null)
		{
			if(EzHideAll!=0)
				clearTimeout(EzHideAll)
			parent.frames.display.scroll(0,0)
			if(EzPrevOver1 != mDivId)
				ezHideAll()
			EzPrevOver1=mDivId;
			ezShowMenu(mDivId,left+"%",0,-1) 
		}
		
	}
	function ezMouseOver2(mDivId)
	{

		mainDiv=document.getElementById(mDivId);
		ezHideAll();

        }
       function ezMouseOut1(mDivId)
       {

		EzHideAll=setTimeout("ezHideAll()",3000);  
	
       }
       function backToNoError()
       {
		return true
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
       
       
       function ezMakeDivs() 
       {
       	    var ezViewCartDiv=parent.display.document.createElement("DIV");
       	    parent.display.document.body.appendChild(ezViewCartDiv);
       		
       	    ezViewCartDiv.id 	          = "ezViewCartDiv"; 
       	    ezViewCartDiv.style.margin 	  = "0px auto"; 
       	    ezViewCartDiv.style.visibility    = "hidden"; 
       	    ezViewCartDiv.style.overflow	  = "auto"; 
       	    ezViewCartDiv.style.position	  = "absolute"; 
       	    ezViewCartDiv.style.top	          = "0px"; 
       	    ezViewCartDiv.className 	  ="dynamicDiv";	
       	    ezViewCartDiv.setAttribute("align","center"); 
       		
       }
       function ezLoadCart()
       {
          
       
       }
       function viewCart()
       {
	  
	  ezMakeDivs();
	  divToPopUp=parent.display.document.getElementById("ezViewCartDiv");
	  ezLoadCart();
	  ezPOPUp("msg",divToPopUp);
	  
	  /*
	   parent.frames.display.scroll(0,0)
	   divToPopUp=parent.display.document.getElementById("ezViewCartDiv")   
	             
	   divToPopUp.style.visibility="visible"
	   
	   divToPopUp.style.top=110+"px"
	   divToPopUp.style.left=200+"px";
	   divToPopUp.style.visibility="visible";
	   */
       }
       
      function ezPOPUp(msg,myDIV)
      {
	  poptext = myDIV.style;
	  var docPath = "";
	  var winHeight=0;
	  
	  docPath=parent.display.document
	  
		var content ="<Table width=300 align = center><Tr><Td><Table WIDTH=100% CELLPADDING=2 CELLSPACING=2 align = center><Tr><Td ><font style='align:justify;font-family: verdana, arial;font-size: 11px;font-style: normal;'>"+msg+"</font></Td></TR></Table></Td></TR></Table>";
		
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
			 
			 myDIV.style.left=700+"px";
			 poptext.top = 10+"px";
		   }
		 poptext.visibility = "visible";
	       }

      }
	//window.onerror=backToNoError

</script>
<script> 
	EZ_FontColor          = "<%= session.getValue("fontColor")%>"
	EZ_FontColorOver      = "<%= session.getValue("fontColorOver")%>"
	EZ_BGColor            = "<%= session.getValue("menuBGColor")%>"
	EZ_BGColorOver        = "<%= session.getValue("menuBGColorOver")%>"
	EZ_SeparatorColor     =	"<%= session.getValue("menuSeperatorColor")%>"
	EZ_SeparatorColor1    = "<%= session.getValue("menuSeperatorColor1")%>"
</script>
</head>
<body  onLoad="ezMakeMenus()" topmargin = "0" leftmargin = "0" >
<form name="msnForm" method="post">
  
 <%
     String UserRole 	= (String)session.getValue("UserRole"); 
     
     if("CU".equals(UserRole) || "CM".equals(UserRole)){
 %>
 
 <%@ include file="../../../Includes/JSPs/Misc/iSalesFinanceCUMenu.jsp"%>   
 
 <%
     }else{
 %>
 	<%@ include file="../../../Includes/JSPs/Misc/iSalesAFCUMenu.jsp"%>                   
 <%
     }
 %>
</form>
<Div id="MenuSol"></Div>   
</body>
</html>
