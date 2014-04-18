<% // @ include file="iLang_Lables.jsp" %>


<%

  String ezListSalesOrders_H =  getLabel("EZLISTSALESORDERS");
  String ezSOSearchByOrderNo_H = getLabel("EZSOSEARCHBYORDERNO");
  String ezSOSearchByPONO_H = getLabel("EZSOSEARCHBYPONO");
  String ezSOSearchByProduct_H = getLabel("EZSOSEARCHBYPRODUCT");
  String ezListPersMsgs_H = getLabel("EZLISTPERSMSGS");
  String ezListFolders_H = getLabel("EZLISTFOLDERS");
  String ezAddSales_H = getLabel("EZADDSALES");
  String ezOpenInvoices_H = getLabel("EZOPENINVOICES");
  String ezFullCatalog_H = getLabel("EZFULLCATALOG");
  String ezCatalog_H = getLabel("EZCATALOG");
  String ezListFavGroups_H = getLabel("EZLISTFAVGROUPS");
  String ezProductSearch_H = getLabel("EZPRODUCTSEARCH");
  String ezViewCart_H = getLabel("EZVIEWCART");
  String ezAddSCOrder_H = getLabel("EZADDSCORDER");
  String ezCopySalesOrder_H = getLabel("EZCOPYSALESORDER");
  String ezAcCopy_H = getLabel("EZACCOPY");
  String ezViewStockInfo_H = getLabel("EZVIEWSTOCKINFO");
  String ezCatalogFinalLevel_H = getLabel("EZCATALOGFINALLEVEL");
  String ezListSalesOrdersByMaterial_H = getLabel("EZLISTSALESORDERSBYMATERIAL");
  String ezSelectSoldTo_H = getLabel("EZSELECTSOLDTO");
  String ezAddSelectRF_H = getLabel("EZADDSELECTRF");
  String ezAddRollingForecast_H = getLabel("EZADDROLLINGFORECAST");
  String ezViewRollingForecast_H = getLabel("EZVIEWROLLINGFORECAST");
  String ezStockAlert_H = getLabel("EZSTOCKALERT");
  String ezQuickSearch_H = getLabel("EZQUICKSEARCH");
  String ezGetDeliveryNos_H = getLabel("EZGETDELIVERYNOS");
  String ezPassword_H = getLabel("EZPASSWORD");
  String ezGetInfo_H =  getLabel("EZGETINFO");
  String ezAddStockInfo_H = getLabel("EZADDSTOCKINFO");
  String ezViewOrders_H =  getLabel("EZVIEWORDERS");
  String ezViewDispatchInfo_H = getLabel("EZVIEWDISPATCHINFO");
  String ezViewReceivedDel_H = getLabel("EZVIEWRECEIVEDDEL");
  String ezAddProjectionsByCM_H = getLabel("EZADDPROJECTIONSBYCM");
  String ezEditProjections_H = getLabel("EZEDITPROJECTIONS");
  String ezViewProjections_H = getLabel("EZVIEWPROJECTIONS");
  String ezViewProjectionPerform_H = getLabel("EZVIEWPROJECTIONPERFORM");
  String ezViewByCountry_H = getLabel("EZVIEWBYCOUNTRY");
  String ezWelcome_H =  getLabel("EZWELCOME");
  String ezBackEndSOList_H = getLabel("EZBACKENDSOLIST");
  String ezBackEndSODetails_H = getLabel("EZBACKENDSODETAILS");
  String ezCreditDSS_H = getLabel("EZCREDITDSS");
  String ezOrdersDSS_H = getLabel("EZORDERSDSS");
  String ezProjectionPerformDSS_H = getLabel("EZPROJECTIONPERFORMDSS");
  String ezStockDSS_H =  getLabel("EZSTOCKDSS");
  String ezMultiEntryBulkSales_H = getLabel("EZMULTIENTRYBULKSALES");
  String iGetPricesBulk_H = getLabel("IGETPRICESBULK");
  String ezDisplay_H = getLabel("EZDISPLAY");
  String ezViewBackEndSalesDetails_H = getLabel("EZVIEWBACKENDSALESDETAILS");
  String ezListViewDelSchedule_H = getLabel("EZLISTVIEWDELSCHEDULE");
  String ezGetDeliveryBySO_H = getLabel("EZGETDELIVERYBYSO");
  String ezBackEndClosedSOList_H = getLabel("EZBACKENDCLOSEDSOLIST");
  String ezSavePassword_H = getLabel("EZSAVEPASSWORD");
  String ezPageHelp_H = getLabel("EZPAGEHELP");

 
  String ezAddSalesOrder_H = getLabel("EZADDSALESORDER");
  String ezOutMsg_H = getLabel("EZOUTMSG");
  String ezEditStockInfoByCU_H = getLabel("EZEDITSTOCKINFOBYCU");
  String ezAddReturnSalesOrder_H = getLabel("EZADDRETURNSALESORDER");
//  String ezAddSalesSh_H = getLabel("EZADDSALESSH ");
//  String ezGetPricesSh_H = getLabel("EZGETPRICESSH");
 // String ezFavGroupFinalLevel_H = getLabel("EZFAVGROUPFINALLEVEL");

  String ezRunProductSearch_H = getLabel("EZRUNPRODUCTSEARCH");
  String ezListFolder_H = getLabel("EZLISTFOLDER");
  String ezComposePersMsg_H = getLabel("EZCOMPOSEPERSMSG");
  String ezInvoiceDetails_H = getLabel("EZINVOICEDETAILS");
  String ezPaymentDetails_H = getLabel("EZPAYMENTDETAILS");
  String ezViewDeliveryDetails_H = getLabel("EZVIEWDELIVERYDETAILS");
  String ezInvoicesAging_H = getLabel("EZINVOICESAGING");
  String ezAddProjections_H = getLabel("EZADDPROJECTIONS");
  String ezDisplayReturn_H = getLabel("EZDISPLAYRETURN");


  String ezEditStockInfo_H = getLabel("EZEDITSTOCKINFO");
  String ezContactInfo_H = getLabel("EZCONTACTINFO");
  String ezProductInfo_H = getLabel("EZPRODUCTINFO");
  String ezAddGroup_H = getLabel("EZADDGROUP");
  String ezGroupDesc_H = getLabel("EZGROUPDESC");
  String ezGetPricesSh_H = getLabel("EZGETPRICESSH");

  String ezDeleteStockInfo_H = getLabel("EZDELETESTOCKINFO");
  String ezMatBonusList_H = getLabel("EZMATBONUSLIST");
  String ezMatStockBatchList_H = getLabel("EZMATSTOCKBATCHLIST");
  String ezMatPriceList_H = getLabel("EZMATPRICELIST");
  String ezMatStockExpiryList_H = getLabel("EZMATSTOCKEXPIRYLIST");

  String ezMatStockList_H = getLabel("EZMATSTOCKLIST");
  String ezMatStockExpiryBatchList_H = getLabel("EZMATSTOCKEXPIRYBATCHLIST");
  String ezAddDelSchedule_H = getLabel("EZADDDELSCHEDULE");
  String ezPersMsgDetails_H = getLabel("EZPERSMSGDETAILS");
  String ezReplyPersMsg_H = getLabel("EZREPLYPERSMSG");
  String ezCopyAddSalesOrder_H = getLabel("EZCOPYADDSALESORDER");
  String ezBackEndFRSList_H = getLabel("EZBACKENDFRSLIST");
  String ezBackEndClosedReturnList_H = getLabel("EZBACKENDCLOSEDRETURNLIST");
  String ezBackEndOpenReturnList_H = getLabel("EZBACKENDOPENRETURNLIST");
  String ezCustInvoiceDetails_H = getLabel("EZCUSTINVOICEDETAILS");
  String ezSOPaymentDetails_H = getLabel("EZSOPAYMENTDETAILS");
  String ezClosedInvoices_H = getLabel("EZCLOSEDINVOICES");
  String ezFavGroupFinalLevel_H = getLabel("EZFAVGROUPFINALLEVEL");
  String ezDisclaimer_H = getLabel("EZDISCLAIMER");
  String ezDeleteFavGroup_H = getLabel("EZDELETEFAVGROUP");
  String ezAddSalesSh_H = getLabel("EZADDSALESSH");
  String ezAddFolder_H = getLabel("EZADDFOLDER");
  String ezViewDispatchLocal_H = getLabel("EZVIEWDISPATCHLOCAL");
  String ezViewDispatches_H = getLabel("EZVIEWDISPATCHES");
  String ezShowInfo_H = getLabel("EZSHOWINFO");
  String ezIndexCU_H = getLabel("EZINDEXCU");
  
  String ezViewDespDetails_H = getLabel("EZVIEWDISPDETAILS");
  String ezViewDespDetailsLocal_H = getLabel("EZVIEWDISPDETAILSLOCAL");
  
  String ezAddProducts_H = getLabel("EZADDPRODUCTS");
  
  
  String ezCreateSalesOrder_H       = getLabel("EZCREATESALESORDER");
  String ezProductEntry_H           = getLabel("EZPRODUCTENTRY");
  String ezAddProductEntryToCart_H  = getLabel("EZADDPRODUCTENTRYTOCART");
  String ezSavedOrdersList_H        = getLabel("EZSAVEDORDERSLIST");
  String ezGridOpenInvoices_H       = getLabel("EZGRIDOPENINVOICES");
  String ezGridClosedInvoices_H     = getLabel("EZGRIDCLOSEDINVOICES");
  String ezListNews_H               = getLabel("EZLISTNEWS");
  String ezAddNews_H                = getLabel("EZADDNEWS");
  String ezEditNews_H               = getLabel("EZEDITNEWS");
  String ezEditSales_H              = getLabel("EZEDITSALES");
  String ezImageUpload_H            = getLabel("EZIMAGEUPLOAD");
  String ezDrillDownCatalog_H       = getLabel("EZDRILLDOWNCATALOG");
  //String ezListFavGroups_H          = getLabel("EZLISTFAVGROUPS");
  //String ezRunProductSearch_H       = getLabel("EZRUNPRODUCTSEARCH");
  
  	
  %>
   
   
