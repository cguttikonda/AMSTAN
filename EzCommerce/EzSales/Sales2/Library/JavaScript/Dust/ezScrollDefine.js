/**
 * @(#) ezScrollDefine.js V1.0	October 22,2002
 *
 * Copyright (c) 2002 EzCommerce Inc. All Rights Reserved.
 * @ author Krishna Prasad V
 *
 **/
 
 function BrowserCheck() {
	var b = navigator.appName
	if (b=="Netscape") this.b = "ns"
	else if (b=="Microsoft Internet Explorer") this.b = "ie"
	     else this.b = b
	this.version = navigator.appVersion
	this.v = parseInt(this.version)
	this.ns = (this.b=="ns" && this.v>=4)
	this.ns4 = (this.b=="ns" && this.v==4)
	this.ns5 = (this.b=="ns" && this.v==5)
	this.ie = (this.b=="ie" && this.v>=4)
	this.ie4 = (this.version.indexOf('MSIE 4')>0)
	this.ie5 = (this.version.indexOf('MSIE 5')>0)
	this.min = (this.ns||this.ie)
 }
 is = new BrowserCheck()


DynLayer.set = false

function DynLayerInit() {

	if (!DynLayer.set) DynLayer.set = true
	if (is.ie) {
		for (var i=0; i<document.all.tags("DIV").length; i++) {
			var divname = document.all.tags("DIV")[i].id
			var index = divname.indexOf("Div")
			if (index > 0) {
				eval(divname.substr(0,index)+' = new DynLayer("'+divname+'")')
			}
		}
	}
	return true
}

function DynLayer(id,frame) {
	
	if (!DynLayer.set && !frame)
		 DynLayerInit()
	
	if (is.ie) {
		this.elm = this.event = (frame)? parent.frames[frame].document.all[id] : document.all[id]
		this.css = (frame)? parent.frames[frame].document.all[id].style : document.all[id].style
		this.doc = document
		this.x = this.elm.offsetLeft
		this.y = this.elm.offsetTop
		this.w = (is.ie4)? this.css.pixelWidth : this.elm.offsetWidth
		this.h = (is.ie4)? this.css.pixelHeight : this.elm.offsetHeight
	}
	this.id = id

	this.obj = id + "DynLayer"
	
	eval(this.obj + "=this")
	this.moveTo = DynLayerMoveTo
	this.moveBy = DynLayerMoveBy
	this.show = DynLayerShow
	this.hide = DynLayerHide
	this.slideInit = DynLayerSlideInit
	
	
}

function DynLayerMoveTo(x,y) {
	if (x!=null) {
		this.x = x
		this.css.pixelLeft = this.x
	}
	if (y!=null) {
		this.y = y
		this.css.pixelTop = this.y
	}
}
function DynLayerMoveBy(x,y) {
	this.moveTo(this.x+x,this.y+y)
}
function DynLayerShow() {
	this.css.visibility = "visible"
}
function DynLayerHide() {
	this.css.visibility = "hidden"
}

// DynLayer Slide Methods (optional)
// straight line animation methods
function DynLayerSlideInit() {

	this.slideTo = DynLayerSlideTo
	this.slideBy = DynLayerSlideBy
	this.slideStart = DynLayerSlideStart
	this.slide = DynLayerSlide
	this.onSlide = new Function("")
	this.onSlideEnd = new Function("")
}
function DynLayerSlideTo(endx,endy,inc,speed,fn) {
	if (endx==null) endx = this.x
	if (endy==null) endy = this.y
	var distx = endx-this.x
	var disty = endy-this.y
	this.slideStart(endx,endy,distx,disty,inc,speed,fn)
}
function DynLayerSlideBy(distx,disty,inc,speed,fn) {
	var endx = this.x + distx
	var endy = this.y + disty
	this.slideStart(endx,endy,distx,disty,inc,speed,fn)
}
function DynLayerSlideStart(endx,endy,distx,disty,inc,speed,fn) {
	
	if (this.slideActive) return
	if (!inc) inc = 10
	if (!speed) speed = 10
	var num = Math.sqrt(Math.pow(distx,2) + Math.pow(disty,2))/inc
	if (num==0) return
	var dx = distx/num
	var dy = disty/num
	if (!fn) fn = null
	this.slideActive = true
	this.slide(dx,dy,endx,endy,num,1,speed,fn)

}
function DynLayerSlide(dx,dy,endx,endy,num,i,speed,fn) {
	if (!this.slideActive) return
	if (i++ < num) {
		this.moveBy(dx,dy)
		this.onSlide()
		if (this.slideActive) setTimeout(this.obj+".slide("+dx+","+dy+","+endx+","+endy+","+num+","+i+","+speed+",\""+fn+"\")",speed)
		else this.onSlideEnd()
	}
	else {
		this.slideActive = false
		this.moveTo(endx,endy)
		this.onSlide()
		this.onSlideEnd()
		eval(fn)
	}
 }