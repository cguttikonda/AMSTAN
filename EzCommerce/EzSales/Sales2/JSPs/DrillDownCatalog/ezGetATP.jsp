<%@ page import="ezc.sales.material.params.*" %>
<%@ page import= "ezc.ezbasicutil.*" %>
<%@ page import = "ezc.ezutil.FormatDate" %>
<jsp:useBean id="EzcMaterialManager" class="ezc.sales.material.client.EzcMaterialManager" scope="session"></jsp:useBean>
<%
	int pageNum=0;
	int startIndex=0;
	int endIndex=0;
	int selCount=0;
	int col=0;

        String[] matIds  = null;
	String[] prodNo =null;
	String[] upcNos = null;
	String[] vendCodes = null;
	ezc.ezdisplay.ResultSetData dataObj= null;
	ReturnObjFromRetrieve myObj =null;
	
        Hashtable atpMat= new Hashtable();
        Vector atpMatVec = new Vector();
        
        String  formatkey=(String)session.getValue("formatKey");
        FormatDate formatDate = new FormatDate();

	retObjcount = rSet.size(); 
	if(pageNo==null || "null".equals(pageNo))
		pageNo="1";

	try{
		pageNum = Integer.parseInt(pageNo);
	}catch(Exception e){
	  	pageNum = 0;
	}

	startIndex = (pageNum*pageSize)-pageSize;
	endIndex   = (pageNum*pageSize)-1;
	
	
	if(endIndex>=retObjcount)
	endIndex = retObjcount-1;

	selCount    = (endIndex-startIndex)+1; 
	matIds      = new String[selCount];
	prodNo      = new String[selCount];
	upcNos      = new String[selCount];
	vendCodes   = new String[selCount];
	
	try{

		for(int i=startIndex;i<=endIndex;i++){
			 dataObj =(ezc.ezdisplay.ResultSetData)rSet.get(i);
			 prodNo[col]    = dataObj.getColumn1().toString();
			 matIds[col]    = dataObj.getColumn8().toString();
			 upcNos[col]    = dataObj.getColumn9().toString();	
			 vendCodes[col] = dataObj.getColumn4().toString();	
			 col++; 
		}

		try{
			EzcMaterialParams ezMatParams = new EzcMaterialParams();
			EziMaterialParams eiMatParams = new EziMaterialParams();  
			eiMatParams.setMatIds(matIds);
			eiMatParams.setMaterialCodes(prodNo);
			eiMatParams.setUPCNumbers(upcNos);
			eiMatParams.setVendorCodes(vendCodes); 
			
			eiMatParams.setMaterial("");
			eiMatParams.setUnit("");

			ezMatParams.setObject(eiMatParams);
			Session.prepareParams(ezMatParams);  


			EzoMaterialParams eoMatParams = (EzoMaterialParams) EzcMaterialManager.getMaterialAvailability(ezMatParams);
			myObj = (ReturnObjFromRetrieve) eoMatParams.getReturn();

		}catch(Exception e){

		}
		
	}catch(Exception err){
		
	}
	
	int myObjCount=0;
	String matNo="",status="",availableQty="",leadTime="",tempLeadTime="",cumQty="";
	String matId = "";
	String linkStr="N";
	String atpDateStr="";
	
	Date tempDate = null;
	Date atpDate = null;
	String plant ="";
	
	Hashtable matHt = new Hashtable();
	Hashtable matDateHt = new Hashtable();
	

	if(myObj!=null)
		myObjCount = myObj.getRowCount();
		
	
	for(int i=0;i<myObjCount;i++)
	{
		linkStr = "N";
		matId  = myObj.getFieldValueString(i,"MATID");
		matNo  = myObj.getFieldValueString(i,"MATERIAL");
		try{
		      matNo = Integer.parseInt(matNo)+"";
		}
		catch(Exception E){  }
		
		plant          	    = myObj.getFieldValueString(i,"PLANT");
		status              = myObj.getFieldValueString(i,"STATUS");
		availableQty        = myObj.getFieldValueString(i,"AVAIL_QTY");
		String availDateStr = myObj.getFieldValueString(i,"ENDLEADTME");
		Date availDate      = (Date)myObj.getFieldValue(i,"ENDLEADTME");
		
		
		if(plant!=null)
		plant = plant.trim();

		if(atpMatVec.contains(matId))
			linkStr="Y";
		else
			atpMatVec.addElement(matId);

		
		if("A".equals(status))
		{
			if("QU".equals(plant) || "BK".equals(plant) || "XX".equals(plant) ) {
				if(matHt.containsKey(matId)){
					cumQty =(String)matHt.get(matId);
					try{
						//availableQty = (Double.parseDouble(availableQty)+Double.parseDouble(cumQty))+"";
						availableQty = (new java.math.BigDecimal(availableQty).add(new java.math.BigDecimal(cumQty))).toString();
						matHt.put(matId,availableQty);

					}catch(Exception e){  }
				}else{
					matHt.put(matId,availableQty);
				}	
			}	
		}
		if("O".equals(status) && availDate!=null)
		{
			if(matDateHt.containsKey(matId)){
				tempDate =(Date)matDateHt.get(matId);  
				
				if(tempDate.compareTo(availDate)<0)
				     matDateHt.put(matId,availDate);
				else
                                     matDateHt.put(matId,tempDate);
			}
			else 
			     matDateHt.put(matId,availDate);
		}
		
		if(matHt.containsKey(matId)){
			status ="A";
		}else if(matDateHt.containsKey(matId)){
			status ="O"; 
		}
		
		atpDate  = (Date)matDateHt.get(matId);
		atpDateStr  = formatDate.getStringFromDate(atpDate,formatkey,FormatDate.MMDDYYYY); 

		String atpTempQty   = (String)matHt.get(matId);

		atpMat.put(matId,status+"¥"+atpTempQty+"¥"+atpDateStr+"¥"+linkStr);  

	}
	
	
	
 
%>  




