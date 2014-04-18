
<%
  
        String curr = editSalVal.getDocCurrency();
     
        ReturnObjFromRetrieve retSchChanges=(ReturnObjFromRetrieve) session.getValue("EzDeliveryLines");	
        
	EzBapisdheadStructure orderHeaderChangeSim = new EzBapisdheadStructure();
 
	EzBapisdh1xStructure orderHeaderxChangeSim = new EzBapisdh1xStructure();	
	EzBapipartnrTable orderPartnersChangeSim = new EzBapipartnrTable();

	EzBapipartnrTableRow partnersRowChangeSim = null;
 
	EzBapiiteminTable iteminTableChangeSim = new EzBapiiteminTable();
	EzBapiiteminTableRow iteminRowChangeSim = null;

	EzBapiitemexTable iteminTablexChangeSim 	= new EzBapiitemexTable();
	EzBapiitemexTableRow iteminTablexRowhangeSim 	= null;

	EzBapiscondTable condTableChangeSim 		= new EzBapiscondTable();
	EzBapiscondTableRow condTableRowChangeSim 	= null;

	EzBapicondxTable condxTableChangeSim 		= new EzBapicondxTable();
	EzBapicondxTableRow condTablexRowChangeSim 	= null;

	EzBapischdlTable deliveryScheduleTableChangeSim = new EzBapischdlTable();
	EzBapischdlTableRow dSTableRowChangeSim 	= null;

	EzBapischdlxTable deliverySchedulexTableChangeSim = new EzBapischdlxTable();
	EzBapischdlxTableRow dSTablexRowChangeSim 	= null;

	EzBapistextTable ezctextTableSim = new EzBapistextTable();
	EzBapistextTableRow ezctextRowSim = null;

	orderHeaderChangeSim.setDlvBlock("02");
	orderHeaderChangeSim.setIncoterms1(editSalVal.getIncoTerms1());
	orderHeaderChangeSim.setIncoterms2(editSalVal.getIncoTerms2());
	orderHeaderChangeSim.setPmnttrms(paymentterms);	
	orderHeaderxChangeSim.setUpdateflag("U");

	String[] notesAll = new String[]{generalNotes,packingInstructions,labelInstructions,inspectionClauses,handlingSpecifications,regulatoryRequirments,documentsRequired,others};
	String notesHId[] = new String[]{"Z013","0010","0003","Z014","Z011","Z012","0006","0015"};

	for(int j=0;j<notesAll.length;j++)
	{
		if(!"None".equals(notesAll[j]) )
		{
			EzStringTokenizer notesAllSt = new EzStringTokenizer(notesAll[j],"\n");
			int notesAllCt = notesAllSt.getTokens().size();

			if(notesAllCt == 0)
			{
				String chkLin = notesAll[j];
				if(chkLin.length() >130)
				{
					int len =(int)Math.ceil(chkLin.length()/130);
					for(int l=0;l<len;l++)
					{
						String cutLen = "";
						try{
							cutLen = chkLin.substring(130*l,130*(l+1));
						}catch(Exception e){cutLen=chkLin.substring(130*l,chkLin.length());}

						ezctextRowSim = new EzBapistextTableRow();
						ezctextRowSim.setItmNumber(new java.math.BigInteger("0"));
						ezctextRowSim.setDocNumber(backEndNo);
						System.out.println("09090909090909090900"+backEndNo);
						ezctextRowSim.setTextId(notesHId[j]);
						ezctextRowSim.setLanguage("E");
						ezctextRowSim.setTextLine(cutLen);
						ezctextRowSim.setColFormat("*");
						ezctextRowSim.setFunction("002");
						ezctextTableSim.appendRow(ezctextRowSim);
					}
				}else
				{
					ezctextRowSim = new EzBapistextTableRow();
					ezctextRowSim.setItmNumber(new java.math.BigInteger("0"));
					ezctextRowSim.setDocNumber(backEndNo);
					System.out.println("09090909090909090900"+backEndNo);
					ezctextRowSim.setTextId(notesHId[j]);
					ezctextRowSim.setLanguage("E");
					ezctextRowSim.setTextLine(chkLin);
					ezctextRowSim.setColFormat("*");
					ezctextRowSim.setFunction("002");
					ezctextTableSim.appendRow(ezctextRowSim);
				}
	
			}else
			{
				for(int linall=0;linall<notesAllCt;linall++)
				{	
					String chkLin = (String)notesAllSt.getTokens().elementAt(linall);
					if(chkLin.length() >130)
					{
						int len =(int)Math.ceil(chkLin.length()/130);
						for(int l=0;l<len;l++)
						{
							String cutLen = "";
							try{
								cutLen = chkLin.substring(130*l,130*(l+1));
							}catch(Exception e){cutLen=chkLin.substring(130*l,chkLin.length());}

							ezctextRowSim = new EzBapistextTableRow();
	
							ezctextRowSim.setItmNumber(new java.math.BigInteger("0"));
							ezctextRowSim.setDocNumber(backEndNo);
							ezctextRowSim.setTextId(notesHId[j]);
							ezctextRowSim.setLanguage("E");
							ezctextRowSim.setTextLine(cutLen);
							ezctextRowSim.setColFormat("*");
							ezctextRowSim.setFunction("002");
							System.out.println("09090909090909090900"+backEndNo);
							ezctextTableSim.appendRow(ezctextRowSim);
						}
					}else
					{
						ezctextRowSim = new EzBapistextTableRow();
	
						ezctextRowSim.setItmNumber(new java.math.BigInteger("0"));
						ezctextRowSim.setDocNumber(backEndNo);
						ezctextRowSim.setTextId(notesHId[j]);
						ezctextRowSim.setLanguage("E");
						ezctextRowSim.setTextLine(chkLin);
						ezctextRowSim.setColFormat("*");
						System.out.println("09090909090909090900"+backEndNo);
						ezctextRowSim.setFunction("002");
						ezctextTableSim.appendRow(ezctextRowSim);
					}
				}
			}
		}
	} 

		
           
	for (int j=0; j < Rows; j++) 
	{ 
		String strMaterialField = product_1[j];
		String strOrderField = commitedQty_1[j];
		String CommitPriceReq = commitedPrice_1[j];
		String strFOC = fOC_1[j];
		String  item = lineNo_1[j];		
		strFOC = ( (strFOC==null) || (strFOC.trim().length()==0) )?"0":strFOC;
		long IntFOC = Integer.parseInt(strFOC);
		String OrderQuantity = strOrderField;
		int delcount = 0;
		String uom = pack_1[j];
		java.math.BigDecimal bOrderQty = null;
		 double bCommitedPrice = 0;
		if (!OrderQuantity.equals(""))
		{ 
		   		
		   	CommitPriceReq = ( (CommitPriceReq==null) || (CommitPriceReq.trim().length()==0) )?"0":CommitPriceReq;
		   	double CommitPriceDob = Double.parseDouble(CommitPriceReq); 
		   
		   	bOrderQty  = new  java.math.BigDecimal(OrderQuantity);
		   	bOrderQty = bOrderQty.multiply(new java.math.BigDecimal(Integer.toString(1000)));
		   	bCommitedPrice = new Double( CommitPriceReq ).doubleValue();
		   
		   	java.math.BigInteger line = new java.math.BigInteger(item);
			
			iteminTablexRowhangeSim = new EzBapiitemexTableRow();
			iteminRowChangeSim = new EzBapiiteminTableRow();

			iteminRowChangeSim.setItmNumber(line);
			iteminTablexRowhangeSim.setItmNumber(line);

			iteminTableChangeSim.appendRow(iteminRowChangeSim);
			iteminTablexChangeSim.appendRow(iteminTablexRowhangeSim);

			
			java.math.BigDecimal  CommitedPrice1 = new java.math.BigDecimal( bCommitedPrice);
			condTableRowChangeSim = new EzBapiscondTableRow();
			condTableRowChangeSim.setItmNumber(line);
			condTableRowChangeSim.setCondType("PR00");
			condTableRowChangeSim.setCondValue(CommitedPrice1.setScale(3,java.math.BigDecimal.ROUND_HALF_UP));//.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)
			if( (curr != null) && (curr.trim().length()!=0) )
				condTableRowChangeSim.setCurrency(curr);
			condTableChangeSim.appendRow(condTableRowChangeSim); 

			condTablexRowChangeSim = new EzBapicondxTableRow();
			condTablexRowChangeSim.setUpdateflag("U");
			condxTableChangeSim.appendRow(condTablexRowChangeSim); 
				
		}
	}	

	if(retSchChanges!=null)
	{
		Vector allowedFlags= new Vector();
		allowedFlags.addElement(new String("D"));			
		allowedFlags.addElement(new String("U"));
		allowedFlags.addElement(new String("I"));

		int locCount = retSchChanges.getRowCount(); 

		for(int k=0;k< locCount ;k++)
		{
			String schFlag		= retSchChanges.getFieldValueString(k,"EZDS_STATUS");
			String tempReqQty	= retSchChanges.getFieldValueString(k,"EZDS_REQ_QTY");
			//String tempReqDate	= retSchChanges.getFieldValueString(k,"EZDS_REQ_DATE");
			String tempReqDate	= reqDateStr;
			String tempLine		= retSchChanges.getFieldValueString(k,"EZDS_SCHED_LINE");
			String tempItem		= retSchChanges.getFieldValueString(k,"EZDS_ITM_NUMBER");
			String tempBackEndNumber= retSchChanges.getFieldValueString(k,"EZDS_BACK_END_NUMBER");
			String tempBackEndItem 	= retSchChanges.getFieldValueString(k,"EZDS_BACK_ITM_NUMBER");

			java.util.GregorianCalendar tempreqDate1 = null;

			System.out.println("schFlag====="+schFlag);
			System.out.println("tempReqQty===="+tempReqQty);
			System.out.println("tempReqDate===="+tempReqDate);

			if(allowedFlags.contains(schFlag))
			{

				dSTableRowChangeSim = new EzBapischdlTableRow();
				dSTableRowChangeSim.setItmNumber(new java.math.BigInteger(tempItem)); 	
				dSTableRowChangeSim.setShortText(tempLine);

				try{
					int yearReq1 = Integer.parseInt(tempReqDate.substring(6,10));
					int monthReq1 = Integer.parseInt(tempReqDate.substring(3,5));
					int dateReq1 = Integer.parseInt(tempReqDate.substring(0,2));
					tempreqDate1 = new java.util.GregorianCalendar(yearReq1,monthReq1-1,dateReq1);

					dSTableRowChangeSim.setReqQty(new java.math.BigDecimal(tempReqQty)); 
					dSTableRowChangeSim.setReqDate(tempreqDate1.getTime()); 
				}catch(Exception e){}		
				deliveryScheduleTableChangeSim.appendRow(dSTableRowChangeSim);

				dSTablexRowChangeSim = new EzBapischdlxTableRow();
				dSTablexRowChangeSim.setUpdateflag(schFlag);
				deliverySchedulexTableChangeSim.appendRow(dSTablexRowChangeSim);
			}

		}
	}
		
	 
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

	escpChangeSim.setSalesDocument(backEndNo);
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
 
 
	if("YES".equalsIgnoreCase(SAPnumber))
	{
		
		EzBapisdheadStructure orderHeaderChange = new EzBapisdheadStructure();
 
		EzBapisdh1xStructure orderHeaderxChange = new EzBapisdh1xStructure();	
		EzBapipartnrTable orderPartnersChange = new EzBapipartnrTable();

		EzBapipartnrTableRow partnersRowChange = null;
 
		EzBapiiteminTable iteminTableChange = new EzBapiiteminTable();
		EzBapiiteminTableRow iteminRowChange = null;

		EzBapiitemexTable iteminTablexChange = new EzBapiitemexTable();
		EzBapiitemexTableRow iteminTablexRowhange= null;
	
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

		orderHeaderChange.setDlvBlock("02");
		orderHeaderxChange.setUpdateflag("U");
		
		if(!"CU".equals(UserRole))
		{
			orderHeaderChange.setIncoterms1(editSalVal.getIncoTerms1());
			orderHeaderChange.setIncoterms2(editSalVal.getIncoTerms2());
			orderHeaderChange.setPmnttrms(paymentterms);				
	
			for(int j=0;j<notesAll.length;j++)
			{
				if(!"None".equals(notesAll[j]))
				{
					EzStringTokenizer notesAllSt = new EzStringTokenizer(notesAll[j],"\n");
					int notesAllCt =notesAllSt.getTokens().size();
					if(notesAllCt == 0)
					{
						ezctextRow = new EzBapistextTableRow();
						ezctextRow.setItmNumber(new java.math.BigInteger("0"));
						ezctextRow.setDocNumber(backEndNo);
						ezctextRow.setTextId(notesHId[j]);
						ezctextRow.setLanguage("E");
						ezctextRow.setTextLine(notesAll[j]);
						ezctextRow.setColFormat("*");
						ezctextRow.setFunction("002");
						ezctextTable.appendRow(ezctextRow);

					}else
					{
						for(int linall=0;linall<notesAllCt;linall++)
						{
							ezctextRow = new EzBapistextTableRow();
							ezctextRow.setItmNumber(new java.math.BigInteger("0"));
							ezctextRow.setDocNumber(backEndNo);
							ezctextRow.setTextId(notesHId[j]);
							ezctextRow.setLanguage("E");
							ezctextRow.setTextLine((String)notesAllSt.getTokens().elementAt(linall));
							ezctextRow.setColFormat("*");
							ezctextRow.setFunction("002");
							ezctextTable.appendRow(ezctextRow);
						}
					}
				}
			} 
	
		}
			
		if(!"CU".equals(UserRole))
		{

			
			for (int j=0; j < Rows; j++) 
			{ 	
				String  item = lineNo_1[j];
				String CommitPriceReq = commitedPrice_1[j];
				java.math.BigInteger line = new java.math.BigInteger(item);
				String strOrderField = commitedQty_1[j];
//************************		String OrderQuantity = strOrderField;

				iteminTablexRowhange = new EzBapiitemexTableRow();
				iteminRowChange = new EzBapiiteminTableRow();

				iteminRowChange.setItmNumber(line);
				iteminTablexRowhange.setItmNumber(line);

				iteminTableChange.appendRow(iteminRowChange);
				iteminTablexChange.appendRow(iteminTablexRowhange);

//*********************	              if (!OrderQuantity.equals(""))
				{ 

						CommitPriceReq = ( (CommitPriceReq==null) || (CommitPriceReq.trim().length()==0) )?"0":CommitPriceReq;
						double CommitPriceDob = Double.parseDouble(CommitPriceReq); 


						java.math.BigDecimal  ConfirmedPriceB = new java.math.BigDecimal( CommitPriceDob);

						condTableRowChange = new EzBapiscondTableRow();
						condTableRowChange.setItmNumber(line);
						condTableRowChange.setCondType("PB00");
						condTableRowChange.setCondValue(ConfirmedPriceB.setScale(2,java.math.BigDecimal.ROUND_HALF_UP));
						if( (curr != null) && (curr.trim().length()!=0) )
							condTableRowChange.setCurrency(curr);
						condTableChange.appendRow(condTableRowChange); 

						condTablexRowChange = new EzBapicondxTableRow();
						condTablexRowChange.setUpdateflag("U");
						condxTableChange.appendRow(condTablexRowChange); 
				}
			}


			if(retSchChanges!=null)  
			{
				Vector allowedFlags= new Vector();
				allowedFlags.addElement(new String("D"));			
				allowedFlags.addElement(new String("U"));
				allowedFlags.addElement(new String("I"));


				for(int cCount=0;cCount<retSchChanges.getRowCount();cCount++)
				{
					String schFlag=retSchChanges.getFieldValueString(cCount,"EZDS_STATUS");

					System.out.println("status============"+schFlag);

					String tempReqQty=retSchChanges.getFieldValueString(cCount,"EZDS_REQ_QTY");
					String tempReqDate=retSchChanges.getFieldValueString(cCount,"EZDS_REQ_DATE");
					String tempLine= retSchChanges.getFieldValueString(cCount,"EZDS_SCHED_LINE");
					String tempItem= retSchChanges.getFieldValueString(cCount,"EZDS_ITM_NUMBER");
					String tempBackEndNumber = retSchChanges.getFieldValueString(cCount,"EZDS_BACK_END_NUMBER");
					String tempBackEndItem = retSchChanges.getFieldValueString(cCount,"EZDS_BACK_ITM_NUMBER");

					java.util.GregorianCalendar tempreqDate1 = null;

					System.out.println("schFlag====="+schFlag);
					System.out.println("tempReqQty===="+tempReqQty);
					System.out.println("tempReqDate===="+tempReqDate);


					if(allowedFlags.contains(schFlag) )
					{
						//schV.addElement(tempBackEndNumber);

						dSTableRowChange = new EzBapischdlTableRow();
						//dSTableRowChange.setItmNumber(new java.math.BigInteger(tempBackEndItem)); 	
						dSTableRowChange.setItmNumber(new java.math.BigInteger(tempItem)); 	
						dSTableRowChange.setShortText(tempLine);

						try{
							int yearReq1 = Integer.parseInt(tempReqDate.substring(6,10));
							int monthReq1 = Integer.parseInt(tempReqDate.substring(3,5));
							int dateReq1 = Integer.parseInt(tempReqDate.substring(0,2));
							tempreqDate1 = new java.util.GregorianCalendar(yearReq1,monthReq1-1,dateReq1);

							dSTableRowChange.setReqQty(new java.math.BigDecimal(tempReqQty)); 
							dSTableRowChange.setReqDate(tempreqDate1.getTime()); 
						}catch(Exception e){}		
						deliveryScheduleTableChange.appendRow(dSTableRowChange);

						dSTablexRowChange = new EzBapischdlxTableRow();
						dSTablexRowChange.setUpdateflag(schFlag);
						deliverySchedulexTableChange.appendRow(dSTablexRowChange);
					}

				}
			}
			
		} // if ! CU
		
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
		escpChange.setSalesDocument(backEndNo);
		escpChange.setSimulation(" ");
		
		ezcSalesOrderParamsChange.setObject(escpChange);
	        Session.prepareParams(ezcSalesOrderParamsChange);
		try{
			EzoSalesOrderChange ioParamsChange =(EzoSalesOrderChange) EzSalesOrderManager.ezChangeWebSalesOrder(ezcSalesOrderParamsChange); 
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
  
	}



    %> 
