<%@ page import="ezc.ezparam.*"%>
<%@ page import = "ezc.ezsap.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*,java.text.*" %>
<%@ include file="../../../Includes/JSPs/Lables/iListSalesOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iListSalesOrders.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>


<%
	out.println("<?xml version=\"1.0\"?>");		
	out.println("<rows>");

	String backEndOrderNo=null;
	ArrayList dispColumns= new ArrayList();
	ArrayList dispLabels= new ArrayList();
	
	if("'Transfered'".toUpperCase().equals(orderStatus.toUpperCase()))
	{

		//dispColumns.add("WEBORNO");	dispLabels.add(wOrd_L);
		dispColumns.add("SAPNO");	dispLabels.add(saOrdNo_L);
		dispColumns.add("WEBORDATE");	dispLabels.add(ordDate_L);
		dispColumns.add("PONO");	dispLabels.add(poNo_L);
		dispColumns.add("PODATE");	dispLabels.add(poDate_L);
		dispColumns.add("CUSTOMER");	dispLabels.add(cust_L);



		

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

		

	}
	else if("'RETTRANSFERED'".equals(orderStatus.toUpperCase()) || "'RETCMTRANSFER'".equals(orderStatus.toUpperCase()) || "'RETTRANSFERED','RETCMTRANSFER'".equals(orderStatus))
		{

			//dispColumns.add("CHECKBOX");  //dispLabels.add("M");
			dispColumns.add("WEBORNO");	dispLabels.add(wOrd_L);
			dispColumns.add("WEBORDATE");	dispLabels.add(wOrdDt_L);
			//dispColumns.add("PONO");	dispLabels.add(poNo_L);
			dispColumns.add("SAPNO");	dispLabels.add(saOrdNo_L);
			//dispColumns.add("STATUS");	//dispLabels.add("Status");
			dispColumns.add("CREATEDBY");	dispLabels.add(creaBy_L);
			dispColumns.add("CUSTOMER");	dispLabels.add(cust_L);

			

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

		
	}
	String forkey 	= (String)session.getValue("formatKey");		
	if(forkey==null) forkey="/";
			
	//ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	int count1=retobj.getRowCount();
	if(count1>0)
	{
		Vector types = new Vector();
		types.addElement("date");
		types.addElement("date");
		EzGlobal.setColTypes(types);

		Vector names = new Vector();
		names.addElement("ORDER_DATE");
		names.addElement("STATUS_DATE");
		EzGlobal.setColNames(names);
		
		ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal(retobj);

		
		String wdateString=null;
		String lfdateString=null;
		Hashtable myValues= new Hashtable();

		int wl=0;
		int lf=0;
		

		//out.println("retobj. "+retobj.toEzcString());
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
			
			wdateString = wdateString.replace('.','/');

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
			 //myValues.put("WEBORDATE",formatDate.getStringFromDate(wdateString,forkey,formatDate.MMDDYYYY));
			 myValues.put("WEBORDATE",wdateString);
			 myValues.put("CREATEDBY",retobj.getFieldValueString(rCount,"CREATEDBY"));
			 myValues.put("PODATE",retobj.getFieldValueString(rCount,"RES1"));
			 String tempCust=retobj.getFieldValueString(rCount,"SOTO_ADDR1");
			 tempCust=(tempCust==null) ||"null".equals(tempCust) || tempCust.length() < 22?tempCust:tempCust.substring(0,20);
			 myValues.put("CUSTOMER",tempCust);
			 myValues.put("CHECKBOX","<input type='checkbox' name='chk' value=\"" + soldtoWeb +","+soldtocode+","+soldtoarea+"\"></input>");
			
			out.println("<row id='"+ soldtoWeb +","+soldtocode+","+soldtoarea+"'>");

			for(int k=0;k<dispColumns.size();k++)
			{
				if( (searchType == null || "null".equals(searchType)) && k==1)
				{
					out.println("<cell><![CDATA[<nobr>"+myValues.get(dispColumns.get(k))+"</nobr>]]></cell>");				
				}
				else if((searchType != null || !"null".equals(searchType)) && k==0)
				{
					out.println("<cell><![CDATA[<nobr>"+myValues.get(dispColumns.get(k))+"</nobr>]]></cell>");				
				}
				else
				{
					out.println("<cell>"+myValues.get(dispColumns.get(k))+"</cell>");
				}	
			}
			out.println("</row>");
		}

					

	}		
	
	System.out.println("orderStatus  "+orderStatus);
	System.out.println("orderByMaterial   "+orderByMaterial);
	System.out.println("newFilter  "+newFilter);
	System.out.println("searchTypesearchTypesearchTypesearchTypesearchType  "+searchType);
	System.out.println("refDocType  "+refDocType);
	System.out.println("searchPatern   "+request.getParameter("searchPatern"));
	
	
	out.println("</rows>");
	
	
	
%>
<Div id="MenuSol"></Div>