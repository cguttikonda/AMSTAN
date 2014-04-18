<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListBPBySysKey.jsp"%>
<%@ page import="java.util.*" %>
<html>
<head>
<Title>List Business Partners </Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Partner/ezSummaryListBPBySysKey.js">

</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<%
	String FUNCTION=request.getParameter("FUNCTION");
	if(ret.getRowCount()!=0)
	{
%>
		<body onLoad='scrollInit();document.ListBPBySysKey.WebSysKey.focus()' bgcolor="#FFFFF7" onResize='scrollInitI()' scroll="no">
<%
	}
	else
	{
%>
		<body onLoad='scrollInit()' bgcolor="#FFFFF7"  scroll="no">
<%
	}
%>



<br>


<form name=myForm method=post action="ezListBPBySysKey.jsp" onSubmit="return chkSubmit()">
<%



	if(ret.getRowCount()>0)
	{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="50%">
<Tr align="center">
	  <Th width="46%" class="labelcell">Select <%=areaLabel.substring(0,areaLabel.length()-1)%>
      </Th>
      <Td width="38%" class="blankcell">
        <div id = listBoxDiv>
		<select name="WebSysKey">
		<option value="sel">--Select--</option>
	<%

		if(websys!=null)
		{
			if("All".equals(websys))
			{
	%>

				<option value="All" selected>All</option>
	<%		}
			else
			{
	%>
				<option value="All" >All</option>
	<%
			}
		}
		else
		{
	%>
			<option value="All" >All</option>
	<%
		}
	%>

<%

		for(int i=0;i<ret.getRowCount();i++)
		{
			if(websyskey!=null)
			{

				if(websyskey.equals(ret.getFieldValue(i,SYSTEM_KEY)))
				{
%>
					<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>' selected><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> </option>
<%				}
				else
				{
%>
					<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>'><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> </option>
<%				}
			}
			else
			{
%>
					<option value='<%=ret.getFieldValue(i,SYSTEM_KEY)%>'><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> </option>
<%
			}
		}
%>

</select>
</div>
</Td>
      <Td width="16%"> <img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" style="cursor:hand" onClick="funsubmit()">
      </Td>
</Tr>
</Table>
<br>
<%

	if(ret1!=null )
	{
		String from = request.getParameter("from");
		String searchPartner=request.getParameter("searchcriteria");
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
			<br>
			<br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
				<Tr>
			    <Td class="displayheader">
    		      <div align="center">No Partners Matched  to your Search Criteria</div>
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
%>
		<div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0" >
		<Tr>
			<Th width="5%">M</Th>
			<Th width="20%">Partner</Th>
			<Th WIDTH="75%">Description</Th>
		</Tr>
		</Table>
		</div>
	
		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
			for(int j=0;j<ret1.getRowCount();j++)
			{
%>
				<Tr>
					<Td width="5%" align = "center"><input type="radio" name="chk1"  value= '<%=ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")%>' >
					<input type="hidden" name="BPDesch" value= '<%=ret1.getFieldValueString(j,"ECA_COMPANY_NAME")%>' ></Td>
					<Td width="20%">		<a href = "ezShowBPInfo.jsp?BusPartner=<%=ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")%>" class=bb><%=ret1.getFieldValueString(j,"EBPC_BUSS_PARTNER")%></a></Td>
					<Td width="75%"><%=ret1.getFieldValueString(j,"ECA_COMPANY_NAME")%></Td>
				</Tr>

<%
			}
%>

		</Table>
		</div>

		<div style="position:absolute;top:81%;left:10%;visibility:visible">

				<Table>
				<Tr>
					<Td class="search"><a href="JavaScript:ezSearch()">Search The Bussiness Partner By Name</a></Td>
				</Tr>
		</Table>
		</div>
		<div id="ButtonDiv" style="position:absolute;top:90%;width:100%">


		<img src="../../Images/Buttons/<%= ButtonDir%>/summary.gif" onclick="funDepDefaults()" style="cursor:hand">
<!--			<input type="button" name="Summary" value="Summary" onclick="funDepDefaults()"> -->

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
			<br>
				<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
				<Tr>
			    <Td class="displayheader">
    		      <div align="center">No Partners To List In This <%=areaLabel.substring(0,areaLabel.length()-1)%></div>
		    </Td>
		  </Tr></Table>
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>


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
						<div align="center"><b>Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%>  to continue.</b></div>
					</Td>
				</Tr>
			</Table>
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>


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
<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>


<%
	}
%>
<input type="hidden" name="BPDesc" value=""  >
<input type="hidden" name="Area" value="<%=areaFlag%>">
<input type="hidden" name="syskey" value="" >
<input type="hidden" name="searchcriteria" value="">
<input type="hidden" name="BusinessPartner" >
<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>" >
</form>
</body>
</html>
