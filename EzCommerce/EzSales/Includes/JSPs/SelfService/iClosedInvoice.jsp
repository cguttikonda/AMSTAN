<%
	if(base!=null && !"null".equals(base) && !"".equals(base))
	{
		ReturnObjFromRetrieve SeqInv = null;
		EzCustomerParams ioparams = new EzCustomerParams();
		ezc.customer.invoice.params.EzcCustomerInvoiceParams newParams=new  		ezc.customer.invoice.params.EzcCustomerInvoiceParams();
		EziCustomerInvoiceParams ecip = new EziCustomerInvoiceParams();
		

		int ffy=Integer.parseInt(fd.substring(6,10))-1900;
		int ffd=Integer.parseInt(fd.substring(3,5));
		int ffm=Integer.parseInt(fd.substring(0,2))-1;
		int tty=Integer.parseInt(td.substring(6,10))-1900;
		int ttd=Integer.parseInt(td.substring(3,5));
		int ttm=Integer.parseInt(td.substring(0,2))-1;
		Date fromDate = new Date(ffy,ffm,ffd);
		Date toDate = new Date(tty,ttm,ttd);
	 	ecip.setFromDate(fromDate);
		ecip.setToDate(toDate);
		ecip.setInvFlag("C");
		ecip.setSelection(billto);
		ecip.setCustomer(billto);
		
		
		newParams.createContainer();
		newParams.setObject(ioparams);
		newParams.setObject(ecip);
		Session.prepareParams(newParams);
		SeqInv = (ReturnObjFromRetrieve) SalesInvManager.getCustomerInvoices(newParams);
		
		lineItems= (ReturnObjFromRetrieve)SeqInv.getFieldValue("LINEITEMS");
		
		dlineItems=new ReturnObjFromRetrieve();
		String objColumns[]={"BILLINGDOCUMENTNO","SAPINVOICENO","DELIVERYDOCUMENTNO","INVOICEDATE","DUEDATE","INVOICEVALUE"};						
		dlineItems.addColumns(objColumns);
		
		

		if (lineItems!=null)
		{
			rowno = lineItems.getRowCount();
			int invcount = 0;
			/*for (int i= 0; i<rowno ; i++)
			{
				////if("RV".equals(lineItems.getFieldValueString(i,"DocType")) && lineItems.getFieldValueString(i,"BusArea").startsWith("F"))
						invcount++;

			}*/
			if (rowno > 0)
			{
%>
				<Div id="theads">
				<Table width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
				<Tr>
					<Th width="25%"><%=billDocNo_L%></Th>
					<Th width="25%"><%=sapInvNo_L%></Th>
					<Th width="25%"><%=invDate_L%></Th>
					<Th width="25%"><%=invVal_L%>[<%= lineItems.getFieldValueString(0,"Currency")%>]</Th>
				</Tr>
				</Table>
				</Div>
				<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:35%;left:2%">
				<Table id="InnerBox1Tab"  align=center  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
				ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();
				String invNum = null;
				String custInvNum = null;
				String custbillNum=null;
				String invAm = null;
				double total=0;
				Date postingDate=null;
				Date blineDate=null;
				for (int i= 0; i<rowno ; i++)
				{

					///if("RV".equals(lineItems.getFieldValueString(i,"DocType")) && lineItems.getFieldValueString(i,"BusArea").startsWith("F"))
					//{

					postingDate=(Date)lineItems.getFieldValue(i,"PstngDate");
					blineDate=(Date)lineItems.getFieldValue(i,"BlineDate");
					invNum = lineItems.getFieldValueString(i,"DocNo");
					custInvNum = lineItems.getFieldValueString(i,"AllocNmbr").trim();
					custbillNum =  lineItems.getFieldValueString(i,"RefDoc").trim();
					invAm = lineItems.getFieldValueString(i,"Amount");
					dlineItems.setFieldValue("BILLINGDOCUMENTNO",custbillNum);
					dlineItems.setFieldValue("SAPINVOICENO",invNum);
					dlineItems.setFieldValue("DELIVERYDOCUMENTNO"," ");
					dlineItems.setFieldValue("INVOICEDATE",FormatDate.getStringFromDate(postingDate,forkey,FormatDate.MMDDYYYY));
					dlineItems.setFieldValue("DUEDATE"," ");
					dlineItems.setFieldValue("INVOICEVALUE",invAm);
					dlineItems.addRow();
%>					<Tr>
						<Td align="left" width="25%"><a href='JavaScript:pageSubmit("<%=custbillNum%>","<%=invNum%>","<%=FormatDate.getStringFromDate(postingDate,forkey,FormatDate.MMDDYYYY)%>")' <%=statusbar%> >
<%
					try{
						out.println(Integer.parseInt(custbillNum));
					}catch(Exception e){
						out.println(custbillNum);
					}
%>
						</a></Td>
						<Td align="left" width="25%">
<%					try{
%>						<%=Integer.parseInt(invNum)%>
<%					}catch(Exception e){
%>
						<%=invNum%>
<%					}
%>						&nbsp;</Td>
						<Td align="center" width="25%"><%=FormatDate.getStringFromDate(postingDate,".",FormatDate.DDMMYYYY)%></Td>
						<Td width="25%" align="right"><%=myFormat.getCurrencyString(invAm)%>&nbsp;</Td>
					</Tr>
<%
					total=total+Double.parseDouble(invAm);
					///}
				}
%>
				</Table>
				</Div>
				<Div id="showTot" style="visibility:hidden">
				<Table align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="99%">
					<Tr>
						<Td colspan=2 class=blankcell>&nbsp;</Td>
						<Td width=50% class=blankcell>
							<Table align=center width=100% border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="90%">
							<Tr>
								<Th width="25%" align=center><%=tot_L%></Th>
								<Td width="25%" align=right><%=myFormat.getCurrencyString(total)%>&nbsp;</Td>
							</Tr>
							</Table>
						</Td>
						</Tr>
				</Table>
				</Div>
<%			}else{
%>
			<Br><Br><Br>
			<Table align="center">
			<Tr>
				<Td class="displayalert" align="center"><%=noClosedInv_L%>.</Td>
			</Tr>
			</Table>
<%			}
		}
	}else{
%>
		<Br><Br><Br>
		<Table align="center">
		<Tr>
			<Td class="displayalert" align="center"><%=selectLable%></Td>
		</Tr></Table>
<%	}
%>
