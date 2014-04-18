<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListAuth.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Config/ezListAuth.js">
</script>


<script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body bgcolor="#FFFFF7" onLoad='scrollInit()' onresize='scrollInit()' >
<form name=myForm method=post action="ezUpdateAuth.jsp">
<br>
<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 top="20%">
<Tr align="center">
    <Td class="displayheader">List of Authorizations</Td>
</Tr>
</Table>

<div id="theads">
<Table id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr>
      <!-- Th width="10%">Enable</Th -->
      <Th width="70%" align="center"> Authorization Description </Th>
      <Th width="30%">WorkFlow Enabled</Th>
      <!-- Th width="20%">Transaction Type</Th -->

</Tr>
</Table>
</div>
<%

    String[] sortArr = { AUTH_DESC };
    ret.sort(sortArr,true);
  int authRows = ret.getRowCount();
  if(authRows > 0 )
  {
%>


<div id="InnerBox1Div">
<Table  id="InnerBox1Tab"  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>

<%
	int cnt=0;
	for ( int i = 0 ; i < authRows ; i++ )
	{

		String component = ret.getFieldValueString(i,"EUAD_COMPONENT").trim();
		if ( component.equalsIgnoreCase("ROLE") )continue;
%>
<Tr align="center" >
<!-- Td width="10%">
   <input type="hidden" name="AuthLang" value="<%=ret.getFieldValue(i,AUTH_LANG)%>">
   <input type="hidden" name="AuthKey"   value="<%= ret.getFieldValue(i,AUTH_KEY) %>">
   <input type="hidden" name="AuthDesc"  value="<%=ret.getFieldValue(i,AUTH_DESC)%>">
 <input type="hidden" name="IsSysAuth" value="<%=ret.getFieldValue(i,"EUAD_IS_SYS_AUTH")%>">
<%
  String DelFlag = (String)ret.getFieldValue(i,AUTH_DEL_FLAG);
  if(DelFlag.equals("Y"))
  {

 %>
       <input type="checkbox" name="CheckBox" value="<%= ret.getFieldValue(i,AUTH_KEY) %>#<%=ret.getFieldValue(i,AUTH_DESC)%>#<%=ret.getFieldValue(i,AUTH_LANG)%>" unchecked>

<%
	}
	else
	{

  %>
        <input type="checkbox" name="CheckBox"  value="<%= ret.getFieldValue(i,AUTH_KEY) %>#<%=ret.getFieldValue(i,AUTH_DESC)%>#<%=ret.getFieldValue(i,AUTH_LANG)%>" checked>
<%
	}
%>
</Td -->
<Td align="left"  width="70%">
  <%= ret.getFieldValue(i,AUTH_DESC) %>
</Td>
<Td align="left"  width="30%">
<%
	String wfEnabled = "";
	if(ret.getFieldValueString(i,WF_ENABLED).equals("Y"))
		wfEnabled = "Yes";
	else
		wfEnabled = "No";
%>
  	<%=wfEnabled%>
</Td>
<!-- Td align="left"  width="20%">
    <%= ret.getFieldValue(i,TRANS_TYPE) %>
</Td -->


</Tr>

<%
	cnt++;
    }//End for

%>
<input type="hidden" name="TotalCount" value="<%=cnt%>" >
</Table>
</div>

  <div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
      <!-- Td align="center" class="blankcell">
       	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/selectall.gif" onClick="setChecked(true)" border=none></a>
      </Td>
      <Td align="center" class="blankcell">
      	<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/update.gif">
      </Td>
      <Td align="center" class="blankcell">
            <a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/clearall.gif" name="CReset" onClick="setChecked(false)" border=none></a>
      </Td -->
      	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</div>


<%
   }//if close
%>

</form>
<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('Authorizations updated successfully');
		</script>
<%
	} //end if
%>
</body>
</html>
