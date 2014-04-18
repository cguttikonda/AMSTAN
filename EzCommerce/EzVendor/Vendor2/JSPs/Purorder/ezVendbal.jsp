<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iVendBal_Labels.jsp"%>
<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/JSPs/Purorder/iVendBal.jsp"%>  
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body scroll=no>
<% 
	String display_header = vendBal_L; 
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<br>
	<form method="post" action="../Misc/ezVendorAddress.jsp" name="vendacc">
	<table  width="90%" align=center >
	<tr> 
		<td width="50%" valign="top" class="blankcell"> 
        		<table id="Table1" width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<tr class="bannercell"> 
        			<th><%=payToAddre_L%></th>
			</tr>
<%
			ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
			myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
			myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
			myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
			myFormat.setSymbol((String)session.getValue("CURRENCY"));
			if ( !hasPayTo )
			{  
%>
				<tr class="bannercell"> 
					<td><%=noPayInfo_L%></td>
				</tr>
<%
			}
			else
			{
				if(payToCompName!=null && !payToCompName.equals("null") && !payToCompName.equals(""))
				{
%>  	
					<tr>
						<td>
							<%=payToCompName%> 
						</td>
					</tr>
<%  
				}
				if(payaddrLine2!=null && !payaddrLine2.equals("null") && !payaddrLine2.equals(""))
				{
%>
					<tr>
						<td> 
							<%=payaddrLine2%> 
						</td>
					</tr>
<%  
				}
				if(payaddrLine3!=null && !payaddrLine3.equals("null") && !payaddrLine3.equals(""))
				{
%>    
			         	<tr>
			         		<td> 
			         			<%=payaddrLine3%> 
			         		</td>
			         	</tr>
<%  
				}
				if(payToCity!=null && !payToCity.equals("null") && !payToCity.equals(""))
				{
%>    
			          	<tr>
			          		<td> 
			          			<%=payToCity%> 
			          		</td>
			          	</tr>
<%  
				}
				if(payToState!=null && !payToState.equals("null") && !payToState.equals(""))
				{
%>    
			          	<tr>
			          		<td> 
			          			<%=payToState+" "+payToZip%> 
			          		</td>
			          	</tr>
<% 
				} 
%>	
          			<tr>
            				<td>
<%
						if((payToCountry.trim()).equalsIgnoreCase("IN"))
						{
							out.println("INDIA");
						}
						else
						{
							out.println(payToCountry);
						}
%>
					</td>
		          	</tr>
<%
			}
%>
        		</table>
      		</td>
      		<td width="50%" valign="top" class="blankcell">
			<table id="Table1" width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
        		<tr> 
        			<th nowrap><%=invAddr_L%></th>
       			</tr>
<%
			if ( !hasOrderTo ) 
			{
%>
				<tr class="bannercell"> 
					<td><%=invInfoAva_L%></td>
				</tr>
<%
			}
			else
			{
				if(ordToCompName!=null && !ordToCompName.equals("null") && !ordToCompName.equals(""))
				{
%>
		        		<tr> 
		        			<td>
		        				<%=ordToCompName%>
		        			</td>
		        		</tr>
<% 
				}
		   		if(addrLine2!=null && !addrLine2.equals("null") && !addrLine2.equals(""))
		   		{
%>		
			          	<tr>
			          		<td>
			          			<%=addrLine2%>
			          		</td>
			          	</tr>
<% 
				} 
				if(addrLine3!=null && !addrLine3.equals("null") && !addrLine3.equals(""))
				{
%>
		          		<tr>
		          			<td>
		          				<%=addrLine3%>
		          			</td>
		          		</tr>
<% 
				} 
				if(ordToCity!=null && !ordToCity.equals("null") && !ordToCity.equals(""))
				{
%>
					<tr>
						<td>
							<%=ordToCity%>
						</td>
					</tr>
<% 
				} 
				if(ordToState!=null && !ordToState.equals("null") && !ordToState.equals(""))
				{
%>
					<tr>
						<td>
							<%=ordToState+" "+ordTozip%>
						</td>
					</tr>
<%  
				} 
%>
        			<tr>
          				<td>
<%
					if( (ordToCountry.trim()).equalsIgnoreCase("IN"))
					{
						out.println("INDIA");
					}
					else
					{
						out.println( ordToCountry); 
					}
%>
					</td>
		          	</tr>
<%
			}
%>
		        </table>
      		</td>
    	</tr>
  	</table>
  	<br>

	<table id="Table1" width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    	<tr align="center" valign="middle"> 
      	<th colspan="2"><%=accountSumm_L%>&nbsp;<%=defPurchaseAreaDescription%></th>
    	</tr>
<%
	String ordbal = null;
	String invbal = null;
	int rowno = 0;
	if(supplbal!=null)
		rowno = supplbal.getRowCount();
	
	if (rowno ==0)
	{
%>
		<tr>
			<td width="20%"><b><%=vendAcct_L%></b></td>
			<td width="18%"><%=defErpVendor%></td>
		</tr>
		<tr> 
			<td width="20%"><b><%=acctBal_L%></b>&nbsp;/&nbsp;<b><%=odAmt_L%></b></td>
			<td width="18%" >0.00/<font color=red>0.00 </font></td>
		</tr>
		</table>
<%
	}
	else
	{
		ordbal = supplbal.getFieldValueString(ORDBAL);
		invbal = supplbal.getFieldValueString("LCBAL");
		java.math.BigDecimal invBalValue = (java.math.BigDecimal) supplbal.getFieldValue(INVBAL);
%>
	     	<tr>
     			<td width="20%"><b><%=vendAcct_L%></b></td>
	      		<td width="18%"><%try{%><%=Long.parseLong(defErpVendor)%><%}catch(Exception e){%><%=defErpVendor%><%}%>
			</td>
	    	</tr>
     		<tr>
	     		<td width="20%"><b><%=acctBal_L%></b>&nbsp;/&nbsp;<b><%=odAmt_L%></b></td>
      			<td width="18%">
<%
			double invoiceLCBAL = 0;
			double overDueAmt = 0;
			for(int i=0;i<supplbal.getRowCount();i++)
			{
				if ("O".equalsIgnoreCase(supplbal.getFieldValueString(i,"SPGLIND"))){
					try{
						overDueAmt += Double.parseDouble(supplbal.getFieldValueString(i,"LCBAL"));
					}catch(Exception e)
					{
						overDueAmt += 0;
					}	
				}
				else{
					try{
						invoiceLCBAL += Double.parseDouble(supplbal.getFieldValueString(i,"LCBAL"));
					}catch(Exception e)
					{
						invoiceLCBAL += 0;
					}	
				}
			}
			invoiceLCBAL *= -1;
			if (overDueAmt != 0)
				overDueAmt *= -1;
%>
			[<%=supplbal.getFieldValueString("LOCCURRENCY")%>]
			<a href="ezListInvOB.jsp?invBal=<%=invoiceLCBAL%>&invCur=<%=supplbal.getFieldValue("LOCCURRENCY")%>&InvStat=O" onMouseover="window.status='Click to view the list of invoices '; return true" onMouseout="window.status=' '; return true"><%=myFormat.getCurrencyString(invoiceLCBAL).trim()%></a>
			&nbsp;/&nbsp;<font color=red><%=myFormat.getCurrencyString(overDueAmt)%></font>
		</td>
		</tr>
<%
	}
%>
</table>
<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<Center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</Center>
</Div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
