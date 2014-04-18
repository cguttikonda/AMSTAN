<%!
	private String getConfigDiscount(ezc.session.EzSession Session,String manfId,String prodCat,String customer,String createdBy)
	{
		String returnValue = "";
		
		try
		{
			String discCode = "";
			String discPer = "";
		
			ezc.ezdiscount.client.EzDiscountManager ezDiscountManager = new ezc.ezdiscount.client.EzDiscountManager();
			ezc.ezparam.EzcParams discMainParams = new ezc.ezparam.EzcParams(false);
			ezc.ezdiscount.params.EziDiscountParams ezDiscParams = new ezc.ezdiscount.params.EziDiscountParams();
			
			ezDiscParams.setType("GET_DISC_MFR_PRODCAT_SPLCUST");
			ezDiscParams.setDiscType("MISC");
			ezDiscParams.setMfr(manfId);
			ezDiscParams.setProdCat(prodCat);
			ezDiscParams.setCustomer(customer+"') AND ESD_STATUS ='Y' AND ESD_CREATED_BY IN ('"+createdBy);
			ezDiscParams.setSyskey("999102");


			discMainParams.setObject(ezDiscParams);
			discMainParams.setLocalStore("Y");
			Session.prepareParams(discMainParams);

			ezc.ezparam.ReturnObjFromRetrieve retDiscCond1 = null;

			try
			{
				retDiscCond1 = (ezc.ezparam.ReturnObjFromRetrieve)ezDiscountManager.ezGetDiscount(discMainParams);
			}
			catch(Exception e){}

			if(retDiscCond1!=null && retDiscCond1.getRowCount()>0)
			{
				discPer = retDiscCond1.getFieldValueString(0,"ESD_DISCOUNT");
				discCode = retDiscCond1.getFieldValueString(0,"ESD_DISC_NO");
				
				returnValue = discPer+"¥"+discCode;
			}
			else
			{
				ezDiscParams.setType("GET_DISC_MFR_PRODCAT_ALLCUST");
				ezDiscParams.setDiscType("MIAC");
				ezDiscParams.setMfr(manfId+"') AND ESD_STATUS ='Y' AND ESD_CREATED_BY IN ('"+createdBy);
				ezDiscParams.setProdCat(prodCat);
				ezDiscParams.setSyskey("999102");
				

				discMainParams.setObject(ezDiscParams);
				discMainParams.setLocalStore("Y");
				Session.prepareParams(discMainParams);
			
				ezc.ezparam.ReturnObjFromRetrieve retDiscCond2 = null;

				try
				{
					retDiscCond2 = (ezc.ezparam.ReturnObjFromRetrieve)ezDiscountManager.ezGetDiscount(discMainParams);
				}
				catch(Exception e){}
				
				if(retDiscCond2!=null && retDiscCond2.getRowCount()>0)
				{
					discPer = retDiscCond2.getFieldValueString(0,"ESD_DISCOUNT");
					discCode = retDiscCond2.getFieldValueString(0,"ESD_DISC_NO");
					
					returnValue = discPer+"¥"+discCode;
				}
				else
				{
					ezDiscParams.setType("GET_DISC_MFR_SPLCUST");
					ezDiscParams.setDiscType("MSC");
					ezDiscParams.setMfr(manfId);
					ezDiscParams.setCustomer(customer+"') AND ESD_STATUS ='Y' AND ESD_CREATED_BY IN ('"+createdBy);
					ezDiscParams.setSyskey("999102");


					discMainParams.setObject(ezDiscParams);
					discMainParams.setLocalStore("Y");
					Session.prepareParams(discMainParams);

					ezc.ezparam.ReturnObjFromRetrieve retDiscCond3 = null;

					try
					{
						retDiscCond3 = (ezc.ezparam.ReturnObjFromRetrieve)ezDiscountManager.ezGetDiscount(discMainParams);
					}
					catch(Exception e){}				

					if(retDiscCond3!=null && retDiscCond3.getRowCount()>0)
					{
						discPer = retDiscCond3.getFieldValueString(0,"ESD_DISCOUNT");
						discCode = retDiscCond3.getFieldValueString(0,"ESD_DISC_NO");
						
						returnValue = discPer+"¥"+discCode;
					}
					else
					{
						ezDiscParams.setType("GET_DISC_MFR_ALLCUST");
						ezDiscParams.setDiscType("MAC");
						ezDiscParams.setMfr(manfId+"') AND ESD_STATUS ='Y' AND ESD_CREATED_BY IN ('"+createdBy);
						ezDiscParams.setSyskey("999102");
						

						discMainParams.setObject(ezDiscParams);
						discMainParams.setLocalStore("Y");
						Session.prepareParams(discMainParams);

						ezc.ezparam.ReturnObjFromRetrieve retDiscCond4 = null;

						try
						{
							retDiscCond4 = (ezc.ezparam.ReturnObjFromRetrieve)ezDiscountManager.ezGetDiscount(discMainParams);
						}
						catch(Exception e){}				

						if(retDiscCond4!=null && retDiscCond4.getRowCount()>0)
						{
							discPer = retDiscCond4.getFieldValueString(0,"ESD_DISCOUNT");
							discCode = retDiscCond4.getFieldValueString(0,"ESD_DISC_NO");
							
							returnValue = discPer+"¥"+discCode;
							
						}
					}
				}
			}
		}
		catch(Exception ex){}
		
		return returnValue;
	}
%>