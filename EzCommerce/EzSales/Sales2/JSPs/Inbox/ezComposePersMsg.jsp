<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/Lib/ezInboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezInbox.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLang_Lables.jsp" %>

<HTML>
<HEAD>
	<script src="../../Library/JavaScript/Inbox/ezComposePersMsgs.js"></script>
	<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>

  	<Title>Inbox: Compose Message</Title>
  	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script>
		
			
		function ezHref(event)
		{
			document.location.href = event;
		}
	
var totid = "";	
var myFlag1=true
var globalid;
function chkSubmit()
{
	var myFlag=true
	
	var FieldNames=new Array();
	var CheckType=new Array();
	var Messages=new Array();

    	var msg=document.myForm.msgText.value;
	
	var ctr=0
	
	/**** TO*******/
	if(document.myForm.toUser.value=="")
	{
		alert("Please Select/Enter To Address");
		document.myForm.toUser.focus();
		return;
	}
	else if(((document.myForm.toUser.value).indexOf("@")>=0))
	{
		var val=document.myForm.toUser.value
		alert("sorry external mails are not allowed")
		myFlag1=false;
		document.myForm.toUser.focus();
		return;
					

	}
	else
	{
		totid = document.myForm.toUser.value;
	}
	/*****END******/
	
	/**** CC*******/
	if(document.myForm.ccUser.value != "")
	{
		if(((document.myForm.ccUser.value).indexOf("@")>=0))
		{
			var val=document.myForm.ccUser.value
			alert("sorry external mails are not allowed")
			myFlag1=false;
			document.myForm.ccUser.focus();
			return;									
		}
		else
		{
			totid  = totid+","+document.myForm.ccUser.value
		}
		
	}
	
	/*****END******/
	
	/**** BCC*******/
	if(document.myForm.ccUser.value != "")
	{
		if(((document.myForm.bccUser.value).indexOf("@")>=0))
		{
			var val=document.myForm.bccUser.value
			alert("sorry external mails are not allowed")
			myFlag1=false;
			document.myForm.bccUser.focus();
			return;									
		}
		else
		{
			totid  = totid+","+document.myForm.bccUser.value
		}
			
	}	
	
	
	
	/*****END******/
	
	//alert("totidtotid  "+totid)
		SendQuery(totid)
	
	}
	function ezHref(event)
	{
		document.location.href = event;
	}
	
	
	
	var showTotalDiv = false;
	var errorid=0;
	
	var sid;
	
	var req;
	
	
	function Initialize()
	{
		try
		{
			req = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(e)
		{
			try
			{
				req = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch(oc)
			{
				req = null;
			}
		}
		if(! req&&typeof XMLHttpRequest != "undefined")
		{
			req = new XMLHttpRequest();
		}
	
	}
	
	function SendQuery(key)
	{
	
	
		try
		{
			req = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(e)
		{
			try
			{
				req = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch(oc)
			{
				req = null;
			}
		}
	
	
	
		
	
		if(!req&&typeof XMLHttpRequest!="undefined")
		{
			req = new XMLHttpRequest();
		}
	
	
	
		var url="";
		
			url=location.protocol+"//<%=request.getServerName()%>/EZP/EzCommerce/EzSales/Sales2/JSPs/Inbox/ezSelectUsersAjax.jsp?userId="+key+"&date="+new Date();
		
		if(req!=null)
		{
			
			req.onreadystatechange = Process;
			req.open("GET", url, true);
			req.send(null);
		}
	
	
	}
	
	function Process()
	{
		if (req.readyState == 4)
		{
			var resText = req.responseText;	 	        	
			var resultText	= resText.split("¥");
			var rcount  = 0;			
			var temp = resultText[0].split("£");
			try
			{				
				rcount   = parseInt(resultText[1]);
				globalid = rcount;
			}catch(Exception){}
			//alert("temp[1]  "+temp[1]);
			if (req.status == 200)
			{
				
				if(rcount>0)
				{
					alert("Please check the following user id(s) ' "+temp[1]+" ' and try again")
					myFlag1 = false;						
					return;
					
				}
				else
				{
					document.myForm.action=action="ezSendPersMsg.jsp"
					document.myForm.submit();
				
				}
			}
			else
			{
				if(req.status == 500)	
					alert("There was a problem while retrieving data,please contact system administrator.");		
			}
			
		}
	}
	
	
	</script>
</HEAD>
<BODY scroll=no>
<FORM name=myForm method=post>
<% String display_header="Compose New Message"; %>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<br>
<Table align=left>
<Tr>	
	<Td align="right" class="blankcell"><font color='red'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* Only Web Mails</Td>
</Tr></Table>
<br>
<Table width="95%" align=center border="1" borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	<Tr>
		<Th  width="15%" height="23" align="left">&nbsp;&nbsp;<b><a href="Javascript:getAddressWindow('TO')" ><font color="#ffffff"><u><%= getLabel("TO") %></u></font></a></b></Th>
		<Td  width="53%" height="23"><input type='text'  class=InputBox style="width:100%" tabindex=2  name=toUser></Td>
	</Tr>
	<Tr>
		<Th  width="15%" height="18" align="left">&nbsp;&nbsp;<a href="Javascript:getAddressWindow('CC')" ><font color="#ffffff"><B><%= getLabel("CC") %> </B></a></Th>
		<Td  width="53%" height="18"><input type='text' class=InputBox  style="width:100%" style="width:100%" tabindex=3  name=ccUser></Td>
		
	</Tr>
	<Tr>
		<Th  width="15%" height="14" align="left">&nbsp;&nbsp;<a href="Javascript:getAddressWindow('BCC')" ><font color="#ffffff"><B><%= getLabel("BCC") %></B></a></Th>
		<Td  width="53%" height="14"><input type='text' class=InputBox style="width:100%"  tabindex=3    name=bccUser></Td>
	</Tr>
	<Tr>
		<Th  width="15%" height="21" ALIGN="left">&nbsp;&nbsp;<B><%= getLabel("SUBJ") %> </B></Th>
		<Td  width="53%"  height="21"><input type='text' class=InputBox style="width:100%" maxLength=80 tabindex=4  name=msgSubject></Td>
		
	</Tr>
	<Tr>
		<Td  colspan="3" height="65"><Textarea title="Type Message Text" style="overflow:auto;width:100%" tabIndex=5 name="msgText" rows=10></Textarea> </Td>
	</Tr>
</Table>

<Table width="100%" align=center >
	<Tr>
		<Td class=blankcell align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Clear");
	buttonMethod.add("funReset()");
	buttonName.add("Send");
	buttonMethod.add("chkSubmit()");
	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
		</Td>
	</Tr>	
</Table>
<br>

<input type=hidden name="attachflag" value="">
<input type="hidden" name="attachString" value="">

</FORM>
<Div id="MenuSol"></Div>
</BODY>

</HTML>
