<%@ page import = "ezc.ezparam.*,ezc.ezbasicutil.*,ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp" %>
<jsp:useBean id="setSalVal" class="ezc.sales.params.EzSalesSetPropParams"/>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<jsp:setProperty name="setSalVal" property="*"/>
<%
	ReturnObjFromRetrieve itemoutTable = null;
	
	String product,productDesc,name,desiredQty,desiredDate,desiredPrice,value_Net,plant,Currency,custProd;
	String UserType = (String)session.getValue("UserType");
	String UserRole = (String)session.getValue("UserRole");
	String agent 	= (String)session.getValue("Agent");
	String salesAreaCode = (String)session.getValue("SalesAreaCode");
	String salesAreaName = (String)session.getValue("Country");
	String user 	= Session.getUserId();

	UserType	= UserType.trim();    
	UserRole	= UserRole.trim();
	agent 		= agent.trim();
	salesAreaCode 	= salesAreaCode.trim();
	user		= user.trim();

	String status 	= request.getParameter("status");
	log4j.log("statusstatusstatusstatusstatus::ezEdit::"+status,"W");
	
	boolean NEW 		= false;	if(("New").equalsIgnoreCase(status)) NEW = true;
	boolean TRANSFERED 	= false;	if(("TRANSFERED").equalsIgnoreCase(status)) TRANSFERED= true;
	boolean NEGOTIATED 	= false;	if(("NEGOTIATED").equalsIgnoreCase(status)) NEGOTIATED= true;

	String paymentterms 	= setSalVal.getPaymentTerms();

	if(paymentterms != null)              
	{      
		try 
		{
			int l=paymentterms.length();   
			String ss="";
			if(l==1)
				ss="   ";
			else if(l==2)
				ss="  ";
			else if(l==3)
				ss=" ";
			paymentterms = ss+paymentterms; 
		}
		catch(Exception e){}
	}
	 
	String msg  = null; 

	String[] prodCode_1 	= request.getParameterValues("product");
	String[] prodDesc_1 	= request.getParameterValues("prodDesc");
	String[] prodDQty_1 	= request.getParameterValues("desiredQty");
	String[] prodCQty_1 	= request.getParameterValues("desiredQty"); 
	String[] prodPack_1 	= request.getParameterValues("pack");
	String[] prodItemCat_1 	= request.getParameterValues("ItemCat");
	String[] prodUomQty	= request.getParameterValues("UomQty");
	String[] custprodCode	= request.getParameterValues("custprodCode");
	String[] itemVenCatalog	= request.getParameterValues("vendCatalog");
	String[] itemOrderType	= request.getParameterValues("orderType");
	String[] itemPlant	= request.getParameterValues("plant");

	
		log4j.log("itemOrderTypeitemOrderType"+itemOrderType.length,"W");

  
	
	String[] itemMfrPart	= request.getParameterValues("itemMfrPart"); 
	String[] itemMfrNr	= request.getParameterValues("itemMfrNr"); 
	String[] itemEanUPC	= request.getParameterValues("itemEanUPC"); 
	String[] itemMatId	= request.getParameterValues("itemMatId");
	String[] itemMmFlag	= request.getParameterValues("itemMmFlag");
	String[] itemDiscCode	= request.getParameterValues("itemDiscCode");
	String[] itemPromoCode  = request.getParameterValues("itemPromoCode");
	String[] itemWeight	= request.getParameterValues("itemWeight");
	String[] itemCnetProd	= request.getParameterValues("itemCnetProd");
	String[] itemMfrCode	= request.getParameterValues("itemMfrCode");
	String[] itemOrgPrice	= request.getParameterValues("itemOrgPrice");
	
	String[] lineNo_1 	= setSalVal.getLineNo();
	String[] fOC_1 		= setSalVal.getFocVal();
	
	String promoCode 	= request.getParameter("hidePromoCode");
	String freightPrice 	= request.getParameter("freightVal");
	String freightWeight 	= request.getParameter("weight");
	String fServType 	= request.getParameter("fServType");
	String freightIns	= request.getParameter("freightIns");
	
	String shTpZone		= request.getParameter("tpZone");  
	String shJurCode	= request.getParameter("jurisdiction"); 
	String shFax		= request.getParameter("faxNumber");
	String shTel		= request.getParameter("telNumber");
	String shMobi		= request.getParameter("mobileNumber"); 
	String shAttn		= request.getParameter("shAttn"); 
	String billTPZone	= request.getParameter("billTPZone");   
	String billJurCode	= request.getParameter("billJurCode");  
	String specialShIns	= request.getParameter("specialShIns"); 
	String saveEmail	= request.getParameter("saveEmail");
	String soNum		= request.getParameter("soNum");
	String grandTotalVal	= request.getParameter("grandTotalVal");     
	if(soNum!=null && !"".equals(soNum)) soNum = soNum.trim();
	int prodCodeLength = prodCode_1.length;   

	String[] desiredDate_1 = request.getParameterValues("desiredDate");
	String[] lineValue_1   = request.getParameterValues("lineValue");
	//String[] desiredPrice_1= request.getParameterValues("desiredPrice");
	String[] desiredPrice_1= request.getParameterValues("finalPrice");
	String[] itemListPrice = request.getParameterValues("itemListPrice");
	String[] finalPriceVal_1= request.getParameterValues("finalPriceVal"); 
	
	String[] del_sch_qty_1 	= setSalVal.getDel_sch_qty();
	String[] del_sch_date_1	= setSalVal.getDel_sch_date();  
	String incoTerms1      	= setSalVal.getIncoTerms1();
	String incoTerms2      	= setSalVal.getIncoTerms2();
	String orderDate       	= setSalVal.getOrderDate();
	int Rows		= Integer.parseInt(setSalVal.getTotal());
	 
	incoTerms1=(incoTerms1==null)?" ":incoTerms1;
	incoTerms2=(incoTerms2==null)?" ":EzReplace.setReplace(incoTerms2);
	
	String carrierName    		= "02";		// hardcoded value will be sent if shiptype is null

	if("SP".equals(fServType)) carrierName = " ";

	String shippingCond    = request.getParameter("shippingCond");
	shippingCond	= carrierName;
	shippingCond	= (shippingCond==null)?" ":shippingCond;
	
	String generalNotesAll = "";
	String generalNotes 		= setSalVal.getGeneralNotes();
	String packingInstructions 	= setSalVal.getPackingInstructions();  
	String labelInstructions 	= setSalVal.getLabelInstructions();
	String inspectionClauses 	= setSalVal.getInspectionClauses();
	String handlingSpecifications 	= setSalVal.getHandlingSpecifications();  
	String regulatoryRequirments 	= setSalVal.getRegulatoryRequirements();
	String documentsRequired 	= setSalVal.getDocumentsRequired();
	String others 			= setSalVal.getOthers();
	String generalNotes1		= setSalVal.getGeneralNotes1();
	String generalNotes2		= setSalVal.getGeneralNotes2(); 
	String generalNotes3		= setSalVal.getGeneralNotes3();
	
	log4j.log("in EditSubmitOrder in EditSubmitOrder in EditSubmitOrder in EditSubmitOrder7","W");

	generalNotes 		= ((generalNotes==null)||(generalNotes.trim().length()==0))?"None":EzReplace.setReplace(generalNotes);
	packingInstructions 	= ((packingInstructions==null)||(packingInstructions.trim().length()==0))?"None":EzReplace.setReplace(packingInstructions);
	labelInstructions 	= ((labelInstructions==null)||(labelInstructions.trim().length()==0))?"None":EzReplace.setReplace(labelInstructions);
	inspectionClauses 	= ((inspectionClauses==null)||(inspectionClauses.trim().length()==0))?"None":EzReplace.setReplace(inspectionClauses);
	handlingSpecifications 	= ((handlingSpecifications==null)||(handlingSpecifications.trim().length()==0))?"None":EzReplace.setReplace(handlingSpecifications);
	regulatoryRequirments 	= ((regulatoryRequirments==null)||(regulatoryRequirments.trim().length()==0))?"None":EzReplace.setReplace(regulatoryRequirments);
	documentsRequired 	= ((documentsRequired==null)||(documentsRequired.trim().length()==0))?"None":EzReplace.setReplace(documentsRequired);
	others 			= ((others==null)||(others.trim().length()==0))?"None":EzReplace.setReplace(others);
	generalNotes1 		= ((generalNotes1==null)||(generalNotes1.trim().length()==0))?"":EzReplace.setReplace(generalNotes1);
	generalNotes2 		= ((generalNotes2==null)||(generalNotes2.trim().length()==0))?"None":EzReplace.setReplace(generalNotes2);
	generalNotes3 		= ((generalNotes3==null)||(generalNotes3.trim().length()==0))?"None":EzReplace.setReplace(generalNotes3);
	generalNotesAll		= "GeneralNotes@@ezc@@"+generalNotes.trim()+"^^ezc^^PackingInstructions@@ezc@@"+packingInstructions.trim()+"^^ezc^^LabelInstructions@@ezc@@"+labelInstructions.trim()+"^^ezc^^InspectionClauses@@ezc@@"+inspectionClauses.trim()+"^^ezc^^HandlingSpecifications@@ezc@@"+handlingSpecifications.trim()+"^^ezc^^Requlatoryrequirments@@ezc@@"+regulatoryRequirments.trim()+"^^ezc^^DocumentsRequired@@ezc@@"+documentsRequired.trim()+"^^ezc^^Others@@ezc@@"+others.trim();
	specialShIns 		= ((specialShIns==null)||(specialShIns.trim().length()==0))?"None":EzReplace.setReplace(specialShIns);
	generalNotes2           = specialShIns;
	
	if(shAttn==null || "null".equals(shAttn) || "".equals(shAttn)) shAttn = "N/A";
	if(shTel==null || "null".equals(shTel) || "".equals(shTel)) shTel = "N/A";
	if(shMobi==null || "null".equals(shMobi) || "".equals(shMobi)) shMobi = "N/A"; 
	if(shFax==null || "null".equals(shFax) || "".equals(shFax)) shFax = "N/A";

	generalNotesAll		= shAttn+"¥"+shTel+"¥"+shMobi+"¥"+shFax;
	  
	ReturnObjFromRetrieve orderError=null;
	String ErrorType 	= "";
	String ErrorMessage 	= "";
	boolean SAPnumber 	= true;
   	String sDocNumber 	= null;	
   	String sTempDocNumber 	= null;	
	String weborno 		= null;
	String docType	=(String)session.getValue("docType");
	String Div	=(String)session.getValue("division");
	String DC 	=(String)session.getValue("dc");
	String SalesOrg	=(String)session.getValue("salesOrg");
	ReturnObjFromRetrieve reterpdef = null;
	ReturnObjFromRetrieve orders =null;
	log4j.log("in EditSubmitOrder in EditSubmitOrder in EditSubmitOrder in EditSubmitOrder8","W");
%>
<Html>
<Body>
<Form target=main>   
<%     
	try
	{
%>
		<%@ include file="../../../Includes/JSPs/Sales/iEditSubmitOrder.jsp"%>
<%
	}
	catch(Exception e)
	{
		System.out.println("Error in iEditSubmitOrder.jsp");  
	}
%>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
<jsp:forward page="../Misc/ezOutMsg.jsp"></jsp:forward>