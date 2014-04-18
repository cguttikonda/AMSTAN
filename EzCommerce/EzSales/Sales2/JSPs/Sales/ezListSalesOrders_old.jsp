<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iListSalesOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iListSalesOrders.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%

	String backEndOrderNo=null;
	ArrayList dispColumns= new ArrayList();
	ArrayList dispLabels= new ArrayList();
	ArrayList dispSizes= new ArrayList();
	if("'Transfered'".toUpperCase().equals(orderStatus.toUpperCase()))
	{

		//dispColumns.add("WEBORNO");	dispLabels.add(wOrd_L);
		dispColumns.add("SAPNO");	dispLabels.add(saOrdNo_L);
		dispColumns.add("WEBORDATE");	dispLabels.add(ordDate_L);
		dispColumns.add("PONO");	dispLabels.add(poNo_L);
		dispColumns.add("PODATE");	dispLabels.add(poDate_L);
		dispColumns.add("CUSTOMER");	dispLabels.add(cust_L);



		dispSizes.add("'20%' align=left");
		dispSizes.add("'15%' align=left");
		dispSizes.add("'21%' align=left");
		dispSizes.add("'14%' align=center");
		dispSizes.add("'30%' align=left");

	}
	else if("'NEW'".toUpperCase().equals(orderStatus.toUpperCase()))
	{

		dispColumns.add("CHECKBOX");	dispLabels.add("M");
		dispColumns.add("WEBORNO");	dispLabels.add(wOrd_L);
		dispColumns.add("WEBORDATE");	dispLabels.add(wOrdDt_L);
		dispColumns.add("PONO");	dispLabels.add(poNo_L);
		//dispColumns.add("SAPNO");	dispLabels.add(saOrdNo_L);
		//dispColumns.add("STATUS");	//dispLabels.add("Status");
		dispColumns.add("CREATEDBY");	dispLabels.add(creaBy_L);
		dispColumns.add("CUSTOMER");	dispLabels.add(cust_L);

		dispSizes.add("'4%' align=center");
		dispSizes.add("'13%' align=left");
		dispSizes.add("'13%' align=center");
		//dispSizes.add("'21%' align=left");
		dispSizes.add("'13%' align=left");
		dispSizes.add("'13%' align=left");
		dispSizes.add("'23%' align=left");

	}
	else if("'RETTRANSFERED'".equals(orderStatus.toUpperCase()) || "'RETCMTRANSFER'".equals(orderStatus.toUpperCase()) || "'RETTRANSFERED','RETCMTRANSFER'".equals(orderStatus))
		{

			//dispColumns.add("CHECKBOX");//	dispLabels.add("M");
			dispColumns.add("WEBORNO");	dispLabels.add(wOrd_L);
			dispColumns.add("WEBORDATE");	dispLabels.add(wOrdDt_L);
			//dispColumns.add("PONO");		dispLabels.add(poNo_L);
			dispColumns.add("SAPNO");	dispLabels.add(saOrdNo_L);
			//dispColumns.add("STATUS");	//dispLabels.add("Status");
			dispColumns.add("CREATEDBY");	dispLabels.add(creaBy_L);
			dispColumns.add("CUSTOMER");	dispLabels.add(cust_L);

			//dispSizes.add("'4%' align=center");
			dispSizes.add("'13%' align=left");
			dispSizes.add("'13%' align=center");
			//dispSizes.add("'21%' align=left");
			dispSizes.add("'13%' align=left");
			dispSizes.add("'13%' align=left");
			dispSizes.add("'23%' align=left");

	}
	else if("'RETNEW'".toUpperCase().equals(orderStatus.toUpperCase()))
	{

				dispColumns.add("CHECKBOX");	dispLabels.add("M");
				dispColumns.add("WEBORNO");	dispLabels.add(wOrd_L);
				dispColumns.add("WEBORDATE");	dispLabels.add(wOrdDt_L);
				dispColumns.add("PONO");		dispLabels.add(poNo_L);
				//dispColumns.add("SAPNO");	//dispLabels.add(saOrdNo_L);
				//dispColumns.add("STATUS");	//dispLabels.add("Status");
				dispColumns.add("CREATEDBY");	dispLabels.add(creaBy_L);
				dispColumns.add("CUSTOMER");	dispLabels.add(cust_L);

				dispSizes.add("'4%' align=center");
				dispSizes.add("'13%' align=left");
				dispSizes.add("'13%' align=center");
				dispSizes.add("'21%' align=left");
				//dispSizes.add("'13%' align=left");
				dispSizes.add("'13%' align=left");
				dispSizes.add("'23%' align=left");

	}
	else if("All".toUpperCase().equals(orderStatus.toUpperCase()))
	{

		dispColumns.add("WEBORNO");		dispLabels.add(wOrd_L);
		//dispColumns.add("WEBORDATE");	dispLabels.add("Web Order Date");
		dispColumns.add("PONO");		dispLabels.add(poNo_L);
		dispColumns.add("SAPNO");		dispLabels.add(saOrdNo_L);
		dispColumns.add("STATUS");		dispLabels.add(status_L);
		dispColumns.add("CREATEDBY");	dispLabels.add(creaBy_L);
		dispColumns.add("CUSTOMER");	dispLabels.add(cust_L);

		dispSizes.add("'13%' align=left");
		dispSizes.add("'22%' align=left");
		dispSizes.add("'12%' align=left");
		dispSizes.add("'16%' align=left");
		dispSizes.add("'13%' align=left");
		dispSizes.add("'24%' align=left");
	}


	else
	{

		dispColumns.add("WEBORNO");		dispLabels.add(wOrd_L);
		dispColumns.add("WEBORDATE");	dispLabels.add(wOrdDt_L);
		dispColumns.add("PONO");		dispLabels.add(poNo_L);
		dispColumns.add("SAPNO");		dispLabels.add(saOrdNo_L);
		//dispColumns.add("STATUS");		//dispLabels.add("Status");
		dispColumns.add("CREATEDBY");	dispLabels.add(creaBy_L);
		dispColumns.add("CUSTOMER");	dispLabels.add(cust_L);

		dispSizes.add("'13%' align=left");
		dispSizes.add("'13%' align=center");
		dispSizes.add("'21%' align=left");
		dispSizes.add("'13%' align=left");
		dispSizes.add("'13%' align=left");
		dispSizes.add("'27%' align=left");
	}


%>
<html>
<head>
	<Title>List of Sales Orders-Powered by EzCommerce Inc</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<script>

		function selStatus()
		{

			for(i=0;i<document.statusForm.orderStatus.options.length;i++)
			{
				if(document.statusForm.orderStatus.options[i].value.toUpperCase()=="<%=orderStatus1.toUpperCase()%>")
				{	document.statusForm.orderStatus.selectedIndex=i;
					break;
				}
			}
		}

		function fun1()
		{
			document.body.style.cursor="wait"
			document.SOForm.submit();
		}
		function callConfirm()
		{
			document.body.style.cursor="wait"
			document.SOForm.action="../Sales/ezCreditDSS.jsp";
			document.SOForm.submit();
		}




		var status=null;
		var orderType=null;
		function setBack()
		{
			document.location.href="../Misc/ezWelcome.jsp";
		}

		function chkDelSumbit(obj)
		{

			var chkbox = document.SOForm.chk.length;

			chkCount=0
			if(isNaN(chkbox))
			{
				if(document.SOForm.chk.checked)
				{
					chkCount++;
				}
			}
			else
			{
				for(a=0;a<chkbox;a++)
				{
					if(document.SOForm.chk[a].checked)
					{
						chkCount++;
						if(parseInt(chkCount) == parseInt(2) )
							break;
					}
				}
			}

			if(chkCount == 0)
			{
				if(obj=="Edit")
				{
					alert("<%=plzChkOrderEdit_A%>");
				}else
				{
					alert("<%=plzChkOrderDel_A%>");
				}
				return false;
			}else if(chkCount > 1)
			{
				if(obj=="Edit")
				{
					alert("Please check only one order to Edit");
					return false;
				}
			}


			return true;
		}

		function ezOrderDel()
		{

			if(chkDelSumbit("Del"))
			{
				if(confirm("<%=ordDelMsg_A%>"))
				{
					if(document.SOForm.onceSubmit.value!=1){
   					 document.SOForm.onceSubmit.value=1
  					 document.body.style.cursor="wait"
					 document.SOForm.action="../Sales/ezDeleteSalesPer.jsp"
					 document.SOForm.submit();
                                       }
				}
			}
		}

		function ezOrderEdit(type)
		{
			if(chkDelSumbit("Edit"))
			{
				var chkbox = document.SOForm.chk.length;
				if(isNaN(chkbox))
				{
					if(document.SOForm.chk.checked)
					{
						aa=document.SOForm.chk.value
						aa1=aa.split(",");
						if(type=="RET")
							funShowEditReturn(aa1[0],aa1[1],aa1[2])
						else
							funShowEdit(aa1[0],aa1[1],aa1[2])
					}
				}
				else
				{
					for(a=0;a<chkbox;a++)
					{
						if(document.SOForm.chk[a].checked)
						{
							aa=document.SOForm.chk[a].value

							aa1=aa.split(",");

							if(type=="RET")
								funShowEditReturn(aa1[0],aa1[1],aa1[2])
							else
								funShowEdit(aa1[0],aa1[1],aa1[2])
						}
					}
				}

			}

		}
//********************************************************************




		function funShowEdit(webOrNo,soldTo,sysKey)
		{
  			 document.body.style.cursor="wait"
			 document.SOForm.webOrNo.value=webOrNo
			 document.SOForm.soldTo.value=soldTo
			 document.SOForm.sysKey.value=sysKey
			 document.SOForm.pageUrl.value="EditOrder"
			 //document.SOForm.target = "_parent"
			 document.SOForm.action="../Misc/ezListWaitSalesDisplay.jsp" ;
			 document.body.style.cursor="wait"
			 document.SOForm.submit();

		}

		function funShowEditReturn(webOrNo,soldTo,sysKey)
		{
			 document.body.style.cursor="wait"
			 document.SOForm.webOrNo.value=webOrNo
			 document.SOForm.soldTo.value=soldTo
			 document.SOForm.sysKey.value=sysKey
			 //document.SOForm.target = "_parent"
			 document.SOForm.action="../Misc/ezListWaitReturnSalesDisplay.jsp";
			 document.body.style.cursor="wait"
			 document.SOForm.submit();

		}
		function funShowEditSO(SONumber,SoldTo)
		{
			document.SOForm.SONumber.value=SONumber
			document.SOForm.soldTo.value=SoldTo
			document.SOForm.pageUrl.value="BackOrder"
			//document.SOForm.target = "_parent"
			document.SOForm.action="../Misc/ezWaitSalesDisplay.jsp?SONumber=" + SONumber +"&SoldTo="+ SoldTo +"&PODATE="+ document.SOForm.poDate.value +"&netValue="+document.SOForm.poDate.value + "&orderType=" + orderType +"&status=<%=orderStatus%>&newFilter=" + document.SOForm.newFilter.value;
			document.body.style.cursor="wait"
			document.SOForm.submit();

		}

		function funShowEditMulti(SoNo,soldTo,sysKey)
		{

			urlStr = "ezSelectSalesOrders.jsp?webOrNo=" + SoNo+"&soldTo="+soldTo+"&sysKey="+sysKey+"&status=<%=orderStatus%>&newFilter=<%=newFilter%>";
			aa=showModalDialog(urlStr,SoNo,'center:yes;dialogWidth:15;dialogHeight:12;status:no;minimize:yes')
			if (aa!=null)
			{
				funShowEditSO(aa,soldTo)
			}
		}
		</script>
	</head>

<body   onLoad="scrollInit()" onresize="scrollInit()" scroll=no>



<form name=SOForm method="post" action="../Sales/ezEditSalesOrder.jsp">
<input type=hidden name="newFilter"  value="<%=newFilter%>">
<input type="hidden" name="SONumber" >
<input type="hidden" name="soldTo" >
<input type="hidden" name="poDate" >
<input type="hidden" name="sysKey" >
<input type="hidden" name="Back">
<input type="hidden" name="onceSubmit" value=0>
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
<td height="35" class="displayheaderback" align=center width="100%">
<%
String statusHeader=null;
if("All".equals(orderStatus)){

	statusHeader="All";
}else{

	for(int d=0;d<statKeys.size();d++)
	{
		String temp1=(String)(statKeys.get(d));
		if(temp1.toUpperCase().equals(orderStatus.toUpperCase()))
		{
			statusHeader=(String)statDesc.get(d);
			break;
		}
	}
}
if("Purchase Orders".equals(statusHeader))
	out.println(acceptOrdLi_L);
else
	out.println(statusHeader +"&nbsp;"+ salordli_L);	
%>
</Td>
</Tr>
</Table>
<%

		int count1=retobj.getRowCount();

		if(count1==0)
		{
			out.println("<Br><Br><Br><Br>");
			out.println("<Table align=center  border=0><Tr>");
			out.println("<Td  align=center class=displayalert>");

			if("All".equals(statusHeader))
				out.println(nosallist_L+".</Td></Tr></Table>");
			else
			{
				out.println(no_L + "&nbsp;"+  statusHeader +"&nbsp;"+ orlist_L+"</Th></Tr></Table>");
			}
		}
		else
		{

			//this code is for globalization

			Vector types = new Vector();
			types.addElement("date");
			types.addElement("date");
			EzGlobal.setColTypes(types);

			Vector names = new Vector();
			names.addElement("ORDER_DATE");
			names.addElement("STATUS_DATE");
			EzGlobal.setColNames(names);

			ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(retobj);


	%>

			<Div id="theads">
				<Table  width="95%"  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
				<Tr align="center" valign="middle">
			      <%
				for(int k=0;k<dispColumns.size();k++)
				{
					out.println("<Th width=" + dispSizes.get(k) + "align=center>" + dispLabels.get(k)  + "</Th>");
				}
				%>
				</Tr>

			       </Table>
			</Div>
			<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:60%;left:2%">
			<Table id="InnerBox1Tab" align=center  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
			<%
					String wdateString=null;
					String lfdateString=null;
					Hashtable myValues= new Hashtable();

					int wl=0;
					int lf=0;
					for(int rCount=0;rCount<count1;rCount++)
					{

						 backEndOrderNo=retobj.getFieldValueString(rCount,"BACKEND_ORNO");
						 backEndOrderNo=("null".equals(backEndOrderNo))?"N/A": backEndOrderNo;
						 wdateString=ret.getFieldValueString(rCount,"ORDER_DATE");
						 lfdateString=ret.getFieldValueString(rCount,"STATUS_DATE");


						wl=wdateString.indexOf(" ");
						lf=lfdateString.indexOf(" ");


						 wdateString=(wl==-1)?ret.getFieldValueString(rCount,"ORDER_DATE"):" ";
						 lfdateString=(lf==-1)?ret.getFieldValueString(rCount,"STATUS_DATE"):" ";

						String anchBegin="";
						String soldtoWeb = retobj.getFieldValueString(rCount,"WEB_ORNO");
						String soldtocode =retobj.getFieldValueString(rCount,"SOLD_TO_CODE");
						String soldtoarea=retobj.getFieldValueString(rCount,"SYSKEY");
						String retSatus = retobj.getFieldValueString(rCount,"STATUS");
						orderStatus =orderStatus.toUpperCase();

						if("'RETNEW'".equals(orderStatus) || "RETNEW".equals(retSatus))
						{
							anchBegin="<a href=\"JavaScript:funShowEditReturn('" + soldtoWeb + "','"+soldtocode+"','"+soldtoarea+"')\" style=\"cursor:hand\"  >";

						}else{
							if("'RETTRANSFERED'".equals(orderStatus) || "'RETCMTRANSFER'".equals(orderStatus) || "'RETTRANSFERED','RETCMTRANSFER'".equals(orderStatus) || "RETTRANSFERED".equals(retSatus) || "RETCMTRANSFER".equals(retSatus))
							{
								anchBegin="<a href=\"JavaScript:funShowEditReturn('" + soldtoWeb + "','"+soldtocode+"','"+soldtoarea+"')\" style=\"cursor:hand\"  >";
							}else{
								anchBegin="<a href=\"JavaScript:funShowEdit('" + soldtoWeb + "','"+soldtocode+"','"+soldtoarea+"')\" style=\"cursor:hand\"  >";
							}
						}

						String anchEnd="</a>";


						String anchBeginSO="<a href=\"JavaScript:funShowEditSO('" +backEndOrderNo + "','" + retobj.getFieldValueString(rCount,"SOLD_TO_CODE") + "')\" style=\"cursor:hand\"  >";
						String anchBeginMulti ="<a href=\"JavaScript:funShowEditMulti('" +soldtoWeb +"','"+soldtocode+"','"+soldtoarea+"')\">";

						if("'TRANSFERED'".toUpperCase().equals(orderStatus))
						{
							 if("Multi Orders".equalsIgnoreCase(backEndOrderNo))
							{
								myValues.put("SAPNO",anchBeginMulti + backEndOrderNo + anchEnd);
							}else
							{
								try{
										myValues.put("SAPNO",anchBeginSO + String.valueOf(Integer.parseInt(backEndOrderNo)) + anchEnd);
									}catch(Exception e)
									{
										myValues.put("SAPNO",anchBeginSO + backEndOrderNo + anchEnd);
									}
							}
								myValues.put("PONO",anchBegin +  retobj.getFieldValueString(rCount,"PO_NO") + anchEnd);
								myValues.put("PONO",anchBegin +  retobj.getFieldValueString(rCount,"PO_NO") + anchEnd);
						}
						else
						{
							
							try{
								myValues.put("SAPNO", String.valueOf(Integer.parseInt(backEndOrderNo)));
							  }catch(Exception e)
							  {
								myValues.put("SAPNO", backEndOrderNo);
							  }
						  myValues.put("PONO",retobj.getFieldValueString(rCount,"PO_NO"));
						}

						 myValues.put("WEBORNO",anchBegin + soldtoWeb + anchEnd);
						 myValues.put("STATUS",displayStatus.get(retSatus));
						 myValues.put("WEBORDATE",wdateString);
						 myValues.put("CREATEDBY",retobj.getFieldValueString(rCount,"CREATEDBY"));
						 myValues.put("PODATE",retobj.getFieldValueString(rCount,"RES1"));
						 String tempCust=retobj.getFieldValueString(rCount,"SOTO_ADDR1");
						 tempCust=(tempCust==null) ||"null".equals(tempCust) || tempCust.length() < 22?tempCust:tempCust.substring(0,20);
						 myValues.put("CUSTOMER",tempCust);
						 myValues.put("CHECKBOX","<input type=checkbox name=chk value=\"" + soldtoWeb +","+soldtocode+","+soldtoarea+"\">");
			%>
						<Tr align=center>
						<%
						for(int k=0;k<dispColumns.size();k++)
						{
							out.println("<Td width=" + dispSizes.get(k) + ">" + myValues.get(dispColumns.get(k))  + "&nbsp;</Td>");
						}
						%>
						</Tr>
<%
					}
%>
		</Table>
		</Div>
					
<%
	}
%>
	<div id="buttonDiv" align=center style="position:absolute;left:0%;width:100%;top:88%">
	
	
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	if("'NEW'".toUpperCase().equals(orderStatus.toUpperCase()) && retobj.getRowCount() >0)
	{
		buttonName.add("Edit");
		buttonMethod.add("ezOrderEdit(\"NEW\")");
		buttonName.add("Delete");
		buttonMethod.add("ezOrderDel()");
	}else if("'RETNEW'".toUpperCase().equals(orderStatus.toUpperCase()) && retobj.getRowCount() >0)
	{
		buttonName.add("Edit");
		buttonMethod.add("ezOrderEdit(\"RET\")");
		buttonName.add("Delete");
		buttonMethod.add("ezOrderDel()");
		
	}
	if(searchType==null || "null".equals(searchType))
	{
		buttonName.add("Back");
		buttonMethod.add("setBack()");
	}
	else
	{
		buttonName.add("Back");
		buttonMethod.add("history.back()");
	}
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
	<input type="hidden" name="ordType" value="<%=orderStatus%>">
	<input type="hidden" name="webOrNo" >
	<input type="hidden" name="pageUrl">

</form>
<form name=statusForm method="post" action="ezListSalesOrders.jsp">
	<input type="hidden" name="refDocType" value="<%=refDocType%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
