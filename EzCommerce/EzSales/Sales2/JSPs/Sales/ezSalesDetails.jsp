<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import = "ezc.ezbasicutil.EzReplace" %>

<%
	ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
	FormatDate formatDate = new FormatDate();
	java.util.Date webOrderDate=(java.util.Date)sdHeader.getFieldValue(0,"ORDER_DATE");

	String Reason = sdHeader.getFieldValueString(0,"RES2");
	Reason= ( (Reason==null)||(Reason.trim().length() == 0)||("null").equals(Reason) )?"None":Reason.trim();
	Reason=Reason.replace((char)13,' ');
	Reason=Reason.replace((char)10,' ');


	Vector types = new Vector();
	types.addElement("date");
	types.addElement("date");
	types.addElement("currency");

	EzGlobal.setColTypes(types);

	Vector names = new Vector();
	names.addElement("ORDER_DATE");
	names.addElement("RES1");
	names.addElement("NET_VALUE");
	EzGlobal.setColNames(names);
	ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(sdHeader);
	

%>
<html>
<head>
	<Title>Sales Order Details-- Powered by EzCommerce Inc</Title>
	<%//@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="35%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<script src="../../Library/JavaScript/ezSniffer.js"></script>
	
	<script>
	var retlen
	var log
	var UserRole = "<%= UserRole %>"
	<%
	if( retLines.getRowCount()>6)
	{
  	  out.println("retlen=1");
	}
	else
	{
	  out.println("retlen=0");
	}
	if( ( CU || AG || CM )&&(!TRANSFERED ) )
	{
	  out.println("log=1");
	}
	else
	{
	 out.println("log=0");
	}
	%>

	function showTab(tabToShow)
	{
	
		obj1=document.getElementById("div1")
		obj2=document.getElementById("div2")
		obj3=document.getElementById("theads")
		obj4a=document.getElementById("InnerBox1Div")
		obj6=document.getElementById("div6")
		obj7=document.getElementById("buttonDiv" )
	
	
			if(tabToShow==1)
			{
				obj1.style.visibility="visible"
				obj2.style.visibility="visible";
				obj3.style.visibility="visible";
				obj4a.style.visibility="visible";
				obj6.style.visibility="hidden"
				obj7.style.visibility="hidden"
				scrollInit();
	
			}
			else if(tabToShow==2)
			{
				obj1.style.visibility="hidden"
				obj2.style.visibility="hidden"
				obj6.style.visibility="visible"
				obj7.style.visibility="visible"
				obj3.style.visibility="hidden";
				obj4a.style.visibility="hidden";
			}
	
	}

	function showSpan(spId)
	{
		spanStyle=document.getElementById(spId).style
		if(spanStyle.display=="none")
			spanStyle.display="block"
		else
			spanStyle.display="none"

	}
        function callSchedule(file)
        {
	   if(document.generalForm.onceSubmit.value!=1){
	     document.generalForm.onceSubmit.value=1
             document.body.style.cursor='wait'
	     document.generalForm.display.value="y"
      	     document.generalForm.action=file;
             document.generalForm.submit();
            }
        }
	/*function openNew(url){
       		open(url,"EzView","menubar=no,personalbar=no,toolbar=no,width=750,height=500,left=20,top=20");
        }*/

function back1()
{
	if(document.generalForm.display.value=="N")
	{
		document.body.style.cursor='wait'
		//document.generalForm.target="main"
		document.generalForm.action="../Misc/ezMenuFrameset.jsp"
		document.generalForm.submit();
	}
}
	function displayreason()
	{
		newWindow=window.open("ezReason.jsp?reasonForRejection=<%=Reason%>","Mywin","resizable=no,left=250,top=100,height=350,width=400,status=no,toolbar=no,menubar=no,location=no");
	}
	function select1()
	{
		document.generalForm.display.value="N"
		showTab(1);
	}
	function ezListPage(obj)
	{
		if( ((obj == "SUBMITTED" ) || (obj == "APPROVED" ) || (obj == "SUBMITTEDTOBP" ) || (obj == "RETURNEDBYBP" )) && (UserRole =="CU") )
		{
			obj = "Submitted','Approved','SubmittedToBP','ReturnedByBP"
		}else if( ( (obj == "APPROVED" ) || (obj == "SUBMITTEDTOBP" ) || (obj == "RETURNEDBYBP" )) && (UserRole =="CM") )
		{
			obj="Approved','SubmittedToBP','ReturnedByBP";
		}
		document.generalForm.urlPage.value="listPage"
		document.generalForm.orderStatus.value="'"+obj+"'"
		document.generalForm.action="../Misc/ezMenuFrameset.jsp"
		document.generalForm.target="main"
		document.generalForm.submit()
	}

	function openNewWindow(obj,i)
	{
		newWindow = window.open(obj,"multi","resizable=no,left=250,top=100,height=350,width=400,status=no,toolbar=no,menubar=no,location=no")
	}
	</script>
</head>
<body  onLoad="scrollInit();select1()" onresize="scrollInit()" scroll=no> 
<form method="post" name="generalForm">
<input type="hidden" name ="display" value="N">
<input type=hidden name="urlPage"  value="dso">
<input type=hidden name="newFilter" value="<%=request.getParameter("newFilter")%>">
<input type=hidden name="orderStatus">
<input type=hidden name="chkBrowser"  value="0">

<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%" id="header" >
<tr>
    <td height="35" class="displayheaderback" width="40%"></td>
    <td height="35" class="displayheaderback"  width="60%">
	<%
 		 if(("Transfered").equalsIgnoreCase(StatusButton))
		 {
			try{
			out.println(ordNo_L+""+Integer.parseInt(sdHeader.getFieldValueString(0,"BACKEND_ORNO")));
			}catch(Exception e)
			{
			out.println(ordNo_L+""+sdHeader.getFieldValueString(0,"BACKEND_ORNO"));
			}
		 }
	%>  <%=details_L%>
   </td>
  </tr>
</table>
<input type="hidden" name="selList" value="<%= sdHeader.getFieldValueString(0,"BACKEND_ORNO") %>|<%= sdHeader.getFieldValueString(0,"RES1")%>" >
<input type="hidden" name="SalesOrder" value="<%= sdHeader.getFieldValueString(0,"BACKEND_ORNO") %>">
<input type="hidden" name="fromPage" value="SalesOrder">
<input type="hidden" name="flag1" value="flag1">
<div id="div1" style="visibility:visible:width:100%">


<Table  id='table1'  width='95%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
  <tr align="center">
    <th colspan="6"><%=geninfo_L%></th>
  </tr>
<Tr >
        <Th class="labelcell" align="left" nowrap><%=weorno_L%></Th>
        <Td><%=sdHeader.getFieldValueString(0,"WEB_ORNO")%></Td>
        <Th class="labelcell" align="left" nowrap><%=weordate_L%></Th>
        <Td><%=ret.getFieldValueString(0,"ORDER_DATE")%></Td>
	<Th class="labelcell" align="left" nowrap><%=crby_L%></Th>
	<Td><%= sdHeader.getFieldValueString(0,"CREATE_USERID") %></Td>
</Tr>

<%



String SAPno = sdHeader.getFieldValueString(0,"BACKEND_ORNO");
SAPno = ((SAPno==null)|| (SAPno.trim().length()==0) ||("null").equals(SAPno))?"Not-Available": SAPno;
String netValue = ret.getFieldValueString(0,"NET_VALUE");
String DisCash = sdHeader.getFieldValueString(0,"DISCOUNT_CASH");
String DisPer =sdHeader.getFieldValueString(0,"DISCOUNT_PERCENTAGE");
String Freight=sdHeader.getFieldValueString(0,"FREIGHT");
DisCash = ( (DisCash == null)||(DisCash.trim().length()==0)||("null".equals(DisCash) )  )?"0":DisCash;
DisPer = ( (DisPer == null)||(DisPer.trim().length()==0)||("null".equals(DisPer)) )?"0":DisPer;
Freight = ( (Freight == null)||(Freight.trim().length()==0)||("null".equals(Freight)) )?"0":Freight;
%>

<Tr>
        <Th class="labelcell" align="left"><%=pono_L%></Th>
        <Td nowrap><%=sdHeader.getFieldValueString(0,"PO_NO")%></Td>
	<Th class="labelcell" align="left" nowrap><%=podate_L%></Th>
<%
	String podate = sdHeader.getFieldValueString(0,"RES1");
	if(podate== null || "null".equals(podate))
		podate=" ";
	try {
		StringTokenizer podateF=new StringTokenizer(podate,".");
		String  forkey=(String)session.getValue("formatKey");
		String dd = (String)podateF.nextElement();
		String mm = (String)podateF.nextElement();
		String yy = (String)podateF.nextElement();
		podate=mm+forkey+dd+forkey+yy;
	}catch(Exception e){

	}

%>
	<Td nowrap><%=sdHeader.getFieldValueString(0,"RES1")%></Td>
	<Th class="labelcell" align="left" nowrap><%=curr_L %></Th>
	<Td nowrap><%= sdHeader.getFieldValueString(0,"DOC_CURRENCY")%></Td>
</Tr>
<Tr>
        <Th class="labelcell" align="left" nowrap><%=soldto_L%> </Th>
	<Td nowrap><%= sdSoldTo.getFieldValueString(0,"SOTO_NAME") %><input type="hidden" name="soldTo" value="<%=sdSoldTo.getFieldValueString(0,"SOLD_TO_CODE")%>"></td>
	<Th class="labelcell" align="left" nowrap><%=shipto_L%> </Th>
  	<Td nowrap><%= sdShipTo.getFieldValueString(0,"SHTO_NAME") %></Td>
	<Th class="labelcell" align="left" nowrap><%=estnetval_L%></Th>
	<Td nowrap><%=netValue%></Td>
</Tr>
<%--
<Tr>
        <Th class="labelcell" align="left" nowrap><%=disCash_L%> </Th>
	<Td nowrap><%=DisCash%></Td>
	<Th class="labelcell" align="left" nowrap><%=discount_L%>(%) </Th>
  	<Td nowrap><%=DisPer%></Td>
	<Th class="labelcell" align="left" nowrap><%=friCharg_L%></Th>
	<Td nowrap><%=Freight%></Td>
</Tr> --%>
</table>

<% 
  out.println("</div>");

	out.println("<Div id='theads'>");
	out.println("<Table  width='95%'  id='tabHead' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >");
%>

  <tr align="center">
    <th colspan="9"  width="75%"> <%=podet_L%></th>
  </tr>

   <tr align="center" valign="middle">
    <% if( (CU || AG || CM )&&(! TRANSFERED )){%>

      <th width="40%"><%=prodesc_L%></th>
      <th  width="5%"><%=uom_L%></th>
      <th  width="14%"><%=quan_L%></th>
     <%-- <th  width="7%"> <%=foc_L%></th> --%>
      <th  width="17%"> <%=price_L%>[<%= sdHeader.getFieldValueString(0,"DOC_CURRENCY")%>]</th>
      <th  width="17%"> <%=reqdat_L%></th>
   </Tr>
<%}else{%>

      <th rowspan=2 width="41%"><%=prodesc_L%></th>
      <th rowspan=2  width="5%"><%=uom_L%></th>
      <th rowspan=2  width="12%"><%=quan_L%></th>
    <%-- <th  rowspan=2 width="8%"> <%=foc_L%></th> --%>
      <th colspan=2  width="21%"><%=price_L%>[<%= sdHeader.getFieldValueString(0,"DOC_CURRENCY")%>]</th>
      <th rowspan=2  width="13%"><%=dat_L%></th>
  </Tr>
  <Tr>
	<Th  width="10.5%"><%=requi_L%></Th>
	<Th  width="10.5%"><%=con_L%></Th>


   </Tr>
<%}

	out.println("</Table>");
	out.println("</div>");
	
	out.println("<DIV id='InnerBox1Div' style='overflow:auto;position:absolute;width:98%;height:35%;left:2%'>");
	out.println("<Table id='InnerBox1Tab'  width='100%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >");


	Vector types1 = new Vector();
	types1.addElement("currency");
	types1.addElement("currency");
	types1.addElement("date");
	types1.addElement("date");
	EzGlobal.setColTypes(types1);

	Vector names1 = new Vector();
	names1.addElement("DESIRED_PRICE");
	names1.addElement("COMMIT_PRICE");
	names1.addElement("PROMISE_FULL_DATE");
	names1.addElement("REQ_DATE");
	EzGlobal.setColNames(names1);

	ezc.ezparam.ReturnObjFromRetrieve ret1 = EzGlobal.getGlobal(retLines);



   String reqDateString=null,proDateString=null;
   int rl=0,r2=0;
   for(int i=0;i<retLines.getRowCount();i++)
   {

	reqDateString=ret1.getFieldValueString(i,"REQ_DATE");
	proDateString=ret1.getFieldValueString(i,"PROMISE_FULL_DATE");
	reqDateString=(reqDateString==null)?"":reqDateString;
	proDateString=(proDateString==null)?"":proDateString;
	int chkcount =0;


	rl=reqDateString.indexOf(" ");
	r2=proDateString.indexOf(" ");

	reqDateString=(rl==-1)?ret1.getFieldValueString(i,"REQ_DATE"):" ";
	proDateString=(r2==-1)?ret1.getFieldValueString(i,"PROMISE_FULL_DATE"):" ";
	String desc = retLines.getFieldValueString(i,"PROD_DESC");
	String ProdLine = retLines.getFieldValueString(i,"SO_LINE_NO");
	String prodNo = retLines.getFieldValueString(i,"PROD_CODE");
	try{
	prodNo = String.valueOf(Long.parseLong(prodNo));
	}
	catch(Exception e){}

	for(int k=0;k<retDeliverySchedules.getRowCount();k++)
	{
		String delProdLine = retDeliverySchedules.getFieldValueString(k,"EZDS_ITM_NUMBER");
		if(ProdLine.equals(delProdLine))
		{

			if(! ("0").equals(retDeliverySchedules.getFieldValueString(k,"EZDS_REQ_QTY") ))
			{
			chkcount++;
			}
		}

	}


%>
   <tr align="center" valign="middle" >

	<% if( LF || BP || TRANSFERED ){
	%>
		<td align="left"  width="41%" title="<%=prodNo %>">
			&nbsp;<%= desc %>
		<input type="hidden" name="matdesc" value="<%= desc %>">
		<input type="hidden" name="lineNo" value="<%= ProdLine %>"></td>
     		<td align="left"  width="5%"><%=retLines.getFieldValueString(i,"UOM") %></td>
		<td align="right"  width="12%"><%=myFormat.getCurrencyString(retLines.getFieldValueString(i,"COMMITED_QTY"))%></td>
		 <!-- <td  width="8%" align="left"><%=retLines.getFieldValueString(i,"FOC") %> %</td> -->
		<Td align="right"  width="10.5%"><%=ret1.getFieldValueString(i,"DESIRED_PRICE")%></Td>
		<td align="right"  width="10.5%"><%=ret1.getFieldValueString(i,"COMMIT_PRICE")%></td>
		<td align="left"  width="13%">
			<%
			if(chkcount >=2)
			{%>
				<a href='JavaScript:openNewWindow("ezDatesDisplay.jsp?ind=<%=i%>&matdesc=<%=desc%>&itemNo=<%= ProdLine%>","<%=i%>")' <%=statusbar%>><%= multiple_L%></a>
			<%}
			else
			{
				out.println(proDateString);
			}%>

		</td>
	<%}else {%>
		<td width="40%" align="left" title="<%=prodNo %>">
			&nbsp;<%= desc %>
		<input type="hidden" name="matdesc" value="<%= desc %>">
		<input type="hidden" name="lineNo" value="<%= ProdLine %>"></td>
	             <td  width="5%" align="left"><%=retLines.getFieldValueString(i,"UOM") %></td>
		<td  width="14%" align="right"><%=myFormat.getCurrencyString(retLines.getFieldValueString(i,"DESIRED_QTY")) %></td>
		<!-- <td  width="7%" align="right"><%=retLines.getFieldValueString(i,"FOC") %> % </td> -->
		<Td  width="17%" align="right"><%=ret1.getFieldValueString(i,"DESIRED_PRICE")%></Td>
		<td  width="17%" align="center" nowrap>

			<%
			if(chkcount >=2)
			{%>
				<a href='JavaScript:openNewWindow("ezDatesDisplay.jsp?ind=<%=i%>&matdesc=<%=desc%>&itemNo=<%= ProdLine%>","<%=i%>")' <%=statusbar%>><%= multiple_L%></a>
			<%}
			else
			{
				out.println(reqDateString);
			}%>
		</td>
	<%}%>

    </tr>
<%}%>
</Table>
</Div>
 <input type="hidden" name="decideParameter" value="DispDet">
<input type="hidden" name="DisplayFlag" value="FromSo">

<!--dont delete above hidden field.It is using in dispatchinfo-->

<div id="div2" style="visibility:visible;Position:Absolute;top:85%">
<Table align="center" width="100%">
<Tr>
	<Td align="center" class="blankcell"><%=taxesDuties_L%></Td>
</Tr>
<Tr align="center"><Td class="blankcell">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("ezListPage(\""+StatusButton+"\")");
	buttonName.add("Remarks");
	buttonMethod.add("showTab(\"2\")");
	//out.println(getButtonStr(buttonName,buttonMethod));

	if(REJECTED || RETURNEDBYCM || RETURNEDBYLF)
	{
		buttonName.add("Reason");
		buttonMethod.add("displayreason()");
 	}
	out.println(getButtonStr(buttonName,buttonMethod));
%>
<% if(!("null".equals(sdHeader.getFieldValueString(0,"BACKEND_ORNO")))){ %>
<% } //paymentdetails.gif%>
</Td>
</Tr>
</Table>
</div>

<%
/*
ResourceBundle rbInco= ResourceBundle.getBundle("EzIncoTerms");
ResourceBundle rbpay= ResourceBundle.getBundle("EzPaymentTerms");
Enumeration incoEnu =rbInco.getKeys();
Enumeration payEnu =rbpay.getKeys();
*/
%>

<%//@ include file="../../../Includes/JSPs/Sales/iNotesValues.jsp" %>
<%--
<div id="div2" style="visibility:hidden;position:absolute;top:10%;left:1%;width:98%">
<Table width="100%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
  <tr align="center">
    <th colspan="2"> <b><%=tecondweb_L%> <%=sdHeader.getFieldValueString(0,"WEB_ORNO")%></b></th>
  </tr>
</Table>
</div>
--%>
<div id="div6" style="overflow:auto;visibility:hidden;position:absolute;top:16%;left:1%;width:100%;height:77%">
<Table align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<tr><th>Remarks</th></tr>
<tr>
<td>
<%
	String t2 =sdHeader.getFieldValueString(0,"TEXT2");
	t2=EzReplace.setNewLine(t2);
	out.println(t2);

%>
</td></tr>
<!--<textarea cols="90" rows="10" style="overflow:auto;border:0" name="generalNotes1" class=txarea readonly><%=sdHeader.getFieldValueString(0,"TEXT2")%></textarea>-->
</table>

<%--
<Table width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

<Tr>
<Th width="25%" align="left"><%=incoter_L%></Th>
<td width="75%">
		<%
		while(incoEnu.hasMoreElements())
		 {
			String s=(String)incoEnu.nextElement();
			if(s.equals(sdHeader.getFieldValueString(0,"INCO_TERMS1")))
			{
				out.println(s+"-->"+rbInco.getString(s));
				break;
			}
		}
	String inco2 = sdHeader.getFieldValueString(0,"INCO_TERMS2") ;
	if( (inco2 == null) || ( ("null").equals(inco2)) )
                       inco2 = "None";
	out.println(inco2);
%>
</td>
</tr>
<Tr>
	<Th align="left"><%=payter_L%></Th>
	<td>
		<%
		while(payEnu.hasMoreElements())
		{
			String s = (String)payEnu.nextElement();

			if(s.equals(sdHeader.getFieldValueString(0,"PAYMENT_TERMS").trim()))
			{
				out.println(s+"-->"+rbpay.getString(s));
				break;
			}
		}%>
	</td>
</tr>
<%
	if(CM || LF || BP)
	{
		String CMNotes = sdHeader.getFieldValueString(0,"TEXT2");
%>
	<Tr>
		<Th align="left" ><%=cmNote_L%></Th>
		 <Td><% CMNotes =EzReplace.setNewLine(CMNotes); out.println(CMNotes);%></Td>
	</tr>
<%
	}
%>
<%
	if(BP || LF)
	{
		String LFNotes = sdHeader.getFieldValueString(0,"TEXT4");
		String BPNotes = sdHeader.getFieldValueString(0,"TEXT3");
%>
	<Tr>
		<Th align="left" ><%=LFNote_L%></Th>
		 <Td><% LFNotes =EzReplace.setNewLine(LFNotes); out.println(LFNotes);%></Td>
	</tr>
	<Tr>
		<Th align="left" ><%=BPNote_L%></Th>
		 <Td><% BPNotes =EzReplace.setNewLine(BPNotes); out.println(BPNotes);%></Td>
	</tr>
<%
	}
%>
<%
	for(int texts=0;texts<HeaderNotes.length;texts++)
	{
%>
<Tr>	
	<Th align="left"  id="<%=HeaderNotesD[texts]%>Th" width="25%"><%=HeaderNotesT[texts]%></Th>
	 <Td width="75%">
		<% 
			HeaderNotes[texts] = ("null".equals(HeaderNotes[texts]) || HeaderNotes[texts] == null)?"None":HeaderNotes[texts];
			HeaderNotes[texts] =EzReplace.setNewLine(HeaderNotes[texts]); out.println(HeaderNotes[texts]);
		%>
	</Td>
</tr>
	<%}%>
</table>
--%>
</div>
<input type="hidden" name="onceSubmit" value=0>
<div id="buttonDiv"  style="visibility:hidden;position:absolute;top:90%;width:100%;left:0%">

<table align="center" width="100%">
<Tr>
<td align="center" class=blankcell valign=center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	buttonMethod.add("showTab(\"1\")");
	out.println(getButtonStr(buttonName,buttonMethod));
%>	
</Td>
</Tr>
</table>
</div>
 </form>
 <Div id="MenuSol"></Div>
</body>
</html>
