<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iAddComittedDate_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Purorder/iGetDeliverySchedules.jsp"%>
<%@ page import="ezc.ezutil.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
<Script>
var tabHeadWidth=95
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/ezConvertDates.js"></Script>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
<%
	Date sysdate=new Date();
%>
<script>

	var comLesTod_L = '<%=comLesTod_L%>';
	var plzEnComDat_L = '<%=plzEnComDat_L%>';
	var subComDatSure_L = '<%=subComDatSure_L%>';
	function checkVal()
	{
	     var ct=0;
  	     var cnt=0;
  	     var fct=0;
	     for(var n=0;n<document.myForm.elements.length;n++)
	     {
	       	if(document.myForm.elements[n].type=='text')
	     	{
	     	   if(document.myForm.elements[n].value=='')
	     	   {
	     	   	ct++;
 	     	   }
 	     	   else
		   {
		   	fct++;
		   }
		   cnt++;
	     	}
	     }

	     if(fct!=cnt)
	     {
	      	alert(plzEnComDat_L)
			return false;
	     }

		
	    var today=new Date('<%=sysdate.getYear()+1900%>',parseInt('<%=sysdate.getMonth()%>',10),'<%=sysdate.getDate()%>');
	     var invDate=false
	     for(n=0;n<document.myForm.elements.length;n++)
	     {
	       	if(document.myForm.elements[n].type=='text')
	     	{
			comDateVal = document.myForm.elements[n].value
			comDateVal = ConvertDate(comDateVal,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')
			var mmm=parseInt(comDateVal.substring(3,5),10)-1
			var comDate = new Date(comDateVal.substring(6,10),mmm,comDateVal.substring(0,2),23,59,59)
			//alert(mmm)
			//alert("comDate"+comDate)
			//alert(today)
			if(comDate < today)
			{
		    		invDate = true;
		    		break;
			}
	     	}
	     }

	     if(invDate)
	     {
	    	alert(comLesTod_L)
			return false;
	     }
	     return true;
	}


	function funCommitedDate()
	{
	    if(checkVal())
	    {
		rt=confirm(subComDatSure_L)
		if(rt)
		{
			document.myForm.action="ezAddSaveCommittedDates.jsp";
			setMessageVisible();

			document.myForm.submit();
			/*var url = "ezSelectAcknowledgeUsers.jsp";
			var hWnd = window.open(url,"UserWindow","width=300,height=300,resizable=yes,scrollbars=yes");
			if ((document.window != null) && (!hWnd.opener))
			{
				hWnd.opener = document.window;
			}*/
		}
	    }

	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body onLoad="scrollInit(0)" onResize="scrollInit(0)" scroll=no>
<form name="myForm" method="post">
<%
	String display_header = delSchPo_L+" "+Long.parseLong(poNum);
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	<BR>
<%
	
	
	if(showData)
	{
%>

		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:60%;left:2%">
		<TABLE width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
		FormatDate myFormat = new FormatDate();

		String date = "";
		String line = "";
		String material = "";
		String matDesc = "";
		String uom = "";
		String scheduleLine = "";
		String key = "";
		String comDate="";
		String curLine="";
		String tempLine="";
		
		int j=0;
		int l=0;
		boolean flag = false;

		String uType=(String)session.getValue("UserType");
		for(int i=0;i<Count;i++)
		{
			date = myFormat.getStringFromDate((java.util.Date)retObj.getFieldValue(i,"DLVDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			line = retObj.getFieldValueString(i,"LINENUM");
			material = retObj.getFieldValueString(i,"MATERIAL");
			try{
				material = String.valueOf(Long.parseLong(material));
			}
			catch(Exception e){}
			if("null".equals(material) || material==null)
				material = "";
			matDesc = retObj.getFieldValueString(i,"MATDESC");
			if("null".equals(matDesc) || matDesc==null)
				matDesc = "";
			uom = retObj.getFieldValueString(i,"UOM");	
			if("null".equals(uom) || uom==null)
				uom = "";
			
				
			scheduleLine = retObj.getFieldValueString(i,"SERIAlNUM");
			tempLine=retObj.getFieldValueString(i,"LINENUM");	

				
			for(int k=0;k<retCount;k++){
				
				if(line.equals(ret.getFieldValueString(k,"DOCITEMNO")) && scheduleLine.equals(ret.getFieldValueString(k,"SCHEDULELINE")))	
				{
					flag = true;
					comDate= myFormat.getStringFromDate((java.util.Date)ret.getFieldValue(k,"COMITTEDDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
					break;
				}
			}
			
			if(flag)
			{
				if(!curLine.equals(tempLine))     	
				{	
					
					
				
%>	
					<tr> 
						<td width="7%" align="center"><%=line%></td>	      
						<td width="15%" align="left">&nbsp;<%=material%></td>
						<td width="30%" align="left">&nbsp;<%=matDesc%></td>
						<td width="7%"  align="center">&nbsp;<%=uom%></td>
						<td width="12%" align="right"><%=getNumberFormat(retObj.getFieldValueString(i,"QUANTITY"),0)%></td>
						<td width="11%" align="center"><%=date%></td>
						<td width="18%" align="center"><%=comDate%></td>
					</tr>
<%			
					curLine=retObj.getFieldValueString(i,"LINENUM");
				}
				else
				{	
%>
					<tr> 
						<td width="7%" align="center">&nbsp;</td>	      
						<td width="15%" align="left">&nbsp;</td>
						<td width="30%" align="left">&nbsp;</td>
						<td width="7%"  align="center">&nbsp;</td>
						<td width="12%" align="right"><%=getNumberFormat(retObj.getFieldValueString(i,"QUANTITY"),0)%></td>
						<td width="11%" align="center"><%=date%></td>
						<td width="18%" align="center"><%=comDate%></td>
					</tr>
<%	        	
					curLine=retObj.getFieldValueString(i,"LINENUM");		
				}
				l=l+1;
			}
			else
			{ 
				if(uType.equals("3"))
				{
					if(!curLine.equals(tempLine))     	
					{			
%>
						<tr> 
							<td width="7%" align="center"><%=line%></td>
							<td width="15%" align="left">&nbsp;<%=material%></td>
							<td width="30%" align="left">&nbsp;<%=matDesc%></td>
							<td width="7%"  align="center">&nbsp;<%=uom%></td>
							<td width="12%" align="right"><%=getNumberFormat(retObj.getFieldValueString(i,"QUANTITY"),0)%></td>
							<td width="11%" align="center"><%=date%></td>
							<td width="18%" align="center">
								<input type=text size=12 class="InputBox" readonly name="committedDate_<%=j%>" value="<%=date%>">
								<%=getDateImage("committedDate_"+j)%>
								<input type="hidden" name="line" value="<%=line%>">     
								<input type="hidden" name="material" value="<%=retObj.getFieldValueString(i,"MATERIAL")%>">     
								<input type="hidden" name="materialDesc" value="<%=retObj.getFieldValueString(i,"MATDESC").replace('\'','`')%>">     
								<input type="hidden" name="uom" value="<%=retObj.getFieldValueString(i,"UOM")%>">     
								<input type="hidden" name="requiredQty" value="<%=getNumberFormat(retObj.getFieldValueString(i,"QUANTITY"),0)%>">     
								<input type="hidden" name="comittedQty" value="<%=getNumberFormat(retObj.getFieldValueString(i,"QUANTITY"),0)%>">     
								<input type="hidden" name="date" value="<%=date%>">     
								<input type="hidden" name="scheduleLine" value="<%=scheduleLine%>">
							</td>
						</tr>
<%	     
						curLine=retObj.getFieldValueString(i,"LINENUM");		    			
					}
					else
					{	
%>
						<tr> 
							<td width="7%" align="center">&nbsp;</td>	      
							<td width="15%" align="left">&nbsp;</td>
							<td width="30%" align="left">&nbsp;</td>
							<td width="7%"  align="center">&nbsp;</td>
							<td width="12%" align="right"><%=getNumberFormat(retObj.getFieldValueString(i,"QUANTITY"),0)%></td>
							<td width="11%" align="center"><%=date%></td>
							<td width="18%" align="center">
								<input type=text size=12 class="InputBox" readonly name="committedDate_<%=j%>" value="<%=date%>">
								<%=getDateImage("committedDate_"+j)%>
								<input type="hidden" name="line" value="<%=line%>">     
								<input type="hidden" name="material" value="<%=retObj.getFieldValueString(i,"MATERIAL")%>">     
								<input type="hidden" name="materialDesc" value="<%=retObj.getFieldValueString(i,"MATDESC").replace('\'','`')%>">     
								<input type="hidden" name="uom" value="<%=retObj.getFieldValueString(i,"UOM")%>">     
								<input type="hidden" name="requiredQty" value="<%=getNumberFormat(retObj.getFieldValueString(i,"QUANTITY"),0)%>">     
								<input type="hidden" name="comittedQty" value="<%=getNumberFormat(retObj.getFieldValueString(i,"QUANTITY"),0)%>">     
								<input type="hidden" name="date" value="<%=date%>">     
								<input type="hidden" name="scheduleLine" value="<%=scheduleLine%>">     
							</td>
						</tr>
<%		
						curLine=retObj.getFieldValueString(i,"LINENUM");
					}	
					j=j+1; 
				}
			}	
			flag=false;	
		}  
%>		
		</table>
		</div> 

<%
		
		if(!uType.equals("3"))
		{
			if(l==0)
			{	
				String noDataStatement = comDatNentPo_L;
%>		
				<%@ include file="../Misc/ezDisplayNoData.jsp" %>
				
				<div id="ButtonDiv" align=center style="position:absolute;top:87%;width:100%" visibility:visible">
				<center>
<%		
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();

				buttonName.add("Back");
				buttonMethod.add("history.go(-1)");
				
				out.println(getButtonStr(buttonName,buttonMethod));
				
%>			
				</center>
				</div>
				<Script>
					document.getElementById("InnerBox1Div").style.visible="hidden"
					document.getElementById("InnerBox1Tab").style.visible="hidden"
				</Script>
<%	   
			}		
		}
		if(j>0)
		{
%>
			<div id="ButtonDiv" align=center style="position:absolute;top:87%;width:100%" visibility:visible">
			<center>
<%		
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();

			buttonName.add("Back");
			buttonMethod.add("history.go(-1)");
			
			buttonName.add("Submit");
			buttonMethod.add("funCommitedDate()");

			buttonName.add("Clear");
			buttonMethod.add("document.forms[0].reset()");
			
			out.println(getButtonStr(buttonName,buttonMethod));
%>			
			</center>
			</Div>
			<%@ include file="../Misc/AddMessage.jsp" %>

			<Div align=center style="position:absolute;top:94%;width:100%" visibility:visible">
			<TABLE align=center>
			<Tr>
			<Td align="center" class="blankcell"><%=toAckClkSub_L%></td>
			</Table>
			</Div>
<%
		}
%>

<%
		if(l>0 || j>0)
		{
%>
			<DIV id="theads">
			<table id="tabHead" width="95%" align="center" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<tr>
				<th width="7%"><%=line_L%></th>
				<th width="15%"><%=mat_L%></th>
				<th width="30%"><%=desc_L%></th>
				<th width="7%"><%=uom_L%></th>
				<th width="12%"><%=reqQty_L%></th>
				<th width="11%"><%=reqDate_L%></th>
				<th width="18%"><%=commitDate_L%></th>
			</tr>
			</table>
			</DIV>
<%
		}
%>

		<div id="msg" align=center style="position:absolute;top:87%;width:100%;visibility:hidden">
		<Table border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr><Th>Please wait .Your Request is being Processed ...</Th></Tr></Table>
		</table>
		</div>

		<input type="hidden" name="toUser" value="">
		<input type="hidden" name="orderType" value="<%=orderType%>">
		<input type="hidden" name="OrderDate" value="<%=request.getParameter("OrderDate")%>">
		<input type="hidden" name="poNum" value="<%=poNum%>">     
		<input type="hidden" name="RCount" value="<%=j%>">  
<%
		if(l>0 && j==0)
		{
%>
			<div id="ButtonDiv" align=center style="position:absolute;top:87%;width:100%" visibility:visible">
			<center>
<%		
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();

				buttonName.add("Back");
				buttonMethod.add("history.go(-1)");

				out.println(getButtonStr(buttonName,buttonMethod));
%>			
			</center>
			</Div>
			<%@ include file="../Misc/AddMessage.jsp" %>
<%
		}
	}
	else
	{ 
		String noDataStatement = comDatNotAvl_L;
%>		
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
		<Div id="ButtonDiv" align=center style="position:absolute;top:87%;width:100%" visibility:visible">
				<center>
		<%		
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
		
				buttonName.add("Back");
				buttonMethod.add("history.go(-1)");
				
				out.println(getButtonStr(buttonName,buttonMethod));
		%>			
				</center>
		</Div>
<% 
	}
%>
<input type="hidden" name="NetAmount" value="<%=NetAmount%>" >
</form>
<Div id="MenuSol"></Div>
</body>
</html>
