<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import ="ezc.ezparam.*" %>
<%@ page import ="ezc.customer.invoice.params.*" %>
<%@ page import ="ezc.client.*"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="CustInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />


<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%
	String custInvNo = request.getParameter("custInvNo");
	String sapInvNo = request.getParameter("sapInvNo");
	String InvDate= request.getParameter("InvDate");
	String InvFalg= request.getParameter("InvFlag");

	EzcCustomerInvoiceParams ecparams = new EzcCustomerInvoiceParams();
	EziCustomerInvoiceParams eiParams = new EziCustomerInvoiceParams();

	eiParams.setCustInvoiceNo(custInvNo);
	eiParams.setSalesDocNum("123");	//Some Dummy Number
	eiParams.setSelection("I");  //I
	ecparams.setObject(eiParams);
	Session.prepareParams(ecparams);
	ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve)CustInvManager.getCustomerInvoiceDetails(ecparams);
	ReturnObjFromRetrieve billHeaders 	= (ReturnObjFromRetrieve)retObj.getFieldValue("BILLING_HEADERS_OUT");
	ReturnObjFromRetrieve billItems 	= (ReturnObjFromRetrieve)retObj.getFieldValue("BILLING_ITEMS_OUT");

	String soldto=(String) session.getValue("AgentCode");
	int mn = Integer.parseInt(InvDate.substring(0,2));
	int dt = Integer.parseInt(InvDate.substring(3,5));
	int yr = Integer.parseInt(InvDate.substring(6,10));
	java.util.GregorianCalendar DateObj =  new java.util.GregorianCalendar(yr,mn-1,dt);
	
	ReturnObjFromRetrieve retList =new ReturnObjFromRetrieve();
	EzcParams params=new EzcParams(true);
	EziCustomerInvoicePaymentsParams inParams = new EziCustomerInvoicePaymentsParams();
	inParams.setInvoiceNo(sapInvNo);
	inParams.setCompCode("1000");
	inParams.setCustomer(soldto);
	inParams.setInvDate(DateObj.getTime());
	params.setObject(inParams);
	Session.prepareParams(params);
	
	try{
		retList=(ReturnObjFromRetrieve) CustInvManager.ezGetCustomerInvoicePayments(params);
		//retList.toEzcString();
	}catch(Exception e){
	System.out.println(">>>>>>>>>"+e);
	}	
	
	//ReturnObjFromRetrieve retList =new ReturnObjFromRetrieve();
%>

<%@ include file="../../../Includes/JSPs/Lables/iPaymentDetails_Lables.jsp"%>
<Html>
	<Head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	</Head>
	<Body scroll=no>
	<Form>
	<%
		String display_header = payDet_L;
	%>
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>

	
	<Br>
	<%

	int disRec=0;
	String curr="";
	for (int i=0;i<retList.getRowCount();i++)
	{
		//if ("S".equals(retList.getFieldValueString(i,"DBCRIND").trim())&&(!sapInvNo.equals(retList.getFieldValueString(i,"DOCNO")))){
		double dd=0.0;
		try{
		dd=Double.parseDouble(retList.getFieldValueString(i,"AMOUNT"));
		}catch(Exception e){}
		if  ("DZ".equals(retList.getFieldValueString(i,"DOCTYPE").trim()))
		{
			disRec++;
			curr=retList.getFieldValueString(i,"CURRENCY");
		}
		else if ( ("RV".equals(retList.getFieldValueString(i,"DOCTYPE")))&& ("H".equals(retList.getFieldValueString(i,"DBCRIND")))&&("12".equals(retList.getFieldValueString(i,"POSTKEY"))) )
			disRec++;
	}

	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
double d= 0.0;
	if(billHeaders.getRowCount()>0)
	{
%>

		<Table width="75%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th><%=inNO_L%> :</Th><Td>
			<%try{out.println(Integer.parseInt(sapInvNo));}catch(Exception e){out.println(sapInvNo);}%>
			</Td>
			<Th><%=inDate_L%> :</Th><Td><%=InvDate%></Td>
			<Th><%=invAmount_L%> :[<%= billHeaders.getFieldValueString(0,"Currency")%>]</Th>
			<Td>
			<%
				try{
					d=Double.parseDouble(billHeaders.getFieldValueString(0,"NetValue"))+Double.parseDouble(billHeaders.getFieldValueString(0,"TaxValue"));
					out.println(myFormat.getCurrencyString(String.valueOf(d)));
				}catch(Exception e){
					out.println(billHeaders.getFieldValueString(0,"NetValue"));
				}
			%>
			</Td>
		</Tr>

		</Table><Br>

<%
	}


	if (disRec>0)
	{
	%>


		<Table width="60%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="33%">Reference Document No</Th>
			<Th width="33%"><%=payDate_L%></Th>
			<Th width="34%"><%=payAmt_L%> [<%=curr%>]</Th>
		</Tr>
		<%
		String  formatkey=(String)session.getValue("formatKey");
		for (int i=0;i<retList.getRowCount();i++)
		{
			String clDoc=retList.getFieldValueString(i,"CLRDOC").trim();
			double dd=0.0;
			try{
			dd=Double.parseDouble(retList.getFieldValueString(i,"AMOUNT"));
			}catch(Exception e){}
			if ("DZ".equals(retList.getFieldValueString(i,"DOCTYPE").trim()))
			{
		%>
			<Tr>
			<Td align="left" width="33%"><%=retList.getFieldValueString(i,"DOCNO")%>&nbsp;</Td>
			<Td align="center" width="33%"><%=FormatDate.getStringFromDate((Date)retList.getFieldValue(i,"POSTINGDATE"),formatkey,FormatDate.MMDDYYYY)%></Td>
			<Td align="right" width="33%">
			<%
				dd =0.0;
				if (dd!=0.0)
					out.println(myFormat.getCurrencyString(retList.getFieldValueString(i,"AMOUNT")));
					//out.println(myFormat.getCurrencyString(String.valueOf(d)));
				else
					out.println(myFormat.getCurrencyString(retList.getFieldValueString(i,"AMTDOCCURR")));
					 //out.println(myFormat.getCurrencyString(String.valueOf(d)));
				%></Td>
			</Tr>
		<%	}
			else if ( ("RV".equals(retList.getFieldValueString(i,"DOCTYPE")))&& ("H".equals(retList.getFieldValueString(i,"DBCRIND")))&&("12".equals(retList.getFieldValueString(i,"POSTKEY"))) && (clDoc.equals(sapInvNo)))
			{%>	<br><br>
				<Table width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
				<Tr>
				<Td align="center"><b><%=thisInvCancel_L%>.</b></Td>
				</Tr>
				</Table>
			<%
				break;
			}
			else if ( ("RV".equals(retList.getFieldValueString(i,"DOCTYPE")))&& ("H".equals(retList.getFieldValueString(i,"DBCRIND")))&&("12".equals(retList.getFieldValueString(i,"POSTKEY"))) && (! clDoc.equals(sapInvNo)))
			{%>	<br><br>
				<Table width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
				<Tr>
				<Td align="center"><b><%=thisInvCancelDoc_L%> :<%=retList.getFieldValueString(i,"CLRDOC")%>.</b></Td>
				</Tr>
				</Table>
			<%
				break;
			}

		}%>
		</Table><Br>
<%
	}
	else
	{
%>

		<br><br><br>
		<Table  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr><Td align="center" align=center class="displayalert">
			<%if ("C".equals(InvFalg)){%>
				<%=paydetNotAvail_L%> <% try{out.println(Integer.parseInt(custInvNo));}catch(Exception e){out.println(custInvNo);} %> .
			<%}else{%>
				<%=payDetYetMade_L%> <%try{out.println(Integer.parseInt(custInvNo));}catch(Exception e){out.println(custInvNo);}%> .
			<%}%>
		</td>
		</Tr>
		</Table>
		<br><br><br>
<%
	}
%>
<div align=center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
