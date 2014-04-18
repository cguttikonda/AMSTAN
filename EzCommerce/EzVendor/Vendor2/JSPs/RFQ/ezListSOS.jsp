<%
	ezc.ezcommon.EzLog4j.log("***ezListSOS.jsp***"+myRetCount,"I");
	if(myRetCount==0)
	{
		
%>

	<br><br>
	<TABLE width=80% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	<tr>
	<Th>No Vendors exist for the selected Material</Th>
	</tr>
	</TABLE>
<%
	}
	else    
	{

%>
<DIV id="theads" >
<TABLE id="tabHead" width="90%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
        <tr>
        <th align="center" width="5%">&nbsp;</th>
        <th align="center" width="10%">Vendor</th>
        <th align="center" width="18%">Vendor Name</th> 
        <th align="center" width="15%">Contract</th>
        <th align="center" width="15%">Contract Item</th>
        <th align="center" width="12%">Info Record</th>
        <th align="center" width="10%">PO Unit</th>
        <th align="center" width="10%">Quantity</th>
        <th align="center" width="5%">QM Info</th>
        
        
         
        
        
        </tr>
</table>
</div>

<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:5%">
<TABLE  id="InnerBox1Tab" width="100%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
<%
	String agreement = "";
	String vendor="",agmtItem="",concatString="",vendName="";
	//if(qty!=null)
	//	qty = qty.substring(0,(qty.length()-1));
 	for(int i=0;i<myRetCount;i++)
	{
		agreement = myRet.getFieldValueString(i,"AGREEMENT");
		try
		{
			vendor=""+Long.parseLong(myRet.getFieldValueString(i,"VENDOR"));
		}
		catch(Exception e)
		{
			vendor=myRet.getFieldValueString(i,"VENDOR");
		}
		try
		{
			agmtItem=""+Long.parseLong(myRet.getFieldValueString(i,"AGMT_ITEM"));
		}
		catch(Exception e)
		{
			agmtItem=myRet.getFieldValueString(i,"AGMT_ITEM");
		}
		
		vendName = (String)venodorsHT.get(vendor);
		if(vendName==null || "null".equals(vendName) || "".equals(vendName))
			vendName = "Not Synchronized";
		
		
		if(!agreement.equals(""))
		   concatString = "AGR#"+myRet.getFieldValueString(i,"VENDOR")+"#"+agreement+"#"+agmtItem;
		else   
		   concatString = "-#"+myRet.getFieldValueString(i,"VENDOR")+"#"+qty+"#"+"A";
%>
		<tr>
			<td align="center" width="5%"><input type="checkbox" name="selChk" value='<%=concatString%>'></td>
			<td align="center" width="10%"><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendor%>')"><%=vendor%>&nbsp;</a></td>
			<td align="left" width="18%"><%=vendName%>&nbsp;</td>
			<td align="left" width="15%"><a href="javascript:getAgmtDtl('<%=myRet.getFieldValueString(i,"AGREEMENT")%>')"><%=myRet.getFieldValueString(i,"AGREEMENT")%></a>&nbsp;</td>
			<td align="left" width="15%"><%=agmtItem%>&nbsp;</td>
			<td align="center" width="12%"><%=myRet.getFieldValueString(i,"INFO_REC")%>&nbsp;</td>
        		<td align="center" width="10%"><%=myRet.getFieldValueString(i,"PO_UNIT")%></td>
        		<td align="center" width="10%"><input type=text name='qtyTxt' class=InputBox value='<%=qty%>' style='width:100%' maxlength=12 readonly></td>
        		<td align="center" width="5%"><a  style='text-decoration:none'  href="javascript:showQMInfo('<%=vendor%>')"><img style="cursor:hand;border:none" src='../../Images/FAQs/question.gif'></a></td>
        		
		</tr>
<%
	}
%>

</table>
</div>
<% 	} 
%>
<Div id="MenuSol"></Div>
