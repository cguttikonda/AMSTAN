<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="javax.xml.transform.*,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult" %>
<%@page import="java.util.*,java.io.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@include file="../../../Includes/Jsps/Rfq/iGetQcfComments.jsp" %>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>


<html>
<head>
	<title>Quotation Comparision Form for Collective RFQ No : <%=qcfNum%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</title>
	<%
   	if(rowCount>1)
   	{
	%>
		<script>
		
		
	var attach;
	function funAttach()
	{
		attach=window.open("../Inbox/ezAttachFile.jsp","UserWindow1","width=350,height=250,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
	}

	function funRemove()
	{
		var attachments=new Array();
		var j=0;
		var count=0;
		if(document.myForm.attachs.length>0)
		{
			for(var i=0;i<document.myForm.attachs.length;i++)
			{
				if(document.myForm.attachs.options[i].selected==true)
				{
					count++;
				}
			}
			if(count==0)
			{
				alert("Please Select a File To Delete");
				//return false;
			}
		}
		else
		{
			alert("No Attachments To Remove");
			//return false;
		}
		for(var i=0;i<document.myForm.attachs.length;i++)
		{
			if(document.myForm.attachs.options[i].selected==false)
			{
				attachments[j]=document.myForm.attachs.options[i].value;
				j++;
			}
		}

		for(var i=document.myForm.attachs.length;i>=0;i--)
		{
			document.myForm.attachs.options[i]=null;
		}
		for(var i=0;i<attachments.length;i++)
		{
			document.myForm.attachflag.value="true"
			document.myForm.attachs.options[i]=new Option(attachments[i],attachments[i]);
		}
	}		
		
		
		var sapWindow;
		var type="<%=type%>";
		

		function funSubmit(action)
		{
			if("100066" == action)
			{
				if(document.myForm.attachs.length>0)
				{
					document.myForm.attachflag.value="true";
					var astring=""
					for(var i=0;i<document.myForm.attachs.length;i++)
					{
						astring=astring+document.myForm.attachs.options[i].value+",";
					}
					astring	= astring.substring(0,astring.length-1);
					document.myForm.attachString.value=astring;
				}
			}
	   		if(document.myForm.comments.value=="")
	   		{
	   			alert("Please Enter Your Comments")
			   	document.myForm.comments.focus();
			   	return false;
			}
			else
		   	{

				document.getElementById("ButtonsDiv").style.visibility="hidden"
				document.myForm.Type.value=type
				document.myForm.actionNum.value=action
				document.myForm.action="ezSaveQcfComments.jsp"
			     	document.myForm.submit();
		   	}
		   }
		   
	function funPrint()
	{
		window.print();
	}

	function openWin(num)
	{
		var url="ezQcfSAPView.jsp?qcfNumber="+num;
		sapWindow=window.open(url,"newwin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}

	function funUnload()
	{
		if(sapWindow!=null && sapWindow.open)
		{
		  sapWindow.close();
		}
	}
	
	function reQuote()
	{
		document.myForm.action="ezReQuoteRFQList.jsp";
		document.myForm.submit();
	}
	
	function openByPassList()
	{
		if(document.myForm.bypass.checked)
		{
			var retValue = window.showModalDialog("ezByPassList.jsp","ByPassWin","center=yes;dialogHeight=25;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")	
			if(retValue != null)
				document.myForm.hideBypassCount.value=retValue;
		}	
	}
	</script>
</head>
<body onUnload="funUnload()" >
<form name="myForm" method="post">


	<table width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=1 >
	<tr>
	<td align=right><a href="javascript:openWin('<%=qcfNum%>')">SAP View</a></td>
	</tr>
	<tr>
	<td align=center colspan=2>
	<pre><font size="2"><%=data%></font></pre>
	</td>
	<tr>
	</Table>
	<%
    	int Count = ret.getRowCount();
    	if(Count>0)
    	{
	%>

		<table id="Table1" width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<tr align="center" valign="middle">
	     	<th width="15%">User</th>
     		<th width="25%">Date</th>
	    	<th width="60%">Comments</th>
  		</tr>
		<%
		for(int i=0;i<Count;i++)
		{
			%>
			<tr>
			<td width="15%"><%=ret.getFieldValueString(i,"USER")%></td>
			<td width="25%" align="center"><%=ret.getFieldValueString(i,"DATE")%></td>
			<td width="60%"><%=ret.getFieldValueString(i,"COMMENTS")%></td>
			</tr>
			<%
		}
	%>
	</table>
	<br>
	<% } %>

	<%
	   // if(action.equals("A"))
	   if((!action.equals("A") || !type.equals("A")) && !"APPROVED".equals(status))
	    {
	%>
		<table width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=1 >
		<tr>
		<th width="100%" align=left>Comments</th>
		</tr>
		<tr>
		<td width="100%" align=center>
		<textarea rows=3 cols=80 name="comments" style="width:100%" class="control1"></textarea>
		</td>
		<tr>
		</Table>

	 <% } %>

	<div id="ButtonsDiv" align=center style="position:absolute;visibility:visible;width:100%">
	<%
	
		//if(!action.equals("A"))
		if(action.equals("A") || type.equals("A"))
		{
	%>
		<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none onClick="window.close()">
		<img src="../../Images/Buttons/<%=ButtonDir%>/Print.gif" style="cursor:hand" border=none onClick="funPrint()">

	<%	}
		else
		{
		    if(! "APPROVED".equals(status))		
		    {
		    	ezc.ezpreprocurement.client.EzPreProcurementManager prepromgr = new ezc.ezpreprocurement.client.EzPreProcurementManager();
		    	ezc.ezpreprocurement.params.EziRFQHeaderParams rfqHeadPar = new ezc.ezpreprocurement.params.EziRFQHeaderParams();
		    	rfqHeadPar.setExt1("CPO");
		    	rfqHeadPar.setCollectiveRFQNo(qcfNum);
		    	ezc.ezparam.EzcParams myParams = new ezc.ezparam.EzcParams(false);
		    	myParams.setLocalStore("Y");
		    	myParams.setObject(rfqHeadPar);
		    	Session.prepareParams(myParams);
		    	ezc.ezparam.ReturnObjFromRetrieve priceRet=(ezc.ezparam.ReturnObjFromRetrieve)prepromgr.ezGetRFQList(myParams);
		    	
		    	Double d1 = new Double("0.0");
		    	Double d2 = null;
		    	for(int j=0;j<priceRet.getRowCount();j++)
		    	{
		    		d2 = new Double(priceRet.getFieldValueString(j,"PRICE"));
		    		if(d1.compareTo(d2) == -1);
		    			d1 = d2;
		    	}
		    	d2 = new Double(quantity);
		    	double d3 = d1.doubleValue();
		    	double d4 = d2.doubleValue();
		    	d3 = d3 * d4;
		    	d2 = new Double(d3);
		    	String finalMaxPrice = d2.toString();
			//System.out.println("finalMaxPricefinalMaxPricefinalMaxPrice==="+finalMaxPrice);	    
		    	
			ezc.ezworkflow.client.EzWorkFlowManager wfm = new ezc.ezworkflow.client.EzWorkFlowManager();
			ezc.ezworkflow.params.EziActionsParams  wfp = new ezc.ezworkflow.params.EziActionsParams();
			ezc.ezparam.EzcParams wfMainP = new ezc.ezparam.EzcParams(false);
			wfp.setFlag("Y");
			wfp.setRole((String)session.getValue("ROLE"));
			wfp.setAuthKey("ADD_RFQ");
			//wfp.setQuantity(quantity);
			wfp.setValue(finalMaxPrice);
			wfMainP.setObject(wfp);
			Session.prepareParams(wfMainP);
			ezc.ezparam.ReturnObjFromRetrieve wfr=(ezc.ezparam.ReturnObjFromRetrieve)wfm.getActionsList(wfMainP);
			String actionsList = wfr.getFieldValueString(0,"ACTIONS");
%>
			<table id="Table1" width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
				<tr>
					<th width="100%" align="center">Attached Files</th>
				</tr>
				<tr>
					<Td width="100%" align="center" rowspan="2" valign="bottom">
						<select name="attachs" style="width:100%" size=5>
						</select>
					</Td>
				</tr>
			</table>
<%
			
			if(actionsList.indexOf("SUBMITTED") >= 0)
			{
		%>	
			<table width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=1 >
			<tr>
				<td width="100%" align=left>
					<input type=checkbox name=bypass value='BYPASS' onclick='openByPassList()'><B>ByPass</B>
					<input type=hidden name=hideBypassCount>
				</td>
			</tr>
			</Table>
		<%
			}
			
		   
			if((actionsList.indexOf("APPROVED") >= 0  && !"PUR_PERSON".equals((String)session.getValue("ROLE"))) || (actionsList.equals("ALL")))
			{
		%>
				<img src="../../Images/Buttons/<%=ButtonDir%>/Approve.gif" style="cursor:hand" border=none onClick="funSubmit('100067')">
		<%
			}
			if((actionsList.indexOf("SUBMITTED") >= 0 && ! "VICE_PRESIDENT".equals((String)session.getValue("ROLE"))) || (actionsList.equals("ALL")))
			{
		%>

				<img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif" style="cursor:hand" border=none onClick="funSubmit('100066')">
		<%
			}
			if((actionsList.indexOf("REJECTED") >= 0  && ! "PUR_PERSON".equals((String)session.getValue("ROLE"))) || (actionsList.equals("ALL")))
			{
		%>
				<img src="../../Images/Buttons/<%=ButtonDir%>/rejected.gif" style="cursor:hand" border=none onClick="funSubmit('100068')">
		<%
			}
		    				
	%>	
		
			<img src="../../Images/Buttons/<%=ButtonDir%>/requote.gif" style="cursor:hand" border=none onClick="JavaScript:reQuote()">
			<img src="../../Images/Buttons/<%=ButtonDir%>/Print.gif" style="cursor:hand" border=none onClick="funPrint()">
			<img src="../../Images/Buttons/<%=ButtonDir%>/clear.gif" style="cursor:hand" border=none onClick="document.myForm.reset()">
			<img src="../../Images/Buttons/<%=ButtonDir%>/Cancel.gif" style="cursor:hand" border=none onClick="window.close()">
			<img src="../../Images/Buttons/<%=ButtonDir%>/attach.gif" border=none style="cursor:hand" border=none onClick="JavaScript:funAttach()">
			<img src="../../Images/Buttons/<%=ButtonDir%>/remove1.gif" border=none style="cursor:hand" border=none onClick="JavaScript:funRemove()">
	<%
		    }
		    else
		    {
	%>
			<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none onClick="window.close()">
			<img src="../../Images/Buttons/<%=ButtonDir%>/Print.gif" style="cursor:hand" border=none onClick="funPrint()">
	<%
		    }
		}	
	%>
	</div>
	<input type="hidden" name="QcfNumber" value="<%=qcfNum%>">
	<input type="hidden" name="quantity" value="<%=quantity%>">
	<input type="hidden" name="actionNum">
	<input type="hidden" name="prevStatus" value="<%=prevStatus%>">
	<input type="hidden" name="nextPart" value="<%=nextPart%>">
	<%
	}
	else
	{
	%>

	<br><br><br>
	<table width="60%" align="center" border=0>

  	<%
  	
  	   if(rowCount<=1)
  	   {
  	%>     	<tr align="center"><th>The Collective RFQ No : <%=qcfNum%> does not Exists.</th></tr>

  	<% }else{%>

  		<tr align="center"><th>You have already entered comments to the Collective RFQ No : <%=qcfNum%></th></tr>
  		<tr align="center"><th><a href="ezQcfComments.jsp?qcfNumber=<%=qcfNum%>&action=N"><font color=white>Click here to view Comments</font></a></th></tr>

  	<% } %>

	</table>
	<br><br>
	<center>
	<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none onClick="window.close()">
	</center>
	<%}%>
<input type=hidden name="Type"	value="">
<input type=hidden name="isdelegate"	value="<%=isDelegate%>">
<input type=hidden name="attachflag" value="">
<input type="hidden" name="attachString" value="">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
