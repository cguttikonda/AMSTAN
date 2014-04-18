<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListBPBySysKeyHier.jsp"%>
<%@ page import="java.util.*" %>



<html>
<head>
<Title>List Business Partners </Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<Script src="../../Library/Script/popup.js"></Script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Partner/ezHierListBPBySysKey.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

<Style>
ul
{
    list-style-type: none;
}
</Style>

</head>
<%
	//String searchPartner=request.getParameter("searchcriteria");
	session.putValue("mySearchCriteria",searchPartner);

	String FUNCTION=request.getParameter("FUNCTION");
	if(ret.getRowCount()!=0)
	{
%>
	<body onLoad='scrollInit();document.myForm.WebSysKey.focus()' onResize='scrollInit()' bgcolor="#FFFFF7"  scroll="no">
<%
	}
	else
	{
%>
		<body onLoad='scrollInit()' bgcolor="#FFFFF7"  scroll=no>
<%
	}
%>



<br>


<form name=myForm method=post action="ezListBPBySysKey.jsp" onSubmit="return chkSubmit()">
<div id="modal" style="z-index:100;position:absolute;left:280px; top:140px; border:1px solid #EEEDE7; border-radius:7px; background-color:#ffffff; padding:1px; font-size:10;width:330px;height:150px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="80" height="80" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>

<%
	String isSel ="";
	String tabHeader = "<Th width='5%'>M</Th><Th width='20%'>Partner</Th><Th WIDTH='25%'>Description</Th><Th WIDTH='25%'>Hierarchy Code</Th>";
	if("All".equals(websys)){
		isSel = "selected";
		tabHeader = "<Th width='5%'>M</Th><Th width='20%'>Partner</Th><Th WIDTH='25%'>Description</Th><Th WIDTH='25%'>Pur. Area</Th><Th WIDTH='25%'>Pur. Area Desc</Th>";
	}	
	if(ret.getRowCount()>0)
	{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
<Tr align="center">
	  <Th width="35%" class="labelcell"><%=areaLabel.substring(0,areaLabel.length()-1)%>
      </Th>
      <Td width="65%" class="blankcell">
        	<select name="WebSysKey" style="width:100%" id=FullListBox onChange="funsubmit()">
		<option value="sel">--Select <%=areaLabel.substring(0,areaLabel.length()-1)%>--</option>
<%
		if ( areaFlag.equals("V") ){
%>			
			<option value="All" <%=isSel%>  >All</option>
	<%
		}
		if(websys!=null)
		{
			ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
			for(int i=0;i<ret.getRowCount();i++)
			{
				if(websyskey!=null)
				{

					if(websyskey.equals(ret.getFieldValue(i,SYSTEM_KEY)))
					{
%>
						<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>' selected><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%				
					}
					else
					{
%>
						<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>'><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%>  (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%				
					}
				}
				else
				{
%>
					<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>'><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%>  (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
				}
			}
		}
%>
</select>

</Td>
</Tr>
</Table>
	<%@ include file="../../../Includes/Lib/AlphabetBean.jsp" %>
	<input type="hidden" name="BPDesc" value=""  >
	<input type="hidden" name="Area" value="<%=areaFlag%>">
	<input type="hidden" name="syskey" value="" >
	<input type="hidden" name="searchcriteria" value="$">
	<input type="hidden" name="BusinessPartner" >
	<input type="hidden" name="BPsyskey" value="" >
	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>" >
<%

	if(ret1!=null && alphaTree.size()>0)
	{
		String from = request.getParameter("from");
		ezc.ezbasicutil.EzSearchReturn mySearch = new ezc.ezbasicutil.EzSearchReturn();
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0)
		{
	          mySearch.search(ret1,"ECA_COMPANY_NAME",searchPartner.toUpperCase());
		}
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0 && ret1.getRowCount()==0 && from!=null)
		{
			if(searchPartner.indexOf("*")==-1)
				searchPartner = "Equals to "+searchPartner;
			else if(searchPartner.indexOf("*")==0)
				searchPartner = "Ends with "+searchPartner.substring(searchPartner.indexOf("*")+1,searchPartner.length());
			else
				searchPartner = "Starts with "+searchPartner.substring(0,searchPartner.indexOf("*"));
%>
			<br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
			    	<Td class="displayheader" align = "center"><nobr>
					There are no Partners to list with Partner Name <%=searchPartner%>.
				</nobr>
		    		</Td>
		  	</Tr>
		  	</Table>
			<br>
			<center>
				<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
			</center>
<%
			return;
		}
		if(searchPartner !=null && (! "null".equals(searchPartner)) && searchPartner.length()!=0 && ret1.getRowCount()==0)
		{
%>
			<br><br><br><br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
				<Tr>
			    <Td class="displayheader">
    		      <div align="center">There are no Partners to list with alphabet starts with "<%=searchPartner.substring(0,searchPartner.indexOf("*"))%>".</div>
		    </Td>
		  </Tr></Table>
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>


<%
		return;
		}
	}
%>




<%
	
	if(ret1!=null && !"sel".equals(websyskey))
	{


		if(ret1.getRowCount()>0)
		{
			//out.println("ret1:::"+ret1.toEzcString());
%>
		<div id="theads">
		<Table  id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
		<Tr>
			<%=tabHeader%>
		</Tr>
		</Table>
		</div>
		<div id="InnerBox1Div" style="overflow:auto">
		<Table  id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
			//ret1.sort(new String[]{"ECA_COMPANY_NAME"},true);
			ret1.sort(new String[]{"EBPC_BUSS_PARTNER"},true);
			String chkKey = "";
			String heirCode = "";
			for(int j=0;j<ret1.getRowCount();j++)
			{
				heirCode = ret1.getFieldValueString(j,"ECA_TELEBOX_NO");
				if(heirCode!=null && !"null".equals(heirCode) && !"".equals(heirCode))
					heirCode = heirCode.toUpperCase();

				chkKey = ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")+"/"+websyskey+"/"+heirCode;
				if("All".equals(websys)){
					chkKey = ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")+"/"+ret1.getFieldValueString(j,"EBPA_SYS_KEY");
				}
			
%>
				<Tr>
				<label for="cb_<%=j%>">
					<Td width="5%" align = "center"><input type="radio" name="chk1" id="cb_<%=j%>" value= '<%=chkKey%>' >
					<input type="hidden" name="BPDesch" value= '<%=ret1.getFieldValueString(j,"ECA_COMPANY_NAME")%>' ></Td>
					<Td width="20%">		<a href = "ezShowBPInfo.jsp?BusPartner=<%=ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")%>" class=bb><%=ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")%></a></Td>
					<Td width="25%"><%=ret1.getFieldValueString(j,"ECA_COMPANY_NAME")%></Td>
					<Td width="25%"><%=heirCode%></Td>
					<input type=hidden name='hierCode' value='<%=heirCode%>'>
<%
					if("All".equals(websys)){
%>
						<Td width="25%"><%=ret1.getFieldValueString(j,"EBPA_SYS_KEY")%></Td>
						<Td width="25%"><%=ret1.getFieldValueString(j,"ESKD_SYS_KEY_DESC")%></Td>
<%
					}
%>	
					
				</label>
				</Tr>

<%
			}
%>

		</Table>
		</div>


		<!--<div style="position:absolute;visibility:visible;top:90%;width:100%">
		<Table>
		<Tr>
			<Td class="search"><a href="JavaScript:ezSearch()">Search The Business Partner By Name</a></Td>
		</Tr>
		</Table>
		</div>-->
		<div id="ButtonDiv" align="center" style="position:absolute;top:80%;width:100%">
		<!--<input type="button" name="synch" value="Hierarchy Synchronize" onclick="funSynch()"> -->
		<a href="JavaScript:funSynch('<%=areaLabel.substring(0,areaLabel.length()-1)%>')"><img src="../../Images/Buttons/<%= ButtonDir%>/synchronize.gif" border=none></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		 </div>
<%		}

	else
	{
	
		if(ret1!=null)
		{
			if( !"sel".equals(websys))
			{
%>

			<br>
			<br><br><br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
				<Tr>
			    <Td class="displayheader">
    		      <div align="center">No Partners To List In This <%=areaLabel.substring(0,areaLabel.length()-1)%></div>
		    </Td>
		  </Tr></Table>
		<br>
		<center><a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" onClick="history.go(-1)" border=none></a></center>


<%			}
		}
	}
	}
	else
	{
%>
				<br><br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
				<Tr>
					<Td class = "labelcell">
						<div align="center"><b>Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%> to continue.</b></div>
					</Td>
				</Tr>
			</Table>
			<br>
			<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a></center>


<%
	}
	}
	else
	{
%>
		<br>
		<br>
		<br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
			<Tr>
		    <Td class="displayheader">
	      <div align="center">No <%=areaLabel%> To List Partners</div>
	    </Td>
	  </Tr></Table>
	  		<input type="hidden" name="Area" value="<%=areaFlag%>">
<br>
	<center>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>


<%
	}
%>
</form>
</body>
</html>
