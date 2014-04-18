<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>


<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"/>
<%
	ezc.ezcommon.EzLog4j log4j = new  ezc.ezcommon.EzLog4j();
	StringTokenizer st = null;
	String id		= request.getParameter("id");
	String addProduct	= request.getParameter("addProduct");
        
       
      
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
      	ReturnObjFromRetrieve retcat = null;
      	ReturnObjFromRetrieve retPerCat = null;
      	
	int retCatCount =0;
	String catalogNo="",catalogDesc="",tempVenCatStr="";
	char initAlpha;
   	 
	
	if(!"0".equals(id))
	{
		Session.prepareParams(ezcpparams);
		ezcpparams.setLanguage("EN");
		retcat = (ReturnObjFromRetrieve)EzCatalogManager.getCatalogList(ezcpparams);
		if(retcat!=null){
			log4j.log("retcatretcatretcat***************"+retcat.toEzcString(),"I");
		}
		retcat.check();
		
		if(retcat!=null){
			retCatCount= retcat.getRowCount();
		}
		
		if(retCatCount> 0)
		{
		   String sortField[]={"EPC_NAME"};
		   retcat.sort(sortField,true);
		}
		
		for(int j=0;j<retCatCount;j++)
		{
			catalogNo	= retcat.getFieldValueString(j,"EPC_NO").trim();
			catalogDesc	= retcat.getFieldValueString(j,"EPC_NAME");
		        initAlpha	= catalogDesc.toUpperCase().charAt(0);
			
			tempVenCatStr =catalogNo+"$$"+catalogDesc;  
			
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

        