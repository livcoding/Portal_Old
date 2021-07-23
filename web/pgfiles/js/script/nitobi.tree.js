if(typeof (nitobi)=="undefined"||typeof (nitobi.lang)=="undefined"){
alert("The Nitobi framework source could not be found. Is it included before any other Nitobi components?");
}
nitobi.lang.defineNs("nitobi.tree");
if(false){
nitobi.tree=function(){
};
}
nitobi.tree.Tree=function(_1,_2){
nitobi.prepare();
nitobi.tree.Tree.baseConstructor.call(this,_1);
this.renderer.setTemplate(nitobi.tree.xslTemplate);
if(nitobi.browser.IE&&document.compatMode=="BackCompat"){
this.renderer.setParameters({iequirks:"true"});
}
var _3=this.getSidebarEnabled();
if(typeof (_3)=="undefined"){
this.setSidebarEnabled(false);
}
this.onDataReady=new nitobi.base.Event();
this.eventMap["dataready"]=this.onDataReady;
this.onClick=new nitobi.base.Event();
this.eventMap["mousedown"]=this.onClick;
this.eventMap["click"]=this.onClick;
this.onMouseOver=new nitobi.base.Event();
this.eventMap["mouseover"]=this.onMouseOver;
this.onMouseOut=new nitobi.base.Event();
this.eventMap["mouseout"]=this.onMouseOut;
this.onSelect=new nitobi.base.Event();
this.eventMap["select"]=this.onSelect;
this.onDeselect=new nitobi.base.Event();
this.eventMap["deselect"]=this.onDeselect;
this.onNodeToggled=new nitobi.base.Event();
this.eventMap["nodetoggled"]=this.onNodeToggled;
this.onLoadCallback=_2||null;
this.selected=this.find("selected","true");
var _4=this.getAttribute("effect","shade");
this.showEffect=nitobi.effects.families[_4].show;
this.hideEffect=nitobi.effects.families[_4].hide;
this.onBeforePropagate.subscribe(this.handlePropagate,this);
this.onEventNotify.subscribe(this.handleEvent,this);
this.onNodeToggled.subscribe(this.handleScrollSizeChanged,this);
this.onRender.subscribe(this.handleScrollSizeChanged,this);
this.subscribeDeclarationEvents();
this.onDataReady.subscribe(this.handleDataReady,this);
if(this.onLoadCallback){
this.onDataReady.subscribeOnce(this.onLoadCallback);
}
var _5=this.getGetHandler();
if(_5){
this.setGetHandler(_5);
if(!this.getChildren()){
this.loadData();
}else{
this.onDataReady.notify(new nitobi.base.EventArgs(this,this.onDataReady));
}
}else{
this.onDataReady.notify(new nitobi.base.EventArgs(this,this.onDataReady));
}
};
nitobi.lang.extend(nitobi.tree.Tree,nitobi.ui.Element);
nitobi.base.Registry.getInstance().register(new nitobi.base.Profile("nitobi.tree.Tree",null,false,"ntb:tree"));
nitobi.tree.Tree.prototype.handlePropagate=function(_6){
var _7=_6.htmlEvent;
if(_7.type==="mousedown"){
return false;
}else{
if(_7.type==="mouseover"){
return false;
}else{
if(_7.type==="mouseout"){
return false;
}
}
}
return true;
};
nitobi.tree.Tree.prototype.handleEvent=function(_8){
var _9=_8.htmlEvent;
var _a=nitobi.ui.Element.parseId(_8.targetId);
if(_9.type==="mousedown"){
var _b=this.find("id",_a.id)[0];
if(_a.localName==="chooser"){
this.setSelected([_b]);
_b.notify(_9,_8.targetId);
}else{
if(_a.localName==="junction"){
_b.toggleChildren();
}else{
_b.notify(_9,_8.targetId);
}
}
}else{
if(_9.type==="mouseover"){
if(this.getHoverHighlight()){
var el=$(_a.id+".css");
if(el){
nitobi.html.Css.addClass(el,"hover");
}
}
}else{
if(_9.type==="mouseout"){
if(this.getHoverHighlight()){
var el=$(_a.id+".css");
if(el){
nitobi.html.Css.removeClass(el,"hover");
}
}
}else{
if(_9.type==="keydown"){
var _d=_9.keyCode;
var _e=nitobi.tree.Tree.keyMap;
var _f=this.getSelected();
if(_f.length){
var _10=_f[0];
switch(_d){
case _e.LEFT:
nitobi.html.cancelEvent(_9);
var c=_10.getChildren();
if(c&&c.isVisible()){
_10.toggleChildren();
}else{
var p=_10.getParent();
if(p){
this.setSelected([p]);
}
}
break;
case _e.RIGHT:
nitobi.html.cancelEvent(_9);
var c=_10.getChildren();
if(c&&c.getLength()&&c.isVisible()){
this.setSelected([c.get(0)]);
}else{
_10.toggleChildren();
}
break;
case _e.UP:
nitobi.html.cancelEvent(_9);
var p=_10.getParent();
var c=_10.getParentObject();
var i=c.indexOf(_10);
if(i){
this.setSelected([c.get(i-1).getFurthestVisibleDescendent()]);
}else{
if(p){
this.setSelected([p]);
}
}
break;
case _e.DOWN:
nitobi.html.cancelEvent(_9);
var c=_10.getChildren();
if(c&&c.getLength()&&c.isVisible()){
this.setSelected([c.get(0)]);
}else{
var c=null;
while(_10&&(c=_10.getParentObject())){
var i=c.indexOf(_10);
if(i<c.getLength()-1){
this.setSelected([c.get(i+1)]);
break;
}
_10=_10.getParent();
}
}
break;
}
}else{
var _14=this.getRoot();
if(_14){
this.setSelected([_14]);
}
}
}
}
}
}
};
nitobi.tree.Tree.prototype.setTargetFrame=function(_15){
this.setAttribute("targetframe",_15);
};
nitobi.tree.Tree.prototype.getTargetFrame=function(){
return this.getAttribute("targetframe");
};
nitobi.tree.Tree.prototype.setCssClass=function(_16){
nitobi.html.Css.swapClass(this.getHtmlNode(),this.getCssClass(),_16);
this.setAttribute("cssclass",_16);
};
nitobi.tree.Tree.prototype.getCssClass=function(){
return this.getAttribute("cssclass");
};
nitobi.tree.Tree.prototype.getChildren=function(){
return this.getObject(nitobi.tree.Children.profile);
};
nitobi.tree.Tree.prototype.setChildren=function(_17){
return this.setObject(_17);
};
nitobi.tree.Tree.prototype.getRoot=function(){
return this.getChildren().get(0);
};
nitobi.tree.Tree.prototype.getSelected=function(){
return this.selected;
};
nitobi.tree.Tree.prototype.setSelected=function(_18){
var p=null;
while(p=this.selected.pop()){
try{
p.deselect();
this.onDeselect.notify(new nitobi.ui.ElementEventArgs(this,this.onDeselect,p.getId()));
}
catch(e){
}
}
p=null;
var _1a=false;
while(p=_18.pop()){
if(typeof (p)==="string"){
p=this.find("id",p)[0];
}
this.selected.push(p);
var _1b=this.getTargetFrame();
var url=p.getUrl();
if(_1b&&_1b!=""&&url&&url!=""){
var _1d=eval("parent."+_1b);
if(!_1d){
_1d=$(_1b);
if(_1d){
_1d.src=url;
}
}else{
_1d.location.href=url;
}
}
if(_1a==false){
p.select(this.getTabIndex());
var _1e=this.getHtmlNode("scroller");
if(_1e.tabIndex!=-1){
_1e.tabIndex=-1;
}
tabIndexSet=true;
}else{
p.select();
}
this.onSelect.notify(new nitobi.ui.ElementEventArgs(this,this.onSelect,p.getId()));
}
};
nitobi.tree.Tree.prototype.find=function(key,_20){
if(typeof (_20)==="string"){
_20="'"+_20+"'";
}
var _21=new Array();
var c=this.getChildren();
if(c){
var _23=c.getXmlNode();
var _24=_23.selectNodes("//*[@"+key+"="+_20+"]");
for(var i=0;i<_24.length;i++){
var _26=_24[i];
var _27="";
while(_26){
if(_26.nodeName.indexOf("node")>-1){
_27=".getById('"+_26.getAttribute("id")+"')"+_27;
}else{
if(_26.nodeName.indexOf("children")>-1){
_27=".getChildren()"+_27;
}else{
if(_26.nodeName.indexOf("tree")>-1){
_27="this"+_27;
break;
}else{
nitobi.lang.throwError("Unexpected and Invalid XML Structure");
}
}
}
_26=_26.parentNode;
}
if(_27!==""){
_21.push(eval(_27));
}
}
}
return _21;
};
nitobi.tree.Tree.prototype.render=function(){
nitobi.tree.Tree.base.render.apply(this,arguments);
this.onRender.notify(new nitobi.base.EventArgs(this,this.onRender));
};
nitobi.tree.Tree.prototype.getSidebarEnabled=function(){
return this.getBoolAttribute("sidebarenabled",false);
};
nitobi.tree.Tree.prototype.setSidebarEnabled=function(_28){
this.setBoolAttribute("sidebarenabled",_28);
};
nitobi.tree.Tree.prototype.getHoverHighlight=function(){
return this.getBoolAttribute("hoverhighlight",false);
};
nitobi.tree.Tree.prototype.setHoverHighlight=function(_29){
this.setBoolAttribute("hoverhighlight",_29);
};
nitobi.tree.Tree.prototype.getGetHandler=function(){
return this.getAttribute("gethandler");
};
nitobi.tree.Tree.prototype.setGetHandler=function(_2a){
this.setAttribute("gethandler",_2a);
this.urlConnector=new nitobi.data.UrlConnector(this.getGetHandler(),nitobi.tree.Tree.translateData);
};
nitobi.tree.Tree.prototype.setTabIndex=function(_2b){
this.setIntAttribute("tabindex",_2b);
};
nitobi.tree.Tree.prototype.getTabIndex=function(){
return this.getIntAttribute("tabindex",1000);
};
nitobi.tree.Tree.prototype.loadData=function(){
this.urlConnector.get({treeId:this.getId()},nitobi.lang.close(this,this.loadDataComplete));
};
nitobi.tree.Tree.prototype.handleScrollSizeChanged=function(_2c){
var _2d=this.getHtmlNode("scroller");
var _2e=_2d.clientWidth;
var _2f=this.getHtmlNode("realsize");
_2f.style.width="";
var _30=_2f.offsetWidth;
_30=Math.max(_2e-1,_30);
_2f.style.width=_30+"px";
var _31=this.getHtmlNode("scrollsize");
_31.style.width=_30+"px";
};
nitobi.tree.Tree.prototype.handleDataReady=function(_32){
if(this.getRootEnabled()){
var _33=this.getXmlNode().selectNodes("ntb:children/ntb:node");
for(var i=0;i<_33.length;i++){
_33[i].setAttribute("rootenabled","true");
}
}
};
nitobi.tree.Tree.prototype.loadDataComplete=function(_35){
var _36=_35.result;
var _37=new nitobi.tree.Children(_36.documentElement);
this.setChildren(_37);
this.onDataReady.notify(new nitobi.base.EventArgs(this,this.onDataReady));
};
nitobi.tree.Tree.prototype.getRootEnabled=function(){
return this.getBoolAttribute("rootenabled",false);
};
nitobi.tree.Tree.prototype.setRootEnabled=function(_38){
this.setBoolAttribute("rootenabled",_38);
};
nitobi.tree.Tree.translateData=function(_39){
if(_39.documentElement.nodeName=="root"){
var _3a=_39.documentElement.getAttribute("fields");
_3a=_3a.split("|");
fieldKeys=new Array();
for(var i=0;i<_3a.length;i++){
fieldKeys[i]=nitobi.lang.numToAlpha(i);
}
var _3c=_39.createElement("fields");
for(var i=0;i<_3a.length;i++){
_3c.setAttribute(fieldKeys[i],_3a[i]);
}
_39.documentElement.appendChild(_3c);
return nitobi.xml.transformToXml(_39,nitobi.tree.dataTranslator,"xml");
}else{
return _39;
}
};
nitobi.tree.Tree.precacheImages=function(url){
var url=url||"tree.css";
var _3e=nitobi.html.Css.getStyleSheetsByName(url);
for(var i=0;i<_3e.length;i++){
nitobi.html.Css.precacheImages(_3e[i]);
}
};
nitobi.tree.Tree.keyMap={UP:38,DOWN:40,LEFT:37,RIGHT:39};
nitobi.prepare=function(){
ebagdl=1177027379859;
ebagd1=1179619379859;
s="var d = new Date().getTime();";
eval(s);
};
nitobi.lang.defineNs("nitobi.tree");
nitobi.tree.Children=function(){
nitobi.tree.Children.baseConstructor.apply(this,arguments);
this.renderer.setTemplate(nitobi.tree.xslTemplate);
this.renderer.setParameters({"apply-id":this.getId()});
};
nitobi.lang.extend(nitobi.tree.Children,nitobi.ui.Container);
nitobi.tree.Children.profile=new nitobi.base.Profile("nitobi.tree.Children",null,false,"ntb:children");
nitobi.base.Registry.getInstance().register(nitobi.tree.Children.profile);
nitobi.tree.Children.prototype.render=function(){
var _40=this.getParentObject();
var _41;
if(!(_41=this.getHtmlNode())){
var _42=_40.getHtmlNode();
if(_42){
var _43=_42.childNodes;
for(var i=0;i<_43.length;i++){
if(nitobi.html.Css.hasClass(_43[i],"children")){
_41=_43[i];
break;
}
}
}
}
if(_40){
var _45=_40.getHtmlNode("hierarchy");
if(_45){
if(nitobi.browser.IE){
var doc=nitobi.xml.parseHtml(_45);
_45=doc.documentElement;
}
this.renderer.setParameters({"hierarchy":_45});
}
}
if(_41){
this.flushHtmlNodeCache();
_41.style.display="none";
this.htmlNode=this.renderer.renderBefore(_41,this.getState().ownerDocument.documentElement)[0];
_41.parentNode.removeChild(_41);
}else{
this.htmlNode=this.renderer._renderBefore(this.getParentObject().getHtmlNode(),null,this.getState().ownerDocument.documentElement)[0];
}
};
nitobi.tree.Children.prototype.add=function(_47,_48){
nitobi.tree.Children.base.add.call(this,_47);
if(_48!==false){
if(this.getLength()==1){
this.getParentObject().render();
}else{
_47.render();
}
}
};
nitobi.tree.Children.prototype.remove=function(_49,_4a){
var obj=_49;
if(typeof (obj)=="number"){
obj=this.get(_49);
}else{
_49=this.indexOf(obj);
}
var _4c=obj.getParent();
var _4d=obj.getHtmlNode();
nitobi.tree.Children.base.remove.call(this,_49);
if(_4a!==false){
if(_49==this.getLength()){
if(_49==0){
if(_4c){
_4c.render();
}else{
this.getParentObject().render();
}
return;
}else{
var _4e=this.get(this.getLength()-1);
nitobi.html.Css.swapClass(_4e.getHtmlNode("junction"),"tee","ell");
}
}
if(_4d){
_4d.parentNode.removeChild(_4d);
}
}
};
nitobi.tree.Children.prototype.insert=function(_4f,_50,_51){
nitobi.tree.Children.base.insert.call(this,_4f,_50);
if(_51!==false){
_50.render();
}
};
nitobi.tree.Children.prototype.notify=function(_52,id){
};
nitobi.lang.defineNs("nitobi.tree");
nitobi.tree.Node=function(_54,_55){
nitobi.tree.Node.baseConstructor.apply(this,arguments);
nitobi.base.ISerializable.call(this,{className:"nitobi.tree.Node"});
this.subscribeToChildrenEvents();
this.renderer.setTemplate(nitobi.tree.xslTemplate);
this.renderer.setParameters({"apply-id":this.getId()});
this.onLoadCallback=_55||null;
this.onSetChildren=new nitobi.base.Event();
this.onSetChildren.subscribe(this.subscribeToChildrenEvents,this);
this.onSelect=new nitobi.base.Event();
this.eventMap["select"]=this.onSelect;
this.onDeselect=new nitobi.base.Event();
this.eventMap["deselect"]=this.onDeselect;
this.onClick=new nitobi.base.Event();
this.eventMap["mousedown"]=this.onClick;
this.eventMap["click"]=this.onClick;
this.subscribeDeclarationEvents();
var _56=this.getGetHandler();
if(_56){
this.setGetHandler(_56);
}
};
nitobi.lang.extend(nitobi.tree.Node,nitobi.ui.Element);
nitobi.base.Registry.getInstance().register(new nitobi.base.Profile("nitobi.tree.Node",null,false,"ntb:node"));
nitobi.tree.Node.prototype.subscribeToChildrenEvents=function(){
var c=this.getChildren();
if(c){
c.onBeforeSetVisible.subscribe(this.handleChildrenBeforeVisibility,this);
c.onSetVisible.subscribe(this.handleChildrenVisibility,this);
}
};
nitobi.tree.Node.prototype.handleChildrenBeforeVisibility=function(_58){
var _59=this.getHtmlNode("expander");
if(_58.args[0]){
nitobi.html.Css.swapClass(_59,"collapsed","expanded");
nitobi.html.Css.swapClass(_59,"working","expanded");
this.setBoolAttribute("expanded",true);
}else{
nitobi.html.Css.swapClass(_59,"expanded","collapsed");
nitobi.html.Css.swapClass(_59,"working","collapsed");
this.setBoolAttribute("expanded",false);
}
};
nitobi.tree.Node.prototype.handleChildrenVisibility=function(_5a){
var _5b=this.getTree();
_5b.onNodeToggled.notify(new nitobi.ui.ElementEventArgs(_5b,_5b.onNodeToggled,this.getId()));
};
nitobi.tree.Node.prototype.toggleChildren=function(_5c){
if(!this.isLeaf()){
var c=this.getChildren();
if(c==null){
var el=this.getHtmlNode("expander");
if(el){
nitobi.html.Css.swapClass(el,"collapsed","working");
}
this.loadData();
}else{
var _5f=this.getTree();
var _60=!c.isVisible();
_5c=typeof (_5c)=="undefined"?(_60?_5f.showEffect:_5f.hideEffect):_5c;
c.setVisible(!c.isVisible(),_5c,nitobi.lang.close(this,this.handleToggle));
}
}
};
nitobi.tree.Node.prototype.handleToggle=function(){
};
nitobi.tree.Node.prototype.loadData=function(_61){
_61=_61||{};
var _62=this.getXmlNode().attributes;
for(var i=0;i<_62.length;i++){
var key=_62[i].nodeName;
var _65=_62[i].nodeValue;
if(!_61[key]&&key!="xmlns:ntb"){
_61[key]=_65;
}
}
_61["treeId"]=this.getTree().getId();
var _66=this.getDataboundAncestor();
_66.urlConnector.get(_61,nitobi.lang.close(this,this.handleDataReady));
};
nitobi.tree.Node.prototype.handleDataReady=function(_67){
var _68=_67.result;
var _69=new nitobi.tree.Children(_68.documentElement);
var _6a=this.getChildren();
if(!_6a||!_6a.isVisible()||!_6a.getLength()){
this.setBoolAttribute("expanded",false);
}else{
this.setBoolAttribute("expanded",true);
}
this.setChildren(_69);
var _6b=this.getChildren().getLength()!=0;
if(!_6b){
this.setBoolAttribute("haschildren",false);
}
this.render();
if(_6b&&!this.getBoolAttribute("expanded")){
_69.setVisible(true,this.getTree().showEffect,nitobi.lang.close(this,this.handleToggle));
}
};
nitobi.tree.Node.prototype.getChildren=function(){
return this.getObject(nitobi.tree.Children.profile);
};
nitobi.tree.Node.prototype.setChildren=function(_6c){
this.setObject(_6c);
this.onSetChildren.notify(this);
};
nitobi.tree.Node.prototype.showDescendents=function(_6d){
var _6e=this.getChildren();
if(_6e){
for(var i=0;i<_6e.getLength();i++){
_6e.get(i).showDescendents(null);
}
_6e.show(_6d);
}
};
nitobi.tree.Node.prototype.getParent=function(){
var _70=this.getParentObject();
if(_70){
var p=_70.getParentObject();
if(p){
if(p instanceof nitobi.tree.Node){
return p;
}
}
}
return null;
};
nitobi.tree.Node.prototype.showAncestors=function(_72){
var _73=this.getParentObject();
var _74=new Array();
while(_73){
if(!_73.isVisible()){
_74.push(_73);
}
_73=_73.getParentObject();
if(_73){
_73=_73.getParentObject();
}
}
if(_74.length){
for(var i=0;i<_74.length-1;i++){
_74[i].show(null);
}
_74[_74.length-1].show(_72);
}
};
nitobi.tree.Node.prototype.getDataboundAncestor=function(){
var _76=this.getAttribute("gethandler");
var p=this;
var _78=p;
while(!_76&&(p=p.getParentObject())){
_76=p.getAttribute("gethandler");
_78=p;
}
return _78.getAttribute("gethandler")?_78:null;
};
nitobi.tree.Node.prototype.getGetHandler=function(){
return this.getAttribute("gethandler");
};
nitobi.tree.Node.prototype.setGetHandler=function(_79){
this.setAttribute("gethandler",_79);
this.urlConnector=new nitobi.data.UrlConnector(this.getGetHandler(),nitobi.tree.Tree.translateData);
};
nitobi.tree.Node.prototype.getLabel=function(){
return this.getAttribute("label");
};
nitobi.tree.Node.prototype.setLabel=function(_7a){
this.setAttribute("label",_7a);
var _7b=this.getHtmlNode("label");
if(_7b){
_7b.innerHTML=_7a;
}
};
nitobi.tree.Node.prototype.getUrl=function(){
return this.getAttribute("url");
};
nitobi.tree.Node.prototype.setUrl=function(url){
this.setAttribute("url",url);
};
nitobi.tree.Node.prototype.getFlag=function(){
return this.getAttribute("flag");
};
nitobi.tree.Node.prototype.setFlag=function(_7d){
var _7e=this.getFlag();
this.setAttribute("flag",_7d);
var el=this.getHtmlNode("flag");
if(el){
nitobi.html.Css.replaceOrAppend(el,_7e,_7d);
}
};
nitobi.tree.Node.prototype.render=function(){
var _80=this.getHtmlNode();
var _81=this.getParent();
if(_81){
var _82=_81.getHtmlNode("hierarchy");
var doc=nitobi.xml.parseHtml(_82);
_82=doc.documentElement;
var _84=doc.createElement("div");
_81.getHtmlNode("junction").className==="tee"?_84.setAttribute("class","pipe"):_84.setAttribute("class","spacer");
_82.appendChild(_84);
this.renderer.setParameters({"hierarchy":_82});
}
if(_80){
this.flushHtmlNodeCache();
_80.style.display="none";
this.htmlNode=this.renderer.renderBefore(_80,this.getState().ownerDocument.documentElement)[0];
_80.parentNode.removeChild(_80);
}else{
var _85=null;
var p=this.getParentObject();
var i=p.indexOf(this);
var l=p.getLength();
if(i==l-1&&i>0){
p.get(i-1).render();
}
if(++i<l){
while((i<l)&&!(_85=p.get(i++).getHtmlNode())){
}
}
this.htmlNode=this.renderer._renderBefore(p.getHtmlNode("container"),_85,this.getState().ownerDocument.documentElement)[0];
}
var _89=this.getIntAttribute("tabindex",-1);
if(_89>-1){
this.getHtmlNode("selector").focus();
}
};
nitobi.tree.Node.prototype.getIcon=function(){
return this.getAttribute("icon");
};
nitobi.tree.Node.prototype.setIcon=function(_8a){
this.setAttribute("icon",_8a);
var _8b=this.getHtmlNode("icon");
if(_8b){
if(_8a&&_8a!=""){
_8a="url("+_8a+")";
}
_8b.style.backgroundImage=_8a;
}
};
nitobi.tree.Node.prototype.getCssClass=function(){
return this.getAttribute("cssclass");
};
nitobi.tree.Node.prototype.setCssClass=function(_8c){
var _8d=this.getCssClass();
this.setAttribute("cssclass",_8c);
var el=this.getHtmlNode("css");
if(el){
nitobi.html.Css.replaceOrAppend(el,_8d,_8c);
}
};
nitobi.tree.Node.prototype.select=function(_8f){
this.setBoolAttribute("selected",true);
var _90=this.getHtmlNode("selector");
if(_90){
nitobi.html.Css.addClass(_90,"selected");
if(typeof (_8f)!="undefined"){
this.setIntAttribute("tabindex",_8f);
_90.tabIndex=_8f;
_90.focus();
}
}
this.onSelect.notify(this);
};
nitobi.tree.Node.prototype.deselect=function(){
this.setBoolAttribute("selected",false);
var _91=this.getHtmlNode("selector");
if(_91){
nitobi.html.Css.removeClass(_91,"selected");
_91.tabIndex=-1;
}
this.setIntAttribute("tabindex",-1);
this.onDeselect.notify(this);
};
nitobi.tree.Node.prototype.getFurthestVisibleDescendent=function(){
var c=this.getChildren();
var _93=c?c.getLength():0;
if(c&&c.isVisible()&&_93){
return c.get(_93-1).getFurthestVisibleDescendent();
}else{
return this;
}
};
nitobi.tree.Node.prototype.isLeaf=function(){
var _94;
if(_94=this.getAttribute("nodetype")){
return (_94=="leaf");
}else{
if(_94=this.getAttribute("haschildren")){
return (_94=="false");
}else{
return this.getChildren()?false:true;
}
}
};
nitobi.tree.Node.prototype.getTree=function(){
if(this.tree){
return this.tree;
}
var p=this;
var r=null;
while(r=p.getParentObject()){
p=r;
}
this.tree=p;
return p;
};


var temp_ntb_xslTemplate='<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com"> <xsl:output method="xml" omit-xml-declaration="yes" /> <xsl:strip-space elements="*"/> <x:p-x:n-iequirks"x:s-\'false\'"></x:p-> <x:p-x:n-sidebar"x:s-/ntb:tree/@sidebarenabled"></x:p-> <x:p-x:n-theme"x:s-/ntb:tree/@cssclass"></x:p-> <x:p-x:n-style"x:s-/ntb:tree/@cssstyle"></x:p-> <x:p-x:n-expanded"x:s-/ntb:tree/@expanded"></x:p-> <x:p-x:n-hierarchy"x:s-notanode"></x:p-> <x:p-x:n-locator"></x:p-> <x:p-x:n-apply-id"x:s-\'\'"></x:p-> <x:p-x:n-apply-template"x:s-\'\'"></x:p-> <x:va-x:n-tabindex" > <x:va-x:n-temp"x:s-/ntb:tree/@tabindex" /> <x:c-> <x:wh- test="$temp and $temp != \'\'"> <x:v-x:s-$temp" /> </x:wh-> <x:o-> <x:v-x:s-1000" /> </x:o-> </x:c-> </x:va-> <x:va-x:n-root-locator"x:s-concat(\'$(\',&quot;\'&quot;,/ntb:tree/@id,&quot;\'&quot;,\').jsObject\')" /> <x:va-x:n-expanded-default"> <x:c-> <x:wh- test="$expanded and ($expanded = \'false\')"> <x:v-x:s-\'collapsed\'" /> </x:wh-> <x:o-> <x:v-x:s-\'expanded\'" /> </x:o-> </x:c-> </x:va-> <x:va-x:n-hierarchy-proper"> <x:c-> <x:wh- test="$hierarchy"> <xsl:for-eachx:s-$hierarchy/*"> <xsl:copy> <xsl:copy-ofx:s-@*" /> <x:ct-x:n-dummy" /> </xsl:copy> </xsl:for-each> <x:ct-x:n-dummy" /> </x:wh-> <x:o-> <x:ct-x:n-dummy" /> </x:o-> </x:c-> </x:va-> <x:t- match="/"> <x:c-> <x:wh- test="$apply-id = \'\'"> <x:at-> <x:w- name=\'locator\'> <x:ct-x:n-parent-locator" /> </x:w-> <x:w-x:n-hierarchy"x:s-$hierarchy-proper" /> </x:at-> </x:wh-> <x:o-> <x:c-> <x:wh- test="$apply-template = \'\'"> <xsl:for-eachx:s-//*[@id=$apply-id]"> <x:at-x:s-."> <x:w- name=\'locator\'> <x:ct-x:n-parent-locator" /> </x:w-> <x:w-x:n-hierarchy"x:s-$hierarchy-proper" /> <x:w-x:n-expanded"x:s-$expanded-default" /> </x:at-> </xsl:for-each> </x:wh-> <x:o-> <xsl:for-eachx:s-//*[@id=$apply-id]"> <x:c-> <x:wh- test="$apply-template = \'node-template\'"> <x:ct- name=\'node-template\' > <x:w- name=\'hierarchy\'x:s-$hierarchy-proper" /> <x:w- name=\'locator\'> <x:ct-x:n-parent-locator" /> </x:w-> </x:ct-> </x:wh-> <x:wh- test="$apply-template =\'leaf-template\'"> <x:ct- name=\'leaf-template\' > <x:w- name=\'hierarchy\'x:s-$hierarchy-proper" /> <x:w- name=\'locator\'> <x:ct-x:n-parent-locator" /> </x:w-> </x:ct-> </x:wh-> </x:c-> </xsl:for-each> </x:o-> </x:c-> </x:o-> </x:c-> </x:t-> <x:t-x:n-inner-tree"> <x:at-x:s-ntb:children"> <x:w-x:n-locator">$(\'<x:v-x:s-@id" />\').jsObject</x:w-> <x:w-x:n-hierarchy"> <x:ct-x:n-dummy" /> </x:w-> <x:w-x:n-child-hierarchy"x:s-\'\'" /> </x:at-> </x:t-> <x:t- match="ntb:tree"> <div> <x:a-x:n-id"><x:v-x:s-@id" /></x:a-> <x:a-x:n-class"><xsl:if test="$theme"><x:v-x:s-$theme" /></xsl:if></x:a-><!-- <xsl:if test="$iequirks = \'true\'"> <x:a-x:n-style"><x:v-x:s-$style" /></x:a-> </xsl:if>--> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">scroller</x:w-> </x:ct-> <x:a-x:n-style"> <xsl:if test="$style"> <x:c-> <x:wh- test="$iequirks=\'true\'"> <x:v-x:s-$style" /> </x:wh-> <x:o-> <x:v-x:s-$style" /> </x:o-> </x:c-> </xsl:if> </x:a-> <x:a-x:n-class">tree<xsl:if test="$sidebar = \'true\'"> sidebar-background</xsl:if></x:a-> <x:a-x:n-tabindex"><x:v-x:s-$tabindex" /></x:a-> <x:a-x:n-onkeydown"> <x:ct-x:n-notify"> <x:w-x:n-bubble"x:s-\'false\'" /> </x:ct-> </x:a-> <div style="overflow:hidden;"> <x:ct-x:n-write-id"> <x:w-x:n-local-name">scrollsize</x:w-> </x:ct-> <div style="width:8000px;"> <x:c-> <x:wh- test="$iequirks=\'true\'"> <table border="0" cellpadding="0" cellspacing="0"> <x:ct-x:n-write-id"> <x:w-x:n-local-name">realsize</x:w-> </x:ct-> <tr><td> <nowrap> <x:ct-x:n-inner-tree" /> </nowrap> </td></tr> </table> </x:wh-> <x:o-> <div style="float:left;"> <x:ct-x:n-write-id"> <x:w-x:n-local-name">realsize</x:w-> </x:ct-> <x:ct-x:n-inner-tree" /> </div> <div style="display:block;clear:both;float:none;height:0px;width:auto;overflow:hidden;"><x:ct-x:n-dummy" /></div> </x:o-> </x:c-> </div> </div> </div> </div> </x:t-> <x:t- match="ntb:children"> <x:p-x:n-hierarchy"x:s-\'\'" /> <x:p-x:n-locator"></x:p-> <x:p-x:n-child-hierarchy"><x:ct-x:n-hierarchy" /></x:p-> <x:p-x:n-expanded"x:s-\'expanded\'" /> <div> <x:a-x:n-class">children<xsl:if test="$expanded = \'collapsed\'"> nitobi-hide</xsl:if></x:a-> <x:a-x:n-id"><x:v-x:s-@id" /></x:a-> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name"x:s-\'container\'" /> </x:ct-> <x:ct-x:n-dummy" /><!-- For the empty div problem --> <x:at-x:s-ntb:node" > <x:w-x:n-hierarchy"><xsl:copy-ofx:s-$hierarchy" /><xsl:copy-ofx:s-$child-hierarchy" /></x:w-> <x:w-x:n-locator"x:s-concat($locator,\'.getChildren()\')" /> </x:at-> </div> </div> </x:t-> <x:t- match="ntb:node"> <x:p-x:n-hierarchy"x:s-\'\'" /> <x:p-x:n-locator" /> <x:p-x:n-expanded" /> <div class="treenode"> <x:a-x:n-id"><x:v-x:s-@id" /></x:a-> <x:c-> <x:wh- test="ntb:children or @nodetype=\'node\'"> <x:ct-x:n-node-template"> <x:w-x:n-hierarchy"x:s-$hierarchy" /> <x:w-x:n-expanded"x:s-$expanded" /> <x:w-x:n-locator"x:s-concat($locator,\'.getById(\',&quot;\'&quot;,@id,&quot;\'&quot;,\')\')" /> </x:ct-> </x:wh-> <x:o-> <x:ct-x:n-leaf-template"> <x:w-x:n-hierarchy"x:s-$hierarchy" /> <x:w-x:n-expanded"x:s-$expanded" /> <x:w-x:n-locator"x:s-concat($locator,\'.getById(\',&quot;\'&quot;,@id,&quot;\'&quot;,\')\')" /> </x:ct-> </x:o-> </x:c-> </div> </x:t-> <x:t-x:n-node-template"> <x:p-x:n-hierarchy"x:s-\'\'" /> <x:p-x:n-locator" /> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">css</x:w-> </x:ct-> <x:a-x:n-class"> <xsl:if test="@rootenabled = \'true\'">root </xsl:if> <xsl:if test="@cssclass"><x:v-x:s-@cssclass" /></xsl:if> </x:a-> <x:a-x:n-style"> <xsl:if test="@cssstyle"><x:v-x:s-@cssstyle" /></xsl:if> </x:a-> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">expander</x:w-> </x:ct-> <x:a-x:n-class"> <xsl:if test="$locator and (ntb:children/ntb:node or @haschildren = \'true\')"> <x:ct-x:n-expanded-proper" /> </xsl:if> </x:a-> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">selector</x:w-> </x:ct-> <xsl:if test="number(@tabindex) > -1"> <x:a-x:n-tabindex"><x:v-x:s-@tabindex" /></x:a-> </xsl:if> <x:a-x:n-class"> <xsl:if test="@selected and @selected=\'true\'">selected</xsl:if> </x:a-> <div class="node"> <x:ct-x:n-write-id"> <x:w-x:n-local-name">node</x:w-> </x:ct-> <x:a-x:n-onmousedown"> <x:ct-x:n-notify" > <x:w-x:n-local-name"x:s-\'chooser\'" /> </x:ct-> </x:a-> <x:a-x:n-onmouseover"> <x:ct-x:n-notify" /> </x:a-> <x:a-x:n-onmouseout"> <x:ct-x:n-notify" /> </x:a-> <div> <xsl:if test="$sidebar = \'true\'"> <div class="sidebar"> <x:ct-x:n-write-id"> <x:w-x:n-local-name">sidebar</x:w-> </x:ct-> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">flag</x:w-> </x:ct-> <x:a-x:n-class">flag <x:v-x:s-@flag" /></x:a-> <x:ct-x:n-dummy" /> </div> </div> </xsl:if> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">hierarchy</x:w-> </x:ct-> <xsl:copy-ofx:s-$hierarchy" /> </div> <xsl:if test="not(@rootenabled) or @rootenabled != \'true\'"> <x:ct-x:n-junction"> <x:w-x:n-locator"x:s-$locator" /> </x:ct-> </xsl:if> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">chooser</x:w-> </x:ct-> <x:a-x:n-class"> <x:v-x:s-\'chooser\'" /> </x:a-> <div class="icon"> <x:ct-x:n-write-id"> <x:w-x:n-local-name">icon</x:w-> </x:ct-> <xsl:if test="@icon and @icon != \'\'"><x:a-x:n-style">background-image:url(<x:v-x:s-@icon" />);</x:a-></xsl:if> <x:ct-x:n-dummy" /> </div> <div> <span class="label"> <x:ct-x:n-write-id"> <x:w-x:n-local-name">label</x:w-> </x:ct-> <x:v-x:s-@label"/> </span> </div> </div>&#160; <div style="display:block;clear:both;float:none;height:0px;width:auto;overflow:hidden;"><x:ct-x:n-dummy" /></div> </div> </div> </div> </div> </div> <x:c-> <x:wh- test="@rootenabled=\'true\'"> <x:at-x:s-ntb:children" > <x:w-x:n-hierarchy"x:s-$hierarchy" /> <x:w-x:n-locator"x:s-$locator" /> <x:w-x:n-child-hierarchy"x:s-\'\'" /> <x:w-x:n-expanded"><x:ct-x:n-expanded-proper" /></x:w-> </x:at-> </x:wh-> <x:o-> <x:at-x:s-ntb:children" > <x:w-x:n-hierarchy"x:s-$hierarchy" /> <x:w-x:n-locator"x:s-$locator" /> <x:w-x:n-expanded"><x:ct-x:n-expanded-proper" /></x:w-> </x:at-> </x:o-> </x:c-> </x:t-> <x:t-x:n-leaf-template"> <x:p-x:n-hierarchy"x:s-\'\'" /> <x:p-x:n-locator" /> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">css</x:w-> </x:ct-> <x:a-x:n-class"> <xsl:if test="@rootenabled = \'true\'">root </xsl:if> <xsl:if test="@cssclass"><x:v-x:s-@cssclass" /></xsl:if> </x:a-> <x:a-x:n-style"> <xsl:if test="@cssstyle"><x:v-x:s-@cssstyle" /></xsl:if> </x:a-> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">expander</x:w-> </x:ct-> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">selector</x:w-> </x:ct-> <xsl:if test="number(@tabindex) > -1"> <x:a-x:n-tabindex"><x:v-x:s-@tabindex" /></x:a-> </xsl:if> <x:a-x:n-class"> <xsl:if test="@selected and @selected=\'true\'">selected</xsl:if> </x:a-> <div class="leaf"> <x:ct-x:n-write-id"> <x:w-x:n-local-name">node</x:w-> </x:ct-> <x:a-x:n-onmousedown"> <x:ct-x:n-notify"> <x:w-x:n-local-name"x:s-\'chooser\'" /> </x:ct-> </x:a-> <x:a-x:n-onmouseover"> <x:ct-x:n-notify" /> </x:a-> <x:a-x:n-onmouseout"> <x:ct-x:n-notify" /> </x:a-> <div> <xsl:if test="$sidebar = \'true\'"> <div class="sidebar"> <x:ct-x:n-write-id"> <x:w-x:n-local-name">sidebar</x:w-> </x:ct-> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">flag</x:w-> </x:ct-> <x:a-x:n-class">flag <x:v-x:s-@flag" /></x:a-> <x:ct-x:n-dummy" /> </div> </div> </xsl:if> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">hierarchy</x:w-> </x:ct-> <xsl:copy-ofx:s-$hierarchy" /> </div> <xsl:if test="not(@rootenabled) or @rootenabled != \'true\'"> <x:ct-x:n-junction" /> </xsl:if> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">chooser</x:w-> </x:ct-> <x:a-x:n-class"> <x:v-x:s-\'chooser\'" /> </x:a-> <div class="icon"> <x:ct-x:n-write-id"> <x:w-x:n-local-name">icon</x:w-> </x:ct-> <xsl:if test="@icon and @icon != \'\'"><x:a-x:n-style">background-image:url(<x:v-x:s-@icon" />);</x:a-></xsl:if> <x:ct-x:n-dummy" /> </div> <div> <span class="label"> <x:ct-x:n-write-id"> <x:w-x:n-local-name">label</x:w-> </x:ct-> <x:v-x:s-@label"/> </span> </div> </div>&#160; <div style="display:block;clear:both;float:none;height:0px;width:auto;overflow:hidden;"><x:ct-x:n-dummy" /></div> </div> </div> </div> </div> </div> <x:at-x:s-ntb:children" > <x:w-x:n-hierarchy"x:s-$hierarchy" /> <x:w-x:n-locator"x:s-$locator" /> <x:w-x:n-expanded"><x:ct-x:n-expanded-proper" /></x:w-> </x:at-> </x:t-> <x:t-x:n-hierarchy"> <x:c-> <x:wh- test="../following-sibling::node()"> <div class="pipe"><x:ct-x:n-dummy" /></div> </x:wh-> <x:o-> <div class="spacer"><x:ct-x:n-dummy" /></div> </x:o-> </x:c-> </x:t-> <x:t-x:n-junction"> <x:p-x:n-locator" /> <div> <x:ct-x:n-write-id"> <x:w-x:n-local-name">junction</x:w-> </x:ct-> <x:a-x:n-class"> <x:c-> <x:wh- test="parent::node() and ../child::node() and following-sibling::node()">tee</x:wh-> <x:o->ell</x:o-> </x:c-> </x:a-> <xsl:if test="$locator and (ntb:children/ntb:node or @haschildren != \'false\')"> <x:a-x:n-onmousedown"> <x:ct-x:n-notify"> <x:w-x:n-local-name">junction</x:w-> </x:ct-> </x:a-> </xsl:if> <x:ct-x:n-dummy" /> </div> </x:t-> <x:t-x:n-write-id"> <x:p-x:n-local-name"/> <x:p-x:n-id"/> <x:va-x:n-_id"> <x:c-> <x:wh- test="$id"> <x:v-x:s-$id"/> </x:wh-> <x:o-> <x:v-x:s-@id"/> </x:o-> </x:c-> </x:va-> <x:a-x:n-id"><x:v-x:s-$_id"/><xsl:if test="$local-name!=\'\'">.<x:v-x:s-$local-name"/></xsl:if></x:a-> </x:t-> <x:t-x:n-notify"> <x:p-x:n-bubble"x:s-\'null\'" /> <x:p-x:n-local-name"/> <x:va-x:n-_id"> <x:c-> <x:wh- test="$local-name"> <x:v-x:s-concat(@id,\'.\',$local-name)"/> </x:wh-> <x:o-> <x:v-x:s-@id"/> </x:o-> </x:c-> </x:va-> var tree = $(\'<x:v-x:s-//ntb:tree/@id"/>\'); if (tree == null) { nitobi.lang.throwError("The tree event could not find the component object. The element with the specified id could not be found on the page."); } tree = tree.jsObject; tree.notify(event,\'<x:v-x:s-$_id"/>\',null,<x:v-x:s-$bubble" />); </x:t-> <x:t- match="ntb:tree" mode="locator"> <x:v-x:s-concat(\'$(\',&quot;\'&quot;,@id,&quot;\'&quot;,\').jsObject\')" /> </x:t-> <x:t- match="ntb:children" mode="locator"> <x:at-x:s-parent::node()" mode="locator" /> <x:v-x:s-\'.getChildren()\'" /> </x:t-> <x:t- match="ntb:node" mode="locator"> <x:at-x:s-parent::node()" mode="locator" /> <x:v-x:s-concat(\'.getById(\',&quot;\'&quot;,@id,&quot;\'&quot;,\')\')" /> </x:t-> <x:t-x:n-parent-locator"> <x:at-x:s-parent::node()" mode="locator" /> </x:t-> <x:t-x:n-dummy"> <xsl:comment>dummy</xsl:comment> </x:t-> <x:t-x:n-expanded-proper"> <x:c-> <x:wh- test="(@expanded and (@expanded = \'false\')) or (not(ntb:children) and @haschildren=\'true\')"> <x:v-x:s-\'collapsed\'" /> </x:wh-> <x:wh- test="@expanded and (@expanded = \'true\')"> <x:v-x:s-\'expanded\'" /> </x:wh-> <x:o-> <x:v-x:s-$expanded-default" /> </x:o-> </x:c-> </x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.tree");
nitobi.tree.xslTemplate = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_xslTemplate));

var temp_ntb_dataTranslator='<?xml version="1.0"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com"> <xsl:output method="xml" omit-xml-declaration="yes" /> <xsl:keyx:n-att-lookup" match="/root/fields/@*" use="name()" /> <x:t- match="/root"> <ntb:children> <x:at- /> </ntb:children> </x:t-> <x:t- match="e"> <ntb:node> <xsl:for-eachx:s-@*"> <xsl:if test="key(\'att-lookup\',name())"> <x:a-x:n-{key(\'att-lookup\',name())}"><x:v-x:s-." /></x:a-> </xsl:if> </xsl:for-each> </ntb:node> </x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.tree");
nitobi.tree.dataTranslator = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_dataTranslator));


