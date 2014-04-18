<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*"%>

<%!
	private String getJobQuotePrice(ezc.session.EzSession Session,String quoteNo,String quoteLine,String prodCode,String cartQty,String quoteCust)
	{
		
		String jobQuotePrice = "0";
		String totOpenQty = "0";

		int retHeaderCount = 0,retItemsCount=0,retCondCount=0,retFlowCount=0;

		ReturnObjFromRetrieve sodetails= null;

		ezc.sales.params.EzcSalesOrderParams  ezcSalesOrderParams = new ezc.sales.params.EzcSalesOrderParams();
		ezc.sales.local.client.EzSalesManager Manager = new ezc.sales.local.client.EzSalesManager();
		ezcSalesOrderParams.setSalesDocNum(quoteNo);
		ezcSalesOrderParams.setCustomer(quoteCust);

		ezc.sales.local.params.EziUserList userList = new ezc.sales.local.params.EziUserList();
		ezcSalesOrderParams.setObject(userList);
		Session.prepareParams(ezcSalesOrderParams);
		sodetails = (ReturnObjFromRetrieve)Manager.ezGetSODetails(ezcSalesOrderParams);

		ReturnObjFromRetrieve retHeader	  = (ReturnObjFromRetrieve)sodetails.getFieldValue("HEADER");
		ReturnObjFromRetrieve retItems	  = (ReturnObjFromRetrieve)sodetails.getFieldValue("ITEMS");
		ReturnObjFromRetrieve retCond     = (ReturnObjFromRetrieve)sodetails.getFieldValue("SDCOND");
		ReturnObjFromRetrieve retFlow     = (ReturnObjFromRetrieve)sodetails.getFieldValue("FLOW");
		
		
		if(retHeader!=null && retHeader.getRowCount()>0)
			retHeaderCount = retHeader.getRowCount();
		if(retItems!=null && retItems.getRowCount()>0)
			retItemsCount = retItems.getRowCount();
		if(retCond!=null && retCond.getRowCount()>0)
			retCondCount = retCond.getRowCount();
		if(retFlow!=null && retFlow.getRowCount()>0)
			retFlowCount = retFlow.getRowCount();

		if(retHeader!=null && retHeaderCount>0)	
		{
			Date valFrom 	= (Date)retHeader.getFieldValue(0,"QT_VALID_F");
			Date valTo 	= (Date)retHeader.getFieldValue(0,"QT_VALID_T");

			Date todayDate = new Date();

			if(valTo.compareTo(todayDate) < 0)
			{
				jobQuotePrice = "EQ";
			}	
			else
			{				
				String openQty = "0",reqQty = "0",reqMat = "", rejReason = "";

				retItems.sort(new String[]{"LINE_NO"},true);

				for(int i=0;i<retItems.getRowCount();i++)
				{
					String lineNum  =  retItems.getFieldValueString(i,"LINE_NO");

					if(lineNum.equals(quoteLine))
					{
						reqQty 		=  retItems.getFieldValueString(i,"QTY");
						reqMat 		=  retItems.getFieldValueString(i,"ITEM_NO");
						rejReason	=  retItems.getFieldValueString(i,"REJREASON");
						break;
					}
				}

				if(!"".equals(rejReason))
				{
					jobQuotePrice = "JR";
				}
				else
				{
					int matLineIndx =  retItems.getRowId("ITEM_NO",prodCode);											

					if(matLineIndx<0)
					{			
						jobQuotePrice = "NM";
					}				
					else if(!reqMat.equals(prodCode))
					{			
						jobQuotePrice = "NL";					
					}
					else
					{				
						/*************Finding Open Qty***********START********/

						HashMap flowHM = new HashMap();
						String openQtyHM="0",openQtyRet="0",totOpenQtyHM="0";
						String itemNo;

						if(retFlow!=null && retFlow.getRowCount()>0)
						{
							for(int fl=0;fl<retFlow.getRowCount();fl++)
							{
								if("C".equals(retFlow.getFieldValueString(fl,"DOC_CAT")))
								{	

									itemNo 	  =  retFlow.getFieldValueString(fl,"REFSDDOCITM");
									openQtyRet = retFlow.getFieldValueString(fl,"REF_QTY");
									try
									{
										openQtyRet = new java.math.BigDecimal(openQtyRet).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
									}
									catch(Exception e){}

									if(flowHM.containsKey(itemNo))
									{
										openQtyHM  = (String)flowHM.get(itemNo);
										try
										{
											openQtyHM = new java.math.BigDecimal(openQtyHM).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
										}
										catch(Exception e){}

										try
										{
											totOpenQtyHM = new java.math.BigDecimal(openQtyHM).add(new java.math.BigDecimal(openQtyRet)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
										}

										catch(Exception e){}

										flowHM.remove(itemNo);
										flowHM.put(itemNo,totOpenQtyHM);
									}
									else
									{
										flowHM.put(itemNo,openQtyRet);
									}			
								}
							}
						}				


						if (!flowHM.isEmpty() && flowHM.containsKey(quoteLine)) 
						{
							openQty= (String)flowHM.get(quoteLine);		 			 

							try
							{
								totOpenQty = new java.math.BigDecimal(reqQty).subtract(new java.math.BigDecimal(openQty)).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();

							}
							catch(Exception e){}
						}
						else
						{		 
							 try
							 {
								totOpenQty = new java.math.BigDecimal(reqQty).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
							 }
							 catch(Exception e){}
						}

						/*************Finding Open Qty***********END********/


						try
						{
							cartQty = new java.math.BigDecimal(cartQty).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}
						catch(Exception e){}
						if(Float.parseFloat(cartQty)>Float.parseFloat(totOpenQty))
						{
							jobQuotePrice = "CQ";
						}
						else
						{

							/*******Finding Job Quote Price**********START********/	
							for(int j=0;j<retCond.getRowCount();j++) 
							{
								String condLineNo = retCond.getFieldValueString(j,"ItmNumber");
								String condType = retCond.getFieldValueString(j,"CondType");												

								if(quoteLine.equals(condLineNo))
								{						

									if("ZJOB".equals(condType))
									{
										jobQuotePrice = retCond.getFieldValueString(j,"Condvalue");

										try
										{
											jobQuotePrice = new java.math.BigDecimal(jobQuotePrice).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
										}
										catch(Exception e){}
									}				
								}
							}
							/*******Finding Job Quote Price*************END********/																
						}					
					}
				}
			}												
		}
		else
		{
			jobQuotePrice = "NQ";		
		}
		
		return jobQuotePrice+"¥"+totOpenQty;
	}	
%>