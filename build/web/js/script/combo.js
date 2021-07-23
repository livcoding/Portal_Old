
if(typeof (nitobi)=="undefined"||typeof (nitobi.lang)=="undefined"){
alert("The Nitobi framework source could not be found. Is it included before any other Nitobi components?");
}
if(typeof (nitobi)=="undefined"){
nitobi={};
}
if(typeof (nitobi.Browser)=="undefined"){
nitobi.Browser={};
}
nitobi.Browser.Unload=function(){
};
nitobi.Browser.GetScrollBarWidth=function(_1){
try{
if(null==_1){
var d=document.getElementById("eba.sb.div");
if(null==d){
d=document.createElement("div");
d.id="eba.sb.div";
d.style.width="100px";
d.style.height="100px";
d.style.overflow="auto";
d.innerHTML="<div style='height:200px;'></div>";
d.style.backgroundColor="black";
d.style.position="absolute";
d.style.top=-100;
document.body.appendChild(d);
}
return (Math.abs(this.GetScrollBarWidth(d)));
}
if(nitobi.browser.IE){
return Math.abs(_1.offsetWidth-_1.clientWidth-(_1.clientLeft?_1.clientLeft*2:0));
}else{
var b=document.getBoxObjectFor(_1);
return Math.abs((b.width-_1.clientWidth));
}
}
catch(err){
}
};
nitobi.Browser.GetBrowserType=function(){
try{
return (navigator.appName=="Microsoft Internet Explorer"?this.nitobi.Browser.IE:this.nitobi.Browser.UNKNOWN);
}
catch(err){
}
};
nitobi.Browser.GetBrowserDetails=function(){
try{
return (this.GetBrowserType()==this.nitobi.Browser.IE?window.clientInformation:null);
}
catch(err){
}
};
nitobi.Browser.IsObjectInView=function(_4,_5,_6,_7){
try{
var _8=_4.getBoundingClientRect();
var _9=_5.getBoundingClientRect();
if(nitobi.browser.MOZ){
_9.top+=_5.scrollTop;
_9.bottom+=_5.scrollTop;
_9.left+=_5.scrollLeft;
_9.right+=_5.scrollLeft;
}
var _a=((true==_6?(_8.top==_9.top):(_8.top>=_9.top)&&(_8.bottom<=_9.bottom))&&(_7?true:(_8.right<=_9.right)&&(_8.left>=_9.left)));
return _a;
}
catch(err){
}
};
nitobi.Browser.VAdjust=function(_b,_c){
var v=(_b.offsetParent?_b.offsetParent.offsetTop:0);
var id=_b.id;
var _f=id.substring(0,1+id.lastIndexOf("_"))+"0";
var _10=_c.ownerDocument;
if(null==_10){
_10=_c.document;
}
var oF=_10.getElementById(_f);
return v-(oF.offsetParent?oF.offsetParent.offsetTop:0);
};
nitobi.Browser.WheelUntil=function(_12,inc,_14,idx,_16,_17){
var min=(inc?-1:0);
var max=(inc?_16:_16+1);
while(idx>min&&idx<max){
if(inc){
idx++;
}else{
idx--;
}
var r=_14.GetRow(idx);
var _1b=this.IsObjectInView(r,_17,false,true);
if(_1b==_12){
return idx;
}
}
return idx;
};
nitobi.Browser.WheelUp=function(_1c){
var top=_1c.GetRow(0);
var _1e=_1c.GetXmlDataSource().GetNumberRows()-1;
var _1f=_1c.GetRow(_1e);
var _20=_1c.GetSectionHTMLTagObject(EBAComboBoxListBody);
var i=parseInt(_20.scrollTop/top.offsetHeight);
var r=(i>_1e?_1f:_1c.GetRow(i));
var _23=r.offsetTop-_20.scrollTop+nitobi.Browser.VAdjust(r,_20);
if(this.IsObjectInView(r,_20,false,true)){
i=this.WheelUntil(false,false,_1c,i,_1e,_20);
}else{
if(_23<0){
i=this.WheelUntil(true,true,_1c,i,_1e,_20);
i--;
}else{
i=this.WheelUntil(true,false,_1c,i,_1e,_20);
i=this.WheelUntil(false,false,_1c,i,_1e,_20);
}
}
this.ScrollIntoView(_1c.GetRow(i),_20,true,false);
};
nitobi.Browser.WheelDown=function(_24){
var top=_24.GetRow(0);
var _26=_24.GetXmlDataSource().GetNumberRows()-1;
var _27=_24.GetRow(_26);
var _28=_24.GetSectionHTMLTagObject(EBAComboBoxListBody);
var i=parseInt(_28.scrollTop/top.offsetHeight);
var r=(i>_26?_27:_24.GetRow(i));
var _2b=r.offsetTop-_28.scrollTop+nitobi.Browser.VAdjust(r,_28);
if(this.IsObjectInView(r,_28,false,true)){
i=1+this.WheelUntil(false,false,_24,i,_26,_28);
}else{
if(_2b<0){
i=this.WheelUntil(true,true,_24,i,_26,_28);
}else{
i=this.WheelUntil(true,false,_24,i,_26,_28);
i=1+this.WheelUntil(false,false,_24,i,_26,_28);
}
}
r=_24.GetRow(i);
_2b=r.offsetTop-_28.scrollTop+nitobi.Browser.VAdjust(r,_28);
if(0==_2b&&i!=_26){
r=_24.GetRow(1+i);
}
this.ScrollIntoView(r,_28,true,false);
};
nitobi.Browser.ScrollIntoView=function(_2c,_2d,Top,_2f){
try{
var _30=_2c.getBoundingClientRect();
var _31=_2d.getBoundingClientRect();
var _32=_2c.offsetTop-_2d.scrollTop;
var v=nitobi.Browser.VAdjust(_2c,_2d);
_32+=v;
var _34=_2c.offsetLeft-_2d.scrollLeft;
var _35=_34+_2c.offsetWidth-_2d.offsetWidth;
var _36=_32+_2c.offsetHeight-_2d.offsetHeight;
var _37=0;
var _38=0;
var _39=this.GetScrollBarWidth(_2d);
if(this.GetVerticalScrollBarStatus(_2d)==true){
_37=_39;
}
if(_34<0){
_2d.scrollLeft+=_34;
}else{
if(_35>0){
if(_30.left-_35>_31.left){
_2d.scrollLeft+=_35+_37;
}else{
_2d.scrollLeft+=_34;
}
}
}
if((_32<0||true==Top)&&true!=_2f){
_2d.scrollTop+=_32;
}else{
if(_36>0||true==_2f){
if(_30.top-_36>_31.top||true==_2f){
_2d.scrollTop+=_36+_38;
}else{
_2d.scrollTop+=_32;
}
}
}
}
catch(err){
}
};
nitobi.Browser.GetVerticalScrollBarStatus=function(_3a){
try{
return this.GetScrollBarWidth(_3a)>0;
}
catch(err){
}
};
nitobi.Browser.GetHorizontalScrollBarStatus=function(_3b){
try{
return (_3b.scrollWidth>_3b.offsetWidth-this.GetScrollBarWidth(_3b));
}
catch(err){
}
};
nitobi.Browser.GetObjectPosition=function(_3c,_3d){
try{
var box=nitobi.html.getBox2(_3c);
switch(_3d){
case "x":
var _3f=0;
return (nitobi.browser.IE?box.left-_3f:box.left);
break;
case "y":
var _3f=0;
return (nitobi.browser.IE?box.top-_3f:box.top);
break;
default:
}
return parseInt(x);
}
catch(err){
}
};
nitobi.Browser.GetObjectXPosition=function(_40){
try{
return this.GetObjectPosition(_40,"x");
}
catch(err){
}
};
nitobi.Browser.GetObjectYPosition=function(_41){
try{
return this.GetObjectPosition(_41,"y");
}
catch(err){
}
};
nitobi.Browser.GetObjectStyle=function(_42,_43){
try{
if(nitobi.browser.IE){
var reg=new RegExp("-([a-z])","g");
_43=_43.replace(reg,function($0,$1){
return $1.toUpperCase();
});
return (_42.currentStyle.getAttribute(_43));
}
if(nitobi.browser.MOZ){
return (document.defaultView.getComputedStyle(_42,"").getPropertyValue(_43));
}
}
catch(err){
}
};
nitobi.Browser.HTMLUnencode=function(_47){
try{
var _48=_47;
var _49=new Array(/&amp;/g,/&lt;/g,/&quot;/g,/&gt;/g,/&nbsp;/g);
var _4a=new Array("&","<","\"",">"," ");
for(var i=0;i<_49.length;i++){
_48=_48.replace(_49[i],_4a[i]);
}
return (_48);
}
catch(err){
}
};
nitobi.Browser.EncodeAngleBracketsInTagAttributes=function(str,_4d){
str=str.replace(/'"'/g,"\"&quot;\"");
try{
_4d.ShowWarning(str.match(/ComboValue .*?[a-z]='/g)==null,"cw002");
}
catch(err){
}
var _4e=str.match(/".*?"/g);
if(_4e){
for(var i=0;i<_4e.length;i++){
val=_4e[i];
val=val.replace(/</g,"&lt;");
val=val.replace(/>/g,"&gt;");
str=str.replace(_4e[i],val);
}
}
return str;
};
nitobi.Browser.LoadPageFromUrl=function(Url,_51){
if(_51==null){
_51="GET";
}
var _52=xbXMLHTTP.create();
_52.abort();
_52.open(_51,Url,false,"","");
_52.send("EBA Combo Box Get Page Request");
return (_52.responseText);
};
nitobi.Browser.GetMeasurementUnitType=function(_53){
try{
if(_53==null||_53==""){
return "";
}
var _54=_53.search(/\D/g);
var _55=_53.substring(_54);
return (_55);
}
catch(err){
}
};
nitobi.Browser.GetMeasurementUnitValue=function(_56){
try{
var _57=_56.search(/\D/g);
var _58=_56.substring(0,_57);
return Number(_58);
}
catch(err){
}
};
nitobi.Browser.AttachEvent=function(_59,_5a,_5b,_5c){
try{
if(_59.addEventListener){
_59.addEventListener(_5b,_5c,false);
}else{
if(_59.attachEvent){
_59.attachEvent(_5a,_5c);
}else{
}
}
}
catch(err){
}
};
nitobi.Browser.GetElementWidth=function(_5d){
try{
if(_5d==null){
throw ("Element in GetElementWidth is null");
}
var _5e=_5d.style;
var top=_5e.top;
var _60=_5e.display;
var _61=_5e.position;
var _62=_5e.visibility;
var _63=Eba.getStyle(_5d,"visibility");
var _64=Eba.getStyle(_5d,"display");
var _65=0;
if(_64=="none"||_63=="hidden"){
_5e.position="absolute";
_5e.top=-1000;
_5e.display="inline";
_5e.visibility="visible";
}
var _66;
if(nitobi.browser.MOZ){
_66=document.getBoxObjectFor(_5d).width;
}else{
var _67=_5d.getBoundingClientRect();
_66=parseInt(_67.right)-parseInt(_67.left);
}
if(_5e.display=="inline"){
_5e.position=_61;
_5e.top=top;
_5e.display=_60;
_5e.visibility=_62;
}
return parseInt(_66);
}
catch(err){
}
};
nitobi.Browser.GetElementHeight=function(_68){
try{
if(_68==null){
throw ("Element in GetElementHeight is null");
}
var _69=_68.style;
var top=_69.top;
var _6b=_69.display;
var _6c=_69.position;
var _6d=_69.visibility;
if(_69.display=="none"||_69.visibility!="visible"){
_69.position="absolute";
_69.top=-1000;
_69.display="inline";
_69.visibility="visible";
}
var _6e;
if(nitobi.browser.MOZ){
_6e=document.getBoxObjectFor(_68).height;
}else{
var _6f=_68.getBoundingClientRect();
_6e=parseInt(_6f.bottom)-parseInt(_6f.top);
}
if(_69.display=="inline"){
_69.position=_6c;
_69.top=top;
_69.display=_6b;
_69.visibility=_6d;
}
return parseInt(_6e);
}
catch(err){
}
};
nitobi.Browser.GetParentElementByTagName=function(_70,_71){
try{
_71=_71.toLowerCase();
var _72;
do{
_70=_70.parentElement;
if(_70!=null){
_72=_70.tagName.toLowerCase();
}
}while((_72!=_71)&&(_70!=null));
return _70;
}
catch(err){
return null;
}
};
nitobi.lang.defineNs("nitobi.drawing");
nitobi.drawing.rgb=function(r,g,b){
return "#"+((r*65536)+(g*256)+b).toString(16);
};
nitobi.drawing.align=function(_76,_77,_78,oh,ow,oy,ox,_7d){
oh=oh||0;
ow=ow||0;
oy=oy||0;
ox=ox||0;
var a=_78;
var td,sd,tt,tb,tl,tr,th,tw,st,sb,sl,sr,sh,sw;
if(nitobi.browser.IE){
td=_77.getBoundingClientRect();
sd=_76.getBoundingClientRect();
tt=td.top;
tb=td.bottom;
tl=td.left;
tr=td.right;
th=Math.abs(tb-tt);
tw=Math.abs(tr-tl);
st=sd.top;
sb=sd.bottom;
sl=sd.left;
sr=sd.right;
sh=Math.abs(sb-st);
sw=Math.abs(sr-sl);
}
if(nitobi.browser.MOZ){
td=document.getBoxObjectFor(_77);
sd=document.getBoxObjectFor(_76);
tt=td.y;
tl=td.x;
tw=td.width;
th=td.height;
st=sd.y;
sl=sd.x;
sw=sd.width;
sh=sd.height;
}
if(a&268435456){
_76.style.height=th+oh;
}
if(a&16777216){
_76.style.width=tw+ow;
}
if(a&1048576){
_76.style.top=nitobi.html.getStyleTop(_76)+tt-st+oy;
}
if(a&65536){
_76.style.top=nitobi.html.getStyleTop(_76)+tt-st+th-sh+oy;
}
if(a&4096){
_76.style.left=nitobi.html.getStyleLeft(_76)-sl+tl+ox;
}
if(a&256){
_76.style.left=nitobi.html.getStyleLeft(_76)-sl+tl+tw-sw+ox;
}
if(a&16){
_76.style.top=nitobi.html.getStyleTop(_76)+tt-st+oy+Math.floor((th-sh)/2);
}
if(a&1){
_76.style.left=nitobi.html.getStyleLeft(_76)-sl+tl+ox+Math.floor((tw-sw)/2);
}
if(_7d){
src.style.top=st-2;
src.style.left=sl-2;
src.style.height=sh;
src.style.width=sw;
tgt.style.top=tt-2;
tgt.style.left=tl-2;
tgt.style.height=th;
tgt.style.width=tw;
if(document.getBoundingClientRect){
sd=_76.getBoundingClientRect();
st=sd.top;
sb=sd.bottom;
sl=sd.left;
sr=sd.right;
sh=Math.abs(sb-st);
sw=Math.abs(sr-sl);
}
if(document.getBoxObjectFor){
sd=document.getBoxObjectFor(_76);
st=sd.screenY;
sl=sd.screenX;
sw=sd.width;
sh=sd.height;
}
src2.style.top=st-2;
src2.style.left=sl-2;
src2.style.height=sh;
src2.style.width=sw;
}
};
nitobi.drawing.align.SAMEHEIGHT=268435456;
nitobi.drawing.align.SAMEWIDTH=16777216;
nitobi.drawing.align.ALIGNTOP=1048576;
nitobi.drawing.align.ALIGNBOTTOM=65536;
nitobi.drawing.align.ALIGNLEFT=4096;
nitobi.drawing.align.ALIGNRIGHT=256;
nitobi.drawing.align.ALIGNMIDDLEVERT=16;
nitobi.drawing.align.ALIGNMIDDLEHORIZ=1;
nitobi.drawing.alignOuterBox=function(_8d,_8e,_8f,oh,ow,oy,ox,_94){
oh=oh||0;
ow=ow||0;
oy=oy||0;
ox=ox||0;
if(nitobi.browser.MOZ){
td=document.getBoxObjectFor(_8e);
sd=document.getBoxObjectFor(_8d);
var _95=parseInt(document.defaultView.getComputedStyle(_8e,"").getPropertyValue("border-left-width"));
var _96=parseInt(document.defaultView.getComputedStyle(_8e,"").getPropertyValue("border-top-width"));
var _97=parseInt(document.defaultView.getComputedStyle(_8d,"").getPropertyValue("border-top-width"));
var _98=parseInt(document.defaultView.getComputedStyle(_8d,"").getPropertyValue("border-bottom-width"));
var _99=parseInt(document.defaultView.getComputedStyle(_8d,"").getPropertyValue("border-left-width"));
var _9a=parseInt(document.defaultView.getComputedStyle(_8d,"").getPropertyValue("border-right-width"));
oy=oy+_97-_96;
ox=ox+_99-_95;
}
nitobi.drawing.align(_8d,_8e,_8f,oh,ow,oy,ox,_94);
};
nitobi.lang.defineNs("nitobi.combo");
nitobi.combo.Button=function(_9b,_9c){
try{
var _9d="ComboBoxButton";
var _9e="ComboBoxButtonPressed";
var _9f="";
var _a0="";
this.SetCombo(_9c);
var _a1=(_9b?_9b.getAttribute("Width"):null);
((null==_a1)||(_a1==""))?this.SetWidth(_9f):this.SetWidth(_a1);
var _a2=(_9b?_9b.getAttribute("Height"):null);
((null==_a2)||(_a2==""))?this.SetHeight(_a0):this.SetHeight(_a2);
var _a3=(_9b?_9b.getAttribute("DefaultCSSClassName"):null);
((null==_a3)||(_a3==""))?this.SetDefaultCSSClassName(_9d):this.SetDefaultCSSClassName(_a3);
var _a4=(_9b?_9b.getAttribute("PressedCSSClassName"):null);
((null==_a4)||(_a4==""))?this.SetPressedCSSClassName(_9e):this.SetPressedCSSClassName(_a4);
this.SetCSSClassName(this.GetDefaultCSSClassName());
this.m_userTag=_9b;
this.m_prevImgClass="ComboBoxButtonImg";
}
catch(err){
}
};
nitobi.combo.Button.prototype.Unload=Button_Unload;
function Button_Unload(){
}
nitobi.combo.Button.prototype.GetDefaultCSSClassName=Button_GetDefaultCSSClassName;
function Button_GetDefaultCSSClassName(){
try{
return this.m_DefaultCSSClassName;
}
catch(err){
}
}
nitobi.combo.Button.prototype.SetDefaultCSSClassName=Button_SetDefaultCSSClassName;
function Button_SetDefaultCSSClassName(_a5){
try{
this.m_DefaultCSSClassName=_a5;
}
catch(err){
}
}
nitobi.combo.Button.prototype.GetPressedCSSClassName=Button_GetPressedCSSClassName;
function Button_GetPressedCSSClassName(){
try{
return this.m_PressedCSSClassName;
}
catch(err){
}
}
nitobi.combo.Button.prototype.SetPressedCSSClassName=Button_SetPressedCSSClassName;
function Button_SetPressedCSSClassName(_a6){
try{
this.m_PressedCSSClassName=_a6;
}
catch(err){
}
}
nitobi.combo.Button.prototype.GetHeight=Button_GetHeight;
function Button_GetHeight(){
try{
return (null==this.m_HTMLTagObject?this.m_Height:this.m_HTMLTagObject.style.height);
}
catch(err){
}
}
nitobi.combo.Button.prototype.SetHeight=Button_SetHeight;
function Button_SetHeight(_a7){
try{
if(null==this.m_HTMLTagObject){
this.m_Height=_a7;
}else{
this.m_HTMLTagObject.style.height=_a7;
}
}
catch(err){
}
}
nitobi.combo.Button.prototype.GetWidth=Button_GetWidth;
function Button_GetWidth(){
try{
if(null==this.m_HTMLTagObject){
return this.m_Width;
}else{
return this.m_HTMLTagObject.style.width;
}
}
catch(err){
}
}
nitobi.combo.Button.prototype.SetWidth=Button_SetWidth;
function Button_SetWidth(_a8){
try{
if(null==this.m_HTMLTagObject){
this.m_Width=_a8;
}else{
this.m_HTMLTagObject.style.width=_a8;
}
}
catch(err){
}
}
nitobi.combo.Button.prototype.GetHTMLTagObject=Button_GetHTMLTagObject;
function Button_GetHTMLTagObject(){
try{
return this.m_HTMLTagObject;
}
catch(err){
}
}
nitobi.combo.Button.prototype.SetHTMLTagObject=Button_SetHTMLTagObject;
function Button_SetHTMLTagObject(_a9){
try{
this.m_HTMLTagObject=_a9;
}
catch(err){
}
}
nitobi.combo.Button.prototype.GetCombo=Button_GetCombo;
function Button_GetCombo(){
try{
return this.m_Combo;
}
catch(err){
}
}
nitobi.combo.Button.prototype.SetCombo=Button_SetCombo;
function Button_SetCombo(_aa){
try{
this.m_Combo=_aa;
}
catch(err){
}
}
nitobi.combo.Button.prototype.GetCSSClassName=Button_GetCSSClassName;
function Button_GetCSSClassName(){
try{
return (null==this.m_HTMLTagObject?this.m_CSSClassName:this.m_HTMLTagObject.className);
}
catch(err){
}
}
nitobi.combo.Button.prototype.SetCSSClassName=Button_SetCSSClassName;
function Button_SetCSSClassName(_ab){
try{
if(null==this.m_HTMLTagObject){
this.m_CSSClassName=_ab;
}else{
this.m_HTMLTagObject.className=_ab;
}
}
catch(err){
}
}
nitobi.combo.Button.prototype.OnMouseOver=Button_OnMouseOver;
function Button_OnMouseOver(_ac,_ad){
try{
if(this.GetCombo().GetEnabled()){
if(null==_ac){
_ac=this.m_Img;
}
this.m_prevImgClass="ComboBoxButtonImgOver";
_ac.className=this.m_prevImgClass;
if(_ad){
this.GetCombo().GetTextBox().OnMouseOver(false);
}
}
}
catch(err){
}
}
nitobi.combo.Button.prototype.OnMouseOut=Button_OnMouseOut;
function Button_OnMouseOut(_ae,_af){
try{
if(null==_ae){
_ae=this.m_Img;
}
this.m_prevImgClass="ComboBoxButtonImg";
_ae.className=this.m_prevImgClass;
if(_af){
this.GetCombo().GetTextBox().OnMouseOut(false);
}
}
catch(err){
}
}
nitobi.combo.Button.prototype.OnMouseDown=Button_OnMouseDown;
function Button_OnMouseDown(_b0){
try{
if(this.GetCombo().GetEnabled()){
if(null!=_b0){
_b0.className="ComboBoxButtonImgPressed";
}
this.OnClick();
}
}
catch(err){
}
}
nitobi.combo.Button.prototype.OnMouseUp=Button_OnMouseUp;
function Button_OnMouseUp(_b1){
try{
if(this.GetCombo().GetEnabled()){
if(null!=_b1){
_b1.className=this.m_prevImgClass;
}
}
}
catch(err){
}
}
nitobi.combo.Button.prototype.OnClick=Button_OnClick;
function Button_OnClick(){
try{
var _b2=this.GetCombo();
var _b3=window.document.getElementsByTagName(nitobi.browser.MOZ?"ntb:Combo":"combo");
for(var i=0;i<_b3.length;i++){
var _b5=_b3[i].object;
try{
if(_b2.GetId()!=_b5.GetId()){
_b5.GetList().Hide();
}
}
catch(err){
}
}
var l=_b2.GetList();
l.Toggle();
var t=_b2.GetTextBox();
var tb=t.GetHTMLTagObject();
if(t.focused){
t.m_skipFocusOnce=true;
}
tb.focus();
}
catch(err){
}
}
nitobi.combo.Button.prototype.GetHTMLRenderString=Button_GetHTMLRenderString;
function Button_GetHTMLRenderString(){
try{
var _b9=this.GetCombo().GetId();
var uid=this.GetCombo().GetUniqueId();
var w=this.GetWidth();
var h=this.GetHeight();
if(nitobi.browser.MOZ){
var _bd="<span id='EBAComboBoxButton"+uid+"' "+"class='"+this.GetDefaultCSSClassName()+"' "+"style='"+(null!=w&&""!=w?"width:"+w+";":"")+(null!=h&&""!=h?"height:"+h+";":"")+"'>"+"<img src='javascript:void(0);' class='ComboBoxButtonImg' id='EBAComboBoxButtonImg"+uid+"' "+"onmouseover='window.document.getElementById(\""+_b9+"\").object.GetButton().OnMouseOver(this, true)' "+"onmouseout='window.document.getElementById(\""+_b9+"\").object.GetButton().OnMouseOut(this, true)' "+"onmousedown='window.document.getElementById(\""+_b9+"\").object.GetButton().OnMouseDown(this);return false;' "+"onmouseup='window.document.getElementById(\""+_b9+"\").object.GetButton().OnMouseUp(this)' "+"onmousemove='return false;' "+"></img></span>";
}else{
var _bd="<span id='EBAComboBoxButton"+uid+"' "+"class='"+this.GetDefaultCSSClassName()+"' "+"style='"+(null!=w&&""!=w?"width:"+w+";":"")+(null!=h&&""!=h?"height:"+h+";":"")+"'>"+"<img class='ComboBoxButtonImg' id='EBAComboBoxButtonImg"+uid+"' "+"onmouseover='window.document.getElementById(\""+_b9+"\").object.GetButton().OnMouseOver(this, true)' "+"onmouseout='window.document.getElementById(\""+_b9+"\").object.GetButton().OnMouseOut(this, true)' "+"onmousedown='window.document.getElementById(\""+_b9+"\").object.GetButton().OnMouseDown(this);return false;' "+"onmouseup='window.document.getElementById(\""+_b9+"\").object.GetButton().OnMouseUp(this)' "+"onmousemove='return false;' "+"></img></span>";
}
return _bd;
}
catch(err){
}
}
nitobi.combo.Button.prototype.Initialize=Button_Initialize;
function Button_Initialize(){
try{
var _be=this.GetCombo();
var uid=_be.GetUniqueId();
this.SetHTMLTagObject(window.document.getElementById("EBAComboBoxButton"+uid));
var img=window.document.getElementById("EBAComboBoxButtonImg"+uid);
var _c1=nitobi.Browser.GetObjectStyle(img,"background-image");
_c1=_c1.replace(/button\.gif/g,"blank.gif");
if(nitobi.browser.IE){
_c1=_c1.substr(5,_c1.length-7);
}else{
_c1=_c1.substr(4,_c1.length-5);
_c1=_c1.replace(/\\\(/g,"(");
_c1=_c1.replace(/\\\)/g,")");
}
img.src=_c1;
this.m_Img=img;
this._onmouseover=img.onmouseover;
this._onmouseout=img.onmouseout;
this._onclick=img.onclick;
this._onmousedown=img.onmousedown;
this._onmouseup=img.onmouseup;
if(!this.GetCombo().GetEnabled()){
this.Disable();
}
this.m_userTag=null;
}
catch(err){
}
}
nitobi.combo.Button.prototype.Disable=Button_Disable;
function Button_Disable(){
var img=this.m_Img;
img.onmouseover=null;
img.onmouseout=null;
img.onclick=null;
img.onmousedown=null;
img.onmouseup=null;
img.className="ComboBoxButtonImgDisabled";
}
nitobi.combo.Button.prototype.Enable=Button_Enable;
function Button_Enable(){
var img=this.m_Img;
img.onmouseover=this._onmouseover;
img.onmouseout=this._onmouseout;
img.onclick=this._onclick;
img.onmousedown=this._onmousedown;
img.onmouseup=this._onmouseup;
img.className="ComboBoxButtonImg";
}
nitobi.lang.defineNs("nitobi.combo");
nitobi.combo.numCombosToLoad=0;
nitobi.combo.numCombosToLoadInitially=4;
nitobi.combo.loadDelayMultiplier=10;
nitobi.getCombo=function(id){
var tag=document.getElementById(id);
};
nitobi.combo.initBase=function(){
if(nitobi.combo.initBase.done==false){
Debug=new Debug;
var _c6=[];
var _c7=window.document.getElementsByTagName(nitobi.browser.MOZ?"eba:ComboPanel":"combopanel");
var _c8=(nitobi.browser.MOZ?window.document.getElementsByTagName("ntb:ComboPanel"):[]);
for(var i=0;i<_c8.length;i++){
_c6.push(_c8[i]);
}
for(var i=0;i<_c7.length;i++){
_c6.push(_c7[i]);
}
for(var i=0;i<_c6.length;i++){
_c6[i].style.display="none";
}
g_EbaTimer=null;
nitobi.combo.createLanguagePack();
try{
g_EbaTimer=new Timer();
}
catch(err){
g_EbaTimer=null;
}
if(nitobi.browser.IE){
nitobi.combo.iframeBacker=window.document.createElement("IFRAME");
nitobi.combo.iframeBacker.style.position="absolute";
nitobi.combo.iframeBacker.style.zindex="1000";
nitobi.combo.iframeBacker.style.visibility="hidden";
nitobi.combo.iframeBacker.name="nitobi.combo.iframeBacker_Id";
nitobi.combo.iframeBacker.id="nitobi.combo.iframeBacker_Id";
nitobi.combo.iframeBacker.frameBorder=0;
nitobi.combo.iframeBacker.src="javascript:true";
window.document.body.insertAdjacentElement("afterBegin",nitobi.combo.iframeBacker);
}
nitobi.combo.initBase.done=true;
}
};
nitobi.combo.initBase.done=false;
nitobi.initCombo=function(el){
nitobi.combo.initBase();
var tag;
if(typeof (el)=="string"){
tag=document.getElementById(el);
}else{
tag=el;
}
tag.object=new nitobi.combo.Combo(tag);
tag.object.Initialize();
tag.object.GetList().Render();
return tag.object;
};
nitobi.initCombos=function(){
nitobi.combo.initBase();
var _cc=[];
var _cd=window.document.getElementsByTagName(nitobi.browser.MOZ?"eba:Combo":"combo");
var _ce=(nitobi.browser.MOZ?window.document.getElementsByTagName("ntb:Combo"):[]);
for(var i=0;i<_ce.length;i++){
_cc.push(_ce[i]);
}
for(var i=0;i<_cd.length;i++){
_cc.push(_cd[i]);
}
if(0==window.document.styleSheets.length){
alert("You are missing a link to the Web ComboBoxes' style sheet.");
}else{
nitobi.combo.numCombosToLoad=_cc.length;
for(var i=0;i<_cc.length;i++){
try{
if(i>=nitobi.combo.numCombosToLoadInitially){
var _d0=i*nitobi.combo.loadDelayMultiplier;
window.setTimeout("try{document.getElementById('"+_cc[i].id+"').object = new nitobi.combo.Combo(document.getElementById('"+_cc[i].id+"'));document.getElementById('"+_cc[i].id+"').object.Initialize();}catch(err){alert(err.message);}",_d0);
}else{
nitobi.initCombo(_cc[i]);
}
}
catch(err){
alert(err.message);
}
}
}
};
function InitializeEbaCombos(){
nitobi.initCombos();
}
nitobi.combo.finishInit=function(){
nitobi.combo.resize();
nitobi.Browser.AttachEvent(window,"onresize","resize",nitobi.combo.resize);
if(window.addEventListener){
window.addEventListener("unload",nitobi.combo.unloadAll,false);
}else{
if(document.addEventListener){
document.addEventListener("unload",nitobi.combo.unloadAll,false);
}else{
if(window.attachEvent){
window.attachEvent("onunload",nitobi.combo.unloadAll);
}else{
if(window.onunload){
window.XTRonunload=window.onunload;
}
window.onunload=nitobi.combo.unloadAll;
}
}
}
try{
eval("try{OnAfterIntializeEbaCombos()} catch(err){}");
}
catch(err){
}
};
nitobi.combo.unloadAll=function(){
try{
var _d1=[];
var _d2=window.document.getElementsByTagName(nitobi.browser.MOZ?"eba:Combo":"combo");
var _d3=(nitobi.browser.MOZ?window.document.getElementsByTagName("ntb:Combo"):[]);
for(var i=0;i<_d3.length;i++){
_d1.push(_d3[i]);
}
for(var i=0;i<_d2.length;i++){
_d1.push(_d2[i]);
}
if(_d1){
for(var i=0;i<_d1.length;i++){
if((_d1[i])&&(_d1[i].object)){
_d1[i].object.Unload();
_d1[i].object=null;
}
}
_d1=null;
}
if(nitobi.browser.IE){
if(nitobi.combo.iframeBacker){
delete nitobi.combo.iframeBacker;
nitobi.combo.iframeBacker=null;
}
}
}
catch(e){
}
};
nitobi.combo.resize=function(){
var _d5=[];
var _d6=window.document.getElementsByTagName(nitobi.browser.MOZ?"eba:Combo":"combo");
var _d7=(nitobi.browser.MOZ?window.document.getElementsByTagName("ntb:Combo"):[]);
for(var i=0;i<_d7.length;i++){
_d5.push(_d7[i]);
}
for(var i=0;i<_d6.length;i++){
_d5.push(_d6[i]);
}
for(var i=0;i<_d5.length;i++){
var _d9=_d5[i].object;
if("smartlist"!=_d9.mode){
if(_d9.GetWidth()!=null){
var _da=_d9.GetUniqueId();
var _db=_d9.GetTextBox();
var _dc=_d9.GetList();
var _dd=document.getElementById(_d9.GetId());
var _de=nitobi.Browser.GetElementWidth(_dd);
if(nitobi.browser.MOZ&&nitobi.Browser.GetMeasurementUnitType(_d9.GetWidth())=="px"){
_de=parseInt(_d9.GetWidth());
}
var _df=document.getElementById("EBAComboBoxButtonImg"+_da);
var _e0;
if(null!=_df){
_e0=nitobi.Browser.GetElementWidth(_df);
}else{
_e0=0;
}
_db.SetWidth((_de-_e0)+"px");
_dc.OnWindowResized();
}
}
}
};
if(false){
nitobi.combo=function(){
};
}
nitobi.combo.Combo=function(_e1){
try{
nitobi.prepare();
var _e2="";
var _e3="GET";
this.Timer=null;
try{
this.Timer=new Timer();
}
catch(err){
this.Timer=null;
}
var _e4="You must specify an Id for the combo box";
var _e5="ntb:Combo could not correctly transform XML data. Do you have the MS XML libraries installed? These are typically installed with your browser and are freely available from Microsoft.";
this.Version="3.5";
((null==_e1.id)||(""==_e1.id))?alert(_e4):this.SetId(_e1.id);
var _e6=null;
var _e7=null;
var _e8=null;
var _e9=null;
_e1.object=this;
this.m_userTag=_e1;
var _ea=null;
this.BuildWarningList();
var _eb=this.m_userTag.getAttribute("DisabledWarningMessages");
if(!((null==_eb)||(""==_eb))){
this.SetDisabledWarningMessages(_eb);
}
var _ec=this.m_userTag.getAttribute("ErrorLevel");
((null==_ec)||(""==_ec))?this.SetErrorLevel(""):this.SetErrorLevel(_ec);
_e1.innerHTML=_e1.innerHTML.replace(/>\s+</g,"><").replace(/^\s+</,"<").replace(/>\s+$/,">");
var dtf=_e1.getAttribute("DataTextField");
var dvf=_e1.getAttribute("DataValueField");
if((null==dtf)||(""==dtf)){
dtf=dvf;
_e1.setAttribute("DataTextField",dtf);
}
this.SetDataTextField(dtf);
this.SetDataValueField(dvf);
if((null!=dtf)&&(""!=dtf)){
if((null==dvf)||(""==dvf)){
dvf=dtf;
}
this.SetDataValueField(dvf);
}
for(var i=0;i<_e1.childNodes.length;i++){
var _f0=_e1.childNodes[i];
var n=_f0.tagName;
if(n){
n=n.toLowerCase().replace(/^eba:/,"").replace(/^ntb:/,"");
switch(n){
case "combobutton":
_e8=_f0;
break;
case "combotextbox":
_e9=_f0;
break;
case "combolist":
_e7=_f0;
break;
case "xmldatasource":
_e6=_f0;
break;
case "combovalues":
_ea=_f0;
}
}
}
var _f2="default";
var _f3=this.m_userTag.getAttribute("Mode");
if(null!=_f3){
_f3=_f3.toLowerCase();
}
switch(_f3){
case "smartsearch":
case "smartlist":
case "compact":
case "filter":
case "unbound":
this.mode=_f3;
break;
default:
this.mode=_f2;
}
var _f4=(_e7==null?null:_e7.getAttribute("DatasourceUrl"));
if((_ea==null&&_f4==null)&&this.mode!="compact"){
this.mode=_f2;
}
var _f5=25;
if(null!=_e7){
var ps=_e7.getAttribute("PageSize");
if(ps!=null&&ps!=""){
_f5=ps;
}
}
var _f7=_e1.getAttribute("InitialSearch");
this.m_InitialSearch="";
if((null==_f7)||(""==_f7)){
this.m_InitialSearch=_e2;
}else{
this.m_InitialSearch=_f7;
}
var rt=_e1.getAttribute("HttpRequestMethod");
((null==rt)||(""==rt))?this.SetHttpRequestMethod(_e3):this.SetHttpRequestMethod(rt);
this.m_NoDataIsland=_ea==null&&_f4!=null&&_e6==null;
if(this.m_NoDataIsland){
var id=_e1.id+"XmlDataSource";
_e7.setAttribute("XmlId",id);
_e6=_e7;
var d=xbDOM.create();
d.async=false;
_f4+=(_f4.indexOf("?")==-1?"?":"&");
_f4+="PageSize="+_f5;
_f4+="&StartingRecordIndex=0"+"&ComboId="+encodeURI(this.GetId())+"&LastString=";
if(this.m_InitialSearch!=null&&this.m_InitialSearch!=""){
_f4+="&SearchSubstring="+encodeURI(this.m_InitialSearch);
}
var _fb=nitobi.Browser.LoadPageFromUrl(_f4,this.GetHttpRequestMethod());
var _fc=_fb.indexOf("<?xml");
if(_fc!=-1){
d.loadXML(_fb.substr(_fc));
}else{
d.loadXML(_fb);
}
try{
this.ShowWarning(d.xml!=""&&d.parseError==0,"cw003",d.parseError.reason);
}
catch(err){
this.ShowWarning(d.xml!="","cw003");
}
var d2=xbDOM.create();
d2.loadXML(d.xml.replace(/>\s+</g,"><"));
d2=xbClipXml(d2,"root","e",_f5);
eval("window.document."+id+"=d2;");
}
var _fe=(this.mode==_f2||this.mode=="unbound");
if(_fe){
this.SetButton(new nitobi.combo.Button(_e8,this));
}
this.SetList(new nitobi.combo.List(_e7,_e6,_ea,this));
this.SetTextBox(new nitobi.combo.TextBox(_e9,this,_fe));
this.m_Over=false;
}
catch(err){
}
};
nitobi.combo.Combo.prototype.BuildWarningList=Combo_BuildWarningList;
function Combo_BuildWarningList(){
this.m_WarningMessagesEnabled=new Array();
this.m_DisableAllWarnings=false;
this.m_WarningMessages=new Array();
this.m_WarningMessages["cw001"]="The combo tried to search the server datasource for data.  "+"The server returned data, but no match was found within this data by the combo. The most "+"likely cause for this warning is that the combo mode does not match the gethandler SQL query type: "+"the sql query is not matching in the same way the combo is. Consult the documentation to see what "+"matches to use given the combo's mode.";
this.m_WarningMessages["cw002"]="The combo tried to load XML data from the page. However, it encountered a tag attribute of the form <tag att='___'/> instead"+" of the form <tag att=\"___\"/>. A possible reason for this is encoding ' as &apos;. To fix this error correct the tag to use "+"<tag att=\"__'___\"/>. If you are manually encoding data, eg. for an unbound combo, do not encode ' as &apos; and do not use ' as your string literal. If you believe, "+"this warning was generated in error, you can disable it.";
this.m_WarningMessages["cw003"]="The combo failed to load and parse the XML sent by the gethandler. Check your gethandler to ensure that it is delivering valid XML.";
}
nitobi.combo.Combo.prototype.SetDisabledWarningMessages=Combo_SetDisabledWarningMessages;
function Combo_SetDisabledWarningMessages(_ff){
if(_ff=="*"){
this.m_DisableAllWarnings=true;
}else{
this.m_DisableAllWarnings=false;
_ff=_ff.toLowerCase();
_ff=_ff.split(",");
for(var i=0;i<_ff.length;i++){
this.m_WarningMessagesEnabled[_ff[i]]=false;
}
}
}
nitobi.combo.Combo.prototype.IsWarningEnabled=Combo_IsWarningEnabled;
function Combo_IsWarningEnabled(_101){
if(this.m_ErrorLevel==""){
return;
}else{
if(this.m_WarningMessagesEnabled[_101]==null){
this.m_WarningMessagesEnabled[_101]=true;
}
return this.m_WarningMessagesEnabled[_101]&&this.m_DisableAllWarnings==false;
}
}
nitobi.combo.Combo.prototype.ShowWarning=Combo_ShowWarning;
function Combo_ShowWarning(_102,_103,_104){
if(_102==false&&this.IsWarningEnabled(_103)){
var s="NTB:Combo Warning "+_103+" from "+this.GetId()+"\n\n"+this.m_WarningMessages[_103]+"\n\nTo disable this and other warnings "+"use the Combo.DisableWarnings tag attribute, e.g., DisableWarnings='"+_103+",cw101,cw102'";
if(_104!=null){
s+="\n\nExtra Information\n\t"+_104;
}
alert(s);
this.m_WarningMessagesEnabled[_103]=false;
}
}
nitobi.combo.Combo.prototype.SetErrorLevel=Combo_SetErrorLevel;
function Combo_SetErrorLevel(_106){
this.m_ErrorLevel=_106.toLowerCase();
}
nitobi.combo.Combo.prototype.GetWidth=Combo_GetWidth;
function Combo_GetWidth(){
return this.m_Width;
}
nitobi.combo.Combo.prototype.SetWidth=Combo_SetWidth;
function Combo_SetWidth(_107){
this.m_Width=_107;
}
nitobi.combo.Combo.prototype.GetHeight=Combo_GetHeight;
function Combo_GetHeight(){
return this.m_Height;
}
nitobi.combo.Combo.prototype.SetHeight=Combo_SetHeight;
function Combo_SetHeight(_108){
this.m_Height=_108;
}
function _EBAMemScrub(_109){
for(var _10a in _109){
if((_10a.indexOf("m_")==0)||(_10a.indexOf("$")==0)){
_109[_10a]=null;
}
}
}
nitobi.combo.Combo.prototype.Unload=Combo_Unload;
function Combo_Unload(){
if(this.m_Callback){
delete this.m_Callback;
this.m_Callback=null;
}
if(this.m_TextBox){
this.m_TextBox.Unload();
delete this.m_TextBox;
this.m_TextBox=null;
}
if(this.m_List){
this.m_List.Unload();
delete this.m_List;
this.m_List=null;
}
if(this.m_Button){
this.m_Button.Unload();
delete m_Button;
}
var _10b=this.GetHTMLTagObject();
_EBAMemScrub(this);
_EBAMemScrub(_10b);
}
nitobi.combo.Combo.prototype.GetHttpRequestMethod=Combo_GetHttpRequestMethod;
function Combo_GetHttpRequestMethod(){
try{
return this.m_HttpRequestMethod;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetHttpRequestMethod=Combo_SetHttpRequestMethod;
function Combo_SetHttpRequestMethod(_10c){
try{
if(null==this.m_HTMLTagObject){
this.m_HttpRequestMethod=_10c;
}else{
this.m_HTMLTagObject.className=_10c;
}
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetCSSClassName=Combo_GetCSSClassName;
function Combo_GetCSSClassName(){
try{
return (null==this.m_HTMLTagObject?this.m_CSSClassName:this.m_HTMLTagObject.className);
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetCSSClassName=Combo_SetCSSClassName;
function Combo_SetCSSClassName(_10d){
try{
if(null==this.m_HTMLTagObject){
this.m_CSSClassName=_10d;
}else{
this.m_HTMLTagObject.className=_10d;
}
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetInitialSearch=Combo_GetInitialSearch;
function Combo_GetInitialSearch(){
return this.m_InitialSearch;
}
nitobi.combo.Combo.prototype.SetInitialSearch=Combo_SetInitialSearch;
function Combo_SetInitialSearch(_10e){
this.m_InitialSearch=_10e;
}
nitobi.combo.Combo.prototype.GetListZIndex=Combo_GetListZIndex;
function Combo_GetListZIndex(){
return this.m_ListZIndex;
}
nitobi.combo.Combo.prototype.SetListZIndex=Combo_SetListZIndex;
function Combo_SetListZIndex(_10f){
this.m_ListZIndex=_10f;
}
nitobi.combo.Combo.prototype.GetMode=Combo_GetMode;
function Combo_GetMode(){
return this.mode;
}
nitobi.combo.Combo.prototype.GetOnBlurEvent=Combo_GetOnBlurEvent;
function Combo_GetOnBlurEvent(){
try{
return this.m_OnBlurEvent;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetOnBlurEvent=Combo_SetOnBlurEvent;
function Combo_SetOnBlurEvent(_110){
try{
this.m_OnBlurEvent=_110;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.OnBlurEvent=Combo_OnBlurEvent;
function Combo_OnBlurEvent(){
try{
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetFocus=Combo_SetFocus;
function Combo_SetFocus(){
this.GetTextBox().m_HTMLTagObject.focus();
}
nitobi.combo.Combo.prototype.GetOnFocusEvent=Combo_GetOnFocusEvent;
function Combo_GetOnFocusEvent(){
try{
return this.m_OnFocusEvent;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetOnFocusEvent=Combo_SetOnFocusEvent;
function Combo_SetOnFocusEvent(_111){
try{
this.m_OnFocusEvent=_111;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetOnLoadEvent=Combo_GetOnLoadEvent;
function Combo_GetOnLoadEvent(){
if("void"==this.m_OnLoadEvent){
return "";
}
return this.m_OnLoadEvent;
}
nitobi.combo.Combo.prototype.SetOnLoadEvent=Combo_SetOnLoadEvent;
function Combo_SetOnLoadEvent(_112){
this.m_OnLoadEvent=_112;
}
nitobi.combo.Combo.prototype.GetOnSelectEvent=Combo_GetOnSelectEvent;
function Combo_GetOnSelectEvent(){
try{
if("void"==this.m_OnSelectEvent){
return "";
}
return this.m_OnSelectEvent;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetOnSelectEvent=Combo_SetOnSelectEvent;
function Combo_SetOnSelectEvent(_113){
try{
this.m_OnSelectEvent=_113;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetOnBeforeSelectEvent=Combo_GetOnBeforeSelectEvent;
function Combo_GetOnBeforeSelectEvent(){
try{
if("void"==this.m_OnBeforeSelectEvent){
return "";
}
return this.m_OnBeforeSelectEvent;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetOnBeforeSelectEvent=Combo_SetOnBeforeSelectEvent;
function Combo_SetOnBeforeSelectEvent(_114){
try{
this.m_OnBeforeSelectEvent=_114;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetHTMLTagObject=Combo_GetHTMLTagObject;
function Combo_GetHTMLTagObject(){
try{
return this.m_HTMLTagObject;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetHTMLTagObject=Combo_SetHTMLTagObject;
function Combo_SetHTMLTagObject(_115){
try{
this.m_HTMLTagObject=_115;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetUniqueId=Combo_GetUniqueId;
function Combo_GetUniqueId(){
try{
return this.m_UniqueId;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetUniqueId=Combo_SetUniqueId;
function Combo_SetUniqueId(_116){
try{
this.m_UniqueId=_116;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetId=Combo_GetId;
function Combo_GetId(){
try{
return this.m_Id;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetId=Combo_SetId;
function Combo_SetId(Id){
try{
this.m_Id=Id;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetButton=Combo_GetButton;
function Combo_GetButton(){
try{
return this.m_Button;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetButton=Combo_SetButton;
function Combo_SetButton(_118){
try{
this.m_Button=_118;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetList=Combo_GetList;
function Combo_GetList(){
try{
return this.m_List;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetList=Combo_SetList;
function Combo_SetList(List){
try{
this.m_List=List;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetTextBox=Combo_GetTextBox;
function Combo_GetTextBox(){
try{
return this.m_TextBox;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetTextBox=Combo_SetTextBox;
function Combo_SetTextBox(_11a){
try{
this.m_TextBox=_11a;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetDebug=Combo_GetDebug;
function Combo_GetDebug(){
try{
return this.m_Debug;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetDebug=Combo_SetDebug;
function Combo_SetDebug(_11b){
try{
this.m_Debug=_11b;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetTextValue=Combo_GetTextValue;
function Combo_GetTextValue(){
try{
return this.GetTextBox().GetValue();
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetTextValue=Combo_SetTextValue;
function Combo_SetTextValue(_11c){
try{
this.GetTextBox().SetValue(_11c);
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetSelectedRowValues=Combo_GetSelectedRowValues;
function Combo_GetSelectedRowValues(){
try{
return this.GetList().GetSelectedRowValues();
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetSelectedRowValues=Combo_SetSelectedRowValues;
function Combo_SetSelectedRowValues(_11d){
try{
this.GetList().SetSelectedRowValues(_11d);
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetSelectedRowIndex=Combo_GetSelectedRowIndex;
function Combo_GetSelectedRowIndex(){
try{
return this.GetList().GetSelectedRowIndex();
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetSelectedRowIndex=Combo_SetSelectedRowIndex;
function Combo_SetSelectedRowIndex(_11e){
try{
this.GetList().SetSelectedRowIndex(_11e);
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetDataTextField=Combo_GetDataTextField;
function Combo_GetDataTextField(){
try{
return this.m_DataTextField;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetDataTextField=Combo_SetDataTextField;
function Combo_SetDataTextField(_11f){
try{
this.m_DataTextField=_11f;
var _120=window.document.getElementById(this.GetId()+"DataTextFieldIndex");
if(null!=_120){
var _121=this.GetList().GetXmlDataSource().GetColumnIndex(_11f);
_120.value=_121;
}
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetDataValueField=Combo_GetDataValueField;
function Combo_GetDataValueField(){
try{
return this.m_DataValueField;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetDataValueField=Combo_SetDataValueField;
function Combo_SetDataValueField(_122){
try{
this.m_DataValueField=_122;
var _123=window.document.getElementById(this.GetId()+"DataValueFieldIndex");
if(null!=_123){
var _124=this.GetList().GetXmlDataSource().GetColumnIndex(_122);
_123.value=_124;
}
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetSelectedItem=Combo_GetSelectedItem;
function Combo_GetSelectedItem(){
try{
var _125=new Object;
_125.Value=null;
_125.Text=null;
var _126=this.GetList().GetSelectedRowIndex();
if(-1!=_126){
var _127=this.GetList().GetXmlDataSource();
var row=_127.GetRow(_126);
var _129=_127.GetColumnIndex(this.GetDataValueField());
if(-1!=_129){
_125.Value=row[_129];
}
_129=_127.GetColumnIndex(this.GetDataTextField());
if(-1!=_129){
_125.Text=row[_129];
}
}
return _125;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetOnHideEvent=Combo_GetOnHideEvent;
function Combo_GetOnHideEvent(){
try{
return this.GetList().GetOnHideEvent();
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetOnHideEvent=Combo_SetOnHideEvent;
function Combo_SetOnHideEvent(_12a){
try{
this.GetList().SetOnHideEvent(_12a);
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetOnTabEvent=Combo_GetOnTabEvent;
function Combo_GetOnTabEvent(){
try{
return this.m_OnTabEvent;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetOnTabEvent=Combo_SetOnTabEvent;
function Combo_SetOnTabEvent(_12b){
try{
this.m_OnTabEvent=_12b;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetEventObject=Combo_GetEventObject;
function Combo_GetEventObject(){
try{
return this.m_EventObject;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetEventObject=Combo_SetEventObject;
function Combo_SetEventObject(_12c){
try{
this.m_EventObject=_12c;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetSmartListSeparator=Combo_GetSmartListSeparator;
function Combo_GetSmartListSeparator(){
return this.SmartListSeparator;
}
nitobi.combo.Combo.prototype.SetSmartListSeparator=Combo_SetSmartListSeparator;
function Combo_SetSmartListSeparator(_12d){
this.SmartListSeparator=_12d;
}
nitobi.combo.Combo.prototype.GetTabIndex=Combo_GetTabIndex;
function Combo_GetTabIndex(){
try{
return this.m_TabIndex;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetTabIndex=Combo_SetTabIndex;
function Combo_SetTabIndex(_12e){
try{
this.m_TabIndex=_12e;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.GetEnabled=Combo_GetEnabled;
function Combo_GetEnabled(){
try{
return this.m_Enabled;
}
catch(err){
}
}
nitobi.combo.Combo.prototype.SetEnabled=Combo_SetEnabled;
function Combo_SetEnabled(_12f){
try{
this.m_Enabled=_12f;
var t=this.GetTextBox();
if(null!=t.GetHTMLTagObject()){
if(_12f){
t.Enable();
}else{
t.Disable();
}
}
var b=this.GetButton();
if(null!=b&&null!=b.m_Img){
if(_12f){
b.Enable();
}else{
b.Disable();
}
}
}
catch(err){
}
}
nitobi.combo.Combo.prototype.Initialize=Combo_Initialize;
function Combo_Initialize(){
try{
var _132="ComboBox";
var _133="";
var _134="";
var _135="";
var _136="";
var _137="";
var _138="";
var _139="0";
var _13a=true;
var _13b="default";
var _13c=1000;
var _13d=",";
var _13e="";
var _13f="";
var _140=this.m_userTag.getAttribute("ListZIndex");
((null==_140)||(""==_140))?this.SetListZIndex(_13c):this.SetListZIndex(_140);
this.SetWidth(this.m_userTag.getAttribute("Width"));
this.SetHeight(this.m_userTag.getAttribute("Height"));
var sls=this.m_userTag.getAttribute("SmartListSeparator");
((null==sls)||(""==sls))?this.SetSmartListSeparator(_13d):this.SetSmartListSeparator(sls);
var _142=this.m_userTag.getAttribute("Enabled");
((null==_142)||(""==_142))?this.SetEnabled(_13a):this.SetEnabled("true"==_142.toLowerCase());
var _143=this.m_userTag.getAttribute("TabIndex");
((null==_143)||(""==_143))?this.SetTabIndex(_139):this.SetTabIndex(_143);
var _144=this.m_userTag.getAttribute("OnTabEvent");
((null==_144)||(""==_144))?this.SetOnTabEvent(_138):this.SetOnTabEvent(_144);
this.SetEventObject(null);
var _145=this.m_userTag.getAttribute("OnFocusEvent");
((null==_145)||(""==_145))?this.SetOnFocusEvent(_137):this.SetOnFocusEvent(_145);
var _146=this.m_userTag.getAttribute("OnBlurEvent");
((null==_146)||(""==_146))?this.SetOnBlurEvent(_136):this.SetOnBlurEvent(_146);
var ose=this.m_userTag.getAttribute("OnSelectEvent");
((null==ose)||(""==ose))?this.SetOnSelectEvent(_133):this.SetOnSelectEvent(ose);
var ole=this.m_userTag.getAttribute("OnLoadEvent");
((null==ole)||(""==ole))?this.SetOnLoadEvent(_134):this.SetOnLoadEvent(ole);
var obse=this.m_userTag.getAttribute("OnBeforeSelectEvent");
((null==obse)||(""==obse))?this.SetOnBeforeSelectEvent(_135):this.SetOnBeforeSelectEvent(obse);
var css=this.m_userTag.getAttribute("CSSClassName");
((null==css)||(""==css))?this.SetCSSClassName(_132):this.SetCSSClassName(css);
var _14b=this.m_userTag.uniqueID;
this.SetUniqueId(_14b);
if(this.GetWidth()!=null){
this.m_userTag.style.width=this.GetWidth();
if("smartlist"==this.mode){
this.m_TextBox.SetWidth(this.GetWidth());
this.m_TextBox.SetHeight(this.GetHeight());
}
if(nitobi.Browser.GetMeasurementUnitType(this.GetWidth())=="%"){
this.m_userTag.style.display="block";
}else{
this.m_userTag.style.display="inline";
}
if("smartlist"==this.mode){
this.m_userTag.style.height=this.GetHeight();
}else{
this.m_userTag.style.overflow="hidden";
}
}
var html="<span id='EBAComboBox"+_14b+"' class='"+this.GetCSSClassName()+"' "+"onMouseOver='window.document.getElementById(\""+this.GetId()+"\").object.m_Over=true' "+"onMouseOut='window.document.getElementById(\""+this.GetId()+"\").object.m_Over=false'>"+"<span id='EBAComboBoxTextAndButton"+_14b+"' class='ComboBoxTextAndButton'><nobr>";
var id="";
var _14e=this.GetId();
for(var i=0,n=this.GetList().GetXmlDataSource().GetNumberColumns();i<n;i++){
id=_14e+"SelectedValue"+i;
html+="<input type='HIDDEN' id='"+id+"' name='"+id+"'></input>";
}
id=_14e+"SelectedRowIndex";
html+="<input type='HIDDEN' id='"+id+"' name='"+id+"' value='"+this.GetSelectedRowIndex()+"'></input>";
var _151=this.GetDataTextField();
id=_14e+"DataTextFieldIndex";
var _152=this.GetList().m_XmlDataSource.GetColumnIndex(_151);
html+="<input type='HIDDEN' id='"+id+"' name='"+id+"' value='"+_152+"'></input>";
id=_14e+"DataValueFieldIndex";
var _153=this.GetDataValueField();
_152=this.GetList().m_XmlDataSource.GetColumnIndex(_153);
html+="<input type='HIDDEN' id='"+id+"' name='"+id+"' value='"+_152+"'></input>";
html+=this.GetTextBox().GetHTMLRenderString();
var _154=(this.mode=="default"||this.mode=="unbound");
if(_154){
html+=this.GetButton().GetHTMLRenderString();
}
html+="</nobr></span></span>";
this.m_userTag.insertAdjacentHTML("beforeEnd",html);
this.SetHTMLTagObject(window.document.getElementById("EBAComboBox"+_14b));
this.GetTextBox().Initialize();
if(_154){
this.GetButton().Initialize();
}
var is=this.m_InitialSearch;
if(null!=is&&""!=is){
this.InitialSearch(is);
}
eval(this.GetOnLoadEvent());
this.m_userTag=null;
nitobi.combo.numCombosToLoad--;
if(nitobi.combo.numCombosToLoad==0){
nitobi.combo.finishInit();
}
}
catch(err){
}
}
nitobi.combo.Combo.prototype.InitialSearch=Combo_InitialSearch;
function Combo_InitialSearch(_156){
try{
var list=this.GetList();
var tb=this.GetTextBox();
var dfi=tb.GetDataFieldIndex();
list.SetDatabaseSearchTimeoutStatus(EBADatabaseSearchTimeoutStatus_EXPIRED);
list.InitialSearchOnce=true;
this.m_Callback=_EbaComboCallback;
list.Search(_156,dfi,this.m_Callback,this.m_NoDataIsland);
}
catch(err){
}
}
function _EbaComboCallback(_15a,list){
if(_15a>=0){
var tb=list.GetCombo().GetTextBox();
var row=list.GetRow(_15a);
list.SetActiveRow(row);
list.SetSelectedRow(_15a);
tb.SetValue(list.GetSelectedRowValues()[tb.GetDataFieldIndex()]);
list.scrollOnce=true;
list.InitialSearchOnce=false;
}else{
var _15e=list.GetCombo();
_15e.SetTextValue(_15e.GetInitialSearch());
}
}
nitobi.combo.Combo.prototype.GetFieldFromActiveRow=Combo_GetFieldFromActiveRow;
function Combo_GetFieldFromActiveRow(_15f){
try{
var l=this.GetList();
if(null!=l){
var r=l.GetActiveRow();
if(null!=r){
var y=l.GetRowIndex(r);
var d=l.GetXmlDataSource();
var x=d.GetColumnIndex(_15f);
return d.GetRowCol(y,x);
}
}
return null;
}
catch(err){
}
}
function Debug(){
this.m_CallStack=new Array;
this.m_CallStackMarker=0;
try{
_ebaWatch.value="";
}
catch(err){
}
}
Debug.prototype.GetCallStack=Debug_GetCallStack;
function Debug_GetCallStack(){
return this.m_CallStack;
}
Debug.prototype.SetCallStack=Debug_SetCallStack;
function Debug_SetCallStack(_165){
this.m_CallStack=_165;
}
Debug.prototype.GetCurrentFunction=Debug_GetCurrentFunction;
function Debug_GetCurrentFunction(){
return this.m_CallStack[this.m_CallStackMarker-1];
}
Debug.prototype.GetState=Debug_GetState;
function Debug_GetState(){
return this.m_State;
}
Debug.prototype.SetState=Debug_SetState;
function Debug_SetState(_166){
this.m_State=_166;
}
Debug.prototype.Assert=Debug_Assert;
function Debug_Assert(_167,_168){
if(this.GetState()&&!_167){
alert("Assert ("+this.GetCurrentFunction()+"): "+_168+"\nStack trace: \n"+this.ShowCallStack());
}
}
Debug.prototype.EnterFunction=Debug_EnterFunction;
function Debug_EnterFunction(_169){
this.m_CallStack[this.m_CallStackMarker++]=_169;
}
Debug.prototype.ExitFunction=Debug_ExitFunction;
function Debug_ExitFunction(){
this.m_CallStack[--this.m_CallStackMarker];
}
Debug.prototype.ShowCallStack=Debug_ShowCallStack;
function Debug_ShowCallStack(){
var s="";
var tabs="\t";
for(var i=0;i<this.m_CallStackMarker;i++){
s+=tabs+this.m_CallStack[i]+"\n";
tabs+="\t";
}
return s;
}
Debug.prototype.SetWatch=Debug_SetWatch;
function Debug_SetWatch(_16d,_16e){
this.EnterFunction("SetWatch");
try{
_ebaWatch.value=_16d+" = "+_16e+"\n"+_ebaWatch.value;
this.ExitFunction();
}
catch(err){
this.ExitFunction();
}
}
Debug.prototype.Echo=Debug_Echo;
function Debug_Echo(Msg){
this.EnterFunction("Echo");
try{
_ebaWatch.value="**"+Msg+"\n"+_ebaWatch.value;
this.ExitFunction();
}
catch(err){
this.ExitFunction();
}
}
Debug.prototype.StartTimer=Debug_StartTimer;
function Debug_StartTimer(_170,_171){
try{
_170.Start(_171);
}
catch(err){
}
}
Debug.prototype.StopTimer=Debug_StopTimer;
function Debug_StopTimer(_172,_173){
try{
_172.Stop(_173);
}
catch(err){
}
}
Debug.prototype.ShowTimer=Debug_ShowTimer;
function Debug_ShowTimer(_174,_175,_176){
try{
}
catch(err){
}
}
Debug.prototype.WriteLog=Debug_WriteLog;
function Debug_WriteLog(_177){
try{
writeLog(_177);
}
catch(err){
}
}
Debug.prototype.StopAndShowTimer=Debug_StopAndShowTimer;
function Debug_StopAndShowTimer(_178,_179,_17a){
try{
this.StopTimer(_179,_17a);
this.ShowTimer(_178,_179,_17a);
}
catch(err){
}
}
Debug.printGlobals=function(){
for(var o in window){
writeLog(o);
}
};
function Iframe(_17c,h,w,_17f){
if(!_17c){
var msg="Iframe constructor: attachee is null!";
alert(msg);
throw msg;
}
var d=window.document;
var oIF=d.createElement("IFRAME");
var s=oIF.style;
this.oIFStyle=s;
this.attachee=_17c;
this.attach();
s.position="absolute";
w=w||_17c.offsetWidth;
s.width=w;
s.height=h||0;
s.display="none";
s.overflow="hidden";
var name="IFRAME"+oIF.uniqueID;
oIF.name=name;
oIF.id=name;
oIF.frameBorder=0;
oIF.src="javascript:true";
var _185=Browser_GetParentElementByTagName(_17f,"form");
if(null==_185){
_185=d.body;
}
_185.appendChild(oIF);
var oF=window.frames[name];
var oD=oF.window.document;
oD.open();
oD.write("<html><head></head><body style=\"margin:0;background-color:white;\"><span id=\"bodySpan\" class=\"ComboBoxListOuterBorder\" style=\"overflow:hidden;float:left;border-width:1px;border-style:solid;width:"+(w-(nitobi.browser.MOZ?2:0))+";height:"+(h-(nitobi.browser.MOZ?2:0))+";\"></span></body></html>");
oD.close();
var dss=d.styleSheets;
var ss=oD.createElement("LINK");
for(var i=0,n=dss.length;i<n;i++){
var ss2=ss.cloneNode(true);
ss2.rel=(nitobi.browser.IE?dss[i].owningElement.rel:dss[i].ownerNode.rel);
ss2.type="text/css";
ss2.href=dss[i].href;
ss2.title=dss[i].title;
oD.body.appendChild(ss2);
}
var head=oD.getElementsByTagName("head")[0];
var ds=(d.scripts?d.scripts:d.getElementsByTagName("script"));
var st=oD.createElement("SCRIPT");
var src=null;
for(var i=0,n=ds.length;i<n;i++){
src=ds[i].src;
if(""!=src){
var st2=st.cloneNode(true);
st2.language=ds[i].language;
st2.src=src;
head.appendChild(st2);
}
}
this.oIF=oIF;
this.oF=oF;
this.d=oD;
this.bodySpan=oD.getElementById("bodySpan");
this.bodySpanStyle=this.bodySpan.style;
if(window.addEventListener){
window.addEventListener("resize",this,false);
}else{
if(window.attachEvent){
if(!window.g_Iframe_oIFs){
window.g_Iframe_oIFs=new Array;
window.g_Iframe_onresize=window.onresize;
Iframe_oResize();
window.onresize=window.oResize.check1;
}
window.g_Iframe_oIFs[name]=this;
}
}
}
Iframe.prototype.Unload=Iframe_Unload;
function Iframe_Unload(){
if(this.oIF){
delete this.oIF;
}
}
var g_Iframe_oIFs=null;
var g_Iframe_onresize=null;
function Iframe_onafterresize(){
for(var f in window.g_Iframe_oIFs){
var oIF=window.g_Iframe_oIFs[f];
oIF.attach();
}
if(window.g_Iframe_onresize){
window.g_Iframe_onresize();
}
}
function Iframe_dfxWinXY(w){
var b,d,x,y;
x=y=0;
var d=window.document;
if(d.body){
b=d.documentElement.clientWidth?d.documentElement:d.body;
x=b.clientWidth||0;
y=b.clientHeight||0;
}
return {x:x,y:y};
}
function Iframe_oResize(){
window.oResize={CHECKTIME:500,oldXY:Iframe_dfxWinXY(window),timerId:0,check1:function(){
window.oResize.check2();
},check2:function(){
if(this.timerId){
window.clearTimeout(this.timerId);
}
this.timerId=setTimeout("window.oResize.check3()",this.CHECKTIME);
},check3:function(){
var _199=Iframe_dfxWinXY(window);
this.timerId=0;
if((_199.x!=this.oldXY.x)||(_199.y!=this.oldXY.y)){
this.oldXY=_199;
Iframe_onafterresize();
}
}};
}
Iframe.prototype.handleEvent=Iframe_handleEvent;
function Iframe_handleEvent(evt){
switch(evt.type){
case "resize":
if(this.isVisible()){
this.attach();
}
break;
}
}
Iframe.prototype.offset=Iframe_offset;
function Iframe_offset(o,attr,a){
var x=(a?o[attr]:0);
var _o=o;
while(o){
x+=(a?0:o[attr]);
if(nitobi.browser.IE&&"TABLE"==o.tagName&&"0"!=o.border&&""!=o.border){
x++;
}
o=o.offsetParent;
}
return x;
}
Iframe.prototype.setHeight=Iframe_setHeight;
function Iframe_setHeight(h,_1a1){
h=parseInt(h);
this.oIFStyle.height=h;
if(_1a1!=true){
this.bodySpanStyle.height=(h-(nitobi.browser.MOZ?parseInt(this.bodySpanStyle.borderTopWidth)+parseInt(this.bodySpanStyle.borderBottomWidth):0));
}
}
Iframe.prototype.setWidth=Iframe_setWidth;
function Iframe_setWidth(w){
w=parseInt(w);
this.oIFStyle.width=w;
this.bodySpanStyle.width=(w-(nitobi.browser.MOZ?parseInt(this.bodySpanStyle.borderLeftWidth)+parseInt(this.bodySpanStyle.borderRightWidth):0));
}
Iframe.prototype.show=Iframe_show;
function Iframe_show(){
this.attach();
this.oIFStyle.display="inline";
}
Iframe.prototype.hide=Iframe_hide;
function Iframe_hide(){
this.oIFStyle.display="none";
}
Iframe.prototype.toggle=Iframe_toggle;
function Iframe_toggle(){
if(this.isVisible()){
this.hide();
}else{
this.show();
}
}
Iframe.prototype.isVisible=Iframe_isVisible;
function Iframe_isVisible(){
return "inline"==this.oIFStyle.display;
}
Iframe.prototype.attach=Iframe_attach;
function Iframe_attach(){
var _1a3=this.attachee;
var a=(_1a3.offsetParent&&"absolute"==_1a3.offsetParent.style.position);
this.oIFStyle.top=this.offset(_1a3,"offsetTop",a)+_1a3.offsetHeight-1+(a?parseInt(_1a3.offsetParent.style.top):0);
this.oIFStyle.left=this.offset(_1a3,"offsetLeft",a)+(a?parseInt(_1a3.offsetParent.style.left):0);
}
var EbaComboUiServerError=0;
var EbaComboUiNoRecords=1;
var EbaComboUiEndOfRecords=2;
var EbaComboUiNumRecords=3;
var EbaComboUiPleaseWait=4;
nitobi.combo.createLanguagePack=function(){
try{
if(typeof (EbaComboUi)=="undefined"){
EbaComboUi=new Array();
EbaComboUi[EbaComboUiServerError]="The ComboBox tried to retrieve information from the server, but an error occured. Please try again later.";
EbaComboUi[EbaComboUiNoRecords]="No new records.";
EbaComboUi[EbaComboUiEndOfRecords]="End of records.";
EbaComboUi[EbaComboUiNumRecords]=" records.";
EbaComboUi[EbaComboUiPleaseWait]="Please Wait...";
}
}
catch(err){
alert("The default language pack could not be loaded.  "+err.message);
}
};
nitobi.lang.defineNs("nitobi.combo");
EBAComboBoxListHeader=0;
EBAComboBoxListBody=1;
EBAComboBoxListFooter=2;
EBAComboBoxListBodyTable=3;
EBAComboBoxListNumSections=4;
EBAComboBoxList=5;
EBADatabaseSearchTimeoutStatus_WAIT=0;
EBADatabaseSearchTimeoutStatus_EXPIRED=1;
EBADatabaseSearchTimeoutStatus_NONE=2;
EBADatabaseSearchTimeoutWait=200;
EBAMoveAction_UP=0;
EBAMoveAction_DOWN=1;
EBAScrollToNone=0;
EBAScrollToTop=1;
EBAScrollToBottom=2;
EBAScrollToNewTop=3;
EBAScrollToTypeAhead=4;
EBAScrollToNewBottom=5;
EBAComboSearchNoRecords=0;
EBAComboSearchNewRecords=1;
EBADefaultScrollbarSize=18;
nitobi.combo.List=function(_1a5,_1a6,_1a7,_1a8){
try{
this.m_Rendered=false;
var _1a9="ComboBoxButton";
var _1aa="150px";
var _1ab=new Array("50px","100px","50px");
var _1ac=new Array("ComboBoxListHeader","ComboBoxListBody","ComboBoxListFooter","ComboBoxListBodyTable");
var _1ad="ComboBoxListBodyTableRowHighlighted";
var _1ae="highlight";
var _1af="highlighttext";
var _1b0="";
var _1b1=-1;
var _1b2=_1a8.mode=="default";
var _1b3="hidden";
var _1b4=false;
var _1b5=_1a8.mode!="default";
var _1b6;
if(_1a8.mode!="classic"){
_1b6=10;
}else{
_1b6=25;
}
var _1b7="";
var _1b8="";
var _1b9="";
var _1ba="";
var _1bb=0;
var _1bc=0;
var _1bd="EBA:Combo could not correctly transform XML data. Do you have the MS XML libraries installed? These are typically installed with your browser and are freely available from Microsoft.";
var _1be="<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0' xmlns:eba='http://developer.ebusiness-apps.com' xmlns:ntb='http://www.nitobi.com' exclude-result-prefixes='eba ntb'>"+"<xsl:output method='xml' version='4.0' omit-xml-declaration='yes' />"+"<xsl:template match='/'>"+"<xsl:apply-templates select='eba:ComboValues|ntb:ComboValues'/>"+"</xsl:template>"+"<xsl:template match='/eba:ComboValues|ntb:ComboValues'>"+"<root>"+"<xsl:attribute name='fields'><xsl:value-of select='@fields' /></xsl:attribute>"+"\t<xsl:apply-templates/>"+"</root>"+"</xsl:template>"+"<xsl:template match='eba:ComboValue|eba:combovalue|ntb:ComboValue|ntb:combovalue'>"+"\t<e><xsl:for-each select='@*'><xsl:attribute name='{name()}'><xsl:value-of select=\".\"/></xsl:attribute></xsl:for-each></e>"+"</xsl:template>"+"</xsl:stylesheet>";
this.SetCombo(_1a8);
var ps=(_1a5?_1a5.getAttribute("PageSize"):null);
((null==ps)||(""==ps))?this.SetPageSize(_1b6):this.SetPageSize(parseInt(ps));
this.clip=(_1a8.mode=="smartsearch"||_1a8.mode=="smartlist"||_1a8.mode=="filter");
var _1c0=(_1a5?_1a5.getAttribute("ClipLength"):null);
((null==_1c0)||(""==_1c0))?this.SetClipLength(this.GetPageSize()):this.SetClipLength(_1c0);
this.SetXmlDataSource(new nitobi.combo.XmlDataSource(_1a6,this.clip,this.clipLength,_1a8));
this.m_httpRequest=xbXMLHTTP.create();
this.unboundMode=false;
if(!_1a6){
this.unboundMode=true;
var _1c1=null;
var _1c2="<eba:ComboValues fields='"+_1a7.getAttribute("fields")+"' xmlns:eba='http://developer.ebusiness-apps.com' xmlns:ntb='http://www.nitobi.com'>";
_1c2+=_1a7.innerHTML.substr(nitobi.browser.IE?31:0)+"</eba:ComboValues>";
_1c2=nitobi.Browser.EncodeAngleBracketsInTagAttributes(_1c2,_1a8).replace(/&nbsp;/g,"&#160;").replace(/>\s+</g,"><");
try{
var oXSL=xbDOM.create();
oXSL.loadXML(_1be);
tmp=xbDOM.create();
tmp.loadXML(_1c2);
xmlObject=xbDOM.create();
tmp.transformNodeToObject(oXSL,xmlObject);
this.GetXmlDataSource().SetXmlObject(xmlObject);
this.GetXmlDataSource().m_Dirty=false;
}
catch(err){
alert(_1bd);
}
}
this.m_SectionHTMLTagObjects=new Array;
this.m_SectionCSSClassNames=new Array;
this.m_SectionHeights=new Array;
this.m_ListColumnDefinitions=new Array;
var _1c4=null;
var _1c5=0;
var _1c6=null;
var _1c7=this.GetCombo().GetDataTextField();
var _1c8=false;
var _1c9=true;
while(_1c9){
if(_1c7!=null||_1c8==true){
var _1ca=new Object;
_1ca.DataFieldIndex=this.GetXmlDataSource().GetColumnIndex(_1c7);
_1ca.DataValueIndex=this.GetXmlDataSource().GetColumnIndex(_1a8.GetDataValueField());
_1ca.HeaderLabel="";
_1ca.Width="100%";
this.m_ListColumnDefinitions[0]=new nitobi.combo.ListColumnDefinition(_1ca);
_1c9=false;
}else{
var _1cb=_1a5;
if((null==_1a5)||(0==_1a5.childNodes.length)){
_1cb=_1a8.m_userTag;
}
var _1cc=null;
for(var i=0;i<_1cb.childNodes.length;i++){
_1c4=_1cb.childNodes[i];
_1cc=_1c4.tagName;
if(_1cc){
_1cc=_1cc.toLowerCase().replace(/^eba:/,"").replace(/^ntb:/,"");
if(_1cc=="combocolumndefinition"){
this.m_ListColumnDefinitions[_1c5]=new nitobi.combo.ListColumnDefinition(_1c4);
_1c5++;
_1c9=false;
}
}
}
_1c8=true;
}
}
var _1ce=(_1a5?_1a5.getAttribute("Width"):null);
((null==_1ce)||(""==_1ce))?this.SetWidth(_1aa):this.SetWidth(_1ce);
var _1cf=(_1a5?_1a5.getAttribute("Overflow-y"):null);
this.m_overflowy=((null==_1cf)||(""==_1cf))?_1b3:_1cf;
var chh=(_1a5?_1a5.getAttribute("CustomHTMLHeader"):null);
((null==chh)||(""==chh))?this.SetCustomHTMLHeader(""):this.SetCustomHTMLHeader(chh);
for(var i=0;i<EBAComboBoxListNumSections;i++){
this.SetSectionCSSClassName(i,_1ac[i]);
}
for(var i=0;i<=EBAComboBoxListFooter;i++){
this.SetSectionHeight(i,_1ab[i]);
}
var _1d1=(_1a5?_1a5.getAttribute("Height"):null);
((null==_1d1)||(""==_1d1))?null:this.SetHeight(parseInt(_1d1));
var hccn=(_1a5?_1a5.getAttribute("HighlightCSSClassName"):null);
if((null==hccn)||(""==hccn)){
this.SetHighlightCSSClassName(_1ad);
this.m_UseHighlightClass=false;
}else{
this.SetHighlightCSSClassName(hccn);
this.m_UseHighlightClass=true;
}
var bhc=(_1a5?_1a5.getAttribute("BackgroundHighlightColor"):null);
((null==bhc)||(""==bhc))?this.SetBackgroundHighlightColor(_1ae):this.SetBackgroundHighlightColor(bhc);
var ohe=(_1a5?_1a5.getAttribute("OnHideEvent"):null);
((null==ohe)||(""==ohe))?this.SetOnHideEvent(_1b7):this.SetOnHideEvent(ohe);
var ose=(_1a5?_1a5.getAttribute("OnShowEvent"):null);
((null==ose)||(""==ose))?this.SetOnShowEvent(_1b8):this.SetOnShowEvent(ose);
var onbs=(_1a5?_1a5.getAttribute("OnBeforeSearchEvent"):null);
((null==onbs)||(""==onbs))?this.SetOnBeforeSearchEvent(_1b9):this.SetOnBeforeSearchEvent(onbs);
var onas=(_1a5?_1a5.getAttribute("OnAfterSearchEvent"):null);
((null==onas)||(""==onas))?this.SetOnAfterSearchEvent(_1ba):this.SetOnAfterSearchEvent(onas);
var fhc=(_1a5?_1a5.getAttribute("ForegroundHighlightColor"):null);
((null==fhc)||(""==fhc))?this.SetForegroundHighlightColor(_1af):this.SetForegroundHighlightColor(fhc);
var offx=(_1a5?_1a5.getAttribute("OffsetX"):null);
((null==offx)||(""==offx))?this.SetOffsetX(_1bb):this.SetOffsetX(offx);
var offy=(_1a5?_1a5.getAttribute("OffsetY"):null);
((null==offy)||(""==offy))?this.SetOffsetY(_1bc):this.SetOffsetY(offy);
var sri=(_1a5?_1a5.parentNode.getAttribute("SelectedRowIndex"):null);
((null==sri)||(""==sri))?this.SetSelectedRowIndex(_1b1):this.SetSelectedRowIndex(parseInt(sri));
var chd=(_1a5?_1a5.getAttribute("CustomHTMLDefinition"):null);
((null==chd)||(""==chd))?this.SetCustomHTMLDefinition(_1b0):this.SetCustomHTMLDefinition(chd);
var ap=(_1a5?_1a5.getAttribute("AllowPaging"):null);
((null==ap)||(""==ap))?this.SetAllowPaging(_1b2):this.SetAllowPaging(ap.toLowerCase()=="true");
var fz=(_1a5?_1a5.getAttribute("FuzzySearchEnabled"):null);
((null==fz)||(""==fz))?this.SetFuzzySearchEnabled(_1b4):this.SetFuzzySearchEnabled(fz.toLowerCase()=="true");
var eds=(_1a5?_1a5.getAttribute("EnableDatabaseSearch"):null);
((null==eds)||(""==eds))?this.SetEnableDatabaseSearch(this.unboundMode==false&&_1b5):this.SetEnableDatabaseSearch(this.unboundMode==false&&eds.toLowerCase()=="true");
if(_1a8.mode=="default"&&this.GetAllowPaging()==true){
this.SetClipLength(this.GetPageSize());
this.clip=true;
}
this.widestColumn=new Array(this.m_ListColumnDefinitions.length);
for(var i=0;i<this.widestColumn.length;i++){
this.widestColumn[i]=0;
}
this.SetDatabaseSearchTimeoutStatus(EBADatabaseSearchTimeoutStatus_NONE);
var durl=(_1a5?_1a5.getAttribute("DatasourceUrl"):null);
if((null==durl)||(""==durl)||this.unboundMode==true){
this.SetDatasourceUrl(window.document.location.toString());
this.SetEnableDatabaseSearch(false);
this.unboundMode=true;
}else{
this.SetDatasourceUrl(durl);
this.SetEnableDatabaseSearch(true);
}
this.m_httpRequestReady=true;
this.SetNumPagesLoaded(0);
this.m_userTag=_1a5;
}
catch(err){
}
};
nitobi.combo.List.prototype.Unload=List_Unload;
function List_Unload(){
if(this.IF){
this.IF.Unload();
delete this.IF;
}
_EBAMemScrub(this);
}
nitobi.combo.List.prototype.SetClipLength=List_SetClipLength;
function List_SetClipLength(_1e1){
this.clipLength=_1e1;
}
nitobi.combo.List.prototype.GetHTMLTagObject=List_GetHTMLTagObject;
function List_GetHTMLTagObject(){
try{
this.Render();
return this.m_HTMLTagObject;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetHTMLTagObject=List_SetHTMLTagObject;
function List_SetHTMLTagObject(_1e2){
try{
this.m_HTMLTagObject=_1e2;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetHighlightCSSClassName=List_GetHighlightCSSClassName;
function List_GetHighlightCSSClassName(){
try{
return this.m_HighlightCSSClassName;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetHighlightCSSClassName=List_SetHighlightCSSClassName;
function List_SetHighlightCSSClassName(_1e3){
try{
this.m_HighlightCSSClassName=_1e3;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetListColumnDefinitions=List_GetListColumnDefinitions;
function List_GetListColumnDefinitions(){
try{
return this.m_ListColumnDefinitions;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetListColumnDefinitions=List_SetListColumnDefinitions;
function List_SetListColumnDefinitions(_1e4){
try{
this.m_ListColumnDefinitions=_1e4;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetCustomHTMLDefinition=List_GetCustomHTMLDefinition;
function List_GetCustomHTMLDefinition(){
try{
return this.m_CustomHTMLDefinition;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetCustomHTMLDefinition=List_SetCustomHTMLDefinition;
function List_SetCustomHTMLDefinition(_1e5){
try{
this.m_CustomHTMLDefinition=_1e5;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetCustomHTMLHeader=List_GetCustomHTMLHeader;
function List_GetCustomHTMLHeader(){
try{
return this.m_CustomHTMLHeader;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetCustomHTMLHeader=List_SetCustomHTMLHeader;
function List_SetCustomHTMLHeader(_1e6){
try{
this.m_CustomHTMLHeader=_1e6;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetCombo=List_GetCombo;
function List_GetCombo(){
try{
return this.m_Combo;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetCombo=List_SetCombo;
function List_SetCombo(_1e7){
try{
this.m_Combo=_1e7;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetXmlDataSource=List_GetXmlDataSource;
function List_GetXmlDataSource(){
try{
return this.m_XmlDataSource;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetXmlDataSource=List_SetXmlDataSource;
function List_SetXmlDataSource(_1e8){
try{
this.m_XmlDataSource=_1e8;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetWidth=List_GetWidth;
function List_GetWidth(){
try{
return this.m_Width;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetWidth=List_SetWidth;
function List_SetWidth(_1e9){
try{
this.m_Width=_1e9;
if(this.m_Rendered){
this.GetHTMLTagObject().style.width=this.GetDesiredPixelWidth();
for(var i=0;i<=EBAComboBoxListFooter;i++){
if(i!=EBAComboBoxListBodyTable){
var _1eb=this.GetSectionHTMLTagObject(i);
if(_1eb!=null){
_1eb.style.width=this.GetDesiredPixelWidth();
}
}
}
this.GenerateCss();
}
}
catch(err){
}
}
nitobi.combo.List.prototype.GetDesiredPixelWidth=List_GetDesiredPixelWidth;
function List_GetDesiredPixelWidth(){
var _1ec=this.GetCombo();
var _1ed=document.getElementById(_1ec.GetId());
var _1ee=nitobi.Browser.GetElementWidth(_1ed);
var _1ef=this.GetWidth();
if(nitobi.Browser.GetMeasurementUnitType(_1ef)=="%"){
var w=(_1ec.GetWidth()==null?_1ec.GetTextBox().GetWidth():_1ec.GetWidth());
var _1f1=1/(parseInt(w)/100);
var _1ef=parseInt(_1ef)/100;
return (Math.floor(_1ee*_1f1*_1ef-2)+"px");
}else{
return _1ef;
}
}
nitobi.combo.List.prototype.GetActualPixelWidth=List_GetActualPixelWidth;
function List_GetActualPixelWidth(){
try{
var tag=this.GetHTMLTagObject();
if(null==tag){
return this.GetDesiredPixelWidth();
}else{
return nitobi.Browser.GetElementWidth(tag);
}
}
catch(err){
}
}
nitobi.combo.List.prototype.GetCSSClassName=List_GetCSSClassName;
function List_GetCSSClassName(){
try{
return (null==this.m_HTMLTagObject?this.m_CSSClassName:this.GetHTMLTagObject().className);
}
catch(err){
}
}
nitobi.combo.List.prototype.SetCSSClassName=List_SetCSSClassName;
function List_SetCSSClassName(_1f3){
try{
if(null==this.m_HTMLTagObject){
this.m_CSSClassName=_1f3;
}else{
this.GetHTMLTagObject().className=_1f3;
}
}
catch(err){
}
}
nitobi.combo.List.prototype.GetSectionHTMLTagObject=List_GetSectionHTMLTagObject;
function List_GetSectionHTMLTagObject(_1f4){
try{
this.Render();
return this.m_SectionHTMLTagObjects[_1f4];
}
catch(err){
}
}
nitobi.combo.List.prototype.SetSectionHTMLTagObject=List_SetSectionHTMLTagObject;
function List_SetSectionHTMLTagObject(_1f5,_1f6){
try{
this.m_SectionHTMLTagObjects[_1f5]=_1f6;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetSectionCSSClassName=List_GetSectionCSSClassName;
function List_GetSectionCSSClassName(_1f7){
try{
return (null==this.m_HTMLTagObject?this.m_SectionCSSClassNames[_1f7]:this.GetSectionHTMLTagObject(_1f7).className);
}
catch(err){
}
}
nitobi.combo.List.prototype.SetSectionCSSClassName=List_SetSectionCSSClassName;
function List_SetSectionCSSClassName(_1f8,_1f9){
try{
if(null==this.m_HTMLTagObject){
this.m_SectionCSSClassNames[_1f8]=_1f9;
}else{
this.GetSectionHTMLTagObject(_1f8).className=_1f9;
}
}
catch(err){
}
}
nitobi.combo.List.prototype.GetSectionHeight=List_GetSectionHeight;
function List_GetSectionHeight(_1fa){
try{
return (null==this.m_HTMLTagObject?this.m_SectionHeights[_1fa]:this.GetSectionHTMLTagObject(_1fa).style.height);
}
catch(err){
}
}
nitobi.combo.List.prototype.SetSectionHeight=List_SetSectionHeight;
function List_SetSectionHeight(_1fb,_1fc){
try{
if(null==this.m_HTMLTagObject){
this.m_SectionHeights[_1fb]=_1fc;
}else{
this.GetSectionHTMLTagObject(_1fb).style.height=_1fc;
}
}
catch(err){
}
}
nitobi.combo.List.prototype.GetSelectedRowIndex=List_GetSelectedRowIndex;
function List_GetSelectedRowIndex(){
try{
if(null==this.m_HTMLTagObject){
return parseInt(this.m_SelectedRowIndex);
}else{
return parseInt(window.document.getElementById(this.GetCombo().GetId()+"SelectedRowIndex").value);
}
}
catch(err){
}
}
nitobi.combo.List.prototype.SetSelectedRowIndex=List_SetSelectedRowIndex;
function List_SetSelectedRowIndex(_1fd){
try{
if(null==this.m_HTMLTagObject){
this.m_SelectedRowIndex=_1fd;
}else{
window.document.getElementById(this.GetCombo().GetId()+"SelectedRowIndex").value=_1fd;
}
}
catch(err){
}
}
nitobi.combo.List.prototype.GetAllowPaging=List_GetAllowPaging;
function List_GetAllowPaging(){
try{
return this.m_AllowPaging;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetAllowPaging=List_SetAllowPaging;
function List_SetAllowPaging(_1fe){
try{
this.m_AllowPaging=_1fe;
}
catch(err){
}
}
nitobi.combo.List.prototype.IsFuzzySearchEnabled=List_IsFuzzySearchEnabled;
function List_IsFuzzySearchEnabled(){
try{
return this.m_FuzzySearchEnabled;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetFuzzySearchEnabled=List_SetFuzzySearchEnabled;
function List_SetFuzzySearchEnabled(_1ff){
try{
this.m_FuzzySearchEnabled=_1ff;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetPageSize=List_GetPageSize;
function List_GetPageSize(){
try{
return this.m_PageSize;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetPageSize=List_SetPageSize;
function List_SetPageSize(_200){
try{
this.m_PageSize=_200;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetNumPagesLoaded=List_GetNumPagesLoaded;
function List_GetNumPagesLoaded(){
try{
return this.m_NumPagesLoaded;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetNumPagesLoaded=List_SetNumPagesLoaded;
function List_SetNumPagesLoaded(_201){
try{
this.m_NumPagesLoaded=_201;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetActiveRow=List_GetActiveRow;
function List_GetActiveRow(){
try{
return this.m_ActiveRow;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetActiveRow=List_SetActiveRow;
function List_SetActiveRow(_202){
try{
var _203;
if(null!=this.m_ActiveRow){
_203=document.getElementById("ContainingTableFor"+this.m_ActiveRow.id);
if(this.m_UseHighlightClass){
_203.className=this.m_OriginalRowClass;
}else{
_203.style.backgroundColor=this.m_OriginalBackgroundHighlightColor;
_203.style.color=this.m_OriginalForegroundHighlightColor;
}
var _204=this.GetListColumnDefinitions();
for(var i=0,n=_204.length;i<n;i++){
var _207=document.getElementById("ContainingSpanFor"+this.m_ActiveRow.id+"_"+i);
if(_207!=null){
_207.style.color=_207.savedColor;
_207.style.backgroundColor=_207.savedBackgroundColor;
}
}
}
this.m_ActiveRow=_202;
if(null!=_202){
if("compact"==this.GetCombo().mode&&_202!=null){
var _208=this.GetRowIndex(_202);
this.SetSelectedRow(_208);
}
_203=document.getElementById("ContainingTableFor"+_202.id);
_207=document.getElementById("ContainingSpanFor"+this.m_ActiveRow.id);
if(this.m_UseHighlightClass){
this.m_OriginalRowClass=_203.className;
_203.className=this.GetHighlightCSSClassName();
}else{
this.m_OriginalBackgroundHighlightColor=_203.style.backgroundColor;
this.m_OriginalForegroundHighlightColor=_203.style.color;
_203.style.backgroundColor=this.m_BackgroundHighlightColor;
_203.style.color=this.m_ForegroundHighlightColor;
}
var _204=this.GetListColumnDefinitions();
for(var i=0,n=_204.length;i<n;i++){
var _207=document.getElementById("ContainingSpanFor"+this.m_ActiveRow.id+"_"+i);
if(_207!=null){
_207.savedColor=_207.style.color;
_207.savedBackgroundColor=_207.style.backgroundColor;
_207.style.color=_203.style.color;
_207.style.backgroundColor=_203.style.backgroundColor;
}
}
}
}
catch(err){
}
}
nitobi.combo.List.prototype.GetSelectedRowValues=List_GetSelectedRowValues;
function List_GetSelectedRowValues(){
try{
var _209=new Array;
for(var i=0;i<this.GetXmlDataSource().GetNumberColumns();i++){
_209[i]=window.document.getElementById(this.GetCombo().GetId()+"SelectedValue"+i).value;
}
return _209;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetSelectedRowValues=List_SetSelectedRowValues;
function List_SetSelectedRowValues(_20b,Row){
try{
this.m_SelectedRowValues=_20b;
var _20d=this.GetCombo().GetId();
var _20e=this.GetXmlDataSource().GetNumberColumns();
if((null==_20b)&&(null==Row)){
for(var i=0;i<_20e;i++){
window.document.getElementById(_20d+"SelectedValue"+i).value="";
}
}else{
if(null==Row){
for(var i=0;i<_20e;i++){
window.document.getElementById(_20d+"SelectedValue"+i).value=_20b[i];
}
}else{
var _210=this.GetCombo().GetUniqueId();
var _211=this.GetRowIndex(Row);
var _212=this.GetXmlDataSource().GetRow(_211);
this.SetSelectedRowValues(_212,null);
}
}
}
catch(err){
}
}
nitobi.combo.List.prototype.GetEnableDatabaseSearch=List_GetEnableDatabaseSearch;
function List_GetEnableDatabaseSearch(){
try{
return this.m_EnableDatabaseSearch;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetEnableDatabaseSearch=List_SetEnableDatabaseSearch;
function List_SetEnableDatabaseSearch(_213){
try{
this.m_EnableDatabaseSearch=_213;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetFooterText=List_GetFooterText;
function List_GetFooterText(){
try{
if(null==this.m_HTMLTagObject){
return this.m_FooterText;
}else{
var _214=document.getElementById("EBAComboBoxListFooterPageNextButton"+this.GetCombo().GetUniqueId());
return (null!=_214?_214.innerHTML:"");
}
}
catch(err){
}
}
nitobi.combo.List.prototype.SetFooterText=List_SetFooterText;
function List_SetFooterText(_215){
try{
if(null==this.m_HTMLTagObject){
this.m_FooterText=_215;
}else{
var _216=this.GetSectionHTMLTagObject(EBAComboBoxListFooter);
if(null!=_216){
_216=document.getElementById("EBAComboBoxListFooterPageNextButton"+this.GetCombo().GetUniqueId());
if(null!=_216){
_216.innerHTML=_215;
}
}
}
}
catch(err){
}
}
nitobi.combo.List.prototype.GetDatabaseSearchTimeoutStatus=List_GetDatabaseSearchTimeoutStatus;
function List_GetDatabaseSearchTimeoutStatus(){
try{
return this.m_DatabaseSearchTimeoutStatus;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetDatabaseSearchTimeoutStatus=List_SetDatabaseSearchTimeoutStatus;
function List_SetDatabaseSearchTimeoutStatus(_217){
try{
this.m_DatabaseSearchTimeoutStatus=_217;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetDatabaseSearchTimeoutId=List_GetDatabaseSearchTimeoutId;
function List_GetDatabaseSearchTimeoutId(){
try{
return this.m_DatabaseSearchTimeoutId;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetDatabaseSearchTimeoutId=List_SetDatabaseSearchTimeoutId;
function List_SetDatabaseSearchTimeoutId(_218){
try{
this.m_DatabaseSearchTimeoutId=_218;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetHeight=List_GetHeight;
function List_GetHeight(){
try{
return this.GetSectionHeight(EBAComboBoxListBody);
}
catch(err){
}
}
nitobi.combo.List.prototype.SetHeight=List_SetHeight;
function List_SetHeight(_219){
try{
this.SetSectionHeight(EBAComboBoxListBody,parseInt(_219));
}
catch(err){
}
}
nitobi.combo.List.prototype.GetActualHeight=List_GetActualPixelHeight;
nitobi.combo.List.prototype.GetActualPixelHeight=List_GetActualPixelHeight;
function List_GetActualPixelHeight(){
try{
var uid=this.GetCombo().GetUniqueId();
var tag=this.GetHTMLTagObject();
var _21c=nitobi.Browser.GetElementHeight(tag);
return _21c;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetBackgroundHighlightColor=List_GetBackgroundHighlightColor;
function List_GetBackgroundHighlightColor(){
try{
return this.m_BackgroundHighlightColor;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetBackgroundHighlightColor=List_SetBackgroundHighlightColor;
function List_SetBackgroundHighlightColor(_21d){
try{
this.m_BackgroundHighlightColor=_21d;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetForegroundHighlightColor=List_GetForegroundHighlightColor;
function List_GetForegroundHighlightColor(){
try{
return this.m_ForegroundHighlightColor;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetForegroundHighlightColor=List_SetForegroundHighlightColor;
function List_SetForegroundHighlightColor(_21e){
try{
this.m_ForegroundHighlightColor=_21e;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetDatasourceUrl=List_GetDatasourceUrl;
function List_GetDatasourceUrl(){
try{
return this.m_DatasourceUrl;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetDatasourceUrl=List_SetDatasourceUrl;
function List_SetDatasourceUrl(_21f){
try{
this.m_DatasourceUrl=_21f;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetOnHideEvent=List_GetOnHideEvent;
function List_GetOnHideEvent(){
try{
return this.m_OnHideEvent;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetOnHideEvent=List_SetOnHideEvent;
function List_SetOnHideEvent(_220){
try{
this.m_OnHideEvent=_220;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetOnShowEvent=List_GetOnShowEvent;
function List_GetOnShowEvent(){
try{
return this.m_OnShowEvent;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetOnShowEvent=List_SetOnShowEvent;
function List_SetOnShowEvent(_221){
try{
this.m_OnShowEvent=_221;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetOnBeforeSearchEvent=List_GetOnBeforeSearchEvent;
function List_GetOnBeforeSearchEvent(){
try{
return this.m_OnBeforeSearchEvent;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetOnBeforeSearchEvent=List_SetOnBeforeSearchEvent;
function List_SetOnBeforeSearchEvent(_222){
try{
this.m_OnBeforeSearchEvent=_222;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetOnAfterSearchEvent=List_GetOnAfterSearchEvent;
function List_GetOnAfterSearchEvent(){
try{
return this.m_OnAfterSearchEvent;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetOnAfterSearchEvent=List_SetOnAfterSearchEvent;
function List_SetOnAfterSearchEvent(_223){
try{
this.m_OnAfterSearchEvent=_223;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetOffsetX=List_GetOffsetX;
function List_GetOffsetX(){
try{
return this.m_OffsetX;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetOffsetX=List_SetOffsetX;
function List_SetOffsetX(_224){
try{
this.m_OffsetX=parseInt(_224);
}
catch(err){
}
}
nitobi.combo.List.prototype.GetOffsetY=List_GetOffsetY;
function List_GetOffsetY(){
try{
return this.m_OffsetY;
}
catch(err){
}
}
nitobi.combo.List.prototype.SetOffsetY=List_SetOffsetY;
function List_SetOffsetY(_225){
try{
this.m_OffsetY=parseInt(_225);
}
catch(err){
}
}
nitobi.combo.List.prototype.AdjustSize=List_AdjustSize;
function List_AdjustSize(){
var list=this.GetSectionHTMLTagObject(EBAComboBoxListBody);
var tag=this.GetHTMLTagObject();
var _228=tag.style;
if(true==nitobi.Browser.GetVerticalScrollBarStatus(list)){
if(nitobi.Browser.GetMeasurementUnitType(this.GetWidth())!="%"){
listWidth=parseInt(this.GetWidth())+nitobi.Browser.GetScrollBarWidth(list)-(nitobi.browser.MOZ?EBADefaultScrollbarSize:0);
listWidth=this.GetDesiredPixelWidth();
}else{
listWidth=this.GetDesiredPixelWidth();
}
list.style.width=listWidth;
header=this.GetSectionHTMLTagObject(EBAComboBoxListHeader);
footer=this.GetSectionHTMLTagObject(EBAComboBoxListFooter);
if(header!=null){
header.style.width=listWidth;
}
if(footer!=null){
footer.style.width=listWidth;
}
_228.width=(listWidth);
if(nitobi.browser.IE){
var _229=nitobi.combo.iframeBacker.style;
_229.width=_228.width;
}
}
if(nitobi.browser.IE){
var _229=nitobi.combo.iframeBacker.style;
_229.height=_228.height;
}
}
nitobi.combo.List.prototype.IsVisible=List_IsVisible;
function List_IsVisible(){
if(!this.m_Rendered){
return false;
}
var tag=this.GetHTMLTagObject();
var _22b=tag.style;
return (_22b.visibility=="visible");
}
nitobi.combo.List.prototype.Show=List_Show;
function List_Show(){
try{
var _22c=this.GetCombo();
var mode=_22c.mode;
this.Render();
if(!this.m_HTMLTagObject||this.IsVisible()||mode=="compact"||this.GetXmlDataSource().GetNumberRows()==0||((mode!="default"&&mode!="unbound")&&_22c.GetTextBox().m_HTMLTagObject.value=="")){
return;
}
var tag=this.GetHTMLTagObject();
var _22f=_22c.GetTextBox().GetHTMLTagObject();
var _230=tag.style;
this.AdjustSize();
var _231=nitobi.Browser.GetElementHeight(_22f);
var _232=(nitobi.browser.MOZ?0:(document.parentWindow.self.frameElement==null?0:0));
var top=nitobi.Browser.GetObjectYPosition(_22f)+_231-_232;
var left=nitobi.Browser.GetObjectXPosition(_22f)-_232;
var _235=parseInt(this.GetActualPixelHeight());
var _236=parseInt(this.GetActualPixelWidth());
_230.top=top;
_230.left=left;
_230.zIndex=_22c.m_ListZIndex;
var _237=(nitobi.browser.IE?parseInt(document.body.clientWidth):window.innerWidth);
var _238=(nitobi.browser.IE?parseInt(document.body.clientHeight):window.innerHeight);
var _239=(document.body.scrollTop==""||parseInt(document.body.scrollTop==0)?0:parseInt(document.body.scrollTop));
var _23a=(document.body.scrollLeft==""||parseInt(document.body.scrollLeft==0)?0:parseInt(document.body.scrollLeft));
if(parseInt(top)-_239+_235>_238){
var _23b=parseInt(_230.top)-_235-_231;
if(_23b>=0){
_230.top=_23b;
}
}
if(parseInt(left)-parseInt(_23a)+_236>_237){
var _23c=document.getElementById(_22c.GetId());
var _23d=nitobi.Browser.GetElementWidth(_23c);
if(_236>_23d){
var _23e=_236-_23d;
var _23f=left-_23e;
if(_23f>=0){
_230.left=_23f;
}
}
}
_230.position="absolute";
_230.display="inline";
this.GenerateCss();
_230.visibility="visible";
this.SetIFrameDimensions();
this.ShowIFrame();
eval(this.GetOnShowEvent());
}
catch(err){
}
}
nitobi.combo.List.prototype.SetX=function(x){
var tag=this.GetHTMLTagObject();
tag.style.left=x;
};
nitobi.combo.List.prototype.GetX=function(){
var tag=this.GetHTMLTagObject();
return tag.style.left;
};
nitobi.combo.List.prototype.SetY=function(y){
var tag=this.GetHTMLTagObject();
tag.style.top=y;
};
nitobi.combo.List.prototype.GetY=function(){
var tag=this.GetHTMLTagObject();
return tag.style.top;
};
nitobi.combo.List.prototype.SetFrameX=function(x){
if(nitobi.browser.ie){
nitobi.combo.iframeBacker.style.left=x;
}
};
nitobi.combo.List.prototype.SetFrameY=function(y){
if(nitobi.browser.ie){
nitobi.combo.iframeBacker.style.top=y;
}
};
nitobi.combo.List.prototype.GetFrame=function(){
if(nitobi.browser.ie){
return nitobi.combo.iframeBacker;
}else{
return null;
}
};
nitobi.combo.List.prototype.ShowIFrame=List_ShowIFrame;
function List_ShowIFrame(){
try{
if(nitobi.browser.IE){
var _248=nitobi.combo.iframeBacker.style;
_248.visibility="visible";
}
}
catch(err){
}
}
nitobi.combo.List.prototype.SetIFrameDimensions=List_SetIFrameDimensions;
function List_SetIFrameDimensions(){
try{
if(nitobi.browser.IE){
var tag=this.GetHTMLTagObject();
var _24a=nitobi.combo.iframeBacker.style;
var _24b=tag.style;
_24a.top=_24b.top;
_24a.left=_24b.left;
_24a.width=nitobi.Browser.GetElementWidth(tag);
_24a.height=nitobi.Browser.GetElementHeight(tag);
_24a.zIndex=parseInt(_24b.zIndex)-1;
}
}
catch(err){
}
}
nitobi.combo.List.prototype.Hide=List_Hide;
function List_Hide(){
try{
if(!this.m_Rendered){
return false;
}
var tag=this.GetHTMLTagObject();
var _24d=tag.style;
_24d.visibility="hidden";
if(nitobi.browser.MOZ){
_24d.display="none";
}
if(nitobi.browser.IE){
var _24e=nitobi.combo.iframeBacker.style;
_24e.visibility="hidden";
}
eval(this.GetOnHideEvent());
}
catch(err){
}
}
nitobi.combo.List.prototype.Toggle=List_Toggle;
function List_Toggle(){
try{
if(this.IsVisible()){
this.Hide();
this.GetCombo().GetTextBox().ToggleHidden();
}else{
this.Show();
this.GetCombo().GetTextBox().ToggleShow();
}
}
catch(err){
}
}
nitobi.combo.List.prototype.SetActiveRowAsSelected=List_SetActiveRowAsSelected;
function List_SetActiveRowAsSelected(){
try{
var _24f=this.GetCombo();
var t=_24f.GetTextBox();
var row=null;
row=this.GetActiveRow();
if(null!=row){
eval(_24f.GetOnBeforeSelectEvent());
}
if(row!=null){
this.SetSelectedRow(this.GetRowIndex(row));
if(_24f.mode!="smartlist"){
t.SetValue(this.GetSelectedRowValues()[t.GetDataFieldIndex()]);
}
}
}
catch(err){
}
}
nitobi.combo.List.prototype.SetSelectedRow=List_SetSelectedRow;
function List_SetSelectedRow(_252){
this.SetSelectedRowIndex(_252);
var _253=this.GetXmlDataSource().GetRow(_252);
this.SetSelectedRowValues(_253,null);
}
nitobi.combo.List.prototype.OnClick=List_OnClick;
function List_OnClick(Row){
try{
eval(this.GetCombo().GetOnBeforeSelectEvent());
var _255=this.GetRowIndex(Row);
this.SetSelectedRowIndex(_255);
var _256=this.GetXmlDataSource().GetRow(_255);
this.SetSelectedRowValues(_256,null);
var _257=this.GetCombo();
var tb=_257.GetTextBox();
var _259=tb.GetDataFieldIndex();
if(_256.length<=_259){
alert("You have bound the textbox to a column that does not exist.\nThe textboxDataFieldIndex is "+_259+".\nThe number of values in the selected row is "+_256.length+".");
}else{
tb.SetValue(_256[_259],_257.mode=="smartlist");
}
this.Hide();
eval(_257.GetOnSelectEvent());
}
catch(err){
}
}
nitobi.combo.List.prototype.OnMouseWheel=List_OnMouseWheel;
function List_OnMouseWheel(evt){
try{
if(nitobi.browser.IE){
var b=nitobi.Browser;
var lb=this.GetSectionHTMLTagObject(EBAComboBoxListBody);
var top=this.GetRow(0);
var bot=this.GetRow(this.GetXmlDataSource().GetNumberRows()-1);
if(null!=top){
if(evt.wheelDelta>=120){
b.WheelUp(this);
}else{
if(evt.wheelDelta<=-120){
b.WheelDown(this);
}
}
evt.cancelBubble=true;
evt.returnValue=false;
}
}
}
catch(err){
}
}
nitobi.combo.List.prototype.Render=List_Render;
function List_Render(){
try{
if(!this.m_Rendered){
this.m_Rendered=true;
var _25f=this.GetCombo();
var _260=document.body;
_260.insertAdjacentHTML("afterBegin",this.GetHTMLRenderString());
this.Initialize(window.document.getElementById("EBAComboBoxText"+_25f.GetId()));
this.OnWindowResized();
this.GenerateCss();
}
}
catch(err){
}
}
nitobi.combo.List.prototype.GetHTMLRenderString=List_GetHTMLRenderString;
function List_GetHTMLRenderString(){
try{
var _261=this.GetCombo();
var _262=_261.GetUniqueId();
var _263=_261.GetId();
var _264=parseInt(this.GetDesiredPixelWidth());
var _265=false;
var _266="";
if(this.m_XmlDataSource.GetXmlObject()){
var xml=null;
if(_261.mode=="default"||_261.mode=="unbound"){
xml=this.m_XmlDataSource.GetXmlObject().xml;
}else{
xml="<root></root>";
}
_266=this.GetRowHTML(xml);
}
var _268=this.GetListColumnDefinitions();
var s="";
s="<span id=\"EBAComboBoxList"+_262+"\" class=\"ComboBoxList"+"\" style=\"width: "+_264+";\" "+"onMouseOver=\"document.getElementById('"+this.GetCombo().GetId()+"').object.m_Over=true\" "+"onMouseOut=\"document.getElementById('"+this.GetCombo().GetId()+"').object.m_Over=false\" "+"onClick=\"document.getElementById('"+this.GetCombo().GetId()+"').object.GetList().OnFocus()\">\n";
var tag=this.m_userTag;
var _26b=tag.childNodes;
var _26c="<span class='ComboMenus ComboListWidth"+_262+"'>";
var _26d=false;
for(var i=0;i<_26b.length;i++){
if(_26b[i].nodeName.toLowerCase().replace(/^eba:/,"").replace(/^ntb:/,"")=="combopanel"){
s+=_26b[i].innerHTML;
}
if(_26b[i].nodeName.toLowerCase().replace(/^eba:/,"").replace(/^ntb:/,"")=="combomenu"){
_26d=true;
var icon=_26b[i].getAttribute("icon");
_26c+="<div style='"+(nitobi.browser.MOZ&&i==0?"":"")+"' class='ComboMenu ComboListWidth"+_262+"' onMouseOver=\"this.className='ComboMenuHighlight ComboListWidth"+_262+"'\" onmouseout=\"this.className='ComboMenu ComboListWidth"+_262+"'\" onclick=\""+_26b[i].getAttribute("OnClickEvent")+"\">";
if(icon!=""){
_26c+="<img class='ComboMenuIcon' align='absmiddle' src='"+icon+"'>";
}
_26c+=_26b[i].getAttribute("text")+"</div>";
}
}
_26c+="</span>";
if(_261.mode=="default"||_261.mode=="filter"||_261.mode=="unbound"){
for(var i=0;i<_268.length;i++){
if(_268[i].GetHeaderLabel()!=""){
_265=true;
}
}
var _270=this.GetCustomHTMLHeader();
if((_265==true)||(_270!="")){
s+="<span id='EBAComboBoxListHeader"+_262+"' class='ComboBoxListHeader' style='padding:0px; margin:0px; width: "+_264+"' >\n";
if(_270!=""){
s+=_270;
}else{
s+="<table cellspacing='0' cellpadding='0' style='border-collapse:collapse;' class='comboHeader"+_262+"'>\n";
s+="<tr style='width:100%' id='EBAComboBoxColumnLabels"+_262+"' class='ComboBoxColumnLabels'>\n";
var _271="";
var _272=false;
for(var i=0;i<_268.length;i++){
var _273=_268[i].GetWidth();
_271="";
if(_268[i].GetColumnType().toLowerCase()=="hidden"){
_271+="style='display: none;'";
_268[i].SetWidth("0%");
}
var _274="comboColumn_"+i+"_"+_262;
var _275=(i>0?"style='padding-left:0px'":"");
s+="<td "+_275+" align='"+_268[i].GetAlign()+"' class='ComboBoxColumnLabel "+_274+"' "+_271+">"+_268[i].GetHeaderLabel()+"</td>\n";
}
s+="</tr>\n";
s+="</table>\n";
}
s+="</span><br>\n";
}
}
if(_26d){
s+=_26c;
}
s+="<span id='EBAComboBoxListBody"+_262+"' class='ComboBoxListBody"+"' style='width:"+_264+";"+(_261.mode=="default"||_261.mode=="unbound"||(_261.mode=="smartsearch"&&this.GetAllowPaging())?"height: "+this.GetSectionHeight(EBAComboBoxListBody)+(this.m_overflowy=="auto"?";_overflow-y:;_overflow:auto":""):"overflow:visible")+";' onscroll=\"document.getElementById('"+this.GetCombo().GetId()+"').object.GetTextBox().GetHTMLTagObject().focus()\" "+"onmousewheel=\"document.getElementById('"+this.GetCombo().GetId()+"').object.GetList().OnMouseWheel(event)\" "+"onfocus=\"document.getElementById('"+this.GetCombo().GetId()+"').object.GetList().OnFocus()\">\n";
s+=_266+"</table>\n"+"</span>\n";
var _276=this.GetAllowPaging();
if((_261.mode=="default"||_261.mode=="smartsearch")&&true==_276){
s+="<br><span id='EBAComboBoxListFooter"+_262+"' style='width:"+_264+"' class='ComboBoxListFooter' >\n";
s+="<span id=\"EBAComboBoxListFooterPageNextButton"+_262+"\" style=\"width:100%\""+" class=\"ComboBoxListFooterPageNextButton\" "+"onMouseOver='this.className=\"ComboBoxListFooterPageNextButtonHighlight\"' "+"onMouseOut='this.className=\"ComboBoxListFooterPageNextButton\"'"+"onClick=\"document.getElementById('"+this.GetCombo().GetId()+"').object.GetList().OnGetNextPage(null, true);\"></span>\n";
s+="</span>\n"+"</span>\n";
}
s+="</span>\n";
return s;
}
catch(err){
}
}
nitobi.combo.List.prototype.Initialize=List_Initialize;
function List_Initialize(_277){
try{
this.attachee=_277;
var c=this.GetCombo();
var d=document;
var _27a=c.GetUniqueId();
this.SetHTMLTagObject(d.getElementById("EBAComboBoxList"+_27a));
this.SetSectionHTMLTagObject(EBAComboBoxListHeader,d.getElementById("EBAComboBoxListHeader"+_27a));
this.SetSectionHTMLTagObject(EBAComboBoxListBody,d.getElementById("EBAComboBoxListBody"+_27a));
this.SetSectionHTMLTagObject(EBAComboBoxListFooter,d.getElementById("EBAComboBoxListFooter"+_27a));
this.SetSectionHTMLTagObject(EBAComboBoxListBodyTable,d.getElementById("EBAComboBoxListBodyTable"+_27a));
this.SetSectionHTMLTagObject(EBAComboBoxList,d.getElementById("EBAComboBoxList"+_27a));
if(c.mode=="default"&&true==this.GetAllowPaging()){
this.SetFooterText(this.GetXmlDataSource().GetNumberRows()+EbaComboUi[EbaComboUiNumRecords]);
}
this.Hide();
}
catch(err){
}
}
nitobi.combo.List.prototype.OnMouseOver=List_OnMouseOver;
function List_OnMouseOver(Row){
try{
this.SetActiveRow(Row);
}
catch(err){
}
}
nitobi.combo.List.prototype.OnMouseOut=List_OnMouseOut;
function List_OnMouseOut(Row){
try{
this.SetActiveRow(null);
}
catch(err){
}
}
nitobi.combo.List.prototype.OnFocus=List_OnFocus;
function List_OnFocus(){
try{
var t=this.GetCombo().GetTextBox();
t.m_skipFocusOnce=true;
t.m_HTMLTagObject.focus();
}
catch(err){
}
}
nitobi.combo.List.prototype.OnGetNextPage=List_OnGetNextPage;
function List_OnGetNextPage(_27e,_27f){
try{
if(this.m_httpRequestReady){
var _280=this.GetXmlDataSource();
var last=null;
if(_27f==true){
var n=_280.GetNumberRows();
if(n>0){
last=_280.GetRowCol(n-1,this.GetCombo().GetTextBox().GetDataFieldIndex());
}
}
this.GetPage(_280.GetNumberRows(),this.GetPageSize(),this.GetCombo().GetTextBox().GetIndexSearchTerm(),_27e,last);
this.GetCombo().GetTextBox().GetHTMLTagObject().focus();
}
}
catch(err){
}
}
nitobi.combo.List.prototype.OnWindowResized=List_OnWindowResized;
function List_OnWindowResized(){
if(!this.m_Rendered){
return;
}
if(nitobi.Browser.GetMeasurementUnitType(this.GetWidth())=="%"){
this.SetWidth(this.GetWidth());
}
}
nitobi.combo.List.prototype.GenerateCss=List_GenerateCss;
function List_GenerateCss(){
var _283=this.GetListColumnDefinitions();
var uid=this.GetCombo().GetUniqueId();
var _285="";
var _286=-1;
var list=this.GetSectionHTMLTagObject(EBAComboBoxListBody);
var sb=nitobi.Browser.GetScrollBarWidth(list);
var _289=(nitobi.browser.MOZ?6:0);
var _28a=0;
for(var i=0;i<this.widestColumn.length;i++){
_28a+=this.widestColumn[i];
}
if(_28a<parseInt(this.GetDesiredPixelWidth())){
_28a=parseInt(this.GetDesiredPixelWidth());
}
var _28c=_28a-sb-_289;
var _28d=_28a-sb-_289;
_285+=".ComboRow"+uid+"{width:"+(_28a-sb)+"px;}";
_285+=".ComboHeader"+uid+"{width:"+(_28a-sb+3)+"px;}";
_285+=".ComboListWidth"+uid+"{width:"+(_28a)+"px;}";
for(var i=0;i<_283.length;i++){
var _28e=_283[i].GetWidth();
if(nitobi.Browser.GetMeasurementUnitType(_28e)=="%"&&_28e!="*"){
_28e=Math.floor((parseInt(_28e)/100)*_28d);
}else{
if(_28e!="*"){
_28e=parseInt(_28e);
}
}
if(_28e=="*"||(i==_283.length-1&&_286==-1)){
_286=i;
}else{
if(_28e<this.widestColumn[i]){
_28e=this.widestColumn[i];
}
_28c-=parseInt(_28e);
_285+=".comboColumn_"+i+"_"+uid+"{ width: "+(_28e)+"px;}";
}
}
if(_286!=-1){
_285+=".comboColumn_"+_286+"_"+uid+"{ width: "+_28c+"px;}";
}
if(this.stylesheet==null){
this.stylesheet=document.createStyleSheet();
}
this.stylesheet.cssText=_285;
}
nitobi.combo.List.prototype.ClearCss=List_ClearCss;
function List_ClearCss(){
if(this.stylesheet==null){
this.stylesheet=document.createStyleSheet();
}
this.stylesheet.cssText="";
}
nitobi.combo.List.prototype.GetRowHTML=List_GetRowHTML;
function List_GetRowHTML(XML,_290){
try{
var _291=this.GetCombo();
var _292=_291.GetId();
var _293=_291.GetUniqueId();
var _294=this.GetListColumnDefinitions();
var _295=parseInt(this.GetWidth());
var xsl="";
if(nitobi.browser.IE){
xsl="<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" xmlns:msxsl=\"urn:schemas-microsoft-com:xslt\" xmlns:jstring=\"http://www.ebusiness-apps.com/comboxsl\"  extension-element-prefixes=\"msxsl\" exclude-result-prefixes=\"jstring\">";
}else{
xsl="<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" version=\"1.0\"  >";
}
xsl+="<xsl:output method='xml' version='4.0' omit-xml-declaration='yes' />\n"+"<xsl:template match='/'>"+"<table cellspacing='0' cellpadding='0' id='EBAComboBoxListBodyTable"+_293+"_"+this.GetNumPagesLoaded()+"' class='ComboBoxListBodyTable comboRow"+_293+"'>\n"+"<xsl:apply-templates>"+"</xsl:apply-templates>"+"</table>"+"</xsl:template>";
xsl+="<xsl:template match='e'>";
xsl+="<tr onclick=\"document.getElementById('"+this.GetCombo().GetId()+"').object.GetList().OnClick(this)\" "+"onmouseover=\"document.getElementById('"+this.GetCombo().GetId()+"').object.GetList().OnMouseOver(this)\" "+"onmouseout=\"document.getElementById('"+this.GetCombo().GetId()+"').object.GetList().OnMouseOut(this)\">";
xsl+="<xsl:attribute name='id'>";
var _297="position()+"+(this.GetXmlDataSource().GetNumberRows()-this.GetXmlDataSource().GetLastPageSize())+"-1";
var _298="EBAComboBoxRow"+_293+"_<xsl:value-of select='"+_297+"'/>";
xsl+=_298+"</xsl:attribute>"+"<td class='ComboRowContainerParent'><table cellspacing='0' cellpadding='0' class='ComboBoxListBodyTableRow "+"comboRow"+_293+"'>"+"<xsl:attribute name='id'>"+"ContainingTableFor"+_298+"</xsl:attribute>"+"<tr class='ComboRowContainer'>";
var _299=this.GetCustomHTMLDefinition();
var _29a;
if(""==_299){
for(var i=0;i<_294.length;i++){
var _29c="";
var _29d=_294[i].GetColumnType().toLowerCase();
if(_29d=="hidden"){
_29c+="style='display: none;'";
}
var _29e="comboColumn_"+i+"_"+_293;
xsl+="<td align='"+_294[i].GetAlign()+"' "+"class='"+_29e+" "+_294[i].GetCSSClassName()+"' "+_29c+">";
xsl+="<span class=\""+_29e+"\" style=\"color:"+_294[i].GetTextColor()+";\" onfocus=\"document.getElementById('"+this.GetCombo().GetId()+"').object.GetList().OnFocus()\""+" onmouseover=\"document.getElementById('"+this.GetCombo().GetId()+"').object.GetList().OnFocus()\">";
xsl+="<xsl:attribute name='id'>"+"ContainingSpanFor"+_298+"_"+i+"</xsl:attribute>"+"<xsl:text disable-output-escaping='yes'>"+"<![CDATA["+_294[i].GetHTMLPrefix()+""+"]]>"+"</xsl:text>";
_29a=_294[i].GetDataFieldIndex();
if(null==_29a){
_29a=i;
}
_29a=parseInt(_29a);
var _29f="";
if(_29d=="image"){
_29f=_294[i].GetImageHandlerURL();
_29f.indexOf("?")==-1?_29f+="?":_29f+="&";
_29f+="image=";
xsl+="<img> <xsl:attribute name='align'><xsl:value-of  select='absmiddle'/></xsl:attribute>"+"<xsl:attribute name='src'><xsl:value-of select=\"concat('"+(_294[i].ImageUrlFromData?"":_29f)+"',"+"@"+String.fromCharCode(97+_29a)+")\"/></xsl:attribute>"+"</img>";
}
if((_290!=null)&&(_29d!="image")){
xsl+="<xsl:call-template name=\"bold\"><xsl:with-param name=\"string\">";
}
if(_29d!="image"){
xsl+="<xsl:value-of select=\"@"+String.fromCharCode(97+_29a)+"\"></xsl:value-of>";
}
if((_290!=null)&&(_29d!="image")){
xsl+="</xsl:with-param><xsl:with-param name=\"pattern\" select='"+EbaConstructValidXpathQuery(_290,true)+"'></xsl:with-param></xsl:call-template>";
}
xsl+="<xsl:text disable-output-escaping='yes'>"+"<![CDATA["+_294[i].GetHTMLSuffix()+""+"]]>"+"</xsl:text>";
xsl+="</span>";
xsl+="</td>";
}
}else{
xsl+="<td width='100%'>";
var done=false;
var _2a1=0;
var _2a2=0;
var _2a3=0;
var _2a4;
while(!done){
_2a1=_299.indexOf("${",_2a2);
if(_2a1!=-1){
_2a2=_299.indexOf("}",_2a1);
_2a4=_299.substr(_2a1+2,_2a2-_2a1-2);
xsl+="<xsl:text disable-output-escaping='yes'>"+"<![CDATA["+_299.substr(_2a3,_2a1-_2a3)+"]]>"+"</xsl:text>";
xsl+="<xsl:value-of select=\"@"+String.fromCharCode(parseInt(_2a4)+97)+"\"></xsl:value-of>";
_2a3=_2a2+1;
}else{
xsl+="<xsl:text disable-output-escaping='yes'>"+"<![CDATA["+_299.substr(_2a3)+"]]>"+"</xsl:text>";
done=true;
}
}
xsl+="</td>";
}
xsl+="</tr></table></td></tr>\n"+"</xsl:template>";
if(_290!=null){
if(nitobi.browser.IE){
xsl+="<msxsl:script language=\"javascript\" implements-prefix=\"jstring\">"+"<![CDATA["+"function lowerCase(s) "+"{"+"\treturn s.toLowerCase();"+"}"+"]]>"+"</msxsl:script>";
}
xsl+="<xsl:template name=\"bold\">"+"<xsl:param name=\"string\" select=\"''\" /><xsl:param name=\"pattern\" select=\"''\" /><xsl:param name=\"carryover\" select=\"''\" />";
if(nitobi.browser.IE){
xsl+="<xsl:variable name=\"lcstring\" select=\"jstring:lowerCase(string($string))\"/>"+"<xsl:variable name=\"lcpattern\" select=\"jstring:lowerCase(string($pattern))\"/>";
}else{
xsl+="<xsl:variable name=\"lcstring\" select=\"translate($string,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')\"/>"+"<xsl:variable name=\"lcpattern\" select=\"translate($pattern,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')\"/>";
}
xsl+="<xsl:choose>"+"<xsl:when test=\"$pattern != '' and $string != '' and contains($lcstring,$lcpattern)\">"+"<xsl:variable name=\"newpattern\" select=\"substring($string,string-length(substring-before($lcstring,$lcpattern)) + 1, string-length($pattern))\"/>"+"<xsl:variable name=\"before\" select=\"substring-before($string, $newpattern)\" />"+"<xsl:variable name=\"len\" select=\"string-length($before)\" />"+"<xsl:variable name=\"newcarryover\" select=\"boolean($len&gt;0 and contains(substring($before,$len,1),'%'))\" />"+"<xsl:value-of select=\"$before\" />"+"<xsl:choose>"+"<xsl:when test=\"($len=0 and $carryover) or $newcarryover or ($len&gt;1 and contains(substring($before,$len - 1,1),'%'))\">"+"<xsl:copy-of select=\"$newpattern\" />"+"</xsl:when>"+"<xsl:otherwise>"+"<b><xsl:copy-of select=\"$newpattern\" /></b>"+"</xsl:otherwise></xsl:choose>"+"<xsl:call-template name=\"bold\">"+"<xsl:with-param name=\"string\" select=\"substring-after($string, $newpattern)\" />"+"<xsl:with-param name=\"pattern\" select=\"$pattern\" />"+"<xsl:with-param name=\"carryover\" select=\"$newcarryover\" />"+"</xsl:call-template>"+"</xsl:when>"+"<xsl:otherwise>"+"<xsl:value-of select=\"$string\" />"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:template>";
}
xsl+="</xsl:stylesheet>";
oXSL=xbDOM.create();
oXSL.loadXML(xsl);
tmp=xbDOM.create();
tmp.loadXML(XML.replace(/>\s+</g,"><"));
var html=tmp.transformNode(oXSL);
return html;
}
catch(err){
}
}
nitobi.combo.List.prototype.ScrollIntoView=List_ScrollIntoView;
function List_ScrollIntoView(Row,Top,_2a8){
try{
if(Row&&this.GetCombo().mode!="compact"){
var _2a9=this.GetSectionHTMLTagObject(EBAComboBoxListBody);
if(nitobi.Browser.IsObjectInView(Row,_2a9,Top,_2a8)==false){
nitobi.Browser.ScrollIntoView(Row,_2a9,Top);
}
}
}
catch(err){
}
}
nitobi.combo.List.prototype.GetRowIndex=List_GetRowIndex;
function List_GetRowIndex(Row){
try{
var vals=Row.id.split("_");
var _2ac=vals[vals.length-1];
return _2ac;
}
catch(err){
}
}
EBAComboListDatasourceAccessStatus_BUSY=0;
EBAComboListDatasourceAccessStatus_READY=1;
nitobi.combo.List.prototype.GetDatasourceAccessStatus=List_GetDatasourceAccessStatus;
function List_GetDatasourceAccessStatus(){
if(this.m_httpRequestReady){
return EBAComboListDatasourceAccessStatus_READY;
}else{
return EBAComboListDatasourceAccessStatus_BUSY;
}
}
nitobi.combo.List.prototype.Eval=List_Eval;
function List_Eval(_2ad){
eval(_2ad);
}
nitobi.combo.List.prototype.GetPage=List_GetPage;
function List_GetPage(_2ae,_2af,_2b0,_2b1,_2b2,_2b3,_2b4,_2b5){
try{
this.SetFooterText(EbaComboUi[EbaComboUiPleaseWait]);
if(_2b2==null){
_2b2="";
}
this.m_httpRequest.abort();
if(null==_2b1){
_2b1=EBAScrollToNone;
}
var _2b6=nitobi.Browser;
this.m_OriginalSearchSubstring=_2b0;
var _2b7=this.GetDatasourceUrl();
_2b7.indexOf("?")==-1?_2b7+="?":_2b7+="&";
_2b7+="StartingRecordIndex="+_2ae+"&PageSize="+_2af+"&SearchSubstring="+encodeURI(_2b0)+"&ComboId="+encodeURI(this.GetCombo().GetId())+"&LastString="+encodeURI(_2b2);
this.m_httpRequest.open(this.GetCombo().GetHttpRequestMethod(),_2b7,true,"","");
var _2b8=this.GetCombo().GetId();
this.m_httpRequest.onreadystatechange=function(){
try{
var _2b9=window.document.getElementById(_2b8);
var co=_2b9.object;
if((_2b9==null)||(co==null)){
alert(EbaComboUi[EbaComboUiServerError]);
}
var t=co.GetTextBox();
var list=co.GetList();
if(list==null){
alert(EbaComboUi[EbaComboUiServerError]);
}
if(list.m_httpRequest.readyState==4){
var _2bd=list.m_httpRequest.responseText;
var _2be=_2bd.indexOf("<?xml");
if(_2be!=-1){
_2bd=_2bd.substr(_2be);
}
var _2bf=list.GetXmlDataSource();
var _2c0=_2bf.GetNumberRows();
var tmp=xbDOM.create();
tmp.loadXML(_2bd);
if(true==list.clip){
tmp=xbClipXml(tmp,"root","e",list.clipLength);
_2bd=tmp.xml;
}
var _2c2=tmp.selectNodes("//e").length;
var _2c3=co.mode!="default"&&!(co.mode=="smartsearch"&&list.GetAllowPaging());
if((_2c2>0)&&(_2ae==0)||_2c3){
list.Clear();
_2bf.Clear();
}
if(_2c2==0&&_2c3){
list.Hide();
}
if(_2c2>0){
_2bf.AddPage(_2bd);
var ss=null;
if(co.mode=="smartsearch"||co.mode=="smartlist"){
ss=list.searchSubstring;
}
list.AddPage(_2bd,ss);
if((_2ae==0)&&(list.GetCombo().GetTextBox().GetSearchTerm()!="")){
list.SetActiveRow(list.GetRow(0));
}
var _2c5=false;
try{
if(!list.IsFuzzySearchEnabled()){
var _2c6=_2bf.Search(list.m_OriginalSearchSubstring,t.GetDataFieldIndex(),co.mode=="smartsearch"||co.mode=="smartlist");
_2c5=(_2c6==-1);
co.ShowWarning(_2c6!=-1,"cw001");
}
}
catch(err){
}
var _2c7;
_2c7=list.IsVisible();
if(EBAScrollToBottom==_2b1){
var r=list.GetRow(_2c0-1);
list.SetActiveRow(r);
list.ScrollIntoView(r,false);
}else{
if(EBAScrollToNewTop==_2b1||EBAScrollToNewBottom==_2b1){
var r=list.GetRow(_2c0);
list.SetActiveRow(r);
list.ScrollIntoView(r,EBAScrollToNewTop==_2b1);
var tb=t.m_HTMLTagObject;
tb.value=list.GetXmlDataSource().GetRowCol(_2c0,t.GetDataFieldIndex());
xbPutCur(tb,tb.value.length);
t.Paging=false;
}else{
if(_2c7){
list.ScrollIntoView(list.GetActiveRow(),true);
}
}
}
try{
if(!_2c5&&_2b3){
_2b3(EBAComboSearchNewRecords,list,_2b0,_2b4,_2b5);
}
}
catch(err){
}
}else{
try{
if(_2b3){
_2b3(EBAComboSearchNoRecords,list,_2b0,_2b4,_2b5);
}
}
catch(err){
}
list.SetFooterText(EbaComboUi[EbaComboUiNoRecords]);
list.SetActiveRow(null);
}
if(list.InitialSearchOnce==true&&_2c2>0){
list.InitialSearchOnce=false;
var row=list.GetRow(0);
list.SetActiveRow(row);
list.SetSelectedRowValues(null,row);
list.SetSelectedRowIndex(0);
var tb=co.GetTextBox();
tb.SetValue(list.GetSelectedRowValues()[tb.GetDataFieldIndex()]);
}
}
list.m_httpRequestReady=true;
t.Paging=false;
}
catch(err){
alert(EbaComboUi[EbaComboUiServerError]+" "+err.message);
}
};
this.m_httpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
var vs=document.getElementsByName("__VIEWSTATE");
if((vs!=null)&&(vs["__VIEWSTATE"]!=null)){
var _2cc="__VIEWSTATE="+encodeURI(vs["__VIEWSTATE"].value).replace(/\+/g,"%2B");
var _2cd="__EVENTTARGET="+encodeURI(this.GetCombo().GetId());
var args="__EVENTARGUMENT=GetPage";
var _2cf=_2cd+"&"+args+"&"+_2cc;
this.m_httpRequest.send(_2cf);
}else{
this.m_httpRequest.send("EBA Combo Box Get Page Request");
}
this.m_httpRequestReady=false;
return true;
}
catch(err){
alert(EbaComboUi[EbaComboUiServerError]);
}
}
nitobi.combo.List.prototype.Search=List_Search;
function List_Search(_2d0,_2d1,_2d2,_2d3){
try{
var _2d4=this.GetCombo();
var _2d5=this.GetXmlDataSource();
if(_2d4.mode!="default"&&_2d0==""){
this.Hide();
return;
}
if(null==_2d3){
_2d3=false;
}
eval(this.GetOnBeforeSearchEvent());
var _2d6=-1;
if(!this.GetEnableDatabaseSearch()||!_2d5.m_Dirty||_2d4.mode=="unbound"){
_2d6=_2d5.Search(_2d0,_2d1,_2d4.mode=="smartsearch"||_2d4.mode=="smartlist");
if(_2d6>-1&&this.InitialSearchOnce!=true){
this.Show();
}
if(-1!=_2d6){
if(_2d2){
try{
_2d2(_2d6,this);
}
catch(err){
}
}
eval(this.GetOnAfterSearchEvent());
}
if(-1==_2d6&&(false==this.GetEnableDatabaseSearch()||_2d3)){
if(_2d2){
try{
_2d2(_2d6,this);
}
catch(err){
}
}
eval(this.GetOnAfterSearchEvent());
}
}
this.searchSubstring=_2d0;
if((-1==_2d6)&&(this.GetEnableDatabaseSearch()==true&&(_2d3==false))){
var _2d7=this.GetDatabaseSearchTimeoutStatus();
var _2d8="var list = window.document.getElementById('"+_2d4.GetId()+"').object.GetList(); "+"list.SetDatabaseSearchTimeoutStatus(EBADatabaseSearchTimeoutStatus_EXPIRED);"+"var textbox = window.document.getElementById('"+_2d4.GetId()+"').object.GetTextBox();"+"list.Search(textbox.GetSearchTerm(),textbox.GetDataFieldIndex(),textbox.m_Callback);";
var _2d9=this.GetDatabaseSearchTimeoutId();
_2d4.GetTextBox().SetIndexSearchTerm(_2d0);
switch(_2d7){
case (EBADatabaseSearchTimeoutStatus_EXPIRED):
if(_2d9!=null){
window.clearTimeout(_2d9);
}
this.SetDatabaseSearchTimeoutStatus(EBADatabaseSearchTimeoutStatus_NONE);
var _2da=_EbaListGetPageCallback;
this.GetPage(0,this.GetPageSize(),_2d0,EBAScrollToTypeAhead,null,_2da,_2d1,_2d2);
break;
case (EBADatabaseSearchTimeoutStatus_WAIT):
if(_2d9!=null){
window.clearTimeout(_2d9);
}
var _2d9=window.setTimeout(_2d8,EBADatabaseSearchTimeoutWait);
this.SetDatabaseSearchTimeoutId(_2d9);
case (EBADatabaseSearchTimeoutStatus_NONE):
this.SetDatabaseSearchTimeoutStatus(EBADatabaseSearchTimeoutStatus_WAIT);
var _2d9=window.setTimeout(_2d8,EBADatabaseSearchTimeoutWait);
this.SetDatabaseSearchTimeoutId(_2d9);
}
}
}
catch(err){
}
}
function _EbaListGetPageCallback(_2db,list,_2dd,_2de,_2df){
if((list==null)){
alert(EbaComboUi[EbaComboUiServerError]);
}
if(_2db==EBAComboSearchNewRecords){
if(!list.IsFuzzySearchEnabled()){
list.Search(_2dd,_2de,_2df);
}else{
list.Show();
}
}else{
_2df(-1,list);
list.Eval(list.GetOnAfterSearchEvent());
}
}
nitobi.combo.List.prototype.Clear=List_Clear;
function List_Clear(){
try{
var _2e0=this.GetSectionHTMLTagObject(EBAComboBoxListBody);
_2e0.innerHTML="";
this.SetSelectedRowIndex(-1);
this.SetSelectedRowValues(null);
}
catch(err){
}
}
nitobi.combo.List.prototype.FitContent=List_FitContent;
function List_FitContent(){
try{
var _2e1=this.GetSectionHTMLTagObject(EBAComboBoxListBody);
var _2e2=_2e1.childNodes[_2e1.childNodes.length-1];
var row=_2e2;
while(row.childNodes[0]!=null&&row.childNodes[0].className.indexOf("ComboBoxListColumnDefinition")==-1){
row=row.childNodes[0];
}
for(var i=0;i<row.childNodes.length;i++){
var _2e5=nitobi.Browser.GetElementWidth(row.childNodes[0]);
if(this.widestColumn[i]<_2e5){
this.widestColumn[i]=_2e5;
}
}
}
catch(err){
}
}
nitobi.combo.List.prototype.AddPage=List_AddPage;
function List_AddPage(_2e6,_2e7){
try{
var _2e8=this.GetXmlDataSource();
var tmp=xbDOM.create();
tmp.loadXML(_2e6);
var _2ea=tmp.selectNodes("//e").length;
if(_2ea>0){
var html=this.GetRowHTML(_2e6,_2e7);
var _2ec=this.GetSectionHTMLTagObject(EBAComboBoxListBody);
_2ec.insertAdjacentHTML("beforeEnd",html,true);
this.GenerateCss();
}
var _2ed=_2e8.GetLastPageSize();
if(0==_2ea){
this.SetFooterText(EbaComboUi[EbaComboUiEndOfRecords]);
}else{
this.SetFooterText(_2e8.GetNumberRows()+EbaComboUi[EbaComboUiNumRecords]);
}
this.AdjustSize();
this.SetIFrameDimensions();
}
catch(err){
}
}
nitobi.combo.List.prototype.HideFooter=List_HideFooter;
function List_HideFooter(){
try{
var _2ee=this.GetSectionHTMLTagObject(EBAComboBoxListFooter);
var _2ef=_2ee.style;
_2ef.visibility="hidden";
}
catch(err){
}
}
nitobi.combo.List.prototype.ShowFooter=List_ShowFooter;
function List_ShowFooter(){
try{
var _2f0=this.GetSectionHTMLTagObject(EBAComboBoxListFooter);
var _2f1=_2f0.style;
_2f1.visibility="visible";
}
catch(err){
}
}
nitobi.combo.List.prototype.AddRow=List_AddRow;
function List_AddRow(_2f2){
try{
var xml="<root><e ";
for(var i=0;i<_2f2.length;i++){
xml+=String.fromCharCode(i+97)+"='"+EbaXmlEncode(_2f2[i])+"' ";
}
xml+="/></root>";
this.GetXmlDataSource().AddPage(xml);
this.AddPage(xml);
}
catch(err){
alert("Error. The values must be valid XML attributes.");
}
}
nitobi.combo.List.prototype.Move=List_Move;
function List_Move(_2f5){
try{
var _2f6=this.GetCombo();
var mode=_2f6.mode;
if(mode=="compact"||this.GetXmlDataSource().GetNumberRows()==0||(mode!="default"&&mode!="unbound"&&_2f6.GetTextBox().m_HTMLTagObject.value=="")){
return false;
}
var _2f8=this.GetActiveRow();
this.Show();
if(null==_2f8){
_2f8=this.GetRow(0,null);
}else{
var _2f9=this.GetRowIndex(this.GetActiveRow());
switch(_2f5){
case (EBAMoveAction_UP):
_2f9--;
break;
case (EBAMoveAction_DOWN):
_2f9++;
break;
default:
}
if((_2f9>=0)&&(_2f9<this.GetXmlDataSource().GetNumberRows())){
_2f8=this.GetRow(_2f9,null);
}
}
this.SetActiveRow(_2f8);
this.ScrollIntoView(_2f8,false,true);
return true;
}
catch(err){
}
}
nitobi.combo.List.prototype.GetRow=List_GetRow;
function List_GetRow(_2fa,Id){
try{
if(null!=_2fa){
return document.getElementById("EBAComboBoxRow"+this.GetCombo().GetUniqueId()+"_"+_2fa);
}
if(null!=Id){
return document.getElementById(Id);
}
}
catch(err){
}
}
nitobi.lang.defineNs("nitobi.combo");
nitobi.combo.ListColumnDefinition=function(_2fc){
try{
if(!_2fc.getAttribute){
_2fc.getAttribute=function(a){
return this[a];
};
}
var _2fe="50px";
var _2ff="ComboBoxListColumnDefinition";
var _300="text";
var _301="";
var _302="left";
var _303="#000";
var _304=(_2fc?_2fc.getAttribute("TextColor"):null);
((null==_304)||(""==_304))?this.SetTextColor(_303):this.SetTextColor(_304);
var _305=(_2fc?_2fc.getAttribute("Align"):null);
((null==_305)||(""==_305))?this.SetAlign(_302):this.SetAlign(_305);
var _306=(_2fc?_2fc.getAttribute("Width"):null);
((null==_306)||(""==_306))?this.SetWidth(_2fe):this.SetWidth(_306);
var ihu=(_2fc?_2fc.getAttribute("ImageHandlerURL"):null);
((null==ihu)||(""==ihu))?this.SetImageHandlerURL(_301):this.SetImageHandlerURL(ihu);
var ct=(_2fc?_2fc.getAttribute("ColumnType"):null);
((null==ct)||(""==ct))?this.SetColumnType(_300):this.SetColumnType(ct.toLowerCase());
this.ImageUrlFromData=((this.GetColumnType()=="image")&&((null==ihu)||(""==ihu)));
var ccn=(_2fc?_2fc.getAttribute("CSSClassName"):null);
((null==ccn)||(""==ccn))?this.SetCSSClassName(_2ff):this.SetCSSClassName(ccn);
var hp=(_2fc?_2fc.getAttribute("HTMLPrefix"):null);
((null==hp)||(""==hp))?this.SetHTMLPrefix(""):this.SetHTMLPrefix(hp);
var hs=(_2fc?_2fc.getAttribute("HTMLSuffix"):null);
((null==hs)||(""==hs))?this.SetHTMLSuffix(""):this.SetHTMLSuffix(hs);
var hl=(_2fc?_2fc.getAttribute("HeaderLabel"):null);
((null==hl)||(""==hl))?this.SetHeaderLabel(""):this.SetHeaderLabel(hl);
var dfi=(_2fc?_2fc.getAttribute("DataFieldIndex"):null);
((null==dfi)||(""==dfi))?this.SetDataFieldIndex(0):this.SetDataFieldIndex(dfi);
}
catch(err){
}
};
nitobi.combo.ListColumnDefinition.prototype.GetAlign=ListColumnDefinition_GetAlign;
function ListColumnDefinition_GetAlign(){
try{
return this.m_Align;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.SetAlign=ListColumnDefinition_SetAlign;
function ListColumnDefinition_SetAlign(_30e){
try{
_30e=_30e.toLowerCase();
if("right"!=_30e&&"left"!=_30e&&"center"!=_30e){
_30e="left";
}
this.m_Align=_30e;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.GetTextColor=ListColumnDefinition_GetTextColor;
function ListColumnDefinition_GetTextColor(){
try{
return this.m_TextColor;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.SetTextColor=ListColumnDefinition_SetTextColor;
function ListColumnDefinition_SetTextColor(_30f){
try{
this.m_TextColor=_30f;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.GetHTMLSuffix=ListColumnDefinition_GetHTMLSuffix;
function ListColumnDefinition_GetHTMLSuffix(){
try{
return this.m_HTMLSuffix;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.SetHTMLSuffix=ListColumnDefinition_SetHTMLSuffix;
function ListColumnDefinition_SetHTMLSuffix(_310){
try{
this.m_HTMLSuffix=_310;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.GetHTMLPrefix=ListColumnDefinition_GetHTMLPrefix;
function ListColumnDefinition_GetHTMLPrefix(){
try{
return this.m_HTMLPrefix;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.SetHTMLPrefix=ListColumnDefinition_SetHTMLPrefix;
function ListColumnDefinition_SetHTMLPrefix(_311){
try{
this.m_HTMLPrefix=_311;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.GetCSSClassName=ListColumnDefinition_GetCSSClassName;
function ListColumnDefinition_GetCSSClassName(){
try{
return this.m_CSSClassName;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.SetCSSClassName=ListColumnDefinition_SetCSSClassName;
function ListColumnDefinition_SetCSSClassName(_312){
try{
this.m_CSSClassName=_312;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.GetColumnType=ListColumnDefinition_GetColumnType;
function ListColumnDefinition_GetColumnType(){
try{
return this.m_ColumnType;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.SetColumnType=ListColumnDefinition_SetColumnType;
function ListColumnDefinition_SetColumnType(_313){
try{
this.m_ColumnType=_313;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.GetHeaderLabel=ListColumnDefinition_GetHeaderLabel;
function ListColumnDefinition_GetHeaderLabel(){
try{
return this.m_HeaderLabel;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.SetHeaderLabel=ListColumnDefinition_SetHeaderLabel;
function ListColumnDefinition_SetHeaderLabel(_314){
try{
this.m_HeaderLabel=_314;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.GetWidth=ListColumnDefinition_GetWidth;
function ListColumnDefinition_GetWidth(){
try{
return this.m_Width;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.SetWidth=ListColumnDefinition_SetWidth;
function ListColumnDefinition_SetWidth(_315){
try{
this.m_Width=_315;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.GetDataFieldIndex=ListColumnDefinition_GetDataFieldIndex;
function ListColumnDefinition_GetDataFieldIndex(){
try{
return this.m_DataFieldIndex;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.SetDataFieldIndex=ListColumnDefinition_SetDataFieldIndex;
function ListColumnDefinition_SetDataFieldIndex(_316){
try{
this.m_DataFieldIndex=_316;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.GetImageHandlerURL=ListColumnDefinition_GetImageHandlerURL;
function ListColumnDefinition_GetImageHandlerURL(){
try{
return this.m_ImageHandlerURL;
}
catch(err){
}
}
nitobi.combo.ListColumnDefinition.prototype.SetImageHandlerURL=ListColumnDefinition_SetImageHandlerURL;
function ListColumnDefinition_SetImageHandlerURL(_317){
try{
this.m_ImageHandlerURL=_317;
}
catch(err){
}
}
nitobi.lang.defineNs("nitobi.combo");
nitobi.combo.TextBox=function(_318,_319,_31a){
try{
var _31b="ComboBoxText ComboBoxTextDynamic";
var _31c="100px";
var _31d="";
var _31e=true;
var _31f="";
var _320=0;
var _321="";
var _322="";
this.SetCombo(_319);
var oeku=(_318?_318.getAttribute("OnEditKeyUpEvent"):null);
((null==oeku)||(""==oeku))?this.SetOnEditKeyUpEvent(_322):this.SetOnEditKeyUpEvent(oeku);
var _324=(_318?_318.getAttribute("Width"):null);
((null==_324)||(""==_324))?this.SetWidth(_31c):this.SetWidth(_324);
var _325=(_318?_318.getAttribute("Height"):null);
((null==_325)||(""==_325))?this.SetHeight(_31d):this.SetHeight(_325);
var ccn=(_318?_318.getAttribute("CSSClassName"):null);
((null==ccn)||(""==ccn))?this.SetCSSClassName(_31b):this.SetCSSClassName(ccn);
var _327=(_318?_318.getAttribute("Editable"):null);
((null==_327)||(""==_327))?this.SetEditable(_31e):this.SetEditable(_327);
var _328=(_318?_318.getAttribute("Value"):null);
((null==_328)||(""==_328))?this.SetValue(_31f):this.SetValue(_328);
var _329=_319.GetDataTextField();
if(_329!=null){
this.SetDataFieldIndex(_319.GetList().GetXmlDataSource().GetColumnIndex(_329));
}else{
var dfi=(_318?_318.getAttribute("DataFieldIndex"):null);
((null==dfi)||(""==dfi))?this.SetDataFieldIndex(_320):this.SetDataFieldIndex(dfi);
}
var st=(_318?_318.getAttribute("SearchTerm"):null);
if((null==st)||(""==st)){
this.SetSearchTerm(_321);
this.SetIndexSearchTerm(_321);
}else{
this.SetSearchTerm(st);
this.SetIndexSearchTerm(st);
}
this.hasButton=_31a;
this.m_userTag=_318;
}
catch(err){
}
};
nitobi.combo.TextBox.prototype.Unload=TextBox_Unload;
function TextBox_Unload(){
if(this.m_List){
delete this.m_List;
this.m_List=null;
}
if(this.m_Callback){
delete this.m_Callback;
this.m_Callback=null;
}
_EBAMemScrub(this);
}
nitobi.combo.TextBox.prototype.GetCSSClassName=TextBox_GetCSSClassName;
function TextBox_GetCSSClassName(){
try{
return (null==this.m_HTMLTagObject?this.m_CSSClassName:this.m_HTMLTagObject.className);
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.SetCSSClassName=TextBox_SetCSSClassName;
function TextBox_SetCSSClassName(_32c){
try{
if(null==this.m_HTMLTagObject){
this.m_CSSClassName=_32c;
}else{
this.m_HTMLTagObject.className=_32c;
}
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.GetHeight=TextBox_GetHeight;
function TextBox_GetHeight(){
try{
return (null==this.m_HTMLTagObject?this.m_Height:this.m_HTMLTagObject.style.height);
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.SetHeight=TextBox_SetHeight;
function TextBox_SetHeight(_32d){
try{
if(null==this.m_HTMLTagObject){
this.m_Height=_32d;
}else{
this.m_HTMLTagObject.style.height=_32d;
}
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.GetWidth=TextBox_GetWidth;
function TextBox_GetWidth(){
try{
return this.m_Width;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.SetWidth=TextBox_SetWidth;
function TextBox_SetWidth(_32e){
try{
this.m_Width=_32e;
if(null!=this.m_HTMLTagObject){
this.m_HTMLTagObject.style.width=_32e;
}
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.GetHTMLTagObject=TextBox_GetHTMLTagObject;
function TextBox_GetHTMLTagObject(){
try{
return this.m_HTMLTagObject;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.SetHTMLTagObject=TextBox_SetHTMLTagObject;
function TextBox_SetHTMLTagObject(_32f){
try{
this.m_HTMLTagObject=_32f;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.GetEditable=TextBox_GetEditable;
function TextBox_GetEditable(){
try{
if(null==this.m_HTMLTagObject){
return this.m_Editable;
}else{
return this.m_HTMLTagObject.getAttribute("contentEditable");
}
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.SetEditable=TextBox_SetEditable;
function TextBox_SetEditable(_330){
try{
if(null==this.m_HTMLTagObject){
this.m_Editable=_330;
}else{
this.m_HTMLTagObject.setAttrbiute("contentEditable",_330);
}
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.GetValue=TextBox_GetValue;
function TextBox_GetValue(){
try{
if(null==this.m_HTMLTagObject){
return this.m_Value;
}else{
return this.m_HTMLTagObject.value;
}
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.SetValue=TextBox_SetValue;
function TextBox_SetValue(_331,_332){
try{
if(null==this.m_HTMLTagObject){
this.m_Value=_331;
}else{
if(this.GetCombo().mode=="smartlist"){
this.SmartSetValue(_331,_332);
}else{
this.m_HTMLTagObject.value=_331;
this.m_TextValueTag.value=_331;
}
}
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.SmartSetValue=TextBox_SmartSetValue;
function TextBox_SmartSetValue(_333,_334){
try{
var t=this.m_HTMLTagObject;
var _336=this.GetCombo();
var lio=t.value.lastIndexOf(_336.SmartListSeparator);
if(lio>-1){
_333=t.value.substring(0,lio)+_336.SmartListSeparator+" "+_333;
}
if(_334){
_333+=_336.SmartListSeparator+" ";
}
t.value=_333;
this.m_TextValueTag.value=_333;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.GetDataFieldIndex=TextBox_GetDataFieldIndex;
function TextBox_GetDataFieldIndex(){
try{
return this.m_DataFieldIndex;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.SetDataFieldIndex=TextBox_SetDataFieldIndex;
function TextBox_SetDataFieldIndex(_338){
try{
this.m_DataFieldIndex=parseInt(_338);
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.GetCombo=TextBox_GetCombo;
function TextBox_GetCombo(){
try{
return this.m_Combo;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.SetCombo=TextBox_SetCombo;
function TextBox_SetCombo(_339){
try{
this.m_Combo=_339;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.GetSearchTerm=TextBox_GetSearchTerm;
function TextBox_GetSearchTerm(){
try{
return this.m_SearchTerm;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.SetSearchTerm=TextBox_SetSearchTerm;
function TextBox_SetSearchTerm(_33a){
try{
this.m_SearchTerm=_33a;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.GetIndexSearchTerm=TextBox_GetIndexSearchTerm;
function TextBox_GetIndexSearchTerm(){
try{
return this.m_IndexSearchTerm;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.SetIndexSearchTerm=TextBox_SetIndexSearchTerm;
function TextBox_SetIndexSearchTerm(_33b){
try{
this.m_IndexSearchTerm=_33b;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.OnChanged=TextBox_OnChanged;
function TextBox_OnChanged(e){
try{
this.m_skipBlur=true;
var _33d=this.GetCombo();
var list=_33d.GetList();
list.SetActiveRow(null);
var _33f=this.GetValue();
this.m_TextValueTag.value=_33f;
var _340=this.GetSearchTerm();
if(_33d.mode=="smartsearch"||_33d.mode=="smartlist"||_33d.mode=="filter"||_33d.mode=="compact"){
list.GetXmlDataSource().m_Dirty=true;
}
if(_33d.mode=="smartlist"){
var lio=_33f.lastIndexOf(_33d.SmartListSeparator);
if(lio>-1){
_33f=_33f.substring(lio+_33d.SmartListSeparator.length).replace(/^\s+/,"");
}
}
if((_340.indexOf(_33f)==0&&_340!=_33f)){
list.GetXmlDataSource().m_Dirty=true;
}
this.SetSearchTerm(_33f);
if(e!=null){
this.prevKeyCode=e.keyCode;
}
var dfi=this.GetDataFieldIndex();
var This=this;
var _344=(e!=null?e.keyCode:0);
this.m_CurrentKeyCode=_344;
this.m_List=list;
this.m_Event=e;
this.m_Callback=_EbaTextboxCallback;
this.m_List.Search(_33f,dfi,this.m_Callback);
}
catch(err){
}
}
function _EbaTextboxCallback(_345,list){
try{
var _347=list.GetCombo();
var tb=_347.GetTextBox();
var e=tb.m_Event;
var _34a=tb.m_CurrentKeyCode;
list.SetSelectedRowValues(null);
list.SetSelectedRowIndex(-1);
var _34b=tb.GetSearchTerm();
var tb=list.GetCombo().GetTextBox();
var row=null;
if(_345>-1){
var _34d="EBAComboBoxRow"+_347.GetUniqueId()+"_"+_345;
row=document.getElementById(_34d);
if(""!=tb.searchValue&&(null==e||(_34a!=46&&_34a!=8))&&(null!=e||(tb.prevKeyCode!=46&&tb.prevKeyCode!=8))&&_347.mode!="smartlist"&&_347.mode!="smartsearch"){
tb.TypeAhead(list.GetXmlDataSource().GetRowCol(_345,tb.GetDataFieldIndex()),tb.GetSearchTerm().length,tb.GetSearchTerm());
list.SetSelectedRow(_345);
}
list.SetActiveRow(row);
}
if(e!=null&&_345>-1&&list.InitialSearchOnce!=true){
list.Show();
list.ScrollIntoView(row,true);
}
tb.m_skipBlur=false;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.TypeAhead=TextBox_TypeAhead;
function TextBox_TypeAhead(txt){
var t=this.m_HTMLTagObject;
var x=xbGetCurPos(t);
if(txt.toLowerCase().indexOf(t.value.toLowerCase())!=0){
return;
}
this.SetValue(txt);
xbHighlight(t,x);
}
nitobi.combo.TextBox.prototype.OnMouseOver=TextBox_OnMouseOver;
function TextBox_OnMouseOver(_351){
try{
if(this.GetCombo().GetEnabled()){
if(this.GetHeight()!="100%"){
var c=this.GetCSSClassName();
this.m_HTMLTagObject.className=c.substring(0,c.lastIndexOf("ComboBoxTextDynamic"))+" ComboBoxTextDynamicOver";
}
if(_351){
var b=this.GetCombo().GetButton();
if(null!=b){
b.OnMouseOver(null,false);
}
}
}
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.OnMouseOut=TextBox_OnMouseOut;
function TextBox_OnMouseOut(_354){
try{
if(this.GetCombo().GetEnabled()){
if(this.GetHeight()!="100%"){
var c=this.GetCSSClassName();
this.m_HTMLTagObject.className=c.substring(0,c.lastIndexOf("ComboBoxTextDynamic"))+" ComboBoxTextDynamic";
}
if(_354){
var b=this.GetCombo().GetButton();
if(null!=b){
b.OnMouseOut(null,false);
}
}
}
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.OnClick=TextBox_OnClick;
function TextBox_OnClick(){
try{
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.ToggleHidden=TextBox_ToggleHidden;
function TextBox_ToggleHidden(){
try{
this.m_ToggleHidden=true;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.ToggleShow=TextBox_ToggleShow;
function TextBox_ToggleShow(){
try{
this.m_ToggleShow=true;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.Render=TextBox_Render;
function TextBox_Render(){
try{
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.GetHTMLRenderString=TextBox_GetHTMLRenderString;
function TextBox_GetHTMLRenderString(){
try{
var c=this.GetCombo();
var _358=c.GetId();
var _359=this.GetValue().replace(/\'/g,"&#39;").replace(/\"/g,"&quot;");
var w=this.GetWidth();
var h=this.GetHeight();
var _35c=c.mode=="smartlist";
var html="";
var _35e;
_35e=(null!=w&&""!=w?"width:"+w+";":"")+(null!=h&&""!=h?"height:"+h+";":"")+(this.hasButton?"border-right:0px solid white;":"");
if(_35c&&nitobi.browser.IE){
html+="<span style='"+_35e+"'>";
_35e="width:100%;height:"+h+";";
}
html+="<"+(_35c==true?"textarea":"input")+" id=\"EBAComboBoxText"+_358+"\" name=\"EBAComboBoxText"+_358+"\" type=\"TEXT\" class='"+this.GetCSSClassName()+"' contentEditable="+this.GetEditable()+" "+(this.GetEditable().toString().toLowerCase()=="true"?"":"readonly='true'")+" AUTOCOMPLETE=OFF value='"+_359+"'  "+"style=\""+_35e+"\" "+"onblur='var combo=window.document.getElementById(\""+_358+"\").object; if(!(combo.m_Over || combo.GetList().m_skipBlur)) window.document.getElementById(\""+_358+"\").object.GetTextBox().OnBlur(event)' "+"onkeyup='window.document.getElementById(\""+_358+"\").object.GetTextBox().OnKeyOperation(event,0)' "+"onkeypress='window.document.getElementById(\""+_358+"\").object.GetTextBox().OnKeyOperation(event,1)' "+"onkeydown='window.document.getElementById(\""+_358+"\").object.GetTextBox().OnKeyOperation(event,2)' "+"onmouseover='window.document.getElementById(\""+_358+"\").object.GetTextBox().OnMouseOver(true)' "+"onmouseout='window.document.getElementById(\""+_358+"\").object.GetTextBox().OnMouseOut(true)' "+"onpaste='window.setTimeout(\"window.document.getElementById(\\\""+_358+"\\\").object.GetTextBox().OnChanged()\",0)' "+"oninput='window.setTimeout(\"window.document.getElementById(\\\""+_358+"\\\").object.GetTextBox().OnChanged()\",0)' "+"onfocus='window.document.getElementById(\""+_358+"\").object.GetTextBox().OnFocus()' "+"tabindex='"+c.GetTabIndex()+"'>"+(_35c==true?_359:"")+"</"+(_35c==true?"textarea>":"input>")+"<input id=\"EBAComboBoxTextValue"+_358+"\" name=\""+_358+"\" type=\"HIDDEN\" value=\""+_359+"\">";
if(_35c&&nitobi.browser.IE){
html+="</span>";
}
return html;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.Initialize=TextBox_Initialize;
function TextBox_Initialize(){
try{
this.m_ToggleHidden=false;
this.m_ToggleShow=false;
this.focused=false;
this.m_skipBlur=false;
this.m_skipFocusOnce=false;
this.prevKeyCode=-1;
this.skipKeyUp=false;
this.SetHTMLTagObject(document.getElementById("EBAComboBoxText"+this.GetCombo().GetId()));
this.m_TextValueTag=document.getElementById("EBAComboBoxTextValue"+this.GetCombo().GetId());
if(!this.GetCombo().GetEnabled()){
this.Disable();
}
this.m_userTag=null;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.Disable=TextBox_Disable;
function TextBox_Disable(){
var t=this.m_HTMLTagObject;
t.disabled=true;
t.className="ComboBoxTextDisabled";
}
nitobi.combo.TextBox.prototype.Enable=TextBox_Enable;
function TextBox_Enable(){
var t=this.m_HTMLTagObject;
t.disabled=false;
t.className="ComboBoxText ComboBoxTextDynamic";
}
nitobi.combo.TextBox.prototype.OnBlur=TextBox_OnBlur;
function TextBox_OnBlur(e){
try{
var _362=this.GetCombo();
var list=_362.GetList();
if(this.m_skipBlur||_362.m_Over){
return;
}
this.focused=false;
list.Hide();
eval(_362.GetOnBlurEvent());
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.OnFocus=TextBox_OnFocus;
function TextBox_OnFocus(){
try{
if(this.m_skipBlur||this.m_skipFocusOnce){
this.m_skipFocusOnce=false;
return;
}
this.focused=true;
var _364;
_364=this.GetCombo().GetList().IsVisible();
if(!_364||this.m_ToggleShow){
this.m_ToggleShow=false;
if(this.m_ToggleHidden){
this.m_ToggleHidden=false;
}else{
eval(this.GetCombo().GetOnFocusEvent());
}
}
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.SetOnEditKeyUpEvent=TextBox_SetOnEditKeyUpEvent;
function TextBox_SetOnEditKeyUpEvent(_365){
try{
this.m_OnEditKeyUpEvent=_365;
}
catch(err){
}
}
nitobi.combo.TextBox.prototype.GetOnEditKeyUpEvent=TextBox_GetOnEditKeyUpEvent;
function TextBox_GetOnEditKeyUpEvent(){
try{
return this.m_OnEditKeyUpEvent;
}
catch(err){
}
}
function TextBox_CancelBubble(e){
if(nitobi.browser.IE){
e.cancelBubble=true;
e.returnValue=false;
}else{
if(nitobi.browser.MOZ){
e.stopPropagation();
e.preventDefault();
}
}
}
nitobi.combo.TextBox.prototype.OnKeyOperation=TextBox_OnKeyOperation;
function TextBox_OnKeyOperation(e,_368){
e=e?e:window.event;
try{
var _369=0;
var _36a=1;
var _36b=2;
var _36c=13;
var _36d=27;
var _36e=9;
var _36f=65;
var _370=90;
var _371=48;
var _372=57;
var _373=40;
var _374=38;
var _375=46;
var _376=8;
var _377=32;
var _378=96;
var _379=105;
var _37a=36;
var _37b=35;
var _37c=37;
var _37d=39;
var _37e=112;
var _37f=123;
var _380=16;
var _381=17;
var _382=18;
var _383=33;
var _384=34;
var t=this.m_HTMLTagObject;
var _386=this.GetCombo();
var list=_386.GetList();
var _388=e.keyCode;
_386.SetEventObject(e);
var dfi=this.GetDataFieldIndex();
switch(_368){
case (_369):
if(_36c!=_388&&_36d!=_388&&_36e!=_388&&(_388<_383||_388>_373)&&(_388<_37e||_388>_37f)&&(_388<_380||_388>_382)){
if(_386.mode=="smartsearch"||_386.mode=="smartlist"||_386.mode=="filter"||_386.mode=="compact"){
list.GetXmlDataSource().m_Dirty=true;
}
this.OnChanged(e);
eval(this.GetOnEditKeyUpEvent());
}
if(_388==_374||_388==_373||_388==_383||_388==_384||_388==_36c){
if(this.smartlistWA==true){
this.smartlistWA=false;
}else{
if(nitobi.browser.IE){
t.value=t.value;
}else{
xbPutCur(t,t.value.length);
}
}
}
if(_386.mode=="smartlist"&&_388==_36c&&list.GetActiveRow()!=null){
this.SetValue(list.GetSelectedRowValues()[this.GetDataFieldIndex()],true);
list.SetActiveRow(null);
}
if(_386.mode=="smartlist"){
var lio=t.value.lastIndexOf(_386.SmartListSeparator);
if(this.lio!=lio){
list.Hide();
}
this.lio=lio;
}
break;
case (_36b):
switch(_388){
case (_36c):
if(_386.mode=="smartlist"){
var lio=t.value.lastIndexOf(_386.SmartListSeparator);
if(lio!=this.lio){
list.Hide();
break;
}
}
this.m_skipBlur=true;
list.SetActiveRowAsSelected();
list.Hide();
t.focus();
eval(_386.GetOnSelectEvent());
TextBox_CancelBubble(e);
this.m_skipBlur=false;
break;
case (_36e):
list.Hide();
eval(_386.GetOnTabEvent());
if(this.m_skipBlur||_386.m_Over){
this.m_skipBlur=false;
_386.m_Over=false;
}
list.SetActiveRowAsSelected();
eval(_386.GetOnSelectEvent());
break;
case (_36d):
list.Hide();
break;
case (_374):
if(this.Paging==true){
break;
}
var _38b;
_38b=list.IsVisible();
if(_386.mode=="smartlist"&&!_38b){
this.smartlistWA=true;
break;
}
if(_386.mode=="smartlist"){
var lio=t.value.lastIndexOf(_386.SmartListSeparator);
if(lio!=this.lio){
list.Hide();
break;
}
}
this.m_skipBlur=true;
this.cursor=xbGetCurPos(t);
if(true==list.Move(EBAMoveAction_UP)){
t.focus();
this.SetValue(list.GetXmlDataSource().GetRowCol(list.GetRowIndex(list.GetActiveRow()),dfi));
}
this.m_skipBlur=false;
break;
case (_373):
if(this.Paging==true){
break;
}
var _38b;
_38b=list.IsVisible();
if(_386.mode=="smartlist"&&!_38b){
this.smartlistWA=true;
break;
}
if(_386.mode=="smartlist"){
var lio=t.value.lastIndexOf(_386.SmartListSeparator);
if(lio!=this.lio){
list.Hide();
break;
}
}
this.m_skipBlur=true;
this.cursor=xbGetCurPos(t);
var r=list.GetActiveRow();
if(null!=r&&list.GetRowIndex(r)==list.GetXmlDataSource().GetNumberRows()-1&&true==list.GetAllowPaging()&&_386.mode=="default"){
list.SetActiveRow(null);
this.Paging=true;
list.OnGetNextPage(EBAScrollToNewBottom,true);
}else{
if(true==list.Move(EBAMoveAction_DOWN)){
t.focus();
this.SetValue(list.GetXmlDataSource().GetRowCol(list.GetRowIndex(list.GetActiveRow()),dfi));
}
}
this.m_skipBlur=false;
break;
case (_383):
if(this.Paging==true){
break;
}
if(_386.mode=="smartlist"){
var lio=t.value.lastIndexOf(_386.SmartListSeparator);
if(lio!=this.lio){
list.Hide();
break;
}
}
this.m_skipBlur=true;
var b=nitobi.Browser;
var lb=list.GetSectionHTMLTagObject(EBAComboBoxListBody);
var _38b;
_38b=list.IsVisible();
if(_38b){
var r=list.GetActiveRow()||list.GetRow(0);
if(null!=r){
var idx=list.GetRowIndex(r);
while(0!=idx){
r=list.GetRow(--idx);
if(!b.IsObjectInView(r,lb)){
break;
}
}
b.ScrollIntoView(r,lb,false,true);
list.SetActiveRow(r);
this.SetValue(list.GetXmlDataSource().GetRowCol(idx,dfi));
}
}
this.m_skipBlur=false;
break;
case (_384):
if(this.Paging==true){
break;
}
if(_386.mode=="smartlist"){
var lio=t.value.lastIndexOf(_386.SmartListSeparator);
if(lio!=this.lio){
list.Hide();
break;
}
}
var _38b;
_38b=list.IsVisible();
if(!_38b){
if(_386.mode!="smartlist"){
list.Show();
}
}else{
this.m_skipBlur=true;
var b=nitobi.Browser;
var lb=list.GetSectionHTMLTagObject(EBAComboBoxListBody);
var r=list.GetActiveRow()||list.GetRow(0);
var idx=list.GetRowIndex(r);
var end=list.GetXmlDataSource().GetNumberRows()-1;
while(idx!=end){
r=list.GetRow(++idx);
if(!b.IsObjectInView(r,lb)){
break;
}
}
if(idx==end&&true==list.GetAllowPaging()&&_386.mode=="default"){
list.SetActiveRow(null);
this.Paging=true;
list.OnGetNextPage(EBAScrollToNewTop,true);
}else{
b.ScrollIntoView(r,lb,true,false);
list.SetActiveRow(r);
this.SetValue(list.GetXmlDataSource().GetRowCol(idx,dfi));
}
this.m_skipBlur=false;
}
break;
default:
}
break;
case (_36a):
if(_388==_36c){
TextBox_CancelBubble(e);
}
break;
default:
}
_386.SetEventObject(null);
}
catch(err){
}
}
nitobi.prepare=function(){
ebagdl=1177027379859;
ebagd1=1179619379859;
s="var d = new Date().getTime();";
eval(s);
};
if(typeof (nitobi)=="undefined"){
nitobi={};
}
function xbDOM(){
}
nitobi.lang.defineNs("nitobi.browser");
if(nitobi.browser.MOZ){
Document.prototype.loadXML=_Document_loadXML;
Node.prototype.__defineGetter__("xml",_Node_getXML);
Document.prototype.readyState=0;
Document.prototype.__load__=Document.prototype.load;
Document.prototype.load=_Document_load;
Document.prototype.onreadystatechange=null;
Node.prototype._uniqueID=null;
Node.prototype.__defineGetter__("uniqueID",_Node_getUniqueID);
XMLDocument.prototype.transformNode=_XMLDocument_transformNode;
XMLDocument.prototype.transformNodeToObject=_XMLDocument_transformNodeToObject;
}
function _Document_loadXML(_391){
changeReadyState(this,1);
var p=new DOMParser();
var d=p.parseFromString(_391,"text/xml");
while(this.hasChildNodes()){
this.removeChild(this.lastChild);
}
for(var i=0;i<d.childNodes.length;i++){
this.appendChild(this.importNode(d.childNodes[i],true));
}
changeReadyState(this,4);
}
function _Node_getXML(){
return new XMLSerializer().serializeToString(this);
}
function _Document_load(_395){
changeReadyState(this,1);
try{
this.__load__(_395);
}
catch(e){
changeReadyState(this,4);
}
}
function changeReadyState(oDOM,_397){
oDOM.readyState=_397;
if(oDOM.onreadystatechange!=null&&(typeof oDOM.onreadystatechange)=="function"){
oDOM.onreadystatechange();
}
}
_Node_getUniqueID.i=1;
function _Node_getUniqueID(){
if(null==this._uniqueID){
this._uniqueID="mz__id"+_Node_getUniqueID.i++;
}
return this._uniqueID;
}
function EbaConstructValidXpathQuery(_398,_399){
try{
var _39a=_398.match(/(\"|\')/g);
if(_39a!=null){
var _39b="concat(";
var _39c="";
var _39d;
for(var i=0;i<_398.length;i++){
if(_398.substr(i,1)=="\""){
_39d="&apos;";
}else{
_39d="&quot;";
}
_39b+=_39c+_39d+EbaXmlEncode(_398.substr(i,1))+_39d;
_39c=",";
}
_39b+=_39c+"&apos;&apos;";
_39b+=")";
_398=_39b;
}else{
var quot=(_399?"\"":"");
_398=quot+EbaXmlEncode(_398)+quot;
}
return _398;
}
catch(err){
}
}
function _XMLDocument_transformNode(_3a0){
var xs=new XMLSerializer();
var d=xbDOM.create();
this.transformNodeToObject(_3a0,d);
if(d.childNodes.length>0&&d.childNodes[0].tagName=="transformiix:result"){
return d.childNodes[0].textContent;
}
return nitobi.Browser.HTMLUnencode(xs.serializeToString(d));
}
function _XMLDocument_transformNodeToObject(_3a3,_3a4){
var p=new XSLTProcessor();
p.importStylesheet(_3a3);
var f=p.transformToFragment(this,_3a4);
while(_3a4.hasChildNodes()){
_3a4.removeChild(_3a4.firstChild);
}
if(_3a3.xml.match(/<xsl:output method=("text"|'text')/)){
var n=this.createElement("transformiix:result");
n.appendChild(f.childNodes[0]);
_3a4.appendChild(n);
return;
}
var d=xbDOM.create();
d.loadXML(f.xml);
f=d;
var cn=f.childNodes;
for(var i=0;i<cn.length;i++){
_3a4.appendChild(this.importNode(cn[i],true));
}
}
function EbaXmlEncode(str){
str=str.replace(/&/g,"&amp;");
str=str.replace(/'/g,"&apos;");
str=str.replace(/\"/g,"&quot;");
str=str.replace(/</g,"&lt;");
str=str.replace(/>/,"&gt;");
return str;
}
function XmlDataIslands(){
}
AX=["Msxml4.DOMDocument","Msxml3.DOMDocument","Msxml2.DOMDocument","Msxml.DOMDocument","Microsoft.XmlDom"];
xbDOM.create=xbDOM_create;
function xbDOM_create(_3ac,_3ad){
var d=null;
if(nitobi.browser.MOZ){
d=window.document.implementation.createDocument(_3ac,_3ad,null);
d.addEventListener("load",function(){
changeReadyState(d,4);
},false);
}else{
for(var i=0;!d&&i<AX.length;i++){
try{
d=new ActiveXObject(AX[i]);
}
catch(e){
}
}
if(_3ad){
if(_3ac){
d.loadXML("<a0:"+_3ad+" xmlns:a0=\""+_3ac+"\" />");
}else{
d.loadXML("<"+_3ad+"/>");
}
}
}
return d;
}
function xbXMLHTTP(){
}
xbXMLHTTP.create=xbXMLHTTP_create;
function xbXMLHTTP_create(){
var x=null;
try{
x=new ActiveXObject("Msxml2.XMLHTTP");
}
catch(e){
try{
x=new ActiveXObject("Microsoft.XMLHTTP");
}
catch(oc){
x=null;
}
}
if(!x&&(typeof XMLHttpRequest)!="undefined"){
x=new XMLHttpRequest();
}
return x;
}
function xbGetCurPos(o){
if(o.createTextRange){
o.focus();
var r=document.selection.createRange().duplicate();
r.moveEnd("textedit",1);
return o.value.length-r.text.length;
}else{
if(o.setSelectionRange){
return o.selectionStart;
}
}
return -1;
}
function xbPutCur(o,x){
if(o.createTextRange){
o.focus();
var r=document.selection.createRange().duplicate();
r.move("character",0-o.value.length);
r.move("character",x);
r.select();
}else{
if(o.setSelectionRange){
o.setSelectionRange(x,x);
}
}
}
function xbHighlight(o,x){
if(o.createTextRange){
o.focus();
var r=document.selection.createRange().duplicate();
r.move("character",0-o.value.length);
r.move("character",x);
r.moveEnd("textedit",1);
r.select();
}else{
if(o.setSelectionRange){
o.setSelectionRange(x,o.value.length);
}
}
}
function xbClipXml(oXml,_3ba,_3bb,_3bc){
var xsl="<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'><xsl:template match='"+_3ba+"'><xsl:copy><xsl:copy-of select='@*'></xsl:copy-of><xsl:apply-templates select='"+_3bb+"'></xsl:apply-templates></xsl:copy></xsl:template><xsl:template match='"+_3bb+"'><xsl:choose><xsl:when test='position()&lt;="+_3bc+"'><xsl:copy-of select='.'></xsl:copy-of></xsl:when></xsl:choose></xsl:template></xsl:stylesheet>";
var x=xbDOM.create();
x.loadXML(xsl);
var newx=xbDOM.create();
oXml.transformNodeToObject(x,newx);
return newx;
}
if(!nitobi.browser.IE){
Document.prototype.createStyleSheet=function(){
var _3c0=this.createElement("style");
this.documentElement.childNodes[0].appendChild(_3c0);
return _3c0;
};
HTMLStyleElement.prototype.__defineSetter__("cssText",function(_3c1){
this.innerHTML=_3c1;
});
HTMLElement.prototype.getBoundingClientRect=function(_3c2,_3c3){
var td=document.getBoxObjectFor(this);
return {top:td.y,left:td.x,bottom:(td.y+td.height),right:(td.x+td.width)};
};
}
if(typeof (Eba)=="undefined"){
Eba={};
}
if(typeof (Eba.Dom)=="undefined"){
Eba.Dom={};
}
Eba.Dom.getWidth=function(elem){
return elem.getBoundingClientRect().right-elem.getBoundingClientRect().left;
};
Eba.getStyle=function(oElm,_3c7){
var _3c8="";
var t=_3c7;
if(document.defaultView&&document.defaultView.getComputedStyle){
_3c8=document.defaultView.getComputedStyle(oElm,"").getPropertyValue(_3c7);
}else{
if(oElm.currentStyle){
_3c7=_3c7.replace(/\-(\w)/g,function(_3ca,p1){
return p1.toUpperCase();
});
_3c8=oElm.currentStyle[_3c7];
}
}
if(_3c8=="inherit"){
return Eba.getStyle(oElm.parentNode,t);
}else{
return _3c8;
}
};
nitobi.Browser.ConvertXmlDataIsland=function(_3cc,_3cd){
if(null!=_3cc&&""!=_3cc){
var xmls=window.document.getElementById(_3cc);
if(null!=xmls){
var id=xmls.getAttribute("id");
var src=xmls.getAttribute("src");
var d=xbDOM.create();
if(null==src){
d.loadXML(this.EncodeAngleBracketsInTagAttributes(xmls.innerHTML.replace(/>\s+</g,"><"),_3cd));
}else{
d.async=false;
var _3d2=nitobi.Browser.LoadPageFromUrl(src,_3cd.GetHttpRequestMethod());
var _3d3=_3d2.indexOf("<?xml");
if(_3d3!=-1){
d.loadXML(_3d2.substr(_3d3));
}else{
d.loadXML(_3d2);
}
var d2=xbDOM.create();
d2.loadXML(this.EncodeAngleBracketsInTagAttributes(d.xml.replace(/>\s+</g,"><"),_3cd));
d=d2;
}
eval("window.document."+id+"=d;");
var p=(xmls.parentNode?xmls.parentNode:xmls.parentElement);
p.removeChild(xmls);
}
}
};
nitobi.lang.defineNs("nitobi.combo");
nitobi.combo.XmlDataSource=function(_3d6,clip,_3d8,_3d9){
try{
this.combo=null;
this.m_Dirty=null;
this.m_LowerCaseXml=null;
if(nitobi.browser.MOZ){
this.m_LowerCaseXml=xbDOM.create();
}
if(_3d6!=null){
this.combo=_3d9;
var x=(_3d6?_3d6.getAttribute("XmlId"):"");
this.SetXmlId(x);
var _3db=document.getElementById(x);
if(nitobi.browser.MOZ||null==_3db){
nitobi.Browser.ConvertXmlDataIsland(x,_3d9);
this.SetXmlObject(eval("window.document."+x),clip,_3d8);
}else{
this.SetXmlObject(_3db);
}
this.SetLastPageSize(this.GetNumberRows());
this.m_Dirty=false;
}else{
this.m_Dirty=true;
this.SetLastPageSize(0);
this.SetNumberColumns(0);
}
}
catch(err){
}
};
nitobi.combo.XmlDataSource.prototype.GetXmlId=XmlDataSource_GetXmlId;
function XmlDataSource_GetXmlId(){
try{
return this.m_XmlId;
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.SetXmlId=XmlDataSource_SetXmlId;
function XmlDataSource_SetXmlId(_3dc){
try{
this.m_XmlId=_3dc;
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.GetXmlObject=XmlDataSource_GetXmlObject;
function XmlDataSource_GetXmlObject(){
try{
return this.m_XmlObject;
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.SetXmlObject=XmlDataSource_SetXmlObject;
function XmlDataSource_SetXmlObject(_3dd,clip,_3df){
try{
if(null==_3dd.documentElement){
return;
}
if(nitobi.browser.MOZ){
var d=xbDOM.create();
var xml=_3dd.xml.replace(/>\s+</g,"><");
d.loadXML(xml);
_3dd=d;
this.m_LowerCaseXml.loadXML(xml.toLowerCase());
}
if(clip==true){
_3dd=xbClipXml(_3dd,"root","e",_3df);
}
this.m_XmlObject=_3dd;
this.SetLastPageSize(this.GetNumberRows());
var _3e2=_3dd.documentElement.getAttribute("fields");
if(null==_3e2){
}else{
var _3e3=_3e2.split("|");
this.SetColumnNames(_3e3);
this.SetNumberColumns(_3e3.length);
}
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.GetNumberRows=XmlDataSource_GetNumberRows;
function XmlDataSource_GetNumberRows(){
try{
var _3e4=this.GetXmlObject().selectNodes("//e").length;
return parseInt(_3e4);
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.GetLastPageSize=XmlDataSource_GetLastPageSize;
function XmlDataSource_GetLastPageSize(){
try{
return this.m_LastPageSize;
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.SetLastPageSize=XmlDataSource_SetLastPageSize;
function XmlDataSource_SetLastPageSize(_3e5){
try{
this.m_LastPageSize=_3e5;
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.GetNumberColumns=XmlDataSource_GetNumberColumns;
function XmlDataSource_GetNumberColumns(){
try{
return this.m_NumberColumns;
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.SetNumberColumns=XmlDataSource_SetNumberColumns;
function XmlDataSource_SetNumberColumns(_3e6){
try{
this.m_NumberColumns=parseInt(_3e6);
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.GetColumnNames=XmlDataSource_GetColumnNames;
function XmlDataSource_GetColumnNames(){
try{
return this.m_ColumnNames;
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.SetColumnNames=XmlDataSource_SetColumnNames;
function XmlDataSource_SetColumnNames(_3e7){
try{
this.m_ColumnNames=_3e7;
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.Search=XmlDataSource_Search;
function XmlDataSource_Search(_3e8,_3e9,_3ea){
try{
_3e8=_3e8.toLowerCase();
_3e8=EbaConstructValidXpathQuery(_3e8,true);
var xsl;
var xsl;
if(nitobi.browser.IE){
xsl="<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" xmlns:msxsl=\"urn:schemas-microsoft-com:xslt\" xmlns:jstring=\"http://www.ebusiness-apps.com/comboxsl\"  extension-element-prefixes=\"msxsl\" exclude-result-prefixes=\"jstring\">";
}else{
xsl="<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" version=\"1.0\"  >";
}
xsl+="<xsl:output method=\"text\" version=\"4.0\"/>";
if(nitobi.browser.IE){
xsl+="<msxsl:script language=\"javascript\" implements-prefix=\"jstring\">"+"<![CDATA["+"function lowerCase(s) "+"{"+"\treturn s.toLowerCase();"+"}"+"]]>"+"</msxsl:script>";
}
xsl+="<xsl:template match=\"/\">"+"<xsl:apply-templates/>"+"</xsl:template>";
if(nitobi.browser.IE){
xsl+="<xsl:template match='//e["+(_3ea==true?"contains":"starts-with")+"(jstring:lowerCase(string(@"+String.fromCharCode(97+parseInt(_3e9))+")),"+_3e8+")][1]'>";
}else{
xsl+="<xsl:template match='//e["+(_3ea==true?"contains":"starts-with")+"(@"+String.fromCharCode(97+parseInt(_3e9))+","+_3e8+")][1]'>";
}
xsl+="<xsl:value-of select='position()-1' />"+"</xsl:template>"+"</xsl:stylesheet>";
var oXSL=xbDOM.create();
oXSL.loadXML(xsl);
var _3ed=oXSL.documentElement;
if((_3ed.tagName.toLowerCase()=="parsererror")||(_3ed.namespaceURI=="http://www.mozilla.org/newlayout/xml/parsererror.xml")){
parseError=new XMLSerializer().serializeToString(oXSL);
}
var _3ee;
if(nitobi.browser.IE){
_3ee=this.GetXmlObject();
}else{
_3ee=this.m_LowerCaseXml;
}
var _3ef=_3ee.transformNode(oXSL);
if(""==_3ef){
_3ef=-1;
}
return parseInt(_3ef);
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.AddPage=XmlDataSource_AddPage;
function XmlDataSource_AddPage(XML){
try{
var _3f1;
var _3f2;
if(nitobi.browser.MOZ){
var _3f3;
_3f3=xbDOM.create();
_3f3.loadXML(XML.toLowerCase());
_3f2=_3f3.selectNodes("//e");
_3f1=this.m_LowerCaseXml.documentElement;
}
var tmp=xbDOM.create();
tmp.loadXML(XML);
var _3f5=tmp.selectNodes("//e");
var root=this.GetXmlObject().documentElement;
this.SetLastPageSize(tmp.selectNodes("//e").length);
for(var i=0;i<_3f5.length;i++){
root.appendChild(_3f5[i]);
if(nitobi.browser.MOZ){
_3f1.appendChild(_3f2[i]);
}
}
this.m_Dirty=false;
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.Clear=XmlDataSource_Clear;
function XmlDataSource_Clear(){
try{
this.GetXmlObject().loadXML("<root/>");
if(nitobi.browser.MOZ){
this.m_LowerCaseXml.loadXML("<root/>");
}
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.GetRow=XmlDataSource_GetRow;
function XmlDataSource_GetRow(_3f8){
try{
_3f8=parseInt(_3f8);
var row=this.GetXmlObject().documentElement.childNodes.item(_3f8);
var _3fa=new Array;
for(var i=0;i<this.GetNumberColumns();i++){
_3fa[i]=row.getAttribute(String.fromCharCode(97+i));
}
return _3fa;
}
catch(err){
}
}
nitobi.combo.XmlDataSource.prototype.GetRowCol=XmlDataSource_GetRowCol;
function XmlDataSource_GetRowCol(Row,Col){
try{
var row=this.GetXmlObject().documentElement.childNodes.item(parseInt(Row));
var val=row.getAttribute(String.fromCharCode(97+parseInt(Col)));
return val;
}
catch(err){
return "";
}
}
nitobi.combo.XmlDataSource.prototype.GetColumnIndex=XmlDataSource_GetColumnIndex;
function XmlDataSource_GetColumnIndex(Name){
try{
if(Name==null){
return 0;
}
Name=Name.toLowerCase();
var _401=this.GetColumnNames();
if(_401!=null){
for(var i=0;i<_401.length;i++){
if(Name==_401[i].toLowerCase()){
return parseInt(i);
}
}
}
return -1;
}
catch(err){
}
}


