<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>

<script src="../../Library/JavaScript/ezTabScroll.js" ></script>

<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<html>
<head>
<%!
	// Start Declarations
	final String SYSTEM_NO = "ESD_SYS_NO";
	final String SYSTEM_NO_DESC_LANGUAGE = "ESD_LANG";
	final String SYSTEM_NO_DESCRIPTION = "ESD_SYS_DESC";

	final String SYSTEM_TYPE = "ESD_SYS_TYPE";
	final String SYSTEM_TYPE_DESC = "EST_DESC";

	final String LANG_KEY = "ELK_LANG";
	final String LANG_ISO = "ELK_ISO_LANG";
	final String LANG_DESC = "ELK_LANG_DESC";

	boolean groupExist = false;
	//End Declarations
%>
<%
	// Key Variables
	ReturnObjFromRetrieve retsys = null;

	String sysType = null;
	String sys_num = null;
	String my_index = null;

	// System Configuration Class
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	retsys = (ReturnObjFromRetrieve)sysManager.getSystemDesc(sparams);
	//retsys.check();

	//Get List of Systems
	int numSystem = retsys.getRowCount();
	if(numSystem > 0)
	{
		sys_num = request.getParameter("SystemNumber");
		my_index = request.getParameter("index");

		//Get System Type for the selected system
		if (my_index != null)
		{
			int index = new Integer(my_index).intValue();
			sysType = (retsys.getFieldValue(index, SYSTEM_TYPE)).toString();
		}
		else
		{
			sysType = (retsys.getFieldValue(0, SYSTEM_TYPE)).toString();
		}
		//Get System Number
	}//end if
%>
<Title>Connection Parameters</Title>
<%
	if(numSystem > 0)
	{
		if((sysType.equals("100"))||(sysType.equals("110"))||(sysType.equals("111")))
		{
%>
        		<script src="../../Library/JavaScript/CParam/ezSapConnectParams.js" ></script>
<%
		}
		if(sysType.equals("150"))
		{
%>
        	<script src="../../Library/JavaScript/CParam/ezBaanConnectParams.js" ></script>
<%
		}
		if((sysType.equals("200"))||(sysType.equals("999")))
		{
%>
			<script src="../../Library/JavaScript/CParam/ezOraAppConnectParams.js" ></script>
<%
		}
	}
%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
function funFocus()
{
	if(document.myForm.SysNum!=null)
	{
		document.myForm.SysNum.focus()
	}
}
</Script>
</head>
<body onLoad="funFocus();scrollInit()" onResize="scrollInit()" scroll="no">
<form name=myForm method=post action="ezAddSaveConnectParam.jsp">
<%
	if(numSystem > 0)
	{
%>
	<br>

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
      			<Th width="25%" class="labelcell"><b>ERP System:</b></Th>
      			<Td width="75%" bgcolor="#FFFFF7">
<%
			int sysRows = retsys.getRowCount();
			String sysName = null;
			if ( sysRows > 0 )
			{
%>
	             		<select style="width:100%;" name="SysNum" id=FullListBox onChange="myalert()">
				<option value='sel'>--Select ERP System--</option>
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
								<%=val%> ( <%=sysName%> )
			    	   			</option>
<%
						}
						else
						{
%>
			    	    			<option value=<%=val%> >
								<%=val%> (<%=sysName%> )
			    	    			</option>
<%
						}//End If
					}//End if
					else
					{
%>
			    			<option value=<%=val%> >
							<%=val%>( <%=sysName%> )
			    			</option>
<%
					}
				}//End for	

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
<%@ include file="ezSystemGroupFilter.jsp"%>
<%
	if(groupExist)
	{
%>
		<div align="center">
    		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
			<Tr>
				<Td class = "labelcell">
					<div align="center"><b>Group Already Exists For This System</b></div>
				</Td>
			</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
	}
	else
	{
   	if(sys_num!=null && !sys_num.equals("sel"))
   	{
%>
		</div>
<div id="theads">
		<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
			<Tr align="center">
    				<Td class="displayheader">ERP Connection Parameters</Td>
  			</Tr>
		</Table>
</div>
  		
<div id="InnerBox1Div" align="center">
    		<Table id="InnerBox1Tab" width="80%" border="0">
      			<Tr>
        			<Td class="blankcell" height="9">
<%
				// variables
				String grpId = "";
%>
<%
				if((sysType.equals("100"))||(sysType.equals("110"))||(sysType.equals("111")))
				{
%>
		          		<%@ include file="ezSapConnectParams.jsp"%>
<%
				}
	        		if(sysType.equals("150"))
				{
%>
          				<%@ include file="ezBaanConnectParams.jsp"%>
<%
				}
				if((sysType.equals("200"))||(sysType.equals("999")))
				{
%>
					<%@ include file="ezOraAppConnectParams.jsp"%>
<%
				}
%>
        			</Td>
      			</Tr>
        		<Tr>
        		<Td class="blankcell">

          		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
            		<Tr>
              			<Td width="25%" class="labelcell" height="14">
                			<div align="left"><b>Connection Attributes</b></div>
              			</Td>
              			<Td colspan="3" height="14" class = labelcell>
                			<div align="center"><font size="-1">Details about number of ERP connections, ERP retries.</font></div>
                			<input type="hidden" name="DBConnections" value="2">
                			<input type="hidden" name="DBRetrys" value="2">
                			<input type="hidden" name="LogFileSize" value="256">
                			<input type="hidden" name="R3Retrys" value="1">
                			<input type="hidden" name="*LogFilePath" value="C:\Temp">
                			<input type="hidden" name="*XMLPath" value="C:\Temp">
                			<input type="hidden" name="ConnectionFlag" value="0">
                			<input type="hidden" name="Connection" value="1">
                			<input type="hidden" name="R3CheckAuth" value="1">
                			<input type="hidden" name="ReadHistory" value="1">
                			<input type="hidden" name="DBMemCache" value="1">
                			<input type="hidden" name="MaterialAccess" value="1">
                			<input type="hidden" name="DataSync" value="1">
                			<input type="hidden" name="CustomerAccess" value="1">
                			<input type="hidden" name="Validations" value="1">
                			<input type="hidden" name="HistoryWrite" value="1">
              			</Td>
            		</Tr>
            		<Tr>
              			<Td width="25%" class="labelcell" height="27">
                			<div align="right">No of ERP Connections:</div>
              			</Td>
              			<Td width="25%" height="27">
                			<input type=text class = "InputBox" name="R3Connections" size="3" maxlength="3" value="1">
              			</Td>
              			<Td width="25%" class="labelcell" height="27">
                			<div align="right">Auto Retry:</div>
              			</Td>
              			<Td width="25%" height="27">
                			<input type=text class = "InputBox" name="AutoRetry" size="3" maxlength="3" value="1">
              			</Td>
            		</Tr>
            		<Tr>
              			<Td width="25%" class="labelcell" height="28">
                			<div align="right">Auto Correction Flag:</div>
              			</Td>
              			<Td width="25%" height="28">
                			<select name="CorrectionFlag">
                		  		<option value="1">True</option>
                  				<option value="0" selected>False</option>
                			</select>
              			</Td>
              			<Td width="25%" class="labelcell" height="28">
                			<div align="right">&nbsp;</div>
              			</Td>
              			<Td width="25%" height="28">&nbsp;</Td>
            		</Tr>
        	</Table>

        	</Td>
      		</Tr>
      		<Tr>
        		<Td class="blankcell">&nbsp;</Td>
      		</Tr>
</Table>
</div>
</div>
<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
    	<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" onClick="checkAll();return document.returnValue">
    	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</div>
<%
	}
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
	</center>
<%
  	}
  	}
%>
  	<div align="center"> </div>
  	<p> <br>
  	</p>
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
	<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif"  border=none></a></center>
<%
	}//end if
%>
</body>
</html>
