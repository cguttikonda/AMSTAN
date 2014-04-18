<%
	if(agentsCount==0)
	{
%>

	<br><br><br><br><br>
	<Table width=80% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<Tr>
			<Th>No Agents exist for the selected Material</th>
		</Tr>
	</Table>
<%
	}
	else
	{
	
%>
<DIV id="theads" >
<TABLE id="tabHead" width="90%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
        <tr>
        <th align="center" width="5%">&nbsp;</th>
        <th align="center" width="10%">Agent</th>
        <th align="center" width="20%">Agent Name</th>
        <th align="center" width="10%">Vendor</th>
         <th align="center" width="19%">Vendor Name</th>
        <th align="center" width="6%">Quantity</th>
        </tr>
</table>
</div>

<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:5%">
<TABLE  id="InnerBox1Tab" width="100%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
<%
	
 	
 	for(int i=0;i<agentsCount;i++)
	{
		String chkStr = "-#"+agentsList.getFieldValueString(i,"EVA_VENDOR_CODE")+"$"+agentsList.getFieldValueString(i,"EVA_AGENT_CODE")+"#"+qty+"#"+"N";
    String vCode = agentsList.getFieldValueString(i,"EVA_VENDOR_CODE");
%>
		<tr>
			<td align="center" width="5%"><input type="checkbox" name="chk1" value="<%=chkStr%>"></td>
			<td align="center" width="10%"><%=agentsList.getFieldValueString(i,"EVA_AGENT_CODE")%>&nbsp;</td>
			<td align="left" width="20%"><%=agentsList.getFieldValueString(i,"EVA_AGENT_NAME")%>&nbsp;</td>
		        <td align="center" width="10%"><%=vCode%>&nbsp;</td>
		        <td align="left" width="19%"><%=venodorsHT.get(vCode)%>&nbsp;</td>
        		<td align="center" width="6%"><input type=text name='qtyTxt' class=InputBox value='<%=qty%>' style='width:100%' maxlength=13></td>
        		
		</tr>
<%
	}
%>
</table>
</div>
<% 	} 
%>
<Div id="MenuSol"></Div>
