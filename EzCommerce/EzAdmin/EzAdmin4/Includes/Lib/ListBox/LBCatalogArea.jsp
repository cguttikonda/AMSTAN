<%
	sys_key = sys_key.toUpperCase();
	int sysRows = retsyskey.getRowCount();
	if ( sysRows > 0 ) 
	{
		retsyskey.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
%>
		<select name="SystemKey" onChange= "myalert()" id = "ListBoxDiv">
<%		
		for ( int i = 0 ; i < sysRows ; i++ )
		{
			String val = (String)(retsyskey.getFieldValue(i,SYSTEM_KEY));
			String checkFlag = (String)retsyskey.getFieldValue(i,"ESKD_SUPP_CUST_FLAG");
			String syskeyDesc = (String)(retsyskey.getFieldValue(i,SYSTEM_KEY_DESCRIPTION));

			val = val.toUpperCase();
			val = val.trim();

			if(sys_key.equals(val))
			{
%>			
				<option selected value="<%=val%>">
<%
				if(checkFlag.equals("V"))
				{
%>
					<%=syskeyDesc%> (<%=val%>)
<%
				}
				else
				{
%>				
					<%=syskeyDesc%> (<%=val%>)
<%
				}
%>				
				</option>
<%
			}
			else
			{
%>
				<option value="<%=val%>" >
<%
				if(checkFlag.equals("V"))
				{
%>				
					<%=syskeyDesc%> (<%=val%>)
<%
				}
				else
				{
%>
					<%=syskeyDesc%> (<%=val%>)
<%
				}
%>
				</option>
<%
			}
		}
%>
		</select>
<%
	}
%>