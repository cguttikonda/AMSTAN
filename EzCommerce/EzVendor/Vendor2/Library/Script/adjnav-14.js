
/**
 * Product:     Layered Navigation Pro for Enterprise 29/06/11 
 * Package:     AdjustWare_Nav_10.1.1_10.0.0_83897
 * Purchase ID: n/a
 * Generated:   2011-07-18 15:13:52
 * File path:   skin/frontend/base/default/js/adjnav-14.js
 * Copyright:   (c) 2011 AITOC, Inc.
 */
// checking if IE: this variable will be understood by IE: isIE = !false
isIE = /*@cc_on!@*/false;

Control.Slider.prototype.setDisabled = function()
{
    this.disabled = true;
    
    if (!isIE)
    {
        this.track.parentNode.className = this.track.parentNode.className + ' disabled';
    }
};


Control.Slider.prototype._isButtonForDOMEvents = function (event, code) {
    return event.which ? (event.which === code + 1) : (event.button === code);
}

Control.Slider.prototype.startDrag = function(event) {
    if((this._isButtonForDOMEvents(event,0))||(Event.isLeftClick(event)))  {
      if (!this.disabled){
        this.active = true;

        var handle = Event.element(event);
        var pointer  = [Event.pointerX(event), Event.pointerY(event)];
        var track = handle;
        if (track==this.track) {
          var offsets  = this.track.cumulativeOffset();
          this.event = event;
          this.setValue(this.translateToValue(
           (this.isVertical() ? pointer[1]-offsets[1] : pointer[0]-offsets[0])-(this.handleLength/2)
          ));
          var offsets  = this.activeHandle.cumulativeOffset();
          this.offsetX = (pointer[0] - offsets[0]);
          this.offsetY = (pointer[1] - offsets[1]);
        } else {
          // find the handle (prevents issues with Safari)
          while((this.handles.indexOf(handle) == -1) && handle.parentNode)
            handle = handle.parentNode;

          if (this.handles.indexOf(handle)!=-1) {
            this.activeHandle    = handle;
            this.activeHandleIdx = this.handles.indexOf(this.activeHandle);
            this.updateStyles();

            var offsets  = this.activeHandle.cumulativeOffset();
            this.offsetX = (pointer[0] - offsets[0]);
            this.offsetY = (pointer[1] - offsets[1]);
          }
        }
      }
      Event.stop(event);
    }
  };

 
function adj_nav_hide_products()
{
    var items = $('narrow-by-list').select('a', 'input');
    n = items.length;
    for (i=0; i<n; ++i){
        items[i].addClassName('adj-nav-disabled');
    }
    
    if (typeof(adj_slider) != 'undefined')
        adj_slider.setDisabled();
    
    var divs = $$('div.adj-nav-progress');
    for (var i=0; i<divs.length; ++i)
        divs[i].show();
}

function adj_nav_show_products(transport)
{
    var resp = {} ;
    if (transport && transport.responseText){
        try {
            resp = eval('(' + transport.responseText + ')');
        }
        catch (e) {
            resp = {};
        }
    }
    
    if (resp.products){
        var el = $('adj-nav-container');
        var ajaxUrl = $('adj-nav-ajax').value;
        
        el.update(resp.products.gsub(ajaxUrl, $('adj-nav-url').value));
        adj_nav_toolbar_init(); // reinit listeners
        
        
        if (!$$('body')[0].hasClassName('checkout-onepage-index')) {
            jQuery(function(){
                jQuery("select, input:checkbox").uniform();
            });
        }
        
        jQuery('#narrow-by-list dd ol').jScrollPane({ verticalDragMaxHeight: 13 });
        /* End 110928 BA Thomas */
        
                
        $('adj-nav-navigation').update(resp.layer.gsub(ajaxUrl, $('adj-nav-url').value));
        
        $('adj-nav-ajax').value = ajaxUrl;  
    }
    
    var items = $('narrow-by-list').select('a','input');
    n = items.length;
    for (i=0; i<n; ++i){
        items[i].removeClassName('adj-nav-disabled');
    }
    if (typeof(adj_slider) != 'undefined')
        adj_slider.setEnabled();
        
}

function adj_nav_add_params(k, v, isSingleVal)
{
    $('adj-nav-params').value = $('adj-nav-params').value.gsub(/\+/, ' ');
    var el = $('adj-nav-params');
    var params = el.value.parseQuery();
    
    var strVal = params[k];
    if (typeof strVal == 'undefined' || !strVal.length){
        params[k] = v;
    }
    else if('clear' == v ){
        params[k] = 'clear';
    }
    else {
        if (k == 'price')
            var values = strVal.split(',');
        else
            var values = strVal.split('-');
        
//        var values = strVal.split('-');
        if (-1 == values.indexOf(v)){
            if (isSingleVal)
                values = [v];
            else 
                values.push(v);
        } 
        else {
            values = values.without(v);
        }
                
        params[k] = values.join('-');
     }
        
   el.value = Object.toQueryString(params);//.gsub('%2B', '+');
}

function do_the_slide(){

        /* Added 110928 BA Thomas */
        var params = $('adj-nav-params').value.parseQuery();
        if(!params['q']) {
            if($('adj-nav-params').value.indexOf('adjclear=true') >= 0 && $('adjnav-has-slide').value == 1) {
                new Effect.SlideDown('category-wrapper');
                $('adjnav-has-slide').value = 0;
            } else if ($('category-wrapper').visible() && $('adjnav-has-slide').value == 0) {
                new Effect.SlideUp('category-wrapper');
                $('adjnav-has-slide').value = 1;
            } else {
                var hasNoSelectedAttribute = !$$('li a.adj-nav-attribute').any(function(ele){return ele.hasClassName('adj-nav-attribute-selected');});
                if(hasNoSelectedAttribute && $('adjnav-has-slide').value == 1)
                {
                    new Effect.SlideDown('category-wrapper');
                    $('adjnav-has-slide').value = 0;
                }
            }
        }
}

function adj_nav_make_request()
{
    adj_nav_hide_products();   
    $('adj-nav-params').value = $('adj-nav-params').value.gsub(/\+/, ' ');
    var params = $('adj-nav-params').value.parseQuery();    
    
    if (!params['order']) // Respect Sort By settings!
	{
		select = null;
		$$('select').each(function(el) {
			if (el.onchange)
			{
				if (el.onchange.toString().match(/adj_nav_toolbar_make_request/))
				{
					select = el; 
				} // if (el.onchange.toString().match(/adj_nav_toolbar_make_request/))
			} // if (el.onchange)
		});
		
		if (select)
		{
			var selectParams = select.value.parseQuery();
			
			if (selectParams && selectParams['order'])
			{
				params['order'] = selectParams['order'];
			} // if (selectParams && selectParams['order']) 
		}    
	}
    
	if (!params['dir']){params['dir'] = 'asc';}

    //Automatically descending if search...
    if(params['q']){params['dir'] = 'desc';}
	
	$('adj-nav-params').value = Object.toQueryString(params);
    
    // tmp aitoc    
    new Ajax.Request($('adj-nav-ajax').value + '?' + $('adj-nav-params').value + '&no_cache=true', 
        {method: 'get', onSuccess: adj_nav_show_products}
    );
}


function adj_update_links(evt, className, isSingleVal)
{
    var link = Event.findElement(evt, 'A'),
        sel = className + '-selected';
    
    if (link.hasClassName(sel))
        link.removeClassName(sel);    
    else
        link.addClassName(sel);
    
    //only one  price-range can be selected
    if (isSingleVal){
        var items = $('narrow-by-list').getElementsByClassName(className);
        var i, n = items.length;
        for (i=0; i<n; ++i){
            if (items[i].hasClassName(sel) && items[i].id != link.id)
                items[i].removeClassName(sel);   
        }
    }

    adj_nav_add_params(link.id.split('-')[0], link.id.split('-')[1], isSingleVal);
    
    adj_nav_make_request();    
    
    Event.stop(evt);    
}


function adj_nav_attribute_listener(evt)
{
    /**
     * Blue Acorn: Check added to disable Engrave option
    **/
    //if (personalizeSelected) {
    //    Event.stop(evt);
    //} else {
        adj_nav_add_params('p', 'clear', 1);
        adj_update_links(evt, 'adj-nav-attribute', 0);
        do_the_slide();
    //}
}

function adj_nav_icon_listener(evt)
{
    adj_nav_add_params('p', 'clear', 1);
    adj_update_links(evt, 'adj-nav-icon', 0);
}

function adj_nav_price_listener(evt)
{
    adj_nav_add_params('p', 'clear', 1);
    adj_update_links(evt, 'adj-nav-price', 1);
}

function adj_nav_clear_listener(evt)
{
    var link = Event.findElement(evt, 'A'),
        varName = link.id.split('-')[0];
    
    adj_nav_add_params('p', 'clear', 1);
    adj_nav_add_params(varName, 'clear', 1);
    
    if ('price' == varName){
        var from =  $('adj-nav-price-from'),
            to   = $('adj-nav-price-to');
          
        if (Object.isElement(from)){
            from.value = from.name;
            to.value   = to.name;
        }
    }
    
    adj_nav_make_request();    
    
    Event.stop(evt);  
}


function adj_nav_round(num){
    num = parseFloat(num);
    if (isNaN(num))
        num = 0;
        
    return Math.round(num);
}

function adj_nav_price_input_listener(evt){
    if (evt.type == 'keypress' && 13 != evt.keyCode)
        return;
        
    if (evt.type == 'keypress')
    {
        var inpObj = Event.findElement(evt, 'INPUT');
    }
    else 
    {
        var inpObj = Event.findElement(evt, 'BUTTON');
    }
        
    var sKey = inpObj.id.split('---')[1];
        
    var numFrom = adj_nav_round($('adj-nav-price-from---' + sKey).value),
        numTo   = adj_nav_round($('adj-nav-price-to---' + sKey).value);
 
    if ((numFrom<0.01 && numTo<0.01) || numFrom<0 || numTo<0)   
        return;


    adj_nav_add_params('p', 'clear', 1);
//    adj_nav_add_params('price', numFrom + ',' + numTo, true);
    adj_nav_add_params(sKey, numFrom + ',' + numTo, true);
    adj_nav_make_request();         
}

function adj_nav_category_listener(evt){
    /*var link = Event.findElement(evt, 'A');
    var catId = link.id.split('-')[1];

    var reg = /cat-/;
    if (reg.test(link.id)){ //is search
        adj_nav_add_params('cat', catId, 1);
        adj_nav_add_params('p', 'clear', 1);
        adj_nav_make_request(); 
        Event.stop(evt);  
    }*/

    //do not stop event
}

function adj_nav_toolbar_listener(evt){
    /* Added by BA 111017 because buttons are used instead of select */
    var eveElHref = (Event.findElement(evt, 'A') != undefined) ? Event.findElement(evt, 'A').href : Event.findElement(evt, 'Button').readAttribute('data_url');
    adj_nav_toolbar_make_request(eveElHref);
    Event.stop(evt); 
}

function adj_nav_toolbar_make_request(href)
{
    var pos = href.indexOf('?');
    if (pos > -1){
        $('adj-nav-params').value = href.substring(pos+1, href.length);
    }
    adj_nav_make_request();
}


function adj_nav_toolbar_init()
{
//    var items = $('adj-nav-container').select('.pages a', '.view-by a');
    /* Added by BA 111017 because buttons are used instead of select */
    var items = $('adj-nav-container').select('.pages a', '.sort-by a');
    var i, n = items.length;
    for (i=0; i<n; ++i){
        Event.observe(items[i], 'click', adj_nav_toolbar_listener);
    }

    /* Added by BA 111411 so that user is scrolled to top when clicking pagination */
    $$('.pager-bottom .pages li a, .toolbar-bottom .limiter button').each(function(ele){
        ele.observe('click', function(){new Effect.ScrollTo('adj-nav-container');});
    });


}

function adj_nav_dt_listener(evt){
//    var e = Event.findElement(evt, 'DT');
//    e.nextSiblings()[0].toggle();
//    e.toggleClassName('adj-nav-dt-selected');
}

function adj_nav_clearall_listener(evt)
{
    $('adj-nav-params').value = $('adj-nav-params').value.gsub(/\+/, ' '); 
    var params = $('adj-nav-params').value.parseQuery();
    $('adj-nav-params').value = 'adjclear=true';
    
    if (params['q'])
    {
        $('adj-nav-params').value += '&q=' + params['q'];
    }
    adj_nav_make_request();
    do_the_slide();

    Event.stop(evt); 
}

function adj_nav_init()
{
    var items, i, j, n, 
        classes = ['category', 'attribute', 'icon', 'price', 'clear', 'dt', 'clearall'];
    
    for (j=0; j<classes.length; ++j){
        items = $('narrow-by-list').select('.adj-nav-' + classes[j]);
        n = items.length;
        for (i=0; i<n; ++i){
            Event.observe(items[i], 'click', eval('adj_nav_' + classes[j] + '_listener'));
        }
    }

// start new fix code    
    items = $('narrow-by-list').select('.adj-nav-price-input-id');
    
    n = items.length;
    
    var btn = $('adj-nav-price-go');
    
    for (i=0; i<n; ++i)
    {
        btn = $('adj-nav-price-go---' + items[i].value);
        if (Object.isElement(btn)){
            Event.observe(btn, 'click', adj_nav_price_input_listener);
            Event.observe($('adj-nav-price-from---' + items[i].value), 'keypress', adj_nav_price_input_listener);
            Event.observe($('adj-nav-price-to---' + items[i].value), 'keypress', adj_nav_price_input_listener);
        }
    }
// finish new fix code    
}
  
function adj_nav_create_slider(width, from, to, min_price, max_price, sKey) 
{
    var price_slider = $('adj-nav-price-slider' + sKey);

    return new Control.Slider(price_slider.select('.handle'), price_slider, {
      range: $R(0, width),
      sliderValue: [from, to],
      restricted: true,
      
      onChange: function (values){
//        var f = adj_nav_round(max_price*values[0]/width),
//            t = adj_nav_round(max_price*values[1]/width);
        var f = adj_nav_calculate(width, from, to, min_price, max_price, values[0]),
            t = adj_nav_calculate(width, from, to, min_price, max_price, values[1]);
           
//        adj_nav_add_params('price', f + ',' + t, true);
        adj_nav_add_params(sKey, f + ',' + t, true);
        
        // we can change values without sliding  
        $('adj-nav-range-from' + sKey).update(f); 
        $('adj-nav-range-to' + sKey).update(t);
            
        adj_nav_make_request();  
      },
      onSlide: function(values) { 
//          $('adj-nav-range-from' + sKey).update(adj_nav_round(max_price*values[0]/width));
//          $('adj-nav-range-to' + sKey).update(adj_nav_round(max_price*values[1]/width));
          $('adj-nav-range-from' + sKey).update(adj_nav_calculate(width, from, to, min_price, max_price, values[0]));
          $('adj-nav-range-to' + sKey).update(adj_nav_calculate(width, from, to, min_price, max_price, values[1]));
      }
    });
}

function adj_nav_calculate(width, from, to, min_price, max_price, value)
{
    var calculated = adj_nav_round(((max_price-min_price)*value/width) + min_price);
    
    return calculated;
}
