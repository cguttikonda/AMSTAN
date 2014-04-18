<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>iHwy jquery listnav plugin - list navigation for ordered and unordered lists</title>

	<link rel="stylesheet" href="http://cdn.ihwy.net/ihwy-com/assets/css/reset-min.css" type="text/css" media="screen" charset="utf-8" />
	<link rel="stylesheet" href="http://cdn.ihwy.net/ihwy-com/assets/css/ihwy-2012.css" type="text/css" media="screen" charset="utf-8" />
	<link rel="stylesheet" href="http://cdn.ihwy.net/ihwy-com/labs/jquery-listnav/2.1/jquery.listnav-2.1.css" type="text/css" media="screen" charset="utf-8" />

	<style type="text/css" media="screen" charset="utf-8">
		body { background:none; }
		.demoWrapper { margin:15px; }
		pre.chili { margin-bottom:2em; }
		#btnDemo2 { margin-bottom:1em; }
	</style>

	<script type="text/javascript" src="http://cdn.ihwy.net/ihwy-com/assets/js/lib/jquery-1.3.2.min.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://cdn.ihwy.net/ihwy-com/assets/js/lib/jquery.cookie.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://cdn.ihwy.net/ihwy-com/assets/js/lib/jquery.idTabs.min.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://cdn.ihwy.net/ihwy-com/labs/jquery-listnav/2.1/jquery.listnav-2.1.js" charset="utf-8"></script>


	<script type="text/javascript" charset="utf-8">
		$(function(){
			if(top.location.href.toLowerCase() == self.location.href.toLowerCase()) $('#docLink').show();

			$("#tabNav ul").idTabs("tab1"); 
			$('#demoOne').listnav();

		});
	</script>
	
</head>
<body>
<form>
	
<div class="demoWrapper">
	<div class="clr"></div>
	
	<div id="tabNav">
		<ul> 
			<li><a href="#tab1">Demo 1</a></li>
		</ul>
		<div class="clr"></div>
	</div>
	<div id="tabs">
		<div id="tab1" class="tab">
			<div id="demo1">
				<div id="demoOne-nav" class="listNav"></div>

				<ul id="demoOne" class="demo">
					<li><a href="#">411 Services</a></li>
					<li><a href="accountants.aspx">Accountants</a></li>
					<li><a href="accounting-bookkeeping_general-service.aspx">Accounting & Bookkeeping - General Service</a></li>
					<li><a href="acupuncture.aspx">Acupuncture</a></li>
					<li><a href="advertising.aspx">Advertising</a></li>
					<li><a href="advertising_agencies-counselors.aspx">Advertising - Agencies & Counselors</a></li>
					<li><a href="advertising_computer.aspx">Advertising - Computer</a></li>
					<li><a href="advertising_promotional.aspx">Advertising - Promotional</a></li>
					<li><a href="attorneys_service-bureaus.aspx">Attorneys - Service Bureaus</a></li>
					<li><a href="auctioneers.aspx">Auctioneers</a></li>
					<li><a href="audio-visual-consultants.aspx">Audio Visual Consultants</a></li>
					<li><a href="audio-visual-production-service.aspx">Audio Visual Production Service</a></li>
					<li><a href="automobile_renting.aspx">Automobile - Renting</a></li>
					<li><a href="automobile_repair-service.aspx">Automobile - Repair & Service</a></li>
					<li><a href="banks.aspx">Banks</a></li>
					<li><a href="banquet-rooms.aspx">Banquet Rooms</a></li>
					<li><a href="barber-shops.aspx">Barber Shops</a></li>
					<li><a href="baseball-clubs.aspx">Baseball Clubs</a></li>
					<li><a href="book-dealers_used-rare.aspx">Book Dealers - Used & Rare</a></li>
					<li><a href="bookbinders.aspx">Bookbinders</a></li>
					<li><a href="brake-service.aspx">Brake Service</a></li>
					<li><a href="business_management-consultants.aspx">Business - Management Consultants</a></li>
					<li><a href="business_services.aspx">Business - Services</a></li>
					<li><a href="cabinet-makers.aspx">Cabinet Makers</a></li>
					<li><a href="cabinets.aspx">Cabinets</a></li>
					<li><a href="cafeterias.aspx">Cafeterias</a></li>
					<li><a href="calligraphers.aspx">Calligraphers</a></li>
					<li><a href="campgrounds.aspx">Campgrounds</a></li>
					<li><a href="cemeteries-crematories.aspx">Cemeteries & Crematories</a></li>
					<li><a href="ceramic-products_decorative.aspx">Ceramic Products - Decorative</a></li>
					<li><a href="chambers-of-commerce.aspx">Chambers of Commerce</a></li>
					<li><a href="crane-service.aspx">Crane Service</a></li>
					<li><a href="cruises.aspx">Cruises</a></li>
					<li><a href="dancing-instruction.aspx">Dancing Instruction</a></li>
					<li><a href="data-communications-equipment-systems_networks.aspx">Data Communications Equipment & Systems - Networks</a></li>
					<li><a href="deck-builders.aspx">Deck Builders</a></li>
					<li><a href="delivery-service.aspx">Delivery Service</a></li>
					<li><a href="dentists.aspx">Dentists</a></li>
					<li><a href="department-stores.aspx">Department Stores</a></li>
					<li><a href="draperies-curtains_retail-custom-made.aspx">Draperies & Curtains - Retail & Custom Made</a></li>
					<li><a href="drilling_companies.aspx">Drilling - Companies</a></li>
					<li><a href="driving_instruction.aspx">Driving - Instruction</a></li>
					<li><a href="drug_abuse-addiction-info-treatment.aspx">Drug - Abuse & Addiction Info & Treatment</a></li>
					<li><a href="drywall-insulation-contractors.aspx">Drywall & Insulation Contractors</a></li>
					<li><a href="earthquake-products-services.aspx">Earthquake Products & Services</a></li>
					<li><a href="e-commerce.aspx">E-Commerce</a></li>
					<li><a href="education-centers.aspx">Education Centers</a></li>
					<li><a href="educational-consultants.aspx">Educational Consultants</a></li>
					<li><a href="educational-service_business.aspx">Educational Service - Business</a></li>
					<li><a href="electric-contractors.aspx">Electric Contractors</a></li>
					<li><a href="electric-transmission-equipment-manufacturers.aspx">Electric Transmission Equipment (Manufacturers)</a></li>
					<li><a href="electrolysis.aspx">Electrolysis</a></li>
					<li><a href="erosion-control.aspx">Erosion Control</a></li>
					<li><a href="excavating-contractors.aspx">Excavating Contractors</a></li>
					<li><a href="executive-search-consultants.aspx">Executive Search Consultants</a></li>
					<li><a href="exercise-physical-fitness-programs.aspx">Exercise & Physical Fitness Programs</a></li>
					<li><a href="exterminating-pest-control-services.aspx">Exterminating & Pest Control Services</a></li>
					<li><a href="fabric-shops.aspx">Fabric Shops</a></li>
					<li><a href="fabrics-wholesale.aspx">Fabrics (Wholesale)</a></li>
					<li><a href="facilities-management.aspx">Facilities Management</a></li>
					<li><a href="farms.aspx">Farms</a></li>
					<li><a href="foundation_educational-philanthropic-research.aspx">Foundation - Educational Philanthropic Research</a></li>
					<li><a href="fraternities-sororities.aspx">Fraternities & Sororities</a></li>
					<li><a href="games-game-supplies.aspx">Games & Game Supplies</a></li>
					<li><a href="garbage-collection.aspx">Garbage Collection</a></li>
					<li><a href="garden-centers.aspx">Garden Centers</a></li>
					<li><a href="gas_liquefied-petroleum_bottled-bulk-wholesale.aspx">Gas - Liquefied Petroleum - Bottled & Bulk (Wholesale)</a></li>
					<li><a href="guide-service.aspx">Guide Service</a></li>
					<li><a href="gymnastic-instruction.aspx">Gymnastic Instruction</a></li>
					<li><a href="halls-auditoriums.aspx">Halls & Auditoriums</a></li>
					<li><a href="handyman-services.aspx">Handyman Services</a></li>
					<li><a href="hardware_retail.aspx">Hardware - Retail</a></li>
					<li><a href="hardwood.aspx">Hardwood</a></li>
					<li><a href="health-diet-foods_retail.aspx">Health & Diet Foods - Retail</a></li>
					<li><a href="house-building-movers.aspx">House & Building Movers</a></li>
					<li><a href="house-cleaning.aspx">House Cleaning</a></li>
					<li><a href="human-factors_research-development.aspx">Human Factors - Research & Development</a></li>
					<li><a href="human-resource-consultants.aspx">Human Resource Consultants</a></li>
					<li><a href="importers.aspx">Importers</a></li>
					<li><a href="industrial_equipment-supplies-wholesale.aspx">Industrial - Equipment & Supplies (Wholesale)</a></li>
					<li><a href="internet_services.aspx">Internet - Services</a></li>
					<li><a href="inventors.aspx">Inventors</a></li>
					<li><a href="investigators.aspx">Investigators</a></li>
					<li><a href="investment_management.aspx">Investment - Management</a></li>
					<li><a href="investments.aspx">Investments</a></li>
					<li><a href="janitor-service.aspx">Janitor Service</a></li>
					<li><a href="jewelers-wholesale.aspx">Jewelers (Wholesale)</a></li>
					<li><a href="jewelers_retail.aspx">Jewelers - Retail</a></li>
					<li><a href="jewelry_designers.aspx">Jewelry - Designers</a></li>
					<li><a href="laboratories.aspx">Laboratories</a></li>
					<li><a href="laboratories_research-development.aspx">Laboratories - Research & Development</a></li>
					<li><a href="land-companies.aspx">Land Companies</a></li>
					<li><a href="landfills_sanitary.aspx">Landfills - Sanitary</a></li>
					<li><a href="lumber-manufacturers.aspx">Lumber (Manufacturers)</a></li>
					<li><a href="lumber_retail.aspx">Lumber - Retail</a></li>
					<li><a href="machine-shops.aspx">Machine Shops</a></li>
					<li><a href="machinery_rebuilding-repairing-wholesale.aspx">Machinery - Rebuilding & Repairing (Wholesale)</a></li>
					<li><a href="machinery_specially-designed-built.aspx">Machinery - Specially Designed & Built</a></li>
					<li><a href="magicians.aspx">Magicians</a></li>
					<li><a href="maid-butler-service.aspx">Maid & Butler Service</a></li>
					<li><a href="motorcycles_supplies-parts-manufacturers.aspx">Motorcycles - Supplies & Parts (Manufacturers)</a></li>
					<li><a href="multimedia-manufacturers.aspx">Multimedia (Manufacturers)</a></li>
					<li><a href="museums.aspx">Museums</a></li>
					<li><a href="newspaper_publishers.aspx">Newspaper - Publishers</a></li>
					<li><a href="nonclassifiable-establishments.aspx">Nonclassifiable Establishments</a></li>
					<li><a href="non-profit-organizations.aspx">Non-Profit Organizations</a></li>
					<li><a href="nurseries_plants-trees-wholesale.aspx">Nurseries - Plants & Trees (Wholesale)</a></li>
					<li><a href="nurserymen.aspx">Nurserymen</a></li>
					<li><a href="nutritionists.aspx">Nutritionists</a></li>
					<li><a href="paint_retail.aspx">Paint - Retail</a></li>
					<li><a href="painters.aspx">Painters</a></li>
					<li><a href="parking-area-lots-maintenance-marking.aspx">Parking Area & Lots Maintenance & Marking</a></li>
					<li><a href="parks.aspx">Parks</a></li>
					<li><a href="party-supplies.aspx">Party Supplies</a></li>
					<li><a href="patio-deck-cleaning-restoration.aspx">Patio & Deck Cleaning & Restoration</a></li>
					<li><a href="paving-contractors.aspx">Paving Contractors</a></li>
					<li><a href="pumps-wholesale.aspx">Pumps (Wholesale)</a></li>
					<li><a href="quilting_materials-supplies.aspx">Quilting - Materials & Supplies</a></li>
					<li><a href="radio-stations-broadcasting-companies.aspx">Radio Stations & Broadcasting Companies</a></li>
					<li><a href="railroads.aspx">Railroads</a></li>
					<li><a href="ranches.aspx">Ranches</a></li>
					<li><a href="reading-improvement-instruction.aspx">Reading Improvement Instruction</a></li>
					<li><a href="reading-rooms.aspx">Reading Rooms</a></li>
					<li><a href="real-estate.aspx">Real Estate</a></li>
					<li><a href="real-estate_appraisers.aspx">Real Estate - Appraisers</a></li>
					<li><a href="real-estate_consultants.aspx">Real Estate - Consultants</a></li>
					<li><a href="restaurants.aspx">Restaurants</a></li>
					<li><a href="restaurants_american.aspx">Restaurants - American</a></li>
					<li><a href="restaurants_bakeries.aspx">Restaurants - Bakeries</a></li>
					<li><a href="restaurants_barbecue.aspx">Restaurants - Barbecue</a></li>
					<li><a href="roofing_materials.aspx">Roofing - Materials</a></li>
					<li><a href="roofing_service-consultants.aspx">Roofing - Service Consultants</a></li>
					<li><a href="sand-gravel-wholesale.aspx">Sand & Gravel (Wholesale)</a></li>
					<li><a href="school-supplies-wholesale.aspx">School Supplies (Wholesale)</a></li>
					<li><a href="schools-educational-services.aspx">Schools & Educational Services</a></li>
					<li><a href="schools_nursery-kindergarten-academic.aspx">Schools - Nursery & Kindergarten Academic</a></li>
					<li><a href="schools_universities-colleges-academic.aspx">Schools - Universities & Colleges Academic</a></li>
					<li><a href="shoe-boot-repairing.aspx">Shoe & Boot Repairing</a></li>
					<li><a href="shoes_retail.aspx">Shoes - Retail</a></li>
					<li><a href="shopping-centers-malls.aspx">Shopping Centers & Malls</a></li>
					<li><a href="shower-doors-enclosures.aspx">Shower Doors & Enclosures</a></li>
					<li><a href="sunglasses-sun-goggles-wholesale.aspx">Sunglasses & Sun Goggles (Wholesale)</a></li>
					<li><a href="surveyors_land.aspx">Surveyors - Land</a></li>
					<li><a href="tanning-salons.aspx">Tanning Salons</a></li>
					<li><a href="tattooing.aspx">Tattooing</a></li>
					<li><a href="tax-consultants.aspx">Tax Consultants</a></li>
					<li><a href="tax-return-preparation-filing.aspx">Tax Return Preparation & Filing</a></li>
					<li><a href="technical-manual-preparation.aspx">Technical Manual Preparation</a></li>
					<li><a href="tools_electric_repairing-parts.aspx">Tools - Electric - Repairing & Parts</a></li>
					<li><a href="tours_operators-promoters.aspx">Tours - Operators & Promoters</a></li>
					<li><a href="tutoring.aspx">Tutoring</a></li>
					<li><a href="ultrasonic-equipment-supplies-wholesale.aspx">Ultrasonic Equipment & Supplies (Wholesale)</a></li>
					<li><a href="upholsterers.aspx">Upholsterers</a></li>
					<li><a href="utilities_underground_cable-locating-service.aspx">Utilities - Underground - Cable Locating Service</a></li>
					<li><a href="vacuum-cleaners_household_dealers.aspx">Vacuum Cleaners - Household - Dealers</a></li>
					<li><a href="vending-machines.aspx">Vending Machines</a></li>
					<li><a href="ventilating-systems_cleaning.aspx">Ventilating Systems - Cleaning</a></li>
					<li><a href="venture-capital-companies.aspx">Venture Capital Companies</a></li>
					<li><a href="vineyards.aspx">Vineyards</a></li>
					<li><a href="vitamin-products-manufacturers.aspx">Vitamin Products (Manufacturers)</a></li>
					<li><a href="vitamins.aspx">Vitamins</a></li>
					<li><a href="wallpapers-wallcoverings_installation.aspx">Wallpapers & Wallcoverings - Installation</a></li>
					<li><a href="windows_repairing.aspx">Windows - Repairing</a></li>
					<li><a href="wineries.aspx">Wineries</a></li>
					<li><a href="wines_consultants.aspx">Wines - Consultants</a></li>
					<li><a href="wines_retail.aspx">Wines - Retail</a></li>
					<li><a href="woodworkers.aspx">Woodworkers</a></li>
					<li><a href="writers.aspx">Writers</a></li>
					<li><a href="x-ray_apparatus-supplies-manufacturers.aspx">X-Ray - Apparatus & Supplies (Manufacturers)</a></li>
					<li><a href="yarn_retail.aspx">Yarn - Retail</a></li>
					<li><a href="yoga-instruction.aspx">Yoga Instruction</a></li>
					<li><a href="youth-organizations-centers.aspx">Youth Organizations & Centers</a></li>
				</ul>
		</div>
	</div>
</div>
</div>
<script type="text/javascript" src="http://cdn.ihwy.net/ihwy-com/assets/js/lib/chili/jquery.chili-2.2.js" charset="utf-8"></script>
<script type="text/javascript" src="http://cdn.ihwy.net/ihwy-com/assets/js/lib/chili/recipes.js" charset="utf-8"></script>

</form>
</body>
</html>
