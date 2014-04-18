<%@ include file="../../../Includes/JSPs/Lables/iLang_Lables.jsp" %>
<%
	String replyToUser = request.getParameter("fromUser");
	String replyToSubject = request.getParameter("msgSubject");
	String replyToMsgID = request.getParameter("MessageID");
	String msgType = request.getParameter("msgType");
        session.putValue("fname","");
%>
<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main1 roundedCorners">
<div class="my-account" style="overflow:hidden">
<div class="dashboard">
<head>
	<Title>Inbox: Reply Personal Message</Title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script language="javascript"></script>
	<script src="../../Library/JavaScript/Inbox/ezComposePersMsgs.js"></script>
	<Script src="../../Library/Script/popup.js"></Script> 
	<script>
	
	function ezHref(event)
	{
		document.location.href = event;
	}

	var totid = "";	
	var myFlag1=true
	var globalid;
	function ezSubmit()
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
			
				url="../Inbox/ezSelectUsersAjax.jsp?userId="+key+"&date="+new Date();
			
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
	function mailSend()
	{
		if(document.myForm.msgText.value=='')
		{
			alert("Please enter text")
		}
		else
		{
			Popup.showModal('modal1');
			document.myForm.submit();
		}	
	}
		
	</script>

</head>
<body onLoad="document.myForm.msgText.focus()" scroll=no>
<form name=myForm method=post action="ezSendReplyPersMsg.jsp" onSubmit="return chkSubmit()">
<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<!--<div class="col1-set">
<div class="info-box"><br>
	<table class="data-table" id="quickatp">
	<Tr  class="displayheaderback">
		<Td width="100%" class="displayheaderback">Reply Message
		</Td>
	</Tr>
</Table>
</div>
</div>-->
<div class="block" style="padding-left: 0px; width:100%;">
 	<div class="block-title">
 	<strong>
 		<span>Reply Message</span>
	 </strong>
	 </div>
 </div>

<div class="col1-set">
<div class="info-box"><br>
	<table class="data-table" id="quickatp">
	<tbody>

	<Tr>
		<!--<Th  width="15%" height="23" align="left">&nbsp;&nbsp;<b><a href="Javascript:getAddressWindow('TO')" ><font ><u><%= getLabel("TO") %></u></font></a></b></Th>-->
		<Th  width="15%" height="23" align="left">&nbsp;&nbsp;<b><font ><u><%= getLabel("TO") %></u></font></b></Th>
		<Td  width="53%" height="23"><input type='text'  class=InputBox style="width:100%" tabindex=2  name=toUser value='<%=replyToUser%>'></Td>
		
	</Tr>
	<Tr>
		<!--<Th  width="15%" height="18" align="left">&nbsp;&nbsp;<a href="Javascript:getAddressWindow('CC')" ><font ><B><%= getLabel("CC") %> </B></a></Th>-->
		<Th  width="15%" height="18" align="left">&nbsp;&nbsp;<font ><B><%= getLabel("CC") %> </B></Th>
		<Td  width="53%" height="18"><input type='text' class=InputBox  style="width:100%" style="width:100%" tabindex=3  name=ccUser></Td>
		
	</Tr>
	<Tr>
		<!--<Th  width="15%" height="14" align="left">&nbsp;&nbsp;<a href="Javascript:getAddressWindow('BCC')" ><font ><B><%= getLabel("BCC") %></B></a></Th>-->
		<Th  width="15%" height="14" align="left">&nbsp;&nbsp;<font ><B><%= getLabel("BCC") %></B></Th>
		<Td  width="53%" height="14"><input type='text' class=InputBox style="width:100%"  tabindex=3    name=bccUser></Td>
	</Tr>
	<Tr>
		<Th  width="15%" height="21" ALIGN="left">&nbsp;&nbsp;<font ><%= getLabel("SUBJ") %></font></Th>
		<Td  width="53%"  height="21"><input type='text' class=InputBox style="width:100%" maxLength=80 tabindex=4  name=msgSubject value='<%=replyToSubject%>'></Td>
		
	</Tr>
	<Tr>
		<Td  colspan="3" height="65"><Textarea title="Type Message Text" style="overflow:auto;width:100%" tabIndex=5 name="msgText" rows=10></Textarea> </Td>
	</Tr>
	</tbody>
</Table>
</div>
</div>

<br>
<input type=hidden name="attachflag" value="">
<input type="hidden" name="attachString" value="">
<input type="hidden" name="msgType" value="<%=msgType%>">
	<!--<p>
			<a href="javascript:void(0)"><span>Back </span></a>
			&nbsp;&nbsp;&nbsp;<a href="javascript:mailSend()"><span>Send</span></a>
			
			
	</p>-->
	<div id="divAction" style="display:block">
		<button type="button" title="Back" class="button" onclick="javascript:goBack()">
		<span>Back</span></button>		

		<button type="button" title="Copy to Cart" class="button" onclick="javascript:mailSend()">
		<span >Send</span></button>

	</div>	
</form>
</body>
</div>
</div>
</div>
</div>
</div>


