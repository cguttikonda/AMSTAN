<%
	int pageNum=0;
	int startIndex=0;
	int endIndex=0;
	int selCount=0;
	int col=0;
	ezc.ezdisplay.ResultSetData dataObj= null;
	String prodNos ="";
	String prdType="";
	String pageNo = request.getParameter("d-49520-p");
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
			 prdType =dataObj.getColumn10().toString(); 
			 if("CNET".equals(prdType))
			 {
				 if(col==0)
					prodNos    = dataObj.getColumn1().toString();
				 else
					prodNos    = prodNos + "','" +dataObj.getColumn1().toString();
				 col++; 
			 }
		}
		if(col>0)
		{
			try{
				ezcpparams = new EzcParams(true);
				cnetParams=new EzCnetConnectorParams();

				cnetParams.setStatus("GET_DIGITALCONTENT_PROD");
				cnetParams.setQuery("and cds_DigContent.MediaTypeID = '1' and cds_DigContent.MimeType = 'image/jpeg'");
				cnetParams.setProdID(prodNos);
				ezcpparams.setObject(cnetParams);
				ezcpparams.setLocalStore("Y");
				Session.prepareParams(ezcpparams);
				ReturnObjFromRetrieve imgRet = (ReturnObjFromRetrieve)CnetManager.ezGetCnetDigContentByStatus(ezcpparams);
				if(imgRet!=null && imgRet.getRowCount()>0)
				{
					for(int j=0;j<imgRet.getRowCount();j++)
					{
						imageHash.put(imgRet.getFieldValueString(j,"ProdID"),imgRet.getFieldValueString(j,"URL"));
						ezc.ezcommon.EzLog4j.log("prd >>>>>"+imgRet.getFieldValueString(j,"ProdID")+"  url>>>>>"+imgRet.getFieldValueString(j,"URL"),"E");
					}
				}



			}catch(Exception e){
				ezc.ezcommon.EzLog4j.log("Exception >>>>>"+e,"E");

			}
		}		
	}catch(Exception err){
		ezc.ezcommon.EzLog4j.log("Exception >>>>>"+err,"E");
	}

	





%>