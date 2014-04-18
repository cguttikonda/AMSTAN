<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="ezc.ezutil.FormatDate,java.util.*,ezc.ezparam.ReturnObjFromRetrieve,ezc.ezbasicutil.*" %>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@include file="../../../Includes/Jsps/Purorder/iPoConWFList.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iGetVendorDesc.jsp"%>
<Html>
<Head>
	<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
	<Meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<Script>
		var tabHeadWidth=96
		var tabHeight="55%"
		function funShowVndrDetails(syskey,soldto)
		{
				var retValue = window.showModalDialog("../RFQ/ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;minimize:yes")	
		} 		
		function submitPage()
		{
			document.myForm.submit();
		}
		function getAmndPODtl(ponum)
		{
			var url="../Rfq/ezGetAmndPOdetails.jsp?PurOrderNum="+ponum+"&POorCon=P";
			var sapWindow=window.open(url,"newwin","width=800,height=500,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
		}
		function showTrail()
		 {
			var radLen = document.myForm.chk1.length
			var colno = 0
			var count = 0
			if(!isNaN(radLen))
			{
				for(i=0;i<radLen;i++)
				{
					if(document.myForm.chk1[i].checked)
						count++
				}

				if(count == 0)
				{
					alert("Please select the Collective RFQ No to see Audit");
					return;
				}

				for(i=0;i<radLen;i++)
				{
					if(document.myForm.chk1[i].checked)
					{
						colno = document.myForm.chk1[i].value
						break;
					}
				}
			}
			else
			{
				if(document.myForm.chk1.checked)
				{
					colno = document.myForm.chk1.value
				}
				else
				{
					alert("Please select the Collective RFQ No to see Audit");
					return;
				}
			}
			// hideButton()
			//document.myForm.wf_trail_list.value = colno;
			//location.href='../Misc/ezWFAuditTrailList.jsp?wf_trail_type=PO_RELEASE&wf_trail_list='+colno

			var url="../Misc/ezOfflineWFAuditTrailList.jsp?wf_trail_type=PO_RELEASE&wf_trail_list="+colno;
			var mywind=window.open(url,"ReportWin","width=700,height=300,left=150,top=150,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
			
			
			//document.myForm.action='../Misc/ezWFAuditTrailList.jsp'
			//document.myForm.submit()
		}		
	</Script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</Head>
<Body onLoad="scrollInit(100)" onResize="scrollInit(100)" scroll=no>
<Form name="myForm">
<input type=hidden name=wf_trail_list >
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<Br>



<Div id='inputDiv' style='position:relative;align:center;top:0%;width:100%;'>
<Table width="40%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'#F3F3F3'" valign=middle>
		<Table border="0" align="center" valign=middle width="100%" cellpadding=3 cellspacing=0 class=welcomecell>
		  <Tr >
			<Td style='background:##F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='21%' align=left >Select PO/Contract</Td>
			<Td style='background:##F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='33%' valign=center >
			<select name='POCON' onchange='submitPage()' id="listBoxDiv1" style="width:100%">
			<option value='-'>Select PO / Contract</option>
<%	
			  while(enum.hasMoreElements())
			{
				keyId = (String)enum.nextElement();
				keyValue = (String)auditHash.get(keyId);
				if(pocon!= null && pocon.equals(keyId))
					selected = "selected";
				else
					selected = "";

%>
				<option value='<%=keyId%>' <%=selected%>><%=keyValue%></option>
<%
			}
%>
			</select>

			
		 </Tr>
	      </Table>
	 </Td>
      <Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif" ></Td>
 </Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>
<Div id="nocount" style="position:absolute;top:40%;width:100%;visibility:visible">
	<Table width="30%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	 <Tr align="center">
		<Th>Select Purchase Order or Contracts</Th>
	 </Tr>
	</Table>
</Div>



<%
	FormatDate fD = new FormatDate();
	String escRow = "",txtBg ="";
	if(wfCount > 0)
	{
		ezc.ezparam.ReturnObjFromRetrieve globalRet = null;
																	
		Vector grtypes = new Vector();
		grtypes.addElement("date");
		EzGlobal.setColTypes(grtypes);
		EzGlobal.setDateFormat("dd.MM.yyyy hh:mm:ss");

		Vector grColNames = new Vector();
		grColNames.addElement("DATE");
		EzGlobal.setColNames(grColNames);
				
		globalRet = EzGlobal.getGlobal(retobj);
	
%>
		<DIV id="theads">
		<Table  id="tabHead" width="96%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<Tr align="center" valign="middle">
			<Th width="3%">&nbsp;</Th>
			<Th width="10%"><%=colHead%></Th>
			<Th width="8%">Date</Th>
			<Th width="8%">Vendor</Th>
      			<Th width="13%">Vendor Name</Th>
			<Th width="10%">PO/Contract<BR>Changes</Th>
			<Th width="24%">Status</Th>
			<Th width="14%">To Act</Th>
			<!--<Th width="10%">Query Status</Th>-->
		</Tr>
		</Table>
		</DIV>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
		<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
<%
		String statusValue = "";
		String fileName = "";
		for(int i=0;i<wfCount;i++)
		{
			if("PO".equals(request.getParameter("POCON")))
			{
				fileName = "ezBlockedPoLineitems.jsp?PurchaseOrder="+retobj.getFieldValueString(i,"DOCID")+"&type=PO&POORCONTRACT=PO&RQSTFROM=PORTAL&vendorNo="+retobj.getFieldValueString(i,"VENDOR");
				
			}
			if("CON".equals(request.getParameter("POCON")))
				fileName = "../Rfq/ezGetAgrmtDetails.jsp?agmtNo="+retobj.getFieldValueString(i,"DOCID")+"&viewType=DETAILS&POORCONTRACT=CON&RQSTFROM=PORTAL";
			if("E".equals(retobj.getFieldValueString(i,"REF1")))
			{
				escRow = "class='redalert'";
				txtBg = "class='tx1'";
			}	
			else	
			{
				escRow = "";
				txtBg = "class='tx'";
			}		
			if("BLOCKED".equals(retobj.getFieldValueString(i,"WFSTATUS")))
				statusValue = "SUBMITTED TO "+getUserName(Session,retobj.getFieldValueString(i,"NEXTPARTICIPANT"),"G",(String)session.getValue("SYSKEY"));
			else	
				statusValue = retobj.getFieldValueString(i,"WFSTATUS")+" BY "+getUserName(Session,retobj.getFieldValueString(i,"MODIFIEDBY"),"U",(String)session.getValue("SYSKEY"));	
%>
			<Tr>
				<Td <%=escRow%>  width="3%" align=center><input type=radio name=chk1 value="<%=retobj.getFieldValueString(i,"DOCID")%>"></Td>
				<Td <%=escRow%> width="10%" align="center"><a href="<%=fileName%>" onClick="hideButton()"><%=retobj.getFieldValueString(i,"DOCID")%></a></Td>
				<!--<Td <%=escRow%> width="9%" align="center"><%=retobj.getFieldValueString(i,"DATE")%></Td>-->
				<Td <%=escRow%> width="8%" align="center"><%=globalRet.getFieldValue(i,"DATE")%></Td>
				<Td <%=escRow%> width="8%" align="center"><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=retobj.getFieldValueString(i,"VENDOR")%>')"><%=retobj.getFieldValueString(i,"VENDOR")%></a></Td>
         			<Td width="13%" align="left"><%=venodorsHT.get(retobj.getFieldValueString(i,"VENDOR"))%></Td>
				<Td <%=escRow%> width="10%" align="center"><%=retobj.getFieldValueString(i,"ISAMMEND")%></Td>
				<Td <%=escRow%> width="24%" ><%=statusValue%> On <%=globalForm.getFieldValueString(i,"MODIFIEDON")%></Td>
				<Td <%=escRow%> width="14%"><%=getUserName(Session,retobj.getFieldValueString(i,"NEXTPARTICIPANT"),retobj.getFieldValueString(i,"PARTICIPANTTYPE"),(String)session.getValue("SYSKEY"))%></Td>
				<!--<Td <%=escRow%> width="10%"><%//=retobj.getFieldValueString(i,"QRYSTATUS")%></Td>-->
			</Tr>
<%
		}
%>
		</Table>
		</Div>
		<Div align=center style="position:absolute;top:91%;visibility:visible;width:100%">
		<Span id="EzButtonsSpan" >

		<%
				buttonName.add("Audit");   
				buttonMethod.add("showTrail()");
				out.println(getButtonStr(buttonName,buttonMethod));
		%>
		</Span>
		<span id="EzButtonsSpan" >
		</span>
				<span id="EzButtonsMsgSpan" style="display:none">
				<Table align=center>
					<Tr>
						<Td class="labelcell">Your request is being processed... Please wait</Td>
					</Tr>
				</Table>
		</span>
		</Div>		
<%
	}
	else
	{
		if("PO".equals(request.getParameter("POCON")))
		{
%>		        
		<Div id="nocount" style="position:absolute;top:40%;width:100%;visibility:visible">
			<Table width="30%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			 <Tr align="center">
				<Th>No Purchase Orders Exist</Th>
			 </Tr>
			</Table>
		</Div>
		
<%
		}
		if("CON".equals(request.getParameter("POCON")))
		{
%>
		<Div id="nocount" style="position:absolute;top:40%;width:100%;visibility:visible">
			<Table width="30%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			 <Tr align="center">
				<Th>No Contracts Exist</Th>
			 </Tr>
			</Table>
		</Div>
<%	
		
		}
		
	}
%>	

</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>





	