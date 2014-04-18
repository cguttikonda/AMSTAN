/*******************************************************************  
2 * File    : JSFX_ImageZoom.js  © JavaScript-FX.com  
3 * Created : 2001/08/31  
4 * Author  : Roy Whittle  (Roy@Whittle.com) www.Roy.Whittle.com  
5 * Purpose : To create a zooming effect for images  
6 * History  
7 * Date         Version        Description  
8 * 2001-08-09    1.0             First version  
9 * 2001-08-31    1.1             Code split - others became JSFX_FadingRollovers,  
10 *                             JSFX_ImageFader and JSFX_ImageZoom.  
11 * 2002-01-27    1.2             Completed development by converting to JSFX namespace  
12 * 2002-04-25    1.3             Added the functions stretchIn & expandIn  
13 * 2004-01-06    1.4             Allowed for the image (tag) being forcibly sized  
14 ***********************************************************************/  
15 /*** Create some global variables ***/  
16 if(!window.JSFX)  
17         JSFX=new Object();  
18 JSFX.ImageZoomRunning = false;  
19 /*******************************************************************  
20 *  
21 * Function    : zoomIn  
22 *  
23 * Description : This function is based on the turn_on() function  
24 *                     of animate2.js (animated rollovers from www.roy.whittle.com).  
25 *                     Each zoom object is given a state.  
26 *                       OnMouseOver the state is switched depending on the current state.  
27 *                       Current state -> Switch to  
28 *                       ===========================  
29 *                       null            ->      OFF.  
30 *                       OFF             ->      ZOOM_IN + start timer  
31 *                       ZOOM_OUT        ->      ZOOM_IN  
32 *                       ZOOM_IN_OUT     ->      ZOOM_IN  
33 *****************************************************************/  
34 JSFX.zoomOn = function(img, zoomStep, maxZoom)  
35 {  
36         if(img)  
37         {  
38                 if(!zoomStep)  
39                 {  
40                         if(img.mode == "EXPAND")  
41                                 zoomStep = img.height/10;  
42                         else  
43                                 zoomStep = img.width/10;  
44                 }  
45  
46                 if(!maxZoom)  
47                 {  
48                         if(img.mode == "EXPAND")  
49                                 maxZoom = img.height/2;  
50                         else  
51                                 maxZoom = img.width/2;  
52                 }  
53  
54  
55                 if(img.state == null)  
56                 {  
57                         img.state = "OFF";  
58                         img.index = 0;  
59                         img.orgWidth =  img.width;  
60                         img.orgHeight = img.height;  
61                         img.zoomStep = zoomStep;  
62                         img.maxZoom  = maxZoom;  
63                 }  
64  
65                 if(img.state == "OFF")  
66                 {  
67                         img.state = "ZOOM_IN";  
68                         start_zooming();  
69                 }  
70                 else if( img.state == "ZOOM_IN_OUT"  
71                         || img.state == "ZOOM_OUT")  
72                 {  
73                         img.state = "ZOOM_IN";  
74                 }  
75         }  
76 }  
77 JSFX.zoomIn = function(img, zoomStep, maxZoom)  
78 {  
79         img.mode = "ZOOM";  
80         JSFX.zoomOn(img, zoomStep, maxZoom);  
81 }  
82 JSFX.stretchIn = function(img, zoomStep, maxZoom)  
83 {  
84         img.mode = "STRETCH";  
85         JSFX.zoomOn(img, zoomStep, maxZoom);  
86 }  
87 JSFX.expandIn = function(img, zoomStep, maxZoom)  
88 {  
89         img.mode = "EXPAND";  
90         JSFX.zoomOn(img, zoomStep, maxZoom);  
91 }  
92 /*******************************************************************  
93 *  
94 * Function    : zoomOut  
95 *  
96 * Description : This function is based on the turn_off function  
97 *                     of animate2.js (animated rollovers from www.roy.whittle.com).  
98 *                     Each zoom object is given a state.  
99 *                       OnMouseOut the state is switched depending on the current state.  
100 *                       Current state -> Switch to  
101 *                       ===========================  
102 *                       ON              ->      ZOOM_OUT + start timer  
103 *                       ZOOM_IN ->      ZOOM_IN_OUT.  
104 *****************************************************************/  
105 JSFX.zoomOut = function(img)  
106 {  
107         if(img)  
108         {  
109                 if(img.state=="ON")  
110                 {  
111                         img.state="ZOOM_OUT";  
112                         start_zooming();  
113                 }  
114                 else if(img.state == "ZOOM_IN")  
115                 {  
116                         img.state="ZOOM_IN_OUT";  
117                 }  
118         }  
119 }  
120 /*******************************************************************  
121 *  
122 * Function    : start_zooming  
123 *  
124 * Description : This function is based on the start_animating() function  
125 *                       of animate2.js (animated rollovers from www.roy.whittle.com).  
126 *                       If the timer is not currently running, it is started.  
127 *                       Only 1 timer is used for all objects  
128 *****************************************************************/  
129 function start_zooming()  
130 {  
131         if(!JSFX.ImageZoomRunning)  
132                 ImageZoomAnimation();  
133 }  
134  
135 JSFX.setZoom = function(img)  
136 {  
137         if(img.mode == "STRETCH")  
138         {  
139                 img.width  = img.orgWidth  + img.index;  
140                 img.height = img.orgHeight;  
141         }  
142         else if(img.mode == "EXPAND")  
143         {  
144                 img.width  = img.orgWidth;  
145                 img.height = img.orgHeight + img.index;  
146         }  
147         else  
148         {  
149                 img.width  = img.orgWidth   + img.index;  
150                 img.height = img.orgHeight  + (img.index * (img.orgHeight/img.orgWidth));  
151         }  
152 }  
153 /*******************************************************************  
154 *  
155 * Function    : ImageZoomAnimation  
156 *  
157 * Description : This function is based on the Animate function  
158 *                   of animate2.js (animated rollovers from www.roy.whittle.com).  
159 *                   Each zoom object has a state. This function  
160 *                   modifies each object and (possibly) changes its state.  
161 *****************************************************************/  
162 function ImageZoomAnimation()  
163 {  
164         JSFX.ImageZoomRunning = false;  
165         for(i=0 ; i<document.images.length ; i++)  
166         {  
167                 var img = document.images[i];  
168                 if(img.state)  
169                 {  
170                         if(img.state == "ZOOM_IN")  
171                         {  
172                                 img.index+=img.zoomStep;  
173                                 if(img.index > img.maxZoom)  
174                                         img.index = img.maxZoom;  
175  
176                                 JSFX.setZoom(img);  
177  
178                                 if(img.index == img.maxZoom)  
179                                         img.state="ON";  
180                                 else  
181                                         JSFX.ImageZoomRunning = true;  
182                         }  
183                         else if(img.state == "ZOOM_IN_OUT")  
184                         {  
185                                 img.index+=img.zoomStep;  
186                                 if(img.index > img.maxZoom)  
187                                         img.index = img.maxZoom;  
188  
189                                 JSFX.setZoom(img);  
190          
191                                 if(img.index == img.maxZoom)  
192                                         img.state="ZOOM_OUT";  
193                                 JSFX.ImageZoomRunning = true;  
194                         }  
195                         else if(img.state == "ZOOM_OUT")  
196                         {  
197                                 img.index-=img.zoomStep;  
198                                 if(img.index < 0)  
199                                         img.index = 0;  
200  
201                                 JSFX.setZoom(img);  
202  
203                                 if(img.index == 0)  
204                                         img.state="OFF";  
205                                 else  
206                                         JSFX.ImageZoomRunning = true;  
207                         }  
208                 }  
209         }  
210         /*** Check to see if we need to animate any more frames. ***/  
211         if(JSFX.ImageZoomRunning)  
212                 setTimeout("ImageZoomAnimation()", 40);  
213 }  
