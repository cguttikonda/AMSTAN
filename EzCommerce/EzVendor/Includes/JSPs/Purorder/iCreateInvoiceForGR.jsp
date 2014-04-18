<%@ page import ="ezc.ezparam.*,ezc.ezshipment.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="Manager" class="ezc.ezshipment.client.EzShipmentManager" scope="page" />


<%
	String stat=request.getParameter("Status");
	String PrepText="";
try{

	if ("Cancel".equals(stat))
	{
		if (session.getValue("GRLIST")!=null)
			session.removeValue("GRLIST");
		if (session.getValue("InvoiceVal")!=null)
			session.removeValue("InvoiceVal");
		if (session.getValue("GRNOS")!=null)
			session.removeValue("GRNOS");

		response.sendRedirect("ezListOpenGrs.jsp");
	}
	else 
	{
		String codes[]=null;
		boolean flag=false;
		if (session.getValue("GRLIST")==null)
		{
			codes=request.getParameterValues("Chk");		
			session.putValue("GRLIST",codes);
			flag=true;
		}
		else
			codes=(String[])session.getValue("GRLIST");

		EzcParams params=new EzcParams(true);
		ezBapi_incinv_create_headerStructure InvHeader=new ezBapi_incinv_create_headerStructure();
	
		Date today=new Date();
		String pstDate=request.getParameter("PostingDate");
		String docNo=request.getParameter("RefDoc");

		InvHeader.setInvoiceInd("X");
    		InvHeader.setDocDate(today);
		if (pstDate==null)
	    		InvHeader.setPstngDate(today);
		else{
			int mm=Integer.parseInt(pstDate.substring(3,5));
			int dd=Integer.parseInt(pstDate.substring(0,2));
			int yy=Integer.parseInt(pstDate.substring(6,10));
			//GregorianCalendar g=new GregorianCalendar(yy,mm-1,dd);
			GregorianCalendar g=new GregorianCalendar(05,02,11);

			Date pstDt=g.getTime();
			InvHeader.setPstngDate(pstDt);
		}
		if (docNo==null)
	    		InvHeader.setRefDocNo("1");	
		else
	    		InvHeader.setRefDocNo(docNo);	
    		InvHeader.setCurrency("INR");
		if (session.getValue("InvoiceVal")==null || "".equals(((String)session.getValue("InvoiceVal")).trim()))
		{
			InvHeader.setGrossAmount(new java.math.BigDecimal(".0001"));
		}	
		else
		{
			String amount=(String)session.getValue("InvoiceVal");

			String amt="";
			if (amount.indexOf(",")!=-1){
				StringTokenizer st=new StringTokenizer(amount,",");
				while (st.hasMoreTokens())
					amt=amt+st.nextToken();
			}
			else
				amt=amount;
			java.math.BigDecimal Amnt=new java.math.BigDecimal (amt);
			InvHeader.setGrossAmount(Amnt);	
		}

		String defErpVendor = (String)session.getValue("SOLDTO");
		InvHeader.setDiffInv(defErpVendor);
		InvHeader.setDocType("RE");
		InvHeader.setCalcTaxInd("X");

	 	/*
		InvHeader.setCompCode();	Taking from Defaults at backend
		
	  	InvHeader.setBlineDate();	
		InvHeader.setDsctPct1();
	       	InvHeader.setDsctPct2();
	        	InvHeader.setHeaderTxt();
		InvHeader.setPmntBlock();
		*/
		params.setObject(InvHeader);	

		EzBapiFlagStructure flagStruct=new EzBapiFlagStructure();
		if (session.getValue("InvoiceVal")==null)
			flagStruct.setFlag("Y");
		else
			flagStruct.setFlag("X");

		System.out.println(" Flag ***************************>>>>>>>>>>"+flagStruct.getFlag());
		params.setObject(flagStruct);	

		ezBapi_incinv_create_itemTable InvTable=new ezBapi_incinv_create_itemTable();
		ezBapi_incinv_create_itemTableRow InvTableRow=null;
		StringTokenizer st=null;
		Vector vecDc=new Vector();
		String matText="";
		Vector vecPo=new Vector();

		/* Putting all GRNs and Qty into the Session.Taking Qty from Session while posting*/
		Hashtable GRns=null;
		if (session.getValue("GRNOS")!=null)
			GRns=(java.util.Hashtable) session.getValue("GRNOS");
			
		for (int i=0;i<codes.length;i++)
		{
			InvTableRow=new ezBapi_incinv_create_itemTableRow();
			
			st=new StringTokenizer(codes[i],"||");
			String grNo= st.nextToken();	//GRno
			String poNo=st.nextToken();		//PO No
			String poItem=st.nextToken();	//PO Item
			String uom=st.nextToken();		//uom
			String FYear=st.nextToken();	//Fiscal Year
			String plant=st.nextToken();		//Plant
			
			String qty="";	
			if (GRns==null)
				qty=st.nextToken();		//Qty
			else{
				try{
					qty=(String)GRns.get(grNo);
					st.nextToken();
				}catch(Exception e){
					qty=st.nextToken();		//Qty
				}
			}
			String amount=st.nextToken();	//Paid Amount
			String DCNo=st.nextToken();	//DC No
			String GRITEMNO=st.nextToken();	//GRITEMNO
			String matDesc=st.nextToken();	//MatDesc
			InvTableRow.setRefDoc(grNo);
			InvTableRow.setPoNumber(poNo);
			InvTableRow.setPoItem(new java.math.BigInteger(poItem));
			InvTableRow.setRefDocYear(new java.math.BigInteger(FYear));
    			InvTableRow.setItemAmount(new java.math.BigDecimal(amount));
    			InvTableRow.setQuantity(new java.math.BigDecimal(qty));
    			InvTableRow.setPoUnit(uom);
			InvTableRow.setRefDocIt(new java.math.BigInteger(GRITEMNO));
			InvTableRow.setInvoiceDocItem(new java.math.BigInteger("1"));

			/*
			InvTableRow.setTaxCode();
    			InvTableRow.setTaxjurcode();
			InvTableRow.setDeCreInd();
			*/
			InvTable.insertRow(i,InvTableRow);
			if ( ! vecPo.contains(poNo))
				vecPo.addElement(poNo);
			
			if (! DCNo.equals("NA"))
				vecDc.addElement(DCNo);
			matText=matText+matDesc+"  "+uom+" "+qty+"<br>";
		}
			
		PrepText="PO NOs:"+vecPo.toString()+"<br>"+"DC NOs:"+vecDc.toString()+"<br><br>"+matText;
	
		params.setObject(InvTable);
		Session.prepareParams(params);
	      
		ReturnObjFromRetrieve retObj=(ReturnObjFromRetrieve)Manager.ezCreateInvoiceForGR(params);
		String Msg=retObj.getFieldValueString("MSGTEXT");

		String InvVal=retObj.getFieldValueString("VALUE");
		
		PrepText=PrepText+"@@"+InvVal;

		System.out.println("***************Value from the BackEnd::");

		String f=retObj.getFieldValueString("FLAG");
		session.putValue("InvoiceVal",InvVal.trim());
		

		if ("ERROR".equals(InvVal))
		{
			if (session.getValue("GRLIST")!=null)
				session.removeValue("GRLIST");

			if (session.getValue("InvoiceVal")!=null)
				session.removeValue("InvoiceVal");
			if (session.getValue("GRNOS")!=null)
				session.removeValue("GRNOS");
		%>	
			<br><br>
			<Table align=center><Tr><Td class=displayheader>Sorry ! Your Request can't be processed.</Td></Tr></Table><br><br>
			<Table align=center><Tr><Td class=blankcell><font color=blue size=4><%=Msg%>.</font></Td></Tr></Table>
			<br><br><Table align='center'><Tr><Td>Contact System Administrator for further Details.</Td></Tr></Table>
			<br><br><br>
			<Table align=center><Tr>
			<Td class="blankcell"><img src="../../../Vendor2/Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand"  onClick='JavaScript:fun1()'  border="none"></td>
			</Tr></Table>
		<%}
		else
		{

			if (flag)
			{

			%>
				<script>
				retVal=showModalDialog('ezInvWindow.jsp',"<%=PrepText%>",'center:yes;dialogWidth:35;dialogHeight:30;status:no;minimize:yes')
				if ((retVal=='Canceld~~')||(retVal==null)){
					document.forms[0].Status.value="Cancel";
				}
				else{
					a=retVal.split("||");
					document.forms[0].RefDoc.value=a[0];
					document.forms[0].PostingDate.value=a[1];
				}
				document.forms[0].submit();
				</script>
			<%
			}
			else
			{
				if (session.getValue("GRLIST")!=null)
					session.removeValue("GRLIST");
				if (session.getValue("InvoiceVal")!=null)
					session.removeValue("InvoiceVal");
				if (session.getValue("GRNOS")!=null)
					session.removeValue("GRNOS");
				%>
				<br><br>
				<Table align=center><Tr>
				<Td class=displayheader>Invoice Posted successfully.</Td></Tr></Table><br><br>
				<%if ((InvVal!=null)&&(InvVal.trim().length()!=0)&&((! InvVal.equalsIgnoreCase("null")))){%>
					<Table align=center width="80%"><Tr>
					<Td><font color=blue><b>Please note this Document No :<%=InvVal%> on your Invoice and submit to our Accounts Department.</b></font></Td></Tr></Table>
					<br><br><br>
				<%}%>
				<Table align=center><Tr>
				<Td class="blankcell"><img src="../../../Vendor2/Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand"  onClick='JavaScript:fun1()'  border="none"></td>
				</Tr></Table>

			<%}
		}
	}
}catch(Exception e)
{
	System.out.println("*****************Exception In GR Posting:"+e);

	try{
	if (session.getValue("GRLIST")!=null)
		session.removeValue("GRLIST");
	if (session.getValue("InvoiceVal")!=null)
		session.removeValue("InvoiceVal");
	if (session.getValue("GRNOS")!=null)
		session.removeValue("GRNOS");
	}catch(Exception e1){  }
	%>
	<br><br>
	<Table align=center><Tr><Td class=displayheader>An Exception has occured while processing.</Td></Tr></Table><br><br>
	<Table align=center><Tr><Td class=blankcell><font color=blue size=4><%=e%>.</font></Td></Tr></Table>
	<br><br><Table align='center'><Tr><Td>Contact System Administrator for further Details.</Td></Tr></Table>
	<br><br><br>
	<Table align=center><Tr>
	<Td class="blankcell"><img src="../../../Vendor2/Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand"  onClick='JavaScript:fun1()'  border="none"></td>
	</Tr></Table>
<%
}	
%>
