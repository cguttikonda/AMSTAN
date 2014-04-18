
<%

//String curr = request.getParameter("DocCurrency");

/*

for(int h=0;h<lineDocs.length;h++)
{
	if(!check.contains(lineDocs[h]) )
	response.sendRedirect("../../../SalesBulk1/JSPs/Sales/ezSalesDetailsError.jsp");
}


for(int i=0;i<check.size();i++)
{
	if(!"YES".equalsIgnoreCase(SAPnumber))
	break;

	EzBapisdheadStructure orderHeaderChangeSim = new EzBapisdheadStructure();
 	EzBapisdh1xStructure orderHeaderxChangeSim = new EzBapisdh1xStructure();	
	EzBapipartnrTable orderPartnersChangeSim = new EzBapipartnrTable();

	EzBapipartnrTableRow partnersRowChangeSim = null;
 	EzBapiiteminTable iteminTableChangeSim = new EzBapiiteminTable();
	EzBapiiteminTableRow iteminRowChangeSim = null;
	EzBapiitemexTable iteminTablexChangeSim = new EzBapiitemexTable();
	EzBapiitemexTableRow iteminTablexRowhangeSim = null;
	EzBapiscondTable condTableChangeSim = new EzBapiscondTable();
	EzBapiscondTableRow condTableRowChangeSim = null;
	EzBapicondxTable condxTableChangeSim = new EzBapicondxTable();
	EzBapicondxTableRow condTablexRowChangeSim = null;
	EzBapischdlTable deliveryScheduleTableChangeSim = new EzBapischdlTable();
	EzBapischdlTableRow dSTableRowChangeSim = null;
	EzBapischdlxTable deliverySchedulexTableChangeSim = new EzBapischdlxTable();
	EzBapischdlxTableRow dSTablexRowChangeSim = null;
	EzBapistextTable ezctextTableSim = new EzBapistextTable();
	EzBapistextTableRow ezctextRowSim = null;
///**************************started setting header values ***********************************
	
	orderHeaderChangeSim.setDlvBlock("02");
	orderHeaderxChangeSim.setUpdateflag("D");
	
    	EzcSalesOrderParams  ezcSalesOrderParamsChangeSim = new EzcSalesOrderParams();
       	EziSalesOrderChangeParams escpChangeSim = new EziSalesOrderChangeParams();

	escpChangeSim.setOrderHeaderIn(orderHeaderChangeSim);
	escpChangeSim.setOrderHeaderInx(orderHeaderxChangeSim);
	escpChangeSim.setOrderItemsIn(iteminTableChangeSim);
	escpChangeSim.setOrderItemsOut(iteminTablexChangeSim);
	escpChangeSim.setOrderPartners(orderPartnersChangeSim);
	escpChangeSim.setOrderConditions(condTableChangeSim);	
	escpChangeSim.setOrderConditionsx(condxTableChangeSim);
	escpChangeSim.setOrderDelSchedule(deliveryScheduleTableChangeSim);
	escpChangeSim.setOrderDelSchedulex(deliverySchedulexTableChangeSim);
	escpChangeSim.setOrderText(ezctextTableSim);
	escpChangeSim.setSalesDocument(String.valueOf(check.elementAt(i)));
	escpChangeSim.setSimulation("X");

 	 ezcSalesOrderParamsChangeSim.setObject(escpChangeSim);

        	Session.prepareParams(ezcSalesOrderParamsChangeSim);
	try{
		EzoSalesOrderChange ioParamsChangeSim =(EzoSalesOrderChange) EzSalesOrderManager.ezChangeWebSalesOrder(ezcSalesOrderParamsChangeSim); 

		for(int pc=0;pc<ioParamsChangeSim.getRowCount();pc++)
		{
			ErrorType =ioParamsChangeSim.getFieldValueString(pc,"TYPE");
			ErrorMessage = ioParamsChangeSim.getFieldValueString(pc,"MESSAGE");
			if("E".equalsIgnoreCase(ErrorType))
			{
				SAPnumber="NO";
				break;
			}
		}
	}catch(Exception e)
	{
		SAPnumber="NO";
	}
	
}

*/

System.out.println("sap number ========="+SAPnumber);

if("YES".equalsIgnoreCase(SAPnumber))
{
	//for(int i=0;i<check.size();i++)
	//{
		EzBapisdheadStructure orderHeaderChange = new EzBapisdheadStructure();
	 	EzBapisdh1xStructure orderHeaderxChange = new EzBapisdh1xStructure();	
		EzBapipartnrTable orderPartnersChange = new EzBapipartnrTable();

		EzBapipartnrTableRow partnersRowChange = null;
 		EzBapiiteminTable iteminTableChange = new EzBapiiteminTable();
		EzBapiiteminTableRow iteminRowChange = null;
		EzBapiitemexTable iteminTablexChange = new EzBapiitemexTable();
		EzBapiitemexTableRow iteminTablexRowhange = null;
		EzBapiscondTable condTableChange = new EzBapiscondTable();
		EzBapiscondTableRow condTableRowChange = null;
		EzBapicondxTable condxTableChange = new EzBapicondxTable();
		EzBapicondxTableRow condTablexRowChange = null;
		EzBapischdlTable deliveryScheduleTableChange = new EzBapischdlTable();
		EzBapischdlTableRow dSTableRowChange = null;
		EzBapischdlxTable deliverySchedulexTableChange = new EzBapischdlxTable();
		EzBapischdlxTableRow dSTablexRowChange = null;
		EzBapistextTable ezctextTable = new EzBapistextTable();
		EzBapistextTableRow ezctextRow = null;

///**************************started setting header values ***********************************
	
		orderHeaderChange.setDlvBlock("02");
		orderHeaderxChange.setUpdateflag("D");
	       
	      /*
	       if(CM )
		{
			orderHeaderxChange.setUpdateflag("D");
			
			
			for(int k=0;k<lineDocs.length;k++)
			{
				if( check.elementAt(i).equals(lineDocs[k]) )
				{

					java.math.BigInteger line = new java.math.BigInteger(lineItems[k]);
					iteminRowChange = new EzBapiiteminTableRow();
					iteminTablexRowhange = new EzBapiitemexTableRow();

					iteminRowChange.setItmNumber(line);
					iteminTablexRowhange.setItmNumber(line);

					iteminTableChange.appendRow(iteminRowChange);
					iteminTablexChange.appendRow(iteminTablexRowhange);
				}
			}



		}else
		{
			orderHeaderxChange.setUpdateflag("U");
		} */
	
    		EzcSalesOrderParams  ezcSalesOrderParamsChange = new EzcSalesOrderParams();
	       	EziSalesOrderChangeParams escpChange = new EziSalesOrderChangeParams();

		escpChange.setOrderHeaderIn(orderHeaderChange);
		escpChange.setOrderHeaderInx(orderHeaderxChange);
		escpChange.setOrderItemsIn(iteminTableChange);
		escpChange.setOrderItemsOut(iteminTablexChange);
		escpChange.setOrderPartners(orderPartnersChange);
		escpChange.setOrderConditions(condTableChange);	
		escpChange.setOrderConditionsx(condxTableChange);
		escpChange.setOrderDelSchedule(deliveryScheduleTableChange);
		escpChange.setOrderDelSchedulex(deliverySchedulexTableChange);
		escpChange.setOrderText(ezctextTable);
				
		escpChange.setSalesDocument(backEndNo); // backEnd number
		
		System.out.println("backEndno======="+backEndNo);
		
		escpChange.setSimulation(" ");

	 	 ezcSalesOrderParamsChange.setObject(escpChange);

	        	Session.prepareParams(ezcSalesOrderParamsChange);
		try{
		        System.out.println("before delete order=====");
		        
			EzoSalesOrderChange ioParamsChange =(EzoSalesOrderChange) EzSalesOrderManager.ezChangeWebSalesOrder(ezcSalesOrderParamsChange); 
			
			System.out.println("after delete order=====");

			for(int pc=0;pc<ioParamsChange.getRowCount();pc++)
			{
				ErrorType =ioParamsChange.getFieldValueString(pc,"TYPE");
				ErrorMessage = ioParamsChange.getFieldValueString(pc,"MESSAGE");
				if("E".equalsIgnoreCase(ErrorType))
				{
					SAPnumber="NO";
					break;
				}
			}
		}catch(Exception e)
				{
					SAPnumber="NO";
		} 

	//}
}

%> 
