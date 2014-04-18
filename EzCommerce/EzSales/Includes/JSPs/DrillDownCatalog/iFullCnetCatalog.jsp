<%@ page import = "ezc.ezparam.*,ezc.ezcnetconnector.params.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"/>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<%
	ezc.ezcommon.EzLog4j log4j = new  ezc.ezcommon.EzLog4j();
	StringTokenizer st = null;
	String id		= request.getParameter("id");
	String addProduct	= request.getParameter("addProduct");
        java.util.ArrayList selCustCat = new java.util.ArrayList();
        String uRole =(String)session.getValue("UserRole");
       
      
        log4j.log("ididididididididid***************"+id,"I");
        
	ReturnObjFromRetrieve ret 	    = null;
	String userId			    = Session.getUserId();
	String skey			    = (String) session.getValue("SalesAreaCode");
  
        java.util.ArrayList childVector     = new java.util.ArrayList();
        java.util.TreeSet alphaTree         = new java.util.TreeSet();
        
        java.util.Vector venCatVectAB       = new java.util.Vector();
        java.util.Vector venCatVectC        = new java.util.Vector();
        java.util.Vector venCatVectDEF      = new java.util.Vector();
        java.util.Vector venCatVectG        = new java.util.Vector();
        java.util.Vector venCatVectHI       = new java.util.Vector();
        java.util.Vector venCatVectJK       = new java.util.Vector();
        java.util.Vector venCatVectLMNO     = new java.util.Vector();
        java.util.Vector venCatVectPQR      = new java.util.Vector();
        java.util.Vector venCatVectST       = new java.util.Vector();
        java.util.Vector venCatVectUV       = new java.util.Vector();
        java.util.Vector venCatVectWXYZ     = new java.util.Vector();
        
        
        java.util.Hashtable venCatalogHT    = new java.util.Hashtable();
        
        
        
   	EzCatalogParams ezcpparams = new EzCatalogParams();
	EzcParams ezcparams = new EzcParams(true);
      	ReturnObjFromRetrieve retcat = null;
      	ReturnObjFromRetrieve retPerCat = null;
      	
	int retCatCount =0;
	String catalogNo="",catalogDesc="",tempVenCatStr="";
	char initAlpha;
   	 
	
	if(!"0".equals(id))
	{
		
		EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
		cnetParams.setQuery("order by cds_Cctez.Description ASC");
		ezcparams.setObject(cnetParams);
		ezcparams.setLocalStore("Y");
		Session.prepareParams(ezcparams);

		retcat = (ReturnObjFromRetrieve)CnetManager.ezGetCnetCategories(ezcparams);
		
		if(retcat!=null){
			log4j.log("retcatretcatretcat***************"+retcat.toEzcString(),"I");
		}
		retcat.check();
		
		if(retcat!=null){
			retCatCount= retcat.getRowCount();
			
			
			if("CU".equals(uRole) || "CUSR".equals(uRole))
			{
				EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
				EzCustomerItemCatParams ecic = new EzCustomerItemCatParams();

				catalogParams.setType("GET_CUST");
				ecic.setSoldTo((String)session.getValue("AgentCode"));
				catalogParams.setLocalStore("Y");
				catalogParams.setObject(ecic);
				Session.prepareParams(catalogParams);

				ReturnObjFromRetrieve retCustCat =(ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(catalogParams);

				if(retCustCat!=null && retCustCat.getRowCount()>0)
				{
					for(int k=0;k<retCustCat.getRowCount();k++)
					{
						selCustCat.add(retCustCat.getFieldValueString(k,"ECI_ITEMCAT"));
					}
				}
			}			
			
			
			
			
			
		}
		for(int j=0;j<retCatCount;j++)
		{
			
			
			
			catalogNo	= retcat.getFieldValueString(j,"CatID").trim();
			catalogDesc	= retcat.getFieldValueString(j,"Description");
		        initAlpha	= catalogDesc.toUpperCase().charAt(0);
			
			tempVenCatStr = catalogDesc+"$$"+catalogNo;  
			
			if(("CU".equals(uRole) || "CUSR".equals(uRole)) && !selCustCat.contains(catalogNo))
				continue;
			
			switch(initAlpha)
			{
			   case 'A':
			   case 'B':
			             venCatVectAB.addElement(tempVenCatStr); 
				     venCatalogHT.put("A-B",venCatVectAB);
			             break;
			   case 'C':
				     venCatVectC.addElement(tempVenCatStr); 
				     venCatalogHT.put("C",venCatVectC);
				     break;
			   case 'D':
			   case 'E':
			   case 'F':
				     venCatVectDEF.addElement(tempVenCatStr); 
				     venCatalogHT.put("D-E-F",venCatVectDEF);
				     break;
		           case 'G':
				     venCatVectG.addElement(tempVenCatStr); 
				     venCatalogHT.put("G",venCatVectG);
				     break;
			   case 'H':
			   case 'I':
				     venCatVectHI.addElement(tempVenCatStr); 
				     venCatalogHT.put("H-I",venCatVectHI);
				     break;
			   case 'J':
			   case 'K':
				     venCatVectJK.addElement(tempVenCatStr); 
				     venCatalogHT.put("J-K",venCatVectJK);
				     break;
			   case 'L':
			   case 'M':
			   case 'N':
			   case 'O':
			     	     venCatVectLMNO.addElement(tempVenCatStr); 
			             venCatalogHT.put("L-M-N-O",venCatVectLMNO);
			             break;
			   case 'P':
			   case 'Q':
			   case 'R':
			     	     venCatVectPQR.addElement(tempVenCatStr); 
			             venCatalogHT.put("P-Q-R",venCatVectPQR);
				     break;
			   case 'S':
			   case 'T':
			     	     venCatVectST.addElement(tempVenCatStr); 
			             venCatalogHT.put("S-T",venCatVectST);
				     break;
			   case 'U':
			   case 'V':
			     	     venCatVectUV.addElement(tempVenCatStr); 
			             venCatalogHT.put("U-V",venCatVectUV);
				     break;
			   case 'W':
			   case 'X':
			   case 'Y':
			   case 'Z':
			     	     venCatVectWXYZ.addElement(tempVenCatStr); 
			     	     venCatalogHT.put("W-X-Y-Z",venCatVectWXYZ);
				     break;
			   
			}
			
		      
		}
		log4j.log("venCatVectAB.size()***************"+venCatVectAB.size(),"I");
		
		
	}
	
	if("0".equals(id) )
	{
		ezcpparams.setLanguage("EN");
		Session.prepareParams(ezcpparams);
		retPerCat = (ReturnObjFromRetrieve) EzCatalogManager.getCustomCatalog(ezcpparams);	
	}
	
	
	
%>

        