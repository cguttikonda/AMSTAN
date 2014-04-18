<%!
	public String getATPQuantity(String matNo,String requiredDate,String requiredQty,String uom,ezc.session.EzSession Session,String showATP,String atpPlants)
	{
		java.math.BigDecimal totAvQty=new java.math.BigDecimal(0);
		String retValue="";
		try{
			/*
			ezc.ezparam.EzcParams   myParams	=new ezc.ezparam.EzcParams(true);
			ezc.ezmaterialsearch.client.EzMaterialSearchManager msManager	=new ezc.ezmaterialsearch.client.EzMaterialSearchManager();
			ezc.ezmaterialsearch.params.EziMaterialAvailabilityParams msParams	=new ezc.ezmaterialsearch.params.EziMaterialAvailabilityParams();
			msParams.setSalesOrg("0010");
			msParams.setDistrChan("10");
			myParams.setObject(msParams);
			Session.prepareParams(myParams);
			ezc.ezparam.ReturnObjFromRetrieve retPlantList = (ezc.ezparam.ReturnObjFromRetrieve)msManager.ezGetPlants(myParams);
			int retPlantListCount=0;
			if(retPlantList!=null) retPlantListCount=retPlantList.getRowCount();
			*/
			java.util.Vector myPlants=new java.util.Vector();
			int retPlantListCount=0;
			if(atpPlants!=null){
				java.util.StringTokenizer st=new java.util.StringTokenizer(atpPlants,";");
				String plantTK="";
				while(st.hasMoreTokens()){
					plantTK=st.nextToken();
					if(plantTK!=null && !"".equals(plantTK.trim()))
					myPlants.add(plantTK.trim());
				}
				
			}	
			retPlantListCount=myPlants.size();
			
			

			ezc.sales.material.params.EzcMaterialParams ezMatParams     = new ezc.sales.material.params.EzcMaterialParams();
			ezc.sales.material.params.EziMaterialParams eiMatParams     = new ezc.sales.material.params.EziMaterialParams();
			ezc.sales.material.params.EzBapiwmdvsTable  InputTable      = new  ezc.sales.material.params.EzBapiwmdvsTable();
			ezc.sales.material.params.EzBapiwmdvsTableRow InputTableRow = new  ezc.sales.material.params.EzBapiwmdvsTableRow();

			int mn = Integer.parseInt(requiredDate.substring(0,2));
			int dt = Integer.parseInt(requiredDate.substring(3,5));
			int yr = Integer.parseInt(requiredDate.substring(6,10));
			java.util.GregorianCalendar reqDateG = new java.util.GregorianCalendar(yr,mn-1,dt);

			InputTableRow.setReqDate(reqDateG.getTime());
			InputTableRow.setReqQty(new java.math.BigDecimal(requiredQty)); 
			InputTable.appendRow(InputTableRow);


			eiMatParams.setMaterial(matNo);
			eiMatParams.setUnit(uom);
			eiMatParams.setCheckRule("01");
			eiMatParams.setWmdvsx(InputTable);

			ezc.sales.material.client.EzcMaterialManager EzcMaterialManager =new ezc.sales.material.client.EzcMaterialManager();

			for(int i=0;i<retPlantListCount;i++)
			{
				String plant=(String)myPlants.get(i);
				eiMatParams.setPlant(plant);
				ezMatParams.setObject(eiMatParams);	
				Session.prepareParams(ezMatParams);
				ezc.sales.material.params.EzoMaterialParams eoMatParams = (ezc.sales.material.params.EzoMaterialParams) EzcMaterialManager.getMaterialAvailability(ezMatParams);
				if(eoMatParams!=null){
					java.math.BigDecimal avQtyAtPlant =(java.math.BigDecimal)eoMatParams.getAvQtyPlt();
					if(avQtyAtPlant!=null){
						totAvQty=totAvQty.add(avQtyAtPlant);
					}

				}	

			}
		}catch(Exception err)
		{
			return err.toString();
		}
		showATP ="Y";
		if("Y".equals(showATP)){
			retValue="<Strong>"+String.valueOf(totAvQty);
		}else{
			if(totAvQty.doubleValue()>0)
			retValue="<Strong>Yes";
			else
			retValue="<Strong>No";

		}
				
		return retValue;

	}

%>
