<%
	int pageNum=0;
	int startIndex=0;
	int endIndex=0;
	int selCount=0;
	int col=0;
	ezc.ezdisplay.ResultSetData dataObj= null;
	String prodNos ="";
	
        Hashtable imageHash= new Hashtable();

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

	try{

		for(int i=startIndex;i<=endIndex;i++){
			 dataObj =(ezc.ezdisplay.ResultSetData)rSet.get(i);
			 if(i==startIndex)
			 	prodNos    = dataObj.getColumn1().toString();
			 else
			 	prodNos    = prodNos + "','" +dataObj.getColumn1().toString();
			 col++; 
		}

		try{
		
					
		
			ezcpparams = new ezc.ezparam.EzCatalogParams(); 
			cnetParams=new EzCustomerItemCatParams();
		
			
			ezcpparams.setType("NONCNET_GET_DIGITALCONTENT_PROD");
			cnetParams.setProdID(prodNos);
			cnetParams.setQuery("");			
			ezcpparams.setObject(cnetParams);
			ezcpparams.setLocalStore("Y");
			Session.prepareParams(ezcpparams);
			ReturnObjFromRetrieve imgRet = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(ezcpparams);

			if(imgRet!=null && imgRet.getRowCount()>0)
			{
				for(int j=0;j<imgRet.getRowCount();j++)
				{
					imageHash.put(imgRet.getFieldValueString(j,"EMM_NO"),imgRet.getFieldValueString(j,"EMM_IMAGE_PATH"));
					log4j.log("prd >>>>>"+imgRet.getFieldValueString(j,"EMM_NO")+"  url>>>>>"+imgRet.getFieldValueString(j,"EMM_IMAGE_PATH"),"E");
				}
			}
			
		//out.println("imgRet:::"+imgRet.toEzcString());				

		}catch(Exception e){
			log4j.log("Exception >>>>>"+e,"E");

		}
		
	}catch(Exception err){
		log4j.log("Exception >>>>>"+err,"E");
	}

%>