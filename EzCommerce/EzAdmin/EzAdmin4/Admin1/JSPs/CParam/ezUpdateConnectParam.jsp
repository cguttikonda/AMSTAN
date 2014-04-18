<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<html>
<head>
<Script>
function funFocus()
{
	if(document.myForm.SysNum!=null)
	{
		document.myForm.SysNum.focus()
	}
}
</Script>
<script src="../../Library/JavaScript/CParam/ezUpdateConnectParam.js" ></script>
<script src="../../Library/JavaScript/ezTabScroll.js" ></script>

<%!
	// Start Declarations

	final String SYSTEM_NO = "ESD_SYS_NO";
	final String SYSTEM_NO_DESC_LANGUAGE = "ESD_LANG";
	final String SYSTEM_NO_DESCRIPTION = "ESD_SYS_DESC";
	final String SYSTEM_TYPE = "ESD_SYS_TYPE";

	final String LANG_KEY = "ELK_LANG";
	final String LANG_ISO = "ELK_ISO_LANG";
	final String LANG_DESC = "ELK_LANG_DESC";

	//End Declarations
%>
<%
	// Key Variables
	ReturnObjFromRetrieve retsys = null;
	ReturnObjFromRetrieve retgrp = null;
	ReturnObjFromRetrieve retgrpinfo = null;

	// System Configuration Class
	String grp_id = null;
	String sys_num = null;
	String sys_type = null;
	int numGrps = 0;

	// Get List Of Systems
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	retsys = (ReturnObjFromRetrieve)sysManager.getSystemDesc(sparams);
	retsys.check();
	//Get List of Systems
	int numSystem = retsys.getRowCount();
	sys_num = request.getParameter("SystemNumber");
	if(numSystem > 0)
		{
		if(sys_num!=null && !sys_num.equals("sel"))
			{
			sys_num=sys_num.trim();
			for(int m=0;m<numSystem;m++)
				{
				String sysNumber = retsys.getFieldValueString(m,SYSTEM_NO);
				if(sysNumber.equals(sys_num))
					{
					sys_type=retsys.getFieldValueString(m,SYSTEM_TYPE);
					}
				}
			// Get List Of Groups for a System
			EzcSysConfigParams sparams1 = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
			snkparams1.setLanguage("EN");
			snkparams1.setSystemNumber(sys_num);
			sparams1.setObject(snkparams1);
			Session.prepareParams(sparams1);
			retgrp = (ReturnObjFromRetrieve)sysManager.getUserGroups(sparams1);
			retgrp.check();

			//Number of groups
			numGrps = retgrp.getRowCount();
			if(numGrps > 0)
				{
				grp_id = request.getParameter("GrpID");
				if(grp_id == null)
					{
					grp_id = (retgrp.getFieldValue(0,"EUG_ID")).toString();
					}
				// Get Group Information
				EzcSysConfigParams sparams2 = new EzcSysConfigParams();
				EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
				snkparams2.setLanguage("EN");
				snkparams2.setUsergroup(grp_id);
				sparams2.setObject(snkparams2);
				Session.prepareParams(sparams2);
				retgrpinfo = (ReturnObjFromRetrieve)sysManager.getUserGroupInfo(sparams2);
				retgrpinfo.check();
				}//end if
			}//end if
		}
%>
<Title>Update Connection Parameters</Title>
<%
	if(sys_num!=null && !sys_num.equals("sel"))
		{
			if((sys_type.equals("100"))||(sys_type.equals("110"))||(sys_type.equals("111")))
				{
%>
					<script src="../../Library/JavaScript/CParam/ezSapConnectParams.js" ></script>
<%
				}
				if(sys_type.equals("150"))
				{
%>
					<script src="../../Library/JavaScript/CParam/ezBaanConnectParams.js" ></script>
<%
				}
				if((sys_type.equals("200"))||(sys_type.equals("999")))
				{
%>
					<script src="../../Library/JavaScript/CParam/ezOraAppConnectParams.js" ></script>
<%
				}
		}
%>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body onLoad='funFocus();scrollInit()' onResize='scrollInit()' scroll="no">
<form name=myForm method=post action="ezUpdateSaveConnectParam.jsp">
<%
	if(numSystem > 0)
		{
%>
<br>

<Table border=1 align='center'  borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr >
      	<Th width="25%" class="labelcell">ERP System:</Th>
      	<Td width="75%">
<%
	int sysRows = retsys.getRowCount();
	String sysName = null;
	if ( sysRows > 0 )
		{
%>
		<select name="SysNum" style="width:100%" id=FullListBox onChange="myalert()">
			<option value='sel'>--Select System--</option>
<%
		for ( int i = 0 ; i < sysRows ; i++ )
			{
			String val = (retsys.getFieldValue(i,SYSTEM_NO)).toString();
			sysName = (String)retsys.getFieldValue(i,SYSTEM_NO_DESCRIPTION);
			if(sys_num!=null)
  				{
				if(sys_num.equals(val.trim()))
					{
%>
	  				<option selected value=<%=val%> >
	  				<%=val%>  (<%=sysName%> )
	  				</option>
<%
	  				}
	  			else
	  				{
%>
	  				<option value=<%=val%> >
	  				<%=val%>  (<%=sysName%> )
	  				</option>
<%
	  				}//End If
	  			}
	  		else
	  			{
%>
	  			<option value=<%=val%> >
	  			<%=val%>  (<%=sysName%> )
	  			</option>
<%
	  			}
	  		}
%>
	  		</select>
<%
	  	}
%>
	</Td>
      	<!--<Td width="10%" align="center">
	<a href="javascript:myalert()"><img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" border=none></a>
	</Td>-->
    	</Tr>
    	</Table>
<%
 	if(sys_num!=null && !sys_num.equals("sel"))
		{

 %>
		<div id="theads">
 	   	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="50%">
 	   	<Tr >
 	     	<Th width="14%" class="labelcell">Group:</Th>
 	     	<Td width="30%">
<%
		if ( numGrps > 0 )
			{

			for ( int i = 0 ; i < numGrps ; i++ )
				{
%>
		        	<input type="hidden" name="GroupID" value=<%=(retgrp.getFieldValue(i,"EUG_ID"))%> >
		        	<%=retgrp.getFieldValue(i,"EUG_NAME")%>
<%
				}

			}
		else
			{
%>
	        	<center>No groups for this system</center>
<%
			}
%>
	</Td>
	</Tr>
  	</Table>
</div>
  	
<%
		if ( numGrps > 0 )
			{
%>
	
		
		<Table border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
		<Tr align="center">
    		<Td class="displayheader">ERP Connection Parameters</Td>
		</Tr>
		</Table>
	 	
<div id="InnerBox1Div" align="center">
		<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=0 cellSpacing=0   width="80%">
		<Tr>
		<Td class="blankcell" height="15">
<%
		//out.println(sys_type);
		if((sys_type.equals("100"))||(sys_type.equals("110"))||(sys_type.equals("111")))
			{
%> 
			<%@ include file="ezUpdateSapConnectParam.jsp"%>
<%
			}
		if(sys_type.equals("150"))
			{
%>
			<%@ include file="ezUpdateBaanConnectParam.jsp"%>
<%
			}
		if((sys_type.equals("200"))||(sys_type.equals("999")))
			{
%>
			<%@ include file="ezUpdateOraAppConnectParam.jsp"%>
<%
			}
%> 
		</Td>
		</Tr>
		<Tr>
		<Td class="blankcell">
           
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
		<Tr >
		<Td width="25%" class="labelcell" height="12">
		<div align="left"><b>Connection Attributes</b></div>
		</Td>
		<Td colspan="3" height="12" class="labelcell">
		<div align="center"><font size="-2">Details about number of ERP connections, ERP retries.</font></div>
                <input type="hidden" name="DBConnections" value="<%=retgrpinfo.getFieldValue(0,"EUG_DB_NO_OF_CONN")%>" >
                <input type="hidden" name="DBRetrys" value="<%=retgrpinfo.getFieldValue(0,"EUG_DB_NO_OF_RETRY")%>" >
                <input type="hidden" name="LogFileSize"  value = "<%=retgrpinfo.getFieldValue(0,"EUG_LOGSIZE")%>" >
                <input type="hidden" name="R3Retrys"  value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_NO_OF_RETRY")%>" >
                <input type="hidden" name="*LogFilePath" value = "<%=retgrpinfo.getFieldValue(0,"EUG_LOGFILE_PATH")%>" >
                <input type="hidden" name="*XMLPath" value = "<%=retgrpinfo.getFieldValue(0,"EUG_XML_EXCHANGE_PATH")%>" >
                <input type="hidden" name="ConnectionFlag" value = "<%=retgrpinfo.getFieldValue(0,"EUG_CONN_LOG")%>" >
                <input type="hidden" name="Connection" value = "<%=retgrpinfo.getFieldValue(0,"EUG_CONNECT_TYPE")%>" >
                <input type="hidden" name="R3CheckAuth" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_CHECK_AUTH")%>" >
                <input type="hidden" name="ReadHistory" value = "<%=retgrpinfo.getFieldValue(0,"EUG_HISTORY_READ")%>" >
                <input type="hidden" name="DBMemCache" value = "<%=retgrpinfo.getFieldValue(0,"EUG_DB_MEM_CACHE")%>" >
		<input type="hidden" name="MaterialAccess" value = "<%=retgrpinfo.getFieldValue(0,"EUG_MATERIAL_ACCESS")%>" >
                <input type="hidden" name="DataSync" value = "<%=retgrpinfo.getFieldValue(0,"EUG_DATA_SYNC_TYPE")%>" >
                <input type="hidden" name="CustomerAccess" value = "<%=retgrpinfo.getFieldValue(0,"EUG_CUST_INFO_ACCESS")%>" >
                <input type="hidden" name="Validations" value = "<%=retgrpinfo.getFieldValue(0,"EUG_VALIDATION_TYPE")%>" >
                <input type="hidden" name="HistoryWrite" value = "<%=retgrpinfo.getFieldValue(0,"EUG_HISTORY_WRITE")%>" >
              	</Td>
	      	</Tr>
            	<Tr>
	    	<Td width="25%" class="labelcell" >
			<div align="right">No of ERP Connections:</div>
              	</Td>
	      	<Td width="25%" >
	      		<input type=text class = "InputBox" name="R3Connections" size="3" maxlength="3" value = "<%=retgrpinfo.getFieldValue(0,"EUG_R3_NO_OF_CONN")%>" >
	      	</Td>
	      	<Td width="25%" class="labelcell" >
	      		<div align="right">Auto Retry:</div>
              	</Td>
	      	<Td width="25%" >
	      		<input type=text class = "InputBox" name="AutoRetry" size="3" maxlength="3" value = "<%=retgrpinfo.getFieldValue(0,"EUG_TRANSACTION_AUTO_RETRY")%>" >
	      	</Td>
	      	</Tr>
	      	<Tr>
              	<Td width="25%" class="labelcell"  height="19">
	      	<div align="right">Auto Correction Flag:</div>
	      	</Td>
	      	<Td width="25%"  height="19">
<%
		String Name9 = "CorrectionFlag";
		Object UserTypes9[] = {"True", "False"};
		Object TypeValues9[] = {"1", "2"};
		String Select_Value9 = (retgrpinfo.getFieldValue(0,"EUG_AUTO_CORRECTION_YESNO").toString());

		if(Select_Value9 != null)
			{
%>
			<select name=<%=Name9%> >
<%
			for (int i = 0 ; i < TypeValues9.length ; i++ )
				{

				if (Select_Value9.equals (TypeValues9[i]) ) // Select the Value
					{
%>
					<option value=<%=TypeValues9[i]%> selected>
					<%=UserTypes9[i].toString ()%>
					</option>
<%					}
				else
					{
%>
					<option value=<%=TypeValues9[i]%>  >
					<%=UserTypes9[i].toString ()%>
					</option>
<%					}
				}
%>

			</select>
<%
			}
		else
			{
%>
			<select name=<%=Name9%> >
<%
			for (int i = 0 ; i < TypeValues9.length ; i++ )
				{

				if ("1".equals (TypeValues9[i]) ) // Select the Value
					{
%>
					<option value=<%=TypeValues9[i]%> selected>
					<%=UserTypes9[i].toString ()%>
					</option>
<%					}
				else
					{
%>
					<option value=<%=TypeValues9[i]%>  >
					<%=UserTypes9[i].toString ()%>
					</option>
<%					}
				}
%>

			</select>
<%
			}
%>
              	</Td>
              	<Td width="50%" class="labelcell" colspan=2>
              		&nbsp;
              	</Td>
              	
            	</Tr>
          	</Table>
        	</Td>
      		</Tr>
	</Table>
	<br>
	</div>
</div>
<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	<p align="center">
    	<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" onClick="checkAll();return document.returnValue">
    	<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/testconnection.gif" onClick="UpdateAndTest();return document.returnValue">
    	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</p>
</div>
<%
	}
}//end if
else
	{
%>
<br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
	<Td class = "labelcell">
		<div align="center"><b>Please Select ERP System  to continue.</b></div>
	</Td>
	</Tr>
</Table>
<br>
<center>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</a>
</center>
<%
}
%>
</form>
<%
}
else
	{
%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
    	<Th>There are No Systems Created Currently</Th>
  	</Tr>
</Table>
<br>
<center>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</a>
</center>
<%
}//end if
%>
</body>
</html>