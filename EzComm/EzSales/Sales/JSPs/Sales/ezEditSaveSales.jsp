<%@ page import = "ezc.ezparam.*,ezc.ezbasicutil.*,ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import = "ezc.shopping.cart.params.*,ezc.shopping.cart.client.*,ezc.shopping.cart.common.*,ezc.sales.params.*" %>
<%@ page import = "java.text.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import = "ezc.ezparam.*,ezc.eznegotiation.params.*,ezc.eznegotiation.client.*" %>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../Misc/ezEncryption.jsp"%>
<%@ include file="../Misc/ezDBMethods.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShipMethods.jsp"%>
<jsp:useBean id="UAdminManager" class="ezc.client.EzUserAdminManager" scope="session" />
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%
	ReturnObjFromRetrieve itemoutTable 	= null;

	String UserType 	= (String)session.getValue("UserType");
	String UserRole 	= (String)session.getValue("UserRole");
	//String agent 		= (String)session.getValue("Agent");
	String sysKey	 	= request.getParameter("sys_key"); 
	if(sysKey==null || "null".equals(sysKey) || "".equals(sysKey))
		sysKey = (String)session.getValue("SalesAreaCode");
	String user_L 		= Session.getUserId();
	String templateName 	= request.getParameter("templateName");
	
	String fromPage 	= request.getParameter("fromPage");
	String [] lineItem	= request.getParameterValues("lineItem"); 
	if (lineItem == null){
		String poDateTmp 	= request.getParameter("poDate");
		log4j.log("lineItem.length>>>>>>>>>>>>NULL","D");
		log4j.log("poDateTmp>>>>>>>>>>>>"+poDateTmp,"D");
		}
	int lineItemLen		= lineItem.length;
	String NegFlag		= "Y";
	int flagListSize	= 0;
	try{ 
		flagListSize = Integer.parseInt(request.getParameter("flagList"));
	}
	catch(Exception e){}
	String  qType		= "";
	String  qComments	= "";
	boolean	QFlag = false;
	boolean	DFlag = false;
	boolean	NFlag = false;
	
	if(flagListSize>0)
		DFlag = true;
	if(lineItemLen>0)
	{
		for(int q=0;q<lineItemLen;q++)
		{
			int x = ((q+1)*10);
			qType		= request.getParameter("qType"+x);
			qComments	= request.getParameter("QComments"+x);
			if(qComments!=null && !"null".equals(qComments) && !"".equals(qComments))
				qComments	= qComments.replaceAll("\'","`");
			if(qType!=null && !"null".equals(qType) && !"".equals(qType))
			{
				QFlag=true;
				break;
			}	
		}
	}
	if(DFlag || QFlag)
		NFlag = true;
	

	log4j.log("lineItem.length>>>>>>>>>>>>"+lineItem.length,"D");
	log4j.log("DFlag>>>>>>>>>>>>"+DFlag,"D");
	log4j.log("QFlag>>>>>>>>>>>>"+QFlag,"D");
	log4j.log("NFlag>>>>>>>>>>>>"+NFlag,"D");
	log4j.log("qComments>>>>>>>>>>>>"+qComments+">>>>>qType>>>>>>>"+qType,"D");
	
	log4j.log("templateName>>>>>>>>>>>>"+templateName,"D");
	
	String msg  = null;

	UserRole=UserRole.trim();
	UserType=UserType.trim();
	//agent = agent.trim();
	sysKey = sysKey.trim();
	user_L = user_L.trim();

	String status = request.getParameter("status"); //"TRANSFERED";//setSalVal.getStatus();
	log4j.log("****status*****"+status,"D");
	boolean NEW 		= false;	if(("New").equalsIgnoreCase(status)) NEW = true;
	boolean TRANSFERED 	= false;	if(("Transfered").equalsIgnoreCase(status))TRANSFERED= true;
	boolean NEGOTIATED 	= false;	if(("Negotiated").equalsIgnoreCase(status))NEGOTIATED= true;
	boolean SUBMITTED 	= false;	if(("Submitted").equalsIgnoreCase(status))SUBMITTED= true;

	String paymentterms = "";//setSalVal.getPaymentTerms();
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

	String poNumber 	= request.getParameter("poNumber");
	String poDate 		= request.getParameter("poDate");
	log4j.log("poDate>>>>>>>>>>>>"+poDate,"D");
	String curr   		= request.getParameter("Currency");
	String complDlv		= request.getParameter("complDlv");

	String purposeOrder 	= request.getParameter("purposeOrder");
	String reasonCode 	= request.getParameter("reasonCode");
	String explanation 	= request.getParameter("explanation");
	String approver 	= request.getParameter("approver");
	String toAct 		= request.getParameter("toAct");
	String createdBy	= request.getParameter("createdBy");
	String defCat1	 	= request.getParameter("defCat1");
	String defCat2 		= request.getParameter("defCat2");
	String defCat3 		= request.getParameter("defCat3");

	String soldToCode 	= request.getParameter("soldToCode");
	String shipToCode 	= request.getParameter("shipToCode");

	String soldToName 	= request.getParameter("soldToName");
	String soldToStreet 	= request.getParameter("soldToStreet");
	String soldToCity 	= request.getParameter("soldToCity");
	String soldToState 	= request.getParameter("soldToState");
	String soldToCountry 	= request.getParameter("soldToCountry");
	String soldToZipCode 	= request.getParameter("soldToZipCode");
	String soldToPhNum 	= request.getParameter("soldToPhNum");
	String soldToEmail 	= request.getParameter("soldToEmail");
	String eddFlag		= request.getParameter("eddFlag"); // Flag for Expected Delivery Date


	String shipToName 	= request.getParameter("shipToName");
	if(shipToName!=null && !"null".equals(shipToName) && !"".equals(shipToName.trim()))
	{
		shipToName = shipToName.replaceAll("\'","`");
	}
	String shipToStreet 	= request.getParameter("shipToStreet");
	if(shipToStreet!=null && !"null".equals(shipToStreet) && !"".equals(shipToStreet.trim()))
	{
		shipToStreet = shipToStreet.replaceAll("\'","`");
	}
	String shipToCity 	= request.getParameter("shipToCity");
	if(shipToCity!=null && !"null".equals(shipToCity) && !"".equals(shipToCity.trim()))
	{
		shipToCity = shipToCity.replaceAll("\'","`");
	}
	String shipToState 	= request.getParameter("shipToState");
	if(shipToState!=null && !"null".equals(shipToState) && !"".equals(shipToState.trim()))
	{
		shipToState = shipToState.replaceAll("\'","`");
	}
	String shipToCountry 	= request.getParameter("shipToCountry");
	if(shipToCountry!=null && !"null".equals(shipToCountry) && !"".equals(shipToCountry.trim()))
	{
		shipToCountry = shipToCountry.replaceAll("\'","`");
	}
	String shipToZipCode 	= request.getParameter("shipToZip");
	String shipToPhNum 	= request.getParameter("shipToPhone");

	String carrierName 	= request.getParameter("carrierName");
	String carrierId 	= request.getParameter("carrierId");
	String billToName 	= request.getParameter("billToName");
	String billToStreet 	= request.getParameter("billToStreet");
	String billToCity 	= request.getParameter("billToCity");
	String billToState 	= request.getParameter("billToState");
	String billToZipCode 	= request.getParameter("billToZipCode");
	String billToCountry 	= request.getParameter("billToCountry");
	String billToAddress 	= request.getParameter("billToAddress");
	String incoTerms 	= request.getParameter("incoTerms_O");
	if(incoTerms == null || "null".equalsIgnoreCase(incoTerms)) incoTerms = "";
	String custGrp5 	= request.getParameter("custGrp5");
	if(custGrp5 == null || "null".equalsIgnoreCase(custGrp5)) custGrp5 = "";
	String custCondGrp3 	= request.getParameter("custCondGrp3");
	if(custCondGrp3 == null || "null".equalsIgnoreCase(custCondGrp3)) custCondGrp3 = "";

	String shipMethod 	= request.getParameter("shipMethod");
	String shipPartnRole 	= request.getParameter("shipPartnRole");
	String webOrdNo_S	= request.getParameter("webOrdNo");
	String freightTotal	= request.getParameter("freightTotal");
	String[] prodCode_1 	= request.getParameterValues("product");	//setSalVal.getProduct();
	String[] prodDesc_1 	= request.getParameterValues("prodDesc");	//setSalVal.getProdDesc();
	String[] prodCQty_1 	= request.getParameterValues("commitedQty");	//setSalVal.getCommitedQty();
	String[] prodPack_1 	= request.getParameterValues("pack");		//setSalVal.getPack();
	String[] prodItemCat_1 	= request.getParameterValues("ItemCat");
	String[] prodUomQty	= request.getParameterValues("UomQty");
	String[] custprodCode	= request.getParameterValues("custprodCode");
	String[] itemVenCatalog	= request.getParameterValues("itemVenCatalog");
	String[] itemOrderType	= request.getParameterValues("orderType"); 
	//String[] itemPlant	= request.getParameterValues("plant");
	String[] itemPlant	= request.getParameterValues("itemPlant");
	String[] itemMfrPart	= request.getParameterValues("itemMfrPart"); 
	String[] itemMfrNr	= request.getParameterValues("itemMfrNr"); 
	String[] itemEanUPC	= request.getParameterValues("itemEanUPC"); 
	String[] itemMatId	= request.getParameterValues("itemMatId");
	String[] itemLineItem	= request.getParameterValues("itemLineItem");
	String[] splitKey	= request.getParameterValues("splitKey");

	String[] itemMmFlag	= request.getParameterValues("itemMmFlag");
	String[] itemDiscCode	= request.getParameterValues("itemDiscCode");
	String[] itemPromoCode  = request.getParameterValues("itemPromoCode");
	String[] itemWeight	= request.getParameterValues("itemWeight");
	String[] itemCnetProd	= request.getParameterValues("itemCnetProd");
	String[] itemMfrCode	= request.getParameterValues("itemMfrCode");
	String[] itemOrgPrice	= request.getParameterValues("itemOrgPrice");
	String[] itemClass_1	= request.getParameterValues("itemClass");

	String[] quoteNum_1	= request.getParameterValues("quoteNum");
	String[] lineNum_1	= request.getParameterValues("lineNum");

	//String promoCode 	= request.getParameter("hidePromoCode");
	String promoCode	= request.getParameter("promoCode");
	String fServType 	= request.getParameter("fServType");
	String specialShIns	= request.getParameter("specialShIns");
	String grandTotalVal	= request.getParameter("grandTotalVal");

	String freightPrice 	= request.getParameter("freightVal"); 
	String freightWeight 	= request.getParameter("weight");
	String freightIns	= request.getParameter("freightIns");
	String dvToAct		= request.getParameter("dvToAct");
	String dvActBy		= request.getParameter("dvActBy");
	String dropShipTo	= request.getParameter("dropShipTo");
	String miscSplitKey 	= request.getParameter("miscSplitKey");
	String miscHandFee 	= request.getParameter("miscHandFee");
	String isResidential 	= request.getParameter("isResidential");
	String vipFlag_S 	= request.getParameter("vipFlag_S");
	String dispFlag_S 	= request.getParameter("dispFlag_S");
	String attachFile 	= request.getParameter("attachFile");

	if(attachFile!=null && !"null".equalsIgnoreCase(attachFile) && !"".equals(attachFile))
	{
		attachFile = replaceString(attachFile,"¥","/");
		session.putValue("ATTACHEDFILES",attachFile);
		session.putValue("FILEPATH","Y");
	}

	String shipToTransZone	= "";

	if(shipToCountry!=null && "PR".equals(shipToCountry.trim()))
	{
		shipToTransZone = "ZPRPR00000";
		shipToState = "";
	}
	else
		shipToCountry = "US";

	if(shipToState!=null && !"null".equalsIgnoreCase(shipToState) && !"".equals(shipToState))
		shipToTransZone = "ZUS"+shipToState.trim()+"00000";

	if(isResidential==null || "null".equalsIgnoreCase(isResidential) || "".equals(isResidential)) isResidential = "";

	String shipComplete 	= (String)session.getValue("SHIPCOMP_PREP");//request.getParameter("shipComplete");
	if(shipComplete!=null && "on".equalsIgnoreCase(shipComplete))shipComplete="Y";
	else shipComplete="N";
	//String shipMethod 	= request.getParameter("shipMethod");
	//String desiredDate 	= request.getParameter("desiredDate");
	String[] listPrice	= request.getParameterValues("listPrice");
	String[] dispFlag	= request.getParameterValues("dispFlag"); 
	String[] vipFlag	= request.getParameterValues("vipFlag");
	String[] qsFlag		= request.getParameterValues("qsFlag");
	String[] itemCustSku	= request.getParameterValues("itemCustSku");
	String[] itemPoLine	= request.getParameterValues("itemPoLine"); 
	String[] poLineNum	= request.getParameterValues("lineNum"); 
	//String[] itemVenCatalog	= request.getParameterValues("itemVenCatalog");
	String[] splitItemNo_1	= request.getParameterValues("splitItemNo");
	String[] kitComp_1	= request.getParameterValues("kitComp");

	String[] itemVolume	= request.getParameterValues("itemVolume");
	String[] itemPoints	= request.getParameterValues("itemPoints");

	int prodCodeLength = prodCode_1.length;

	String[] desiredDate_1 = request.getParameterValues("desiredDate"); 	//setSalVal.getDesiredDate();
	String[] lineValue_1   = request.getParameterValues("lineValue");	//setSalVal.getLineValue();
	//String[] desiredPrice_1= request.getParameterValues("desiredPrice");	//setSalVal.getDesiredPrice();
	String[] desiredPrice_1= request.getParameterValues("finalPrice");
	String[] itemListPrice = request.getParameterValues("itemListPrice");	//setSalVal.getDesiredPrice();
	String[] finalPriceVal_1= request.getParameterValues("finalPriceVal");
	String[] del_sch_qty_1 = request.getParameterValues("delSchQty");	//setSalVal.getDel_sch_qty();
	String[] del_sch_date_1= request.getParameterValues("delSchDate");	//setSalVal.getDel_sch_date();
	String incoTerms1      = "";	//setSalVal.getIncoTerms1();   
	String incoTerms2      = "";	//setSalVal.getIncoTerms2();
	incoTerms1=(incoTerms1==null)?" ":incoTerms1;
	incoTerms2=(incoTerms2==null)?" ":EzReplace.setReplace(incoTerms2);

	log4j.log("in AddSave in AddSave in AddSave in AddSave in AddSave in AddSave--carrierName:-->"+carrierName,"W");

	String headerReqDate = request.getParameter("desiredDate");	//requiredDate

	GregorianCalendar reqDateH = null;
	try
	{
		reqDateH = new GregorianCalendar(Integer.parseInt(headerReqDate.substring(6,10)),(Integer.parseInt(headerReqDate.substring(0,2))-1),Integer.parseInt(headerReqDate.substring(3,5)));
	}
	catch(Exception e)
	{
		reqDateH = (GregorianCalendar)GregorianCalendar.getInstance();
	}

	String shippingCond    = request.getParameter("shippingCond");
	shippingCond	= carrierName;
	shippingCond=(shippingCond==null)?" ":shippingCond;
	
	String generalNotesAll = "";
	String generalNotes 		= "";	//setSalVal.getGeneralNotes();
	String packingInstructions 	= "";	//setSalVal.getPackingInstructions();  
	String labelInstructions 	= "";	//setSalVal.getLabelInstructions();
	String inspectionClauses 	= "";	//setSalVal.getInspectionClauses();
	String handlingSpecifications 	= "";	//setSalVal.getHandlingSpecifications();
	String regulatoryRequirments 	= "";	//setSalVal.getRegulatoryRequirements();
	String documentsRequired 	= "";	//setSalVal.getDocumentsRequired();
	String others 			= "";	//setSalVal.getOthers(); 
	String generalNotes1		= request.getParameter("comments");		//setSalVal.getGeneralNotes1();
	String generalNotes2		= request.getParameter("shipInst");		//setSalVal.getGeneralNotes2();
	String generalNotes3		= "";	//setSalVal.getGeneralNotes3();

	generalNotes 		= ((generalNotes==null)||(generalNotes.trim().length()==0))?"None":EzReplace.setReplace(generalNotes);
	packingInstructions 	= ((packingInstructions==null)||(packingInstructions.trim().length()==0))?"None":EzReplace.setReplace(packingInstructions);
	labelInstructions 	= ((labelInstructions==null)||(labelInstructions.trim().length()==0))?"None":EzReplace.setReplace(labelInstructions);
	inspectionClauses 	= ((inspectionClauses==null)||(inspectionClauses.trim().length()==0))?"None":EzReplace.setReplace(inspectionClauses);
	handlingSpecifications 	= ((handlingSpecifications==null)||(handlingSpecifications.trim().length()==0))?"None":EzReplace.setReplace(handlingSpecifications);
	regulatoryRequirments 	= ((regulatoryRequirments==null)||(regulatoryRequirments.trim().length()==0))?"None":EzReplace.setReplace(regulatoryRequirments);
	documentsRequired 	= ((documentsRequired==null)||(documentsRequired.trim().length()==0))?"None":EzReplace.setReplace(documentsRequired);
	others 			= ((others==null)||(others.trim().length()==0))?"None":EzReplace.setReplace(others);
	generalNotes1 		= ((generalNotes1==null)||(generalNotes1.trim().length()==0))?"":EzReplace.setReplace(generalNotes1);
	generalNotes2 		= ((generalNotes2==null)||(generalNotes2.trim().length()==0))?"":EzReplace.setReplace(generalNotes2);
	generalNotes3 		= ((generalNotes3==null)||(generalNotes3.trim().length()==0))?"None":EzReplace.setReplace(generalNotes3);
	generalNotesAll		= "";//"GeneralNotes@@ezc@@"+generalNotes.trim()+"^^ezc^^PackingInstructions@@ezc@@"+packingInstructions.trim()+"^^ezc^^LabelInstructions@@ezc@@"+labelInstructions.trim()+"^^ezc^^InspectionClauses@@ezc@@"+inspectionClauses.trim()+"^^ezc^^HandlingSpecifications@@ezc@@"+handlingSpecifications.trim()+"^^ezc^^Requlatoryrequirments@@ezc@@"+regulatoryRequirments.trim()+"^^ezc^^DocumentsRequired@@ezc@@"+documentsRequired.trim()+"^^ezc^^Others@@ezc@@"+others.trim();
	specialShIns 		= ((specialShIns==null)||(specialShIns.trim().length()==0))?"None":EzReplace.setReplace(specialShIns);
	//generalNotes2           = specialShIns;

	String dlvChk = "";

	if(complDlv!=null && "on".equalsIgnoreCase(complDlv)) dlvChk = "X";

	ReturnObjFromRetrieve orderError = null;
	String ErrorType 	="";
	String ErrorMessage 	="";
	boolean SAPnumber 	=true;
   	String sDocNumber 	= null;	
   	String sTempDocNumber 	= null;	
	String weborno 		= null;

	String docType	= request.getParameter("catType_C");

	if(docType!=null && "FOC".equals(docType))
		docType = "FD";
	else
		docType	=(String)session.getValue("docType");

	String Div	=(String)session.getValue("division");
	String DC 	=(String)session.getValue("dc");
	String SalesOrg	=(String)session.getValue("salesOrg");
	ReturnObjFromRetrieve reterpdef = null;
	ReturnObjFromRetrieve orders =null;
	ReturnObjFromRetrieve ordItems =null;


	try
	{
		String dupReq = (String)session.getValue("DUPREQ");
		if(dupReq==null || "null".equalsIgnoreCase(dupReq) || "".equals(dupReq)) dupReq = "N";

		log4j.log("dupReq:-->"+dupReq,"D");
		if("N".equals(dupReq))
		{
			session.putValue("DUPREQ","Y");
%>
		<%@ include file="../../../Includes/JSPs/Sales/iEditSaveOrder.jsp"%>
<%
		}
	}
	catch(Exception e){}
%>
<%
	response.sendRedirect("../Sales/ezOutMsg.jsp");
%>