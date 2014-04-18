<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iSetBaseERP.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<BODY >
<Table  width="40%" border="0" align="center">
  	<Tr align="center"> 
    	<Td class="displayheader">Set Base ERP System</Td>
  	</Tr>
</Table>
<br>
<form method="post" action="ezSaveSetBaseERP.jsp" name="Systems">
<Table  width="50%" align="center">
	<Tr> 
      	<Th width="31%"> System </Th>
  	</Tr>
<%
int sysRows = ret.getRowCount();
if ( sysRows > 0 ) 
	{
	for ( int i = 0 ; i < sysRows; i++ )
		{		
%>
		<Tr align="left">
		<Td>
<%
		String val1 = (ret.getFieldValue(i,SYSTEM_NO)).toString();
		if(retbasesys != null)
			{
			int baseSys = retbasesys.getRowCount();
			if(baseSys > 0)
				{
				int BaseSysNum = ((java.math.BigDecimal)retbasesys.getFieldValue(0,BASE_ERP)).intValue();
				String strBaseSys = String.valueOf(BaseSysNum);
				if(strBaseSys.equals(val1.trim()))
				{
%>				
				<input type="radio" checked name="BaseErp" value="<%=ret.getFieldValue(i,SYSTEM_NO)%>" >
				<%=ret.getFieldValue(i,SYSTEM_NO_DESCRIPTION)%>
				->
				<%=ret.getFieldValue(i,SYSTEM_NO)%>
<%
				}
			else
				{
%>
				<input type="radio" name="BaseErp" value= "<%=ret.getFieldValue(i,SYSTEM_NO)%>" >
				<%=ret.getFieldValue(i,SYSTEM_NO_DESCRIPTION)%>
				->
				<%=ret.getFieldValue(i,SYSTEM_NO)%>
<%				
				}
			}
		else
			{
%>			
			<input type="radio" name="BaseErp" value= "<%=ret.getFieldValue(i,SYSTEM_NO)%>" >
			<%=ret.getFieldValue(i,SYSTEM_NO_DESCRIPTION)%>
			->
			<%=ret.getFieldValue(i,SYSTEM_NO)%>
<%
			}
		}//end if retbasesys not null
%>		
        	</Td>
		</Tr>
<%		
	}//End for
}//End If
%> 
</Table>
<p align="center"> 
	<input type="submit" name="Submit" value="Submit">
</p>
</form>
</body>
</html>