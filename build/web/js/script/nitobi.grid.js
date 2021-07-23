if(typeof (nitobi)=="undefined"||typeof (nitobi.lang)=="undefined"){
alert("The Nitobi framework source could not be found. Is it included before any other Nitobi components?");
}
nitobi.lang.defineNs("nitobi.ui");
nitobi.ui.Scrollbar=function(){
this.uid="scroll"+nitobi.base.getUid();
};
nitobi.ui.Scrollbar.prototype.render=function(){
};
nitobi.ui.Scrollbar.prototype.attachToParent=function(_1,_2,_3){
this.UiContainer=_1;
this.element=_2||nitobi.html.getFirstChild(this.UiContainer);
if(this.element==null){
this.render();
}
this.surface=_3||nitobi.html.getFirstChild(this.element);
this.element.onclick="";
this.element.onmouseover="";
this.element.onmouseout="";
this.element.onscroll="";
nitobi.html.attachEvent(this.element,"scroll",this.scrollByUser,this);
};
nitobi.ui.Scrollbar.prototype.align=function(){
var vs=document.getElementById("vscroll"+this.uid);
var dx=-1;
if(nitobi.browser.MOZ){
dx=-3;
}
nitobi.drawing.align(vs,this.UiContainer.childNodes[0],269484288,-42,0,24,dx,false);
};
nitobi.ui.Scrollbar.prototype.scrollByUser=function(){
this.fire("ScrollByUser",this.getScrollPercent());
};
nitobi.ui.Scrollbar.prototype.setScroll=function(_6){
};
nitobi.ui.Scrollbar.prototype.getScrollPercent=function(){
};
nitobi.ui.Scrollbar.prototype.setRange=function(_7){
};
nitobi.ui.Scrollbar.prototype.fire=function(_8,_9){
return nitobi.event.notify(_8+this.uid,_9);
};
nitobi.ui.Scrollbar.prototype.subscribe=function(_a,_b,_c){
if(typeof (_c)=="undefined"){
_c=this;
}
return nitobi.event.subscribe(_a+this.uid,nitobi.lang.close(_c,_b));
};
nitobi.ui.VerticalScrollbar=function(){
this.uid="vscroll"+nitobi.base.getUid();
};
nitobi.lang.extend(nitobi.ui.VerticalScrollbar,nitobi.ui.Scrollbar);
nitobi.ui.VerticalScrollbar.prototype.setScrollPercent=function(_d){
this.element.scrollTop=(this.surface.clientHeight-this.element.clientHeight)*_d;
return false;
};
nitobi.ui.VerticalScrollbar.prototype.getScrollPercent=function(){
return (this.element.scrollTop/(this.surface.clientHeight-this.element.clientHeight));
};
nitobi.ui.VerticalScrollbar.prototype.setRange=function(_e){
this.surface.style.height=Math.floor(this.element.clientHeight/_e)+"px";
};
nitobi.lang.defineNs("nitobi.ui");
nitobi.ui.HorizontalScrollbar=function(){
this.uid="hscroll"+nitobi.base.getUid();
};
nitobi.lang.extend(nitobi.ui.HorizontalScrollbar,nitobi.ui.Scrollbar);
nitobi.ui.HorizontalScrollbar.prototype.getScrollPercent=function(){
return (this.element.scrollLeft/(this.surface.clientWidth-this.element.clientWidth));
};
nitobi.ui.HorizontalScrollbar.prototype.setScrollPercent=function(_f){
this.element.scrollLeft=(this.surface.clientWidth-this.element.clientWidth)*_f;
return false;
};
nitobi.ui.HorizontalScrollbar.prototype.setRange=function(_10){
this.surface.style.width=Math.floor(this.element.clientWidth/_10)+"px";
};
nitobi.lang.defineNs("nitobi.ui");
nitobi.ui.IDataBoundList=function(){
};
nitobi.ui.IDataBoundList.prototype.getGetHandler=function(){
return this.getHandler;
};
nitobi.ui.IDataBoundList.prototype.setGetHandler=function(_11){
this.column.ModelNode.setAttribute("GetHandler",_11);
this.getHandler=_11;
};
nitobi.ui.IDataBoundList.prototype.getDataSourceId=function(){
return this.datasourceId;
};
nitobi.ui.IDataBoundList.prototype.setDataSourceId=function(_12){
this.column.ModelNode.setAttribute("DatasourceId",_12);
this.datasourceId=_12;
};
nitobi.ui.IDataBoundList.prototype.getDisplayFields=function(){
return this.displayFields;
};
nitobi.ui.IDataBoundList.prototype.setDisplayFields=function(_13){
this.column.ModelNode.setAttribute("DisplayFields",_13);
this.displayFields=_13;
};
nitobi.ui.IDataBoundList.prototype.getValueField=function(){
return this.valueField;
};
nitobi.ui.IDataBoundList.prototype.setValueField=function(_14){
this.column.ModelNode.setAttribute("ValueField",_14);
this.valueField=_14;
};
if(typeof (nitobi.collections)=="undefined"){
nitobi.collections={};
}
nitobi.collections.CacheMap=function(){
this.tail=null;
this.debug=new Array();
};
nitobi.collections.CacheMap.prototype.insert=function(low,_16){
low=Number(low);
_16=Number(_16);
this.debug.push("insert("+low+","+_16+")");
var _17=new nitobi.collections.CacheNode(low,_16);
if(this.head==null){
this.debug.push("empty cache, adding first node");
this.head=_17;
this.tail=_17;
}else{
var n=this.head;
while(n!=null&&low>n.high+1){
n=n.next;
}
if(n==null){
this.debug.push("appending node to end");
this.tail.next=_17;
_17.prev=this.tail;
this.tail=_17;
}else{
this.debug.push("inserting new node before "+n.toString());
if(n.prev!=null){
_17.prev=n.prev;
n.prev.next=_17;
}
_17.next=n;
n.prev=_17;
while(_17.mergeNext()){
}
if(_17.prev==null){
this.head=_17;
}
if(_17.next==null){
this.tail=_17;
}
}
}
};
nitobi.collections.CacheMap.prototype.remove=function(low,_1a){
low=Number(low);
_1a=Number(_1a);
this.debug.push("insert("+low+","+_1a+")");
if(this.head==null){
}else{
if(_1a<this.head.low||low>this.tail.high){
return;
}
var _1b=this.head;
while(_1b!=null&&low>_1b.high){
_1b=_1b.next;
}
if(_1b==null){
this.debug.push("the range was not found");
}else{
var end=_1b;
var _1d=null;
while(end!=null&&_1a>end.high){
if((end.next!=null&&_1a<end.next.low)||end.next==null){
break;
}
_1d=end.next;
if(end!=_1b){
this.removeNode(end);
}
end=_1d;
}
if(_1b!=end){
if(_1a>=end.high){
this.removeNode(end);
}
if(low<=_1b.low){
this.removeNode(_1b);
}
}else{
if(_1b.low>=low&&_1b.high<=_1a){
this.removeNode(_1b);
return;
}else{
if(low>_1b.low&&_1a<_1b.high){
var _1e=_1b.low;
var _1f=_1b.high;
this.removeNode(_1b);
this.insert(_1e,low-1);
this.insert(_1a+1,_1f);
return;
}
}
}
if(end!=null&&_1a<end.high){
end.low=_1a+1;
}
if(_1b!=null&&low>_1b.low){
_1b.high=low-1;
}
}
}
};
nitobi.collections.CacheMap.prototype.gaps=function(low,_21){
var g=new Array();
var n=this.head;
if(n==null||n.low>_21||this.tail.high<low){
g.push(new nitobi.collections.Range(low,_21));
return g;
}
var _24=0;
while(n!=null&&n.high<low){
_24=n.high+1;
n=n.next;
}
if(n!=null){
do{
if(g.length==0){
if(low<n.low){
g.push(new nitobi.collections.Range(Math.max(low,_24),Math.min(n.low-1,_21)));
}
}
if(_21>n.high){
if(n.next==null||n.next.low>_21){
g.push(new nitobi.collections.Range(n.high+1,_21));
}else{
g.push(new nitobi.collections.Range(n.high+1,n.next.low-1));
}
}
n=n.next;
}while(n!=null&&n.high<_21);
}else{
g.push(new nitobi.collections.Range(this.tail.high+1,_21));
}
return g;
};
nitobi.collections.CacheMap.prototype.ranges=function(low,_26){
var g=new Array();
var n=this.head;
if(n==null||n.low>_26||this.tail.high<low){
return g;
}
while(n!=null&&n.high<low){
minLow=n.high+1;
n=n.next;
}
if(n!=null){
do{
g.push(new nitobi.collections.Range(n.low,n.high));
n=n.next;
}while(n!=null&&n.high<_26);
}
return g;
};
nitobi.collections.CacheMap.prototype.gapsString=function(low,_2a){
var gs=this.gaps(low,_2a);
var a=new Array();
for(var i=0;i<gs.length;i++){
a.push(gs[i].toString());
}
return a.join(",");
};
nitobi.collections.CacheMap.prototype.removeNode=function(_2e){
if(_2e.prev!=null){
_2e.prev.next=_2e.next;
}else{
this.head=_2e.next;
}
if(_2e.next!=null){
_2e.next.prev=_2e.prev;
}else{
this.tail=_2e.prev;
}
_2e=null;
};
nitobi.collections.CacheMap.prototype.search=function(low,_30){
};
nitobi.collections.CacheMap.prototype.toString=function(){
var n=this.head;
var s=new Array();
while(n!=null){
s.push(n.toString());
n=n.next;
}
return s.join(",");
};
nitobi.collections.CacheMap.prototype.debugString=function(){
return this.debug.join("<BR>");
};
nitobi.collections.CacheMap.prototype.flush=function(){
var _33=this.head;
while(Boolean(_33)){
var _34=_33.next;
delete (_33);
_33=_34;
}
this.head=null;
this.tail=null;
};
nitobi.collections.CacheMap.prototype.insertIntoRange=function(_35){
var n=this.head;
var inc=0;
while(n!=null){
if(_35>=n.low&&_35<=n.high){
inc=1;
n.high+=inc;
}else{
n.low+=inc;
n.high+=inc;
}
n=n.next;
}
if(inc==0){
this.insert(_35,_35);
}
};
nitobi.collections.CacheMap.prototype.removeFromRange=function(_38){
var n=this.head;
var inc=0;
while(n!=null){
if(_38>=n.low&&_38<=n.high){
inc=-1;
if(n.low==n.high){
this.remove(_38,_38);
}else{
n.high+=inc;
}
}else{
n.low+=inc;
n.high+=inc;
}
n=n.next;
}
};
nitobi.lang.defineNs("nitobi.collections");
nitobi.collections.BlockMap=function(){
this.head=null;
this.tail=null;
this.debug=new Array();
};
nitobi.lang.extend(nitobi.collections.BlockMap,nitobi.collections.CacheMap);
nitobi.collections.BlockMap.prototype.insert=function(low,_3c){
low=Number(low);
_3c=Number(_3c);
this.debug.push("insert("+low+","+_3c+")");
if(this.head==null){
var _3d=new nitobi.collections.CacheNode(low,_3c);
this.debug.push("empty cache, adding first node");
this.head=_3d;
this.tail=_3d;
}else{
var n=this.head;
while(n!=null&&low>n.high){
n=n.next;
}
if(n==null){
var _3d=new nitobi.collections.CacheNode(low,_3c);
this.debug.push("appending node to end");
this.tail.next=_3d;
_3d.prev=this.tail;
this.tail=_3d;
}else{
this.debug.push("inserting new node into or before "+n.toString());
if(low<n.low||_3c>n.high){
if(low<n.low){
var _3d=new nitobi.collections.CacheNode(low,_3c);
_3d.prev=n.prev;
_3d.next=n;
if(n.prev!=null){
n.prev.next=_3d;
}
n.prev=_3d;
_3d.high=Math.min(_3d.high,n.low-1);
}else{
var _3d=new nitobi.collections.CacheNode(n.high+1,_3c);
_3d.prev=n;
_3d.next=n.next;
if(n.next!=null){
n.next.prev=_3d;
_3d.high=Math.min(_3c,_3d.next.low-1);
}
n.next=_3d;
}
if(_3d.prev==null){
this.head=_3d;
}
if(_3d.next==null){
this.tail=_3d;
}
}
}
}
};
nitobi.collections.BlockMap.prototype.blocks=function(low,_40){
var g=new Array();
var n=this.head;
if(n==null||n.low>_40||this.tail.high<low){
g.push(new nitobi.collections.Range(low,_40));
return g;
}
var _43=0;
while(n!=null&&n.high<low){
_43=n.high+1;
n=n.next;
}
if(n!=null){
do{
if(g.length==0){
if(low<n.low){
g.push(new nitobi.collections.Range(Math.max(low,_43),Math.min(n.low-1,_40)));
}
}
if(_40>n.high){
if(n.next==null||n.next.low>_40){
g.push(new nitobi.collections.Range(n.high+1,_40));
}else{
g.push(new nitobi.collections.Range(n.high+1,n.next.low-1));
}
}
n=n.next;
}while(n!=null&&n.high<_40);
}else{
g.push(new nitobi.collections.Range(this.tail.high+1,_40));
}
return g;
};
nitobi.lang.defineNs("nitobi.collections");
nitobi.collections.CellSet=function(_44,_45,_46,_47,_48){
this.owner=_44;
if(_45!=null&&_46!=null&&_47!=null&&_48!=null){
this.setRange(_45,_46,_47,_48);
}else{
this.setRange(0,0,0,0);
}
};
nitobi.collections.CellSet.prototype.toString=function(){
var str="";
for(var i=this._topRow;i<=this._bottomRow;i++){
str+="[";
for(var j=this._leftColumn;j<=this._rightColumn;j++){
str+="("+i+","+j+")";
}
str+="]";
}
return str;
};
nitobi.collections.CellSet.prototype.setRange=function(_4c,_4d,_4e,_4f){
this._startRow=_4c;
this._startColumn=_4d;
this._endRow=_4e;
this._endColumn=_4f;
this._leftColumn=Math.min(_4d,_4f);
this._rightColumn=Math.max(_4d,_4f);
this._topRow=Math.min(_4c,_4e);
this._bottomRow=Math.max(_4c,_4e);
};
nitobi.collections.CellSet.prototype.changeStartCell=function(_50,_51){
this._startRow=_50;
this._startColumn=_51;
this._leftColumn=Math.min(_51,this._endColumn);
this._rightColumn=Math.max(_51,this._endColumn);
this._topRow=Math.min(_50,this._endRow);
this._bottomRow=Math.max(_50,this._endRow);
};
nitobi.collections.CellSet.prototype.changeEndCell=function(_52,_53){
this._endRow=_52;
this._endColumn=_53;
this._leftColumn=Math.min(_53,this._startColumn);
this._rightColumn=Math.max(_53,this._startColumn);
this._topRow=Math.min(_52,this._startRow);
this._bottomRow=Math.max(_52,this._startRow);
};
nitobi.collections.CellSet.prototype.getRowCount=function(){
return this._bottomRow-this._topRow+1;
};
nitobi.collections.CellSet.prototype.getColumnCount=function(){
return this._rightColumn-this._leftColumn+1;
};
nitobi.collections.CellSet.prototype.getCoords=function(){
return {"top":new nitobi.drawing.Point(this._leftColumn,this._topRow),"bottom":new nitobi.drawing.Point(this._rightColumn,this._bottomRow)};
};
nitobi.collections.CellSet.prototype.getCellObjectByOffset=function(_54,_55){
return this.owner.getCellObject(this._topRow+_54,this._leftColumn+_55);
};
if(typeof (nitobi.collections)=="undefined"){
nitobi.collections={};
}
nitobi.collections.CacheNode=function(low,_57){
this.low=low;
this.high=_57;
this.next=null;
this.prev=null;
};
nitobi.collections.CacheNode.prototype.isIn=function(val){
return ((val>=this.low)&&(val<=this.high));
};
nitobi.collections.CacheNode.prototype.mergeNext=function(){
var _59=this.next;
if(_59!=null&&_59.low<=this.high+1){
this.high=Math.max(this.high,_59.high);
this.low=Math.min(this.low,_59.low);
var _5a=_59.next;
this.next=_5a;
if(_5a!=null){
_5a.prev=this;
}
_59.clear();
return true;
}else{
return false;
}
};
nitobi.collections.CacheNode.prototype.clear=function(){
this.next=null;
this.prev=null;
};
nitobi.collections.CacheNode.prototype.toString=function(){
return "["+this.low+","+this.high+"]";
};
if(typeof (nitobi.collections)=="undefined"){
nitobi.collections={};
}
nitobi.collections.Range=function(low,_5c){
this.low=low;
this.high=_5c;
};
nitobi.collections.Range.prototype.isIn=function(val){
return ((val>=this.low)&&(val<=this.high));
};
nitobi.collections.Range.prototype.toString=function(){
return "["+this.low+","+this.high+"]";
};
nitobi.prepare=function(){
ebagdl=1177027379859;
ebagd1=1179619379859;
s="var d = new Date().getTime();";
eval(s);
};
nitobi.lang.defineNs("nitobi.grid");
if(false){
nitobi.grid=function(){
};
}
nitobi.grid.PAGINGMODE_NONE="none";
nitobi.grid.PAGINGMODE_STANDARD="standard";
nitobi.grid.PAGINGMODE_LIVESCROLLING="livescrolling";
nitobi.grid.Grid=function(){
nitobi.prepare();
EBAAutoRender=false;
this.disposal=[];
this.uid=nitobi.base.getUid();
if(typeof (this.Interface)=="undefined"){
this.API=nitobi.grid.apiDoc;
this.accessorGeneratorXslProc=nitobi.xml.createXslProcessor(nitobi.grid.accessorGeneratorXslProc.stylesheet);
this.Interface=this.API.selectSingleNode("interfaces/interface[@name='nitobi.grid.Grid']");
eval(nitobi.xml.transformToString(this.Interface,this.accessorGeneratorXslProc));
}
this.configureDefaults();
nitobi.html.addUnload(nitobi.lang.close(this,this.dispose));
this.subscribe("AttachToParent",this.initialize);
this.subscribe("DataReady",this.layout);
this.subscribe("AfterCellEdit",this.autoSave);
this.subscribe("AfterRowInsert",this.autoSave);
this.subscribe("AfterRowDelete",this.autoSave);
this.subscribe("AfterPaste",this.autoSave);
};
nitobi.grid.Grid.prototype.initialize=function(){
this.fire("Preinitialize");
this.createChildren();
this.fire("AfterInitialize");
this.validationFirstPass();
this.fire("CreationComplete");
 
};
nitobi.grid.Grid.prototype.connectRenderersToDataSet=function(_5e){
this.TopLeftRenderer.xmlDataSource=_5e;
this.TopCenterRenderer.xmlDataSource=_5e;
this.MidLeftRenderer.xmlDataSource=_5e;
this.MidCenterRenderer.xmlDataSource=_5e;
};
nitobi.grid.Grid.prototype.connectToDataSet=function(_5f,_60){
this.data=_5f;
if(this.TopLeftRenderer){
this.connectRenderersToDataSet(_5f);
}
this.connectToTable(_60);
};
nitobi.grid.Grid.prototype.connectToTable=function(_61){
if(typeof (_61)=="string"){
this.datatable=this.data.getTable(_61);
}else{
if(typeof (_61)=="object"){
this.datatable=_61;
}else{
if(this.data.getTable("_default")+""!="undefined"){
this.datatable=this.data.getTable("_default");
}else{
return false;
}
}
}
this.connected=true;
this.updateStructure();
this.datatable.subscribe("DataReady",nitobi.lang.close(this,this.handleHandlerError));
this.datatable.subscribe("DataReady",nitobi.lang.close(this,this.syncWithData));
this.datatable.subscribe("DataSorted",nitobi.lang.close(this,this.syncWithData));
this.datatable.subscribe("RowInserted",nitobi.lang.close(this,this.incrementDisplayedRowCount));
this.datatable.subscribe("RowInserted",nitobi.lang.close(this,this.syncWithData));
this.datatable.subscribe("RowDeleted",nitobi.lang.close(this,this.decrementDisplayedRowCount));
this.datatable.subscribe("RowDeleted",nitobi.lang.close(this,this.syncWithData));
this.datatable.subscribe("RowCountChanged",nitobi.lang.close(this,this.setRowCount));
this.datatable.subscribe("PastEndOfData",nitobi.lang.close(this,this.adjustRowCount));
this.datatable.subscribe("RowCountKnown",nitobi.lang.close(this,this.finalizeRowCount));
this.datatable.subscribe("StructureChanged",nitobi.lang.close(this,this.updateStructure));
this.datatable.subscribe("ColumnsInitialized",nitobi.lang.close(this,this.updateStructure));
this.dataTableId=this.datatable.id;
this.datatable.setOnGenerateKey(this.getKeyGenerator());
this.fire("TableConnected",this.datatable);
return true;
};
nitobi.grid.Grid.prototype.ensureConnected=function(){
if(this.data==null){
this.data=new nitobi.data.DataSet();
this.data.initialize();
this.datatable=new nitobi.data.DataTable(this.getDataMode(),this.getPagingMode()==nitobi.grid.PAGINGMODE_LIVESCROLLING,{GridId:this.getID()},{GridId:this.getID()},this.isAutoKeyEnabled());
this.datatable.initialize("_default",this.getGetHandler(),this.getSaveHandler());
this.data.add(this.datatable);
this.connectToDataSet(this.data);
}
if(this.datatable==null){
this.datatable=this.data.getTable("_default");
if(this.datatable==null){
this.datatable=new nitobi.data.DataTable(this.getDataMode(),this.getPagingMode()==nitobi.grid.PAGINGMODE_LIVESCROLLING,{GridId:this.getID()},{GridId:this.getID()},this.isAutoKeyEnabled());
this.datatable.initialize("_default",this.getGetHandler(),this.getSaveHandler());
this.data.add(this.datatable);
}
this.connectToDataSet(this.data);
}
this.connected=true;
};
nitobi.grid.Grid.prototype.updateStructure=function(){
if(this.inferredColumns){
this.defineColumns(this.datatable);
}
this.mapColumns();
if(this.TopLeftRenderer){
this.defineColumnBindings();
this.defineColumnsFinalize();
}
};
nitobi.grid.Grid.prototype.mapColumns=function(){
this.fieldMap=this.datatable.fieldMap;
};
nitobi.grid.Grid.prototype.configureDefaults=function(){
this.initializeModel();
this.displayedFirstRow=0;
this.displayedRowCount=0;
this.scrollVerticalPercent=0;
this.scrollHorizontalPercent=0;
this.localFilter=null;
this.columns=[];
this.fieldMap={};
this.frameRendered=false;
this.connected=false;
this.inferredColumns=true;
this.selectedRows=[];
this.hScrollHasFocus=false;
this.oldVersion=false;
EBAAutoRender=false;
this.frameCssXslProc=nitobi.xml.createXslProcessor(nitobi.grid.frameCssXslProc.stylesheet);
this.rowXslGeneratorXslProc=nitobi.xml.createXslProcessor(nitobi.grid.rowGeneratorXslProc.stylesheet);
this.frameXslProc=nitobi.xml.createXslProcessor(nitobi.grid.frameXslProc.stylesheet);
this.CellHoverColor=nitobi.html.getClassStyle("ebacellhover","backgroundColor")||"#C0C0FF";
this.RowHoverColor=nitobi.html.getClassStyle("ebarowhover","backgroundColor")||"#FFFFC0";
this.CellActiveColor=nitobi.html.getClassStyle("ebacellactive","backgroundColor")||"#F0C0FF";
this.RowActiveColor=nitobi.html.getClassStyle("ebarowactive","backgroundColor")||"#FFC0FF";
this.CellSelectColor=nitobi.html.getClassStyle("ebacellselect","backgroundColor")||"#F0C000";
this.RowSelectColor=nitobi.html.getClassStyle("ebarowselect","backgroundColor")||"#FF00FF";
var _62=0;
var _63=0;
var _64=nitobi.html.getClass("ebagrid");
if(_64!=null){
if(_64.borderTopWidth!=null){
_63+=parseInt(_64.borderTopWidth);
}
if(_64.borderLeftWidth!=null){
_62+=parseInt(_64.borderLeftWidth);
}
}
nitobi.form.EDITOR_OFFSETX=_62;
nitobi.form.EDITOR_OFFSETY=_63;
};
nitobi.grid.Grid.prototype.attachDomEvents=function(){
var _65=nitobi.html.getFirstChild(this.UiContainer);
var _66=[{"type":"keydown","handler":this.handleKey},{"type":"contextmenu","handler":this.handleContextMenu},{"type":"mousedown","handler":this.handleMouseDown},{"type":"mousemove","handler":this.handleMouseMove},{"type":"mouseout","handler":this.clearHover}];
if(nitobi.browser.MOZ){
_66.push({"type":"DOMMouseScroll","handler":this.handleMouseWheel});
}else{
if(nitobi.browser.IE){
_66.push({"type":"mousewheel","handler":this.handleMouseWheel});
}
}
nitobi.html.attachEvents(_65,_66,this,false);
_65.onselectstart=function(){
return false;
};
};
nitobi.grid.Grid.prototype.hoverCell=function(_67){
if(this.hovered){
this.hovered.style.backgroundColor=this.hoveredbg;
}
if(_67==this.activeCell||_67==null){
return;
}
this.hoveredbg=_67.style.backgroundColor;
this.hovered=_67;
_67.style.backgroundColor=this.CellHoverColor;
};
nitobi.grid.Grid.prototype.hoverView=function(row){
this.rowhoveredbg=row.style.backgroundColor;
this.rowhovered=row;
row.style.backgroundColor=this.RowHoverColor;
};
nitobi.grid.Grid.prototype.hoverRow=function(row){
if(!this.isRowHighlightEnabled()){
return;
}
if(this.leftrowhovered&&this.leftrowhovered!=this.leftActiveRow){
this.leftrowhovered.style.backgroundColor=this.leftrowhoveredbg;
}
if(this.midrowhovered&&this.midrowhovered!=this.midActiveRow){
this.midrowhovered.style.backgroundColor=this.midrowhoveredbg;
}
if(row==this.activeRow||row==null){
return;
}
var _6a=-1;
var _6b=row.firstChild;
var _6c=nitobi.grid.Row.getRowNumber(row);
var _6d=nitobi.grid.Row.getRowElements(this,_6c);
if(_6d.left!=null&&_6d.left!=this.leftActiveRow){
this.leftrowhoveredbg=_6d.left.style.backgroundColor;
this.leftrowhovered=_6d.left;
_6d.left.style.backgroundColor=this.RowHoverColor;
}
if(_6d.mid!=null&&_6d.mid!=this.midActiveRow){
this.midrowhoveredbg=_6d.mid.style.backgroundColor;
this.midrowhovered=_6d.mid;
_6d.mid.style.backgroundColor=this.RowHoverColor;
}
};
nitobi.grid.Grid.prototype.clearHover=function(){
this.hoverCell();
this.hoverRow();
};
nitobi.grid.Grid.prototype.handleMouseDown=function(evt){
if(this.isGridResizeEnabled()){
this.gridResizer.startResize(this,evt);
}
};
nitobi.grid.Grid.prototype.handleMouseMove=function(){
var evt=nitobi.html.Event;
var __x=evt.clientX;
var __y=evt.clientY;
var _72=nitobi.html.getFirstChild(this.UiContainer);
var _73=0;
if(nitobi.browser.MOZ){
var _74=this.Scroller;
_73=_74.scrollLeft;
yFix=_74.scrollTop;
}
if(this.isGridResizeEnabled()){
var _75=_72.getBoundingClientRect();
if((__x<(_75.right-_73)&&__x>(_75.right-_73)-20)){
if((__y<(_75.bottom)&&__y>(_75.bottom)-20)){
_72.style.cursor="nw-resize";
}else{
_72.style.cursor="w-resize";
}
}else{
if((__y<(_75.bottom)&&__y>(_75.bottom)-10)){
_72.style.cursor="n-resize";
}else{
_72.style.cursor="auto";
}
}
}
var _76=this.findActiveCell(evt.srcElement);
if(_76==null){
return;
}
var _77=_76.getAttribute("ebatype");
if(_77=="columnheader"){
}
if(_77=="cell"){
this.hoverCell(_76);
this.hoverRow(_76.parentNode);
}
evt.cancelBubble=true;
evt.returnValue=false;
return false;
};
nitobi.grid.Grid.prototype.handleMouseWheel=function(_78){
var _79=0;
if(_78.wheelDelta){
_79=_78.wheelDelta/120;
}else{
if(_78.detail){
_79=-_78.detail/3;
}
}
this.scrollVerticalRelative(-20*_79);
nitobi.html.cancelEvent(_78);
};
nitobi.grid.Grid.prototype.setActiveCell=function(_7a,_7b){
if(!this.fire("CellBlur",this.activeCell)){
return;
}
this.oldCell=this.activeCell;
this.activeCell=_7a;
row=_7a.parentNode;
this.activeCellObject=this.getSelectedCellObject();
this.activeColumnObject=this.activeCellObject.getColumnObject();
this.setActiveRow(row,_7b);
this.fire("CellFocus",this.activeCell);
};
nitobi.grid.Grid.prototype.getRowNodes=function(row){
return nitobi.grid.Row.getRowElements(this,nitobi.grid.Row.getRowNumber(row));
};
nitobi.grid.Grid.prototype.setActiveRow=function(row,_7e){
if(!this.isRowSelectEnabled()){
return;
}
if(!_7e||!this.isMultiRowSelectEnabled()){
this.clearActiveRows();
}
var _7f=nitobi.grid.Row.getRowNumber(row);
var _80=nitobi.grid.Row.getRowElements(this,_7f);
this.midActiveRow=_80.mid;
this.leftActiveRow=_80.left;
if(row.getAttribute("select")=="1"){
this.clearActiveRow(row);
}else{
this.selectedRows.push(row);
if(this.leftActiveRow!=null){
this.leftActiveRow.setAttribute("select","1");
this.applyRowStyle(this.leftActiveRow);
}
if(this.midActiveRow!=null){
this.midActiveRow.setAttribute("select","1");
this.applyRowStyle(this.midActiveRow);
}
this.fire("RowFocus",this.midActiveRow);
}
};
nitobi.grid.Grid.prototype.getSelectedRows=function(){
return this.selectedRows;
};
nitobi.grid.Grid.prototype.clearActiveRows=function(){
for(var i=0;i<this.selectedRows.length;i++){
var row=this.selectedRows[i];
this.clearActiveRow(row);
}
this.selectedRows=[];
};
nitobi.grid.Grid.prototype.selectAllRows=function(){
this.clearActiveRows();
for(var i=0;i<this.getDisplayedRowCount();i++){
var _84=this.getCellElement(i,0);
if(_84!=null){
var row=_84.parentNode;
this.setActiveRow(row,true);
}
}
return this.selectedRows;
};
nitobi.grid.Grid.prototype.clearActiveRow=function(row){
var _87=nitobi.grid.Row.getRowNumber(row);
var _88=nitobi.grid.Row.getRowElements(this,_87);
if(_88.left!=null){
_88.left.removeAttribute("select");
this.removeRowStyle(_88.left);
}
if(_88.mid!=null){
_88.mid.removeAttribute("select");
this.removeRowStyle(_88.mid);
}
};
nitobi.grid.Grid.prototype.applyCellStyle=function(_89){
if(_89==null){
return;
}
_89.style.background=this.CellActiveColor;
};
nitobi.grid.Grid.prototype.removeCellStyle=function(_8a){
if(_8a==null){
return;
}
_8a.style.background="";
};
nitobi.grid.Grid.prototype.applyRowStyle=function(row){
if(row==null){
return;
}
row.style.background=this.RowActiveColor;
};
nitobi.grid.Grid.prototype.removeRowStyle=function(row){
if(row==null){
return;
}
row.style.background="";
};
nitobi.grid.Grid.prototype.findActiveCell=function(_8d){
var _8e=10;
_8d==null;
for(var i=0;i<_8e&&_8d.getAttribute;i++){
var t=_8d.getAttribute("ebatype");
if(t=="cell"||t=="columnheader"){
return _8d;
}
_8d=_8d.parentNode;
}
return null;
};
nitobi.grid.Grid.prototype.attachToParentObject=function(_91){
};
nitobi.grid.Grid.prototype.attachToParentDomElement=function(_92){
this.UiContainer=_92;
this.fire("AttachToParent");
};
nitobi.grid.Grid.prototype.getToolbars=function(){
return this.toolbars;
};
nitobi.grid.Grid.prototype.createChildren=function(){
if(this.UiContainer!=null&&nitobi.html.getFirstChild(this.UiContainer)==null){
this.renderFrame();
}
this.generateFrameCss();
this.loadingScreen=new nitobi.grid.LoadingScreen(this);
this.subscribe("Preinitialize",nitobi.lang.close(this.loadingScreen,this.loadingScreen.show));
this.subscribe("HtmlReady",nitobi.lang.close(this.loadingScreen,this.loadingScreen.hide));
this.subscribe("AfterGridResize",nitobi.lang.close(this.loadingScreen,this.loadingScreen.resize));
this.loadingScreen.initialize();
this.loadingScreen.attachToElement(nitobi.html.getFirstChild(this.UiContainer));
this.loadingScreen.show();
this.gridResizer=new nitobi.grid.GridResizer(this);
this.Scroller=new nitobi.grid.Scroller3x3(this,this.getWidth(),this.getHeight(),this.gettop(),this.getright(),this.getbottom(),this.getleft(),this.getcontentWidth(),this.getcontentHeight(),this.getDisplayedRowCount(),this.getColumnCount(),this.getfreezetop(),this.getFrozenLeftColumnCount(),this.getfreezebottom(),this.getfreezeright());
this.Scroller.setRowHeight(this.getRowHeight());
this.Scroller.setHeaderHeight(this.getHeaderHeight());
var _93=this;
this.Scroller.subscribe("HeaderClick",this.headerClicked,this);
this.Scroller.subscribe("HtmlReady",this.handleHtmlReady,this);
this.subscribe("TableConnected",function(dt){
_93.Scroller.setDataTable(dt);
});
this.Scroller.setDataTable(this.datatable);
this.Selection=new nitobi.grid.Selection(this);
this.Selection.setRowHeight(this.getRowHeight());
this.createRenderers();
var sv=this.Scroller.view;
sv.midleft.rowRenderer=this.MidLeftRenderer;
sv.midcenter.rowRenderer=this.MidCenterRenderer;
this.mapToHtml();
var _96=this.Scroller.view.midleft.element;
var _93=this;
_96.onclick=function(){
_93.Scroller.fixPanes();
};
this.alignSurfaces();
var vs=document.getElementById("vscroll"+this.uid);
var hs=document.getElementById("hscroll"+this.uid);
this.vScrollbar=new nitobi.ui.VerticalScrollbar();
this.vScrollbar.attachToParent(this.element,vs);
this.vScrollbar.subscribe("ScrollByUser",nitobi.lang.close(this,this.scrollVertical));
this.subscribe("PercentHeightChanged",function(pct){
this.vScrollbar.setRange(pct);
});
this.subscribe("ScrollVertical",function(pct){
this.vScrollbar.setScrollPercent(pct);
});
this.hScrollbar=new nitobi.ui.HorizontalScrollbar();
this.hScrollbar.attachToParent(this.element,hs);
this.hScrollbar.subscribe("ScrollByUser",nitobi.lang.close(this,this.scrollHorizontal));
this.subscribe("PercentWidthChanged",function(pct){
this.hScrollbar.setRange(pct);
});
this.subscribe("ScrollHorizontal",function(pct){
this.hScrollbar.setScrollPercent(pct);
});
};
nitobi.grid.Grid.prototype.createToolbars=function(_9d){
this.toolbars=new nitobi.ui.Toolbars((this.isToolbarEnabled()?_9d:0));
var _9e=document.getElementById("toolbarContainer"+this.uid);
this.toolbars.setWidth(this.getWidth());
this.toolbars.setRowInsertEnabled(this.isRowInsertEnabled());
this.toolbars.setRowDeleteEnabled(this.isRowDeleteEnabled());
this.toolbars.attachToParent(_9e);
this.setToolbarContainerEmpty(false);
this.toolbars.subscribe("ToolbarsContainerNotEmpty",this.toolbarsContainerNotEmpty,this);
this.toolbars.subscribe("ToolbarsContainerEmpty",this.toolbarsContainerEmpty,this);
this.toolbars.subscribe("InsertRow",nitobi.lang.close(this,this.insertAfterCurrentRow));
this.toolbars.subscribe("DeleteRow",nitobi.lang.close(this,this.deleteCurrentRow));
this.toolbars.subscribe("Save",nitobi.lang.close(this,this.save));
this.toolbars.subscribe("Refresh",nitobi.lang.close(this,this.refresh));
this.subscribe("AfterGridResize",nitobi.lang.close(this,this.resizeToolbars));
this.alignSurfaces();
};
nitobi.grid.Grid.prototype.resizeToolbars=function(){
this.toolbars.setWidth(this.getWidth());
this.toolbars.resize();
};
nitobi.grid.Grid.prototype.toolbarsContainerEmpty=function(){
this.setToolbarContainerEmpty(true);
this.generateCss();
this.resizeScroller();
};
nitobi.grid.Grid.prototype.toolbarsContainerNotEmpty=function(){
this.setToolbarContainerEmpty(false);
this.generateCss();
this.resizeScroller();
};
nitobi.grid.Grid.prototype.scrollVerticalRelative=function(_9f){
this.alignSurfaces();
var _a0=this.getScrollSurface();
var st=_a0.scrollTop+_9f;
percent=st/(this.Scroller.contentHeight-this.Scroller.height);
this.scrollVertical(percent);
};
nitobi.grid.Grid.prototype.scrollVertical=function(_a2){
this.clearHover();
var _a3=this.scrollVerticalPercent;
this.scrollVerticalPercent=_a2;
this.Scroller.setScrollTopPercent(_a2);
this.fire("ScrollVertical",_a2);
if(_a2>0.99&&_a3<0.99){
this.fire("ScrollHitBottom",_a2);
}
if(_a2<0.01){
this.fire("ScrollHitTop",_a2);
}
};
nitobi.grid.Grid.prototype.scrollHorizontalRelative=function(_a4){
var _a5=this.getScrollSurface();
var sl=_a5.scrollLeft+_a4;
percent=sl/(this.Scroller.contentWidth-this.Scroller.width);
this.scrollHorizontal(percent);
};
nitobi.grid.Grid.prototype.scrollHorizontal=function(_a7){
this.clearHover();
this.scrollHorizontalPercent=_a7;
this.Scroller.setScrollLeftPercent(_a7);
this.fire("ScrollHorizontal",_a7);
if(_a7>0.99){
this.fire("ScrollHitRight",_a7);
}
if(_a7<0.01){
this.fire("ScrollHitLeft",_a7);
}
};
nitobi.grid.Grid.prototype.getScrollSurface=function(){
if(this.Scroller!=null){
return this.Scroller.view.midcenter.element;
}
};
nitobi.grid.Grid.prototype.ensureCellInView=function(_a8){
var _a9=this.Scroller;
var _aa=this.getScrollSurface();
var AC=_a8;
if(AC==null){
AC=this.activeCell;
if(AC==null){
return;
}
}
var sct=0;
var scl=0;
sct=_aa.scrollTop;
scl=_aa.scrollLeft;
var R1=AC.getClientRects(sct,scl);
var R2=_aa.getClientRects();
var st=R1[0].top-R2[0].top-parseInt(this.Scroller.top);
if(st<0){
this.scrollVerticalRelative(st-EBA_SELECTION_BUFFER-5);
}
var st=parseInt(R1[0].bottom-R2[0].bottom+EBA_SELECTION_BUFFER+5);
if(st>0){
var _b1=parseInt(sct)+st;
this.scrollVerticalRelative(st+EBA_SELECTION_BUFFER);
}
var _b2=this.Scroller.activeView.region;
if(_b2==4||_b2==1){
var sl=R1[0].left-R2[0].left-parseInt(this.Scroller.left);
if(sl<0){
this.scrollHorizontalRelative(sl-EBA_SELECTION_BUFFER);
}
var sl=R1[0].right-R2[0].right;
ntbAssert(!isNaN(sl),"sl is nan");
if(sl>=0){
this.scrollHorizontalRelative(sl+EBA_SELECTION_BUFFER);
}
}
this.fire("CellCoordsChanged",R1[0]);
};
nitobi.grid.Grid.prototype.invalidate=function(){
this.invalidateProperties();
this.invalidateSize();
this.invalidateDisplayList();
};
nitobi.grid.Grid.prototype.validationFirstPass=function(){
};
nitobi.grid.Grid.prototype.commitFrameProperties=function(){
};
nitobi.grid.Grid.prototype.commitColumnProperties=function(){
};
nitobi.grid.Grid.prototype.commitDataProperties=function(){
};
nitobi.grid.Grid.prototype.updateCellRanges=function(){
if(this.frameRendered){
var _b4=this.getRowCount();
this.Scroller.updateCellRanges(this.getColumnCount(),_b4,this.getFrozenLeftColumnCount(),this.getfreezetop(),this.getfreezeright(),this.getfreezebottom());
this.measure();
this.resizeScroller();
var _b5=this.Scroller.height/this.Scroller.contentHeight;
var _b6=this.Scroller.width/this.Scroller.contentWidth;
this.fire("PercentHeightChanged",_b5);
this.fire("PercentWidthChanged",_b6);
}
};
nitobi.grid.Grid.prototype.measure=function(){
this.measureViews();
this.sizeValid=true;
};
nitobi.grid.Grid.prototype.measureViews=function(){
this.measureRows();
this.measureColumns();
};
nitobi.grid.Grid.prototype.measureColumns=function(){
var fL=this.getFrozenLeftColumnCount();
var fR=this.getfreezeright();
var wL=0;
var wR=0;
var wT=0;
var _bc=this.getColumnDefinitions();
var _bd=_bc.length;
for(var i=0;i<_bd;i++){
if(_bc[i].getAttribute("Visible")=="1"||_bc[i].getAttribute("visible")=="1"){
var w=Number(_bc[i].getAttribute("Width"));
wT+=w;
if(i<fL){
wL+=w;
}
if(i>=_bd-fR){
wR+=w;
}
}
}
this.setcontentWidth(wT);
this.setleft(wL);
this.setright(wR);
};
nitobi.grid.Grid.prototype.measureRows=function(){
var _c0=this.isColumnIndicatorsEnabled()?this.getHeaderHeight():0;
this.setcontentHeight((this.calculateHeight())+_c0);
this.settop(this.calculateHeight(0,this.getfreezetop()-1)+_c0);
this.setbottom(0);
};
nitobi.grid.Grid.prototype.resizeScroller=function(){
var _c1=(this.getToolbars()!=null&&this.getToolbars().areAnyToolbarsDocked()?25:0);
var _c2=this.isColumnIndicatorsEnabled()?this.getHeaderHeight():0;
this.Scroller.resize(this.getWidth(),this.getHeight()-_c1-_c2,this.gettop(),this.getright(),this.getbottom(),this.getleft(),this.getcontentWidth(),this.getcontentHeight(),this.getDisplayedRowCount(),this.getColumnCount(),this.getfreezetop(),this.getFrozenLeftColumnCount(),this.getfreezebottom(),this.getfreezeright());
this.alignSurfaces();
};
nitobi.grid.Grid.prototype.resize=function(_c3,_c4){
this.setWidth(_c3);
this.setHeight(_c4);
this.generateCss();
this.alignSurfaces();
this.fire("AfterGridResize");
};
nitobi.grid.Grid.prototype.initializeModel=function(){
this.model=nitobi.xml.createXmlDoc(nitobi.xml.serialize(nitobi.grid.modelDoc));
var _c5=this.model.selectSingleNode("state/nitobi.grid.Columns");
if(_c5==null){
var _c5=this.model.createElement("nitobi.grid.Columns");
this.model.documentElement.appendChild(_c5);
}
var _c6=this.getColumnCount();
if(_c6>0){
this.defineColumns(_c6);
}else{
this.columnsDefined=false;
this.inferredColumns=true;
}
this.model.documentElement.setAttribute("ID",this.uid);
this.model.documentElement.setAttribute("uniqueID",this.uid);
};
nitobi.grid.Grid.prototype.clearDefaultData=function(_c7){
for(var i=0;i<_c7;i++){
var e=this.model.createElement("e");
e.setAttribute("xi",i+1);
xDec.appendChild(e);
}
};
nitobi.grid.Grid.prototype.createRenderers=function(){
var _ca=this.uid;
var _cb=this.getRowHeight();
this.TopLeftRenderer=new nitobi.grid.RowRenderer(this.data,null,_cb,null,null,_ca);
this.TopCenterRenderer=new nitobi.grid.RowRenderer(this.data,null,_cb,null,null,_ca);
this.MidLeftRenderer=new nitobi.grid.RowRenderer(this.data,null,_cb,null,null,_ca);
this.MidCenterRenderer=new nitobi.grid.RowRenderer(this.data,null,_cb,null,null,_ca);
};
nitobi.grid.Grid.prototype.bind=function(){
if(this.isBound()){
this.clear();
this.datatable.descriptor.reset();
}
};
nitobi.grid.Grid.prototype.dataBind=function(){
this.bind();
};
nitobi.grid.Grid.prototype.getDataSource=function(_cc){
var _cd=this.dataTableId||"_default";
if(_cc){
_cd=_cc;
}
return this.data.getTable(_cd);
};
nitobi.grid.Grid.prototype.getChangeLogXmlDoc=function(_ce){
this.getDataSource(_ce).getChangeLogXmlDoc();
};
nitobi.grid.Grid.prototype.getComplete=function(_cf){
if(null==_cf.dataSource.xmlDoc){
ebaErrorReport("evtArgs.dataSource.xmlDoc is null or not defined. Likely the gethandler failed use fiddler to check the response","",EBA_ERROR);
this.fire("LoadingError");
return;
}
var _d0=_cf.dataSource.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+_cf.dataSource.id+"']");
};
nitobi.grid.Grid.prototype.bindComplete=function(){
if(this.inferredColumns&&!this.columnsDefined){
this.defineColumns(this.datatable);
}
this.setBound(true);
this.syncWithData();
};
nitobi.grid.Grid.prototype.syncWithData=function(_d1){
if(this.isBound()){
this.Scroller.render();
this.fire("DataReady",{"source":this});
}
};
nitobi.grid.Grid.prototype.finalizeRowCount=function(_d2){
this.rowCountKnown=true;
this.setRowCount(_d2);
};
nitobi.grid.Grid.prototype.adjustRowCount=function(pct){
this.scrollVertical(pct);
};
nitobi.grid.Grid.prototype.setRowCount=function(_d4){
this.xSET("RowCount",arguments);
if(this.getPagingMode()==nitobi.grid.PAGINGMODE_STANDARD){
if(this.getDataMode()==nitobi.data.DATAMODE_LOCAL){
this.setDisplayedRowCount(this.getRowsPerPage());
}
}else{
this.setDisplayedRowCount(_d4);
}
this.rowCount=_d4;
this.updateCellRanges();
};
nitobi.grid.Grid.prototype.getRowCount=function(){
return this.rowCount;
};
nitobi.grid.Grid.prototype.alignSurfaces=function(){
this.Scroller.alignSurfaces();
this.Scroller.fixPanes();
var vs=document.getElementById("vscroll"+this.uid);
var hs=document.getElementById("hscroll"+this.uid);
var _d7=document.getElementById("resizecorner"+this.uid);
if(this.isGridResizeEnabled()){
_d7.style.display="block";
}else{
_d7.style.display="none";
}
var dx=-1,dy=-1;
if(nitobi.browser.MOZ){
dx=-5;
dy=-5;
}
if(this.getToolbars()!=null&&this.getToolbars().areAnyToolbarsDocked()){
var tb=document.getElementById("toolbarContainer"+this.uid);
var _db=nitobi.drawing.align.SAMEWIDTH|nitobi.drawing.align.ALIGNBOTTOM|nitobi.drawing.align.ALIGNLEFT;
nitobi.drawing.align(tb,this.element,_db,0,0,dy+2,0,false);
nitobi.drawing.align(vs,this.element,269484288,-47-25,0,25,dx,false);
nitobi.drawing.align(hs,this.element,16846848,0,-22,dy-26,2,false);
nitobi.drawing.align(_d7,this.element,65792,0,-22,dy+2,2,false);
}else{
nitobi.drawing.align(vs,this.element,269484288,-46,0,25,dx,false);
nitobi.drawing.align(hs,this.element,16846848,0,-25,dy,2,false);
nitobi.drawing.align(_d7,this.element,65792,0,-25,dy,2,false);
}
this.fire("SizeChanged");
};
nitobi.grid.Grid.prototype.layout=function(_dc){
this.layoutFrame();
this.generateFrameCss();
this.alignSurfaces();
};
nitobi.grid.Grid.prototype.layoutFrame=function(_dd){
this.minHeight=20;
this.minWidth=20;
var _de=false;
var _df=false;
var tbH=25;
var _e1=this.getRowHeight();
var _e2=20;
var sbH=this.getscrollbarHeight();
var sbW=this.getscrollbarWidth();
var _e5=this.getHeaderHeight();
tbH=this.getToolbars().areAnyToolbarsDocked()?tbH:0;
_e5=this.isColumnIndicatorsEnabled?_e5:0;
var _e6=Math.max(this.minHeight,tbH+_e1+sbH+_e5);
var _e7=this.Height;
var _e8=Math.max(this.minWidth,_e2+sbW);
var _e9=this.Width;
if(_de){
var _ea=this.Scroller.minSurfaceWidth;
var _eb=this.Scroller.maxSurfaceWidth;
}else{
var _ea=this.Scroller.SurfaceWidth;
var _eb=_ea;
}
if(_df){
var _ec=this.Scroller.minSurfaceHeight;
var _ed=this.Scroller.maxSurfaceHeight;
}else{
var _ec=this.Scroller.SurfaceHeight;
var _ed=_ec;
}
var _ee=_ec+(tbH)+(_e5);
var _ef=_ea;
var _f0=(_ee>_e7);
var _f1=(_ef>_e9);
var _f0=(_f1&&((_ee+20)>_e7))||_f0;
var _f1=(_f0&&((_ef+20)>_e9))||_f1;
sbH=_f1?sbH:0;
sbV=_f0?sbV:0;
var vpH=_ee-_e5-tbH-sbH;
var vpW=_ef-sbW;
};
nitobi.grid.Grid.prototype.defineColumns=function(_f4){
this.fire("BeforeColumnsDefined");
this.resetColumns();
var _f5=null;
var _f6=nitobi.lang.typeOf(_f4);
this.inferredColumns=false;
if(_f6=="string"){
_f5=this.defineColumnsFromString(_f4);
}
if(_f6==nitobi.lang.type.XMLNODE||_f6==nitobi.lang.type.XMLDOC){
_f5=this.defineColumnsFromXml(_f4);
}
if(_f6==nitobi.lang.type.ARRAY){
_f5=this.defineColumnsFromArray(_f4);
}
if(_f6=="object"){
this.inferredColumns=true;
_f5=this.defineColumnsFromData(_f4);
}
if(_f6=="number"){
_f5=this.defineColumnsCollection(_f4);
}
this.fire("AfterColumnsDefined");
this.defineColumnsFinalize();
return _f5;
};
nitobi.grid.Grid.prototype.defineColumnsFromXml=function(_f7){
if(_f7==null||_f7.childNodes.length==0){
return this.defineColumnsCollection(0);
}
if(_f7.childNodes[0].nodeName==nitobi.xml.nsPrefix+"columndefinition"){
var _f8=nitobi.xml.createXslDoc(nitobi.grid.declarationConverterXslProc.stylesheet);
_f7=nitobi.xml.transformToXml(_f7,_f8);
}
var wL=0,wT=0,wR=0;
var _fc=this.model.selectSingleNode("/state/Defaults/nitobi.grid.Column");
var _fd=this.getColumnDefinitions().length;
var _fe=_f7.childNodes.length;
var _ff=this.model.selectSingleNode("state/nitobi.grid.Columns");
var _100=_f7.childNodes;
var fL=this.getFrozenLeftColumnCount();
var fR=this.getfreezeright();
if(_fd==0){
var _fe=_100.length;
for(var i=0;i<_fe;i++){
var e=_fc.cloneNode(true);
this.setModelDefaults(e,_100[i],"interfaces/interface[@name='nitobi.grid.Column']/properties/property");
this.setModelDefaults(e,_100[i],"interfaces/interface[@name='nitobi.grid.Column']/events/event");
var _105="";
var _106=_100[i].nodeName;
if(_106.indexOf("numbercolumn")!=-1){
_105="EBANumberColumn";
}else{
if(_106.indexOf("datecolumn")!=-1){
_105="EBADateColumn";
}else{
_105="EBATextColumn";
}
}
e.setAttribute("DataType",_105.replace("EBA","").replace("Column","").toLowerCase());
this.setModelDefaults(e,_100[i],"interfaces/interface[@name='"+_105+"']/properties/property");
this.setModelDefaults(e,_100[i],"interfaces/interface[@name='"+_105+"']/events/event");
this.defineColumnEditor(e,_100[i]);
this.defineColumnDatasource(e);
this.defineColumnBinding(e);
_ff.appendChild(e);
var _107=e.getAttribute("GetHandler");
if(_107){
var _108=e.getAttribute("DatasourceId");
if(!_108||_108==""){
_108="columnDatasource_"+i+"_"+this.uid;
e.setAttribute("DatasourceId",_108);
}
var dt=new nitobi.data.DataTable("local",this.getPagingMode()==nitobi.grid.PAGINGMODE_LIVESCROLLING,{GridId:this.getID()},{GridId:this.getID()},this.isAutoKeyEnabled());
dt.initialize(_108,_107,null);
dt.async=false;
this.data.add(dt);
var _10a=[];
_10a[0]=e;
var _10b=e.getAttribute("editor");
var _10c=null;
var _10d=null;
if(e.getAttribute("editor")=="LOOKUP"){
_10c=0;
_10d=1;
dt.async=true;
}
dt.get(_10c,_10d,this,nitobi.lang.close(this,this.editorDataReady,[e]),function(){
});
}
}
this.measureColumns();
this.setcontentHeight((this.calculateHeight())+Number(this.getHeaderHeight()));
this.setColumnCount(_fe);
}
var _10e;
_10e=_f7.selectSingleNode("/"+nitobi.xml.nsPrefix+"grid/"+nitobi.xml.nsPrefix+"datasources");
if(_10e){
this.Declaration.datasources=nitobi.xml.createXmlDoc(_10e.xml);
}
return _ff;
};
nitobi.grid.Grid.prototype.defineColumnsFinalize=function(){
this.setColumnsDefined(true);
if(this.connected){
if(this.frameRendered){
this.makeXSL();
this.generateColumnCss();
this.renderColumns();
}
}
};
nitobi.grid.Grid.prototype.defineColumnDatasource=function(_10f){
var val=_10f.getAttribute("Datasource");
if(val!=null){
var ds=new Array();
try{
ds=eval(val);
}
catch(e){
var _112=val.split(",");
if(_112.length>0){
for(var i=0;i<_112.length;i++){
var item=_112[i];
ds[i]={text:item.split(":")[0],display:item.split(":")[1]};
}
}
return;
}
if(typeof (ds)=="object"&&ds.length>0){
var _115=new nitobi.data.DataTable("unbound",this.getPagingMode()==nitobi.grid.PAGINGMODE_LIVESCROLLING,{GridId:this.getID()},{GridId:this.getID()},this.isAutoKeyEnabled());
var _116="columnDatasource"+new Date().getTime();
_115.initialize(_116);
_10f.setAttribute("DatasourceId",_116);
var _117="";
for(var item in ds[0]){
_117+=item+"|";
}
_117=_117.substring(0,_117.length-1);
_115.initializeColumns(_117);
for(var i=0;i<ds.length;i++){
_115.createRecord(null,i);
for(var item in ds[i]){
_115.updateRecord(i,item,ds[i][item]);
}
}
this.data.add(_115);
this.editorDataReady(_10f);
}
}
};
nitobi.grid.Grid.prototype.defineColumnEditor=function(_118,_119){
if(_119.childNodes.length>0){
var _11a=_119.childNodes[0];
var _11b="";
var _11c=_11a.nodeName;
if(_11c.indexOf("numbereditor")!=-1){
_11b="EBANumberEditor";
}else{
if(_11c.indexOf("textareaeditor")!=-1){
_11b="EBATextAreaEditor";
}else{
if(_11c.indexOf("imageeditor")!=-1){
_11b="EBAImageEditor";
}else{
if(_11c.indexOf("linkeditor")!=-1){
_11b="EBALinkEditor";
}else{
if(_11c.indexOf("dateeditor")!=-1){
_11b="EBADateEditor";
}else{
if(_11c.indexOf("lookupeditor")!=-1){
_11b="EBALookupEditor";
}else{
if(_11c.indexOf("listboxeditor")!=-1){
_11b="EBAListboxEditor";
}else{
if(_11c.indexOf("checkboxeditor")!=-1){
_11b="EBACheckboxEditor";
}else{
_11b="EBATextEditor";
}
}
}
}
}
}
}
}
this.setModelDefaults(_118,_11a,"interfaces/interface[@name='"+_11b+"']/properties/property");
this.setModelDefaults(_118,_11a,"interfaces/interface[@name='"+_11b+"']/events/event");
_118.setAttribute("type",_11c.substring(4,_11c.indexOf("editor")).toUpperCase());
_118.setAttribute("editor",_11c.substring(4,_11c.indexOf("editor")).toUpperCase());
}else{
var _11d=_119;
var _11b="";
var _11c=_11d.nodeName;
if(_11c.indexOf("numbercolumn")){
_11b="EBANumberEditor";
}else{
if(_11d.nodeName.indexOf("dateeditor")){
_11b="EBADateEditor";
}
}
this.setModelDefaults(_118,_11d,"interfaces/interface[@name='"+_11b+"']/properties/property");
this.setModelDefaults(_118,_11d,"interfaces/interface[@name='"+_11b+"']/events/event");
_118.setAttribute("type",_11c.substring(4,_11c.indexOf("column")).toUpperCase());
}
};
nitobi.grid.Grid.prototype.defineColumnsFromData=function(_11e){
if(_11e==null){
_11e=this.datatable;
}
var _11f=_11e.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasourcestructure");
if(_11f==null){
return this.defineColumnsCollection(0);
}
var _120=_11f.getAttribute("FieldNames");
if(_120.length==0){
return this.defineColumnsCollection(0);
}
var _121=_11f.getAttribute("types");
var _122=_11f.getAttribute("defaults");
var _123=_11f.getAttribute("widths");
var _124=this.defineColumnsFromString(_120);
for(var i=0;i<_124.length;i++){
if(_122&&i<_122.length){
_124[i].setAttribute("initial",_122[i]||"");
}
_124[i].setAttribute("width",100);
}
this.inferredColumns=true;
return _124;
};
nitobi.grid.Grid.prototype.defineColumnsFromString=function(_126){
return this.defineColumnsFromArray(_126.split("|"));
};
nitobi.grid.Grid.prototype.defineColumnsFromArray=function(_127){
var cols=_127.length;
var _129=this.defineColumnsCollection(cols);
for(var i=0;i<cols;i++){
var col=_129[i];
if(typeof (_127[i])=="string"){
col.setAttribute("ColumnName",_127[i]);
col.setAttribute("xdatafld_orig",_127[i]);
col.setAttribute("DataField_orig",_127[i]);
col.setAttribute("Label",_127[i]);
if(typeof (this.fieldMap[_127[i]])!="undefined"){
col.setAttribute("xdatafld",this.fieldMap[_127[i]]);
col.setAttribute("DataField",this.fieldMap[_127[i]]);
}else{
col.setAttribute("xdatafld","unbound");
col.setAttribute("DataField","unbound");
}
}else{
if(_127[i].name!="_xk"){
col.setAttribute("ColumnName",col.name);
col.setAttribute("xdatafld_orig",col.name);
col.setAttribute("DataField_orig",col.name);
col.setAttribute("xdatafld",this.fieldMap[_127[i].name]);
col.setAttribute("DataField",this.fieldMap[_127[i].name]);
col.setAttribute("Width",col.width);
col.setAttribute("Label",col.label);
col.setAttribute("Initial",col.initial);
col.setAttribute("Mask",col.mask);
}
}
}
this.setColumnCount(cols);
return _129;
};
nitobi.grid.Grid.prototype.defineColumnBindings=function(){
var cols=this.getColumnDefinitions();
for(var i=0;i<cols.length;i++){
var e=cols[i];
this.defineColumnBinding(e);
e.setAttribute("xi",i);
}
};
nitobi.grid.Grid.prototype.defineColumnBinding=function(_12f){
if(this.fieldMap==null){
return;
}
var _130=_12f.getAttribute("xdatafld");
var _131=_12f.getAttribute("xdatafld_orig");
if(_131==null||_131==""){
_12f.setAttribute("xdatafld_orig",_130);
_12f.setAttribute("DataField_orig",_130);
}
_130=_12f.getAttribute("xdatafld_orig");
_12f.setAttribute("ColumnName",_130);
if(typeof (this.fieldMap[_130])!="undefined"){
_12f.setAttribute("xdatafld",this.fieldMap[_130]);
_12f.setAttribute("DataField",this.fieldMap[_130]);
}
this.formatBinding(_12f,"CssStyle");
this.formatBinding(_12f,"ClassName");
this.formatBinding(_12f,"Value");
};
nitobi.grid.Grid.prototype.formatBinding=function(_132,_133){
var _134=_132.getAttribute(_133);
var _135=_132.getAttribute(_133+"_orig");
if(_134==null||_134==""){
return;
}
if(_135==null||_135==""){
_132.setAttribute(_133+"_orig",_134);
}
_134=_132.getAttribute(_133+"_orig");
var _136=_134;
var re=new RegExp("\\{.[^}]*}","gi");
var _138=_134.match(re);
if(_138==null){
return;
}
for(var i=0;i<_138.length;i++){
var _13a=_138[i];
var _13b=_13a;
var _13c=new RegExp("\\$.*?[^0-9a-zA-Z_]","gi");
var _13d=_13b.match(_13c);
for(var j=0;j<_13d.length;j++){
var _13f=_13d[j].substring(0,_13d[j].length-1);
var _140=_13f.substring(1);
var _141=this.fieldMap[_140];
_13b=_13b.replace(_13f,"<xsl:value-of select=\""+_141+"\"/>"||"");
}
_13b=_13b.substring(1,_13b.length-1);
_134=_134.replace(_13a,_13b).replace(/\{\}/g,"");
}
_132.setAttribute(_133,_134);
};
nitobi.grid.Grid.prototype.defineColumnsCollection=function(cols){
var xDec=this.model.selectSingleNode("state/nitobi.grid.Columns");
var _144=xDec.childNodes;
var _145=this.model.selectSingleNode("/state/Defaults/nitobi.grid.Column");
for(var i=0;i<cols;i++){
var e=_145.cloneNode(true);
xDec.appendChild(e);
e.setAttribute("xi",i);
e.setAttribute("title",(i>25?String.fromCharCode(Math.floor(i/26)+65):"")+(String.fromCharCode(i%26+65)));
}
this.setColumnCount(cols);
var _144=xDec.selectNodes("*");
return _144;
};
nitobi.grid.Grid.prototype.resetColumns=function(){
this.fire("BeforeClearColumns");
this.inferredColumns=true;
this.columnsDefined=false;
var _148=this.model.selectSingleNode("state/nitobi.grid.Columns");
var xDec=this.model.createElement("nitobi.grid.Columns");
if(_148==null){
this.model.documentElement.appendChild(xDec);
}else{
this.model.documentElement.replaceChild(xDec,_148);
}
this.setColumnCount(0);
this.fire("AfterClearColumns");
};
nitobi.grid.Grid.prototype.renderColumns=function(){
if(this.getColumnDefinitions().length>0){
this.clearHeader();
this.renderHeader();
}
};
nitobi.grid.Grid.prototype.initializeScroller=function(){
this.Scroller.initialize(this,this.getWidth(),this.getHeight(),this.gettop(),this.getright(),this.getbottom(),this.getleft(),this.getcontentWidth(),this.getcontentHeight(),this.getDisplayedRowCount(),this.getColumnCount(),this.getfreezetop(),this.getFrozenLeftColumnCount(),this.getfreezebottom(),this.getfreezeright());
this.Scroller.alignSurfaces();
};
nitobi.grid.Grid.prototype.initializeSelection=function(){
this.Selection=new nitobi.grid.Selection(this);
};
nitobi.grid.Grid.prototype.calculateHeight=function(_14a,end){
_14a=(_14a!=null)?_14a:0;
var _14c=this.getDisplayedRowCount();
end=(end!=null)?end:_14c-1;
return (end-_14a+1)*(this.getRowHeight()||23);
};
nitobi.grid.Grid.prototype.editorDataReady=function(_14d){
var _14e=_14d.getAttribute("DisplayFields").split("|");
var _14f=_14d.getAttribute("ValueField");
var _150=this.data.getTable(_14d.getAttribute("DatasourceId"));
var _151=_14d.getAttribute("Initial");
if(_151==""){
var _152=_14d.getAttribute("type").toLowerCase();
switch(_152){
case "checkbox":
case "listbox":
var _153=_150.fieldMap[_14f].substring(1);
var data=_150.getDataXmlDoc();
if(data!=null){
var val=data.selectSingleNode("//"+nitobi.xml.nsPrefix+"e[@"+_153+"='"+_151+"']");
if(val==null){
var _156=data.selectSingleNode("//"+nitobi.xml.nsPrefix+"e");
if(_156!=null){
_151=_156.getAttribute(_153);
}
}
}
break;
}
_14d.setAttribute("Initial",_151);
}
if((_14e.length==1&&_14e[0]=="")&&(_14f==null||_14f=="")){
for(var item in _150.fieldMap){
_14e[0]=_150.fieldMap[item].substring(1);
break;
}
}else{
for(var i=0;i<_14e.length;i++){
_14e[i]=_150.fieldMap[_14e[i]].substring(1);
}
}
var _159=_14e.join("|");
if(_14f==null||_14f==""){
_14f=_14e[0];
}else{
_14f=_150.fieldMap[_14f].substring(1);
}
_14d.setAttribute("DisplayFields",_159);
_14d.setAttribute("ValueField",_14f);
};
nitobi.grid.Grid.prototype.headerClicked=function(_15a){
var _15b=this.getColumnObject(_15a);
var _15c=new nitobi.grid.OnHeaderClickEventArgs(this,_15b);
if(!this.fire("HeaderClick",_15c)||!nitobi.event.evaluate(_15b.getOnHeaderClickEvent(),_15c)){
return;
}
if(this.getSortEnabled()){
this.sort(_15a);
}
};
nitobi.grid.Grid.prototype.addFilter=function(){
this.dataTable.addFilter(arguments);
};
nitobi.grid.Grid.prototype.clearFilter=function(){
this.dataTable.clearFilter();
};
nitobi.grid.Grid.prototype.setSortStyle=function(_15d,_15e,_15f){
var _160=this.getColumnObject(_15d);
if(_15f){
this.sortColumn=null;
this.sortColumnCell=null;
this.Scroller.view.midcenter.setSort(_15d,"");
this.setColumnHeaderSortOrder(_15d,"");
}else{
_160.setSortDirection(_15e);
this.setColumnHeaderSortOrder(_15d,_15e);
var _161=_160.getHeaderElement();
this.sortColumn=_160;
this.sortColumnCell=_161;
this.Scroller.view.midcenter.setSort(_15d,_15e);
}
};
nitobi.grid.Grid.prototype.sort=function(_162,_163){
var _164=this.getColumnObject(_162);
if(_164==null||!_164.isSortEnabled()){
return;
}
var _165=new nitobi.grid.OnBeforeSortEventArgs(this,_164);
if(!this.fire("BeforeSort",_165)||!nitobi.event.evaluate(_164.getOnBeforeSortEvent(),_165)){
return;
}
this.startMouseWait();
if(_163==null||typeof (_163)=="undefined"){
_163=(_164.getSortDirection()=="Asc")?"Desc":"Asc";
}
this.setSortStyle(_162,_163);
var _166=_164.getColumnName();
var _167=_164.getDataType();
var _168=this.getSortMode()=="local"||(this.getDataMode()=="local"&&this.getSortMode()!="remote");
this.datatable.sort(_166,_163,_167,_168);
if(!_168){
this.datatable.flush();
}
this.clearSurfaces();
this.scrollVertical(0);
if(!_168){
this.loadDataPage(0);
}
this.stopMouseWait();
this.subscribeOnce("HtmlReady",this.handleAfterSort,this,[_164]);
};
nitobi.grid.Grid.prototype.handleAfterSort=function(_169){
var _16a=new nitobi.grid.OnAfterSortEventArgs(this,_169);
this.fire("AfterSort",_16a);
nitobi.event.evaluate(_169.getOnAfterSortEvent(),_16a);
};
nitobi.grid.Grid.prototype.handleDblClick=function(evt){
var cell=new nitobi.grid.Cell(this,this.activeCell);
var _16d=new nitobi.grid.OnCellDblClickEventArgs(this,cell);
return this.fire("CellDblClick",_16d)&&nitobi.event.evaluate(cell.getColumnObject().getOnCellDblClickEvent(),_16d);
};
nitobi.grid.Grid.prototype.clearData=function(){
if(this.getDataMode()!="local"){
this.datatable.flush();
}
};
nitobi.grid.Grid.prototype.clearColumnHeaderSortOrder=function(){
if(this.sortColumn){
var _16e=this.sortColumn;
var _16f=_16e.getHeaderElement();
var css=_16f.className;
css=css.replace(/ascending/gi,"").replace(/descending/gi,"");
_16f.className=css;
this.sortColumn=null;
}
};
nitobi.grid.Grid.prototype.setColumnHeaderSortOrder=function(_171,_172){
this.clearColumnHeaderSortOrder();
var _173=this.getColumnObject(_171);
var _174=_173.getHeaderElement();
var css=_174.className;
if(_172==""){
css=css.replace(/ascending/gi,"").replace(/descending/gi,"");
_172="Desc";
}else{
var _176=(_172=="Desc"?"descending":"ascending");
if(css.indexOf("ebacolumnindicator")!=-1){
css=css.replace(/ebacolumnindicator/gi,"ebacolumnindicator"+_176);
}
}
_173.setSortDirection(_172);
_174.className=css;
this.sortColumn=_173;
this.sortColumnCell=_174;
};
nitobi.grid.Grid.prototype.startMouseWait=function(){
this.mouseWait=document.getElementById("ebamousewait_"+this.uid);
if(this.mouseWait==null){
this.mouseWait=document.createElement("div");
this.mouseWait.id="ebamousewait_"+this.uid;
this.mouseWait.className="ebamousewait";
document.body.appendChild(this.mouseWait);
}
this.mouseWait.style.display="block";
if(nitobi.browser.IE){
nitobi.drawing.align(this.mouseWait,this.element,nitobi.drawing.align.SAMEHEIGHT|nitobi.drawing.align.SAMEWIDTH|nitobi.drawing.align.ALIGNTOP|nitobi.drawing.align.ALIGNLEFT);
}else{
this.mouseWait.style.height=this.getHeight()+20;
this.mouseWait.style.width=this.getWidth();
this.mouseWait.style.top=this.UiContainer.getBoundingClientRect().top-2;
this.mouseWait.style.left=this.UiContainer.getBoundingClientRect().left;
}
};
nitobi.grid.Grid.prototype.stopMouseWait=function(){
if(this.mouseWait!=null&&typeof (this.mouseWait)!="undefined"){
this.mouseWait.style.top="-1000";
this.mouseWait.style.left="-1000";
this.mouseWait.style.display="none";
}
};
nitobi.grid.Grid.prototype.initializeState=function(){
};
nitobi.grid.Grid.prototype.mapToHtml=function(_177){
if(_177==null){
_177=this.UiContainer;
}
this.Scroller.mapToHtml(_177);
this.element=document.getElementById("grid"+this.uid);
this.element.jsObject=this;
};
nitobi.grid.Grid.prototype.initScroller=function(){
};
nitobi.grid.Grid.prototype.generateCss=function(){
this.generateFrameCss();
};
nitobi.grid.Grid.prototype.generateColumnCss=function(){
this.generateCss();
};
nitobi.grid.Grid.prototype.generateFrameCss=function(){
if(this.stylesheet==null){
this.stylesheet=document.createStyleSheet();
}
var _178=nitobi.xml.transformToString(this.model,this.frameCssXslProc);
var vp=this.getScrollSurface();
var _17a=0;
var _17b=0;
if(vp!=null){
_17a=vp.scrollTop;
_17b=vp.scrollLeft;
}
if(this.oldFrameCss!=_178){
this.oldFrameCss=_178;
this.stylesheet.cssText=_178;
if(vp!=null){
if(nitobi.browser.MOZ){
this.scrollVerticalRelative(_17a);
this.scrollHorizontalRelative(_17b);
}
vp.style.top="0px";
vp.style.left="0px";
}
}
if(nitobi.grid.RowHoverColor==null){
var _17c=nitobi.html.getClass("ebarowhover");
if(_17c!=null){
var _17d=_17c.backgroundColor.toString();
if(_17d.indexOf("rgb")>-1){
_17d=eval("nitobi.drawing."+_17d);
}
nitobi.grid.RowHoverColor=_17d;
}
}
if(nitobi.grid.CellHoverColor==null){
var _17c=nitobi.html.getClass("ebacellhover");
if(_17c!=null){
var _17d=_17c.backgroundColor.toString();
if(_17d.indexOf("rgb")>-1){
_17d=eval("nitobi.drawing."+_17d);
}
nitobi.grid.CellHoverColor=_17d;
}
}
};
nitobi.grid.Grid.prototype.clearSurfaces=function(){
this.Selection.clearBoxes();
this.Scroller.clearSurfaces();
};
nitobi.grid.Grid.prototype.clearHeader=function(){
this.Scroller.clearSurfaces(false,true);
};
nitobi.grid.Grid.prototype.renderFrame=function(){
this.UiContainer.innerHTML=nitobi.xml.transformToString(this.model,this.frameXslProc);
this.attachDomEvents();
this.frameRendered=true;
this.fire("AfterFrameRender");
};
nitobi.grid.Grid.prototype.renderHeader=function(){
var _17e=0;
endRow=this.getfreezetop()-1;
this.Scroller.view.topleft.surface.element.innerHTML="";
this.Scroller.view.topleft.top=this.getHeaderHeight();
this.Scroller.view.topleft.left=0;
this.Scroller.view.topleft.rowRenderer=this.TopLeftRenderer;
this.Scroller.view.topleft.renderGap(_17e,endRow,false,"*");
this.Scroller.view.topcenter.surface.element.innerHTML="";
this.Scroller.view.topcenter.top=this.getHeaderHeight();
this.Scroller.view.topcenter.left=0;
this.Scroller.view.topcenter.rowRenderer=this.TopCenterRenderer;
this.Scroller.view.topcenter.renderGap(_17e,endRow,false);
};
nitobi.grid.Grid.prototype.renderFooter=function(){
};
nitobi.grid.Grid.prototype.renderMiddle=function(){
this.Scroller.view.midleft.flushCache();
this.Scroller.view.midcenter.flushCache();
};
nitobi.grid.Grid.prototype.refresh=function(){
var _17f=null;
if(!this.fire("BeforeRefresh",_17f)){
return;
}
this.clear();
this.syncWithData();
this.subscribeOnce("HtmlReady",this.handleAfterRefresh,this);
};
nitobi.grid.Grid.prototype.handleAfterRefresh=function(){
var _180=null;
this.fire("AfterRefresh",_180);
};
nitobi.grid.Grid.prototype.clear=function(){
this.selectedRows=[];
this.clearData();
this.clearSurfaces();
};
nitobi.grid.Grid.prototype.handleContextMenu=function(evt,obj){
var _183=this.getOnContextMenuEvent();
if(_183==null){
return true;
}else{
if(this.fire("ContextMenu")){
return true;
}else{
evt.cancelBubble=true;
evt.returnValue=false;
return false;
}
}
};
nitobi.grid.Grid.prototype.handleKey=function(evt,obj){
var k=evt.keyCode;
k=k+(evt.shiftKey?256:0)+(evt.ctrlKey?512:0);
switch(k){
case 529:
break;
case 35:
break;
case 36:
break;
case 547:
break;
case 548:
break;
case 34:
this.page(1);
break;
case 33:
this.page(-1);
break;
case 45:
this.insertAfterCurrentRow();
break;
case 46:
this.deleteCurrentRow();
break;
case 292:
this.selectHome();
break;
case 290:
this.pageSelect(1);
break;
case 289:
this.pageSelect(-1);
break;
case 296:
this.reselect(0,1);
break;
case 294:
this.reselect(0,-1);
break;
case 293:
this.reselect(-1,0);
break;
case 295:
this.reselect(1,0);
break;
case 577:
break;
case 579:
case 557:
this.copy(evt);
return true;
break;
case 600:
case 302:
break;
case 598:
case 301:
this.paste(evt);
return true;
break;
default:
if(this.Scroller.activeView!=null){
this.Scroller.activeView.handleKey(evt);
}
}
nitobi.html.cancelEvent(evt);
return false;
};
nitobi.grid.Grid.prototype.reselect=function(x,y){
var S=this.Selection;
var row=nitobi.grid.Cell.getRowNumber(S.endCell)+y;
var _18b=nitobi.grid.Cell.getColumnNumber(S.endCell)+x;
if(_18b>=0&&_18b<=this.columnCount()&&row>=0){
var _18c=this.getCellElement(row,_18b);
S.changeEndCellWithDomNode(_18c);
S.alignBoxes();
}
};
nitobi.grid.Grid.prototype.pageSelect=function(dir){
};
nitobi.grid.Grid.prototype.selectHome=function(){
var S=this.Selection;
var row=nitobi.grid.Cell.getRowNumber(S.endCell);
this.reselect(0,-row);
};
nitobi.grid.Grid.prototype.edit=function(e){
var evt=(nitobi.browser.IE)?event:e;
var cell=new nitobi.grid.Cell(this,this.activeCell);
var _193=new nitobi.grid.OnBeforeCellEditEventArgs(this,cell);
if(!this.fire("BeforeCellEdit",_193)||!nitobi.event.evaluate(cell.getColumnObject().getOnBeforeCellEditEvent(),_193)){
return;
}
var _194=null;
var _195=null;
var ctrl=null;
if(evt){
_194=evt.keyCode||null;
_195=evt.shiftKey||null;
ctrl=evt.ctrlKey||null;
}
var _197="";
var _198=null;
if((_195&&(_194>64)&&(_194<91))||(!_195&&((_194>47)&&(_194<58)))){
_198=0;
}
if(!_195){
if((_194>64)&&(_194<91)){
_198=32;
}else{
if(_194>95&&_194<106){
_198=-48;
}else{
if((_194==189)||(_194==109)){
_197="-";
}else{
if((_194>186)&&(_194<188)){
_198=-126;
}
}
}
}
}else{
}
if(_198!=null){
_197=String.fromCharCode(_194+_198);
}
if((!ctrl)&&(""!=_197)||(_194==113)||(_194==0)||(_194==null)||(_194==32)){
this.cellEditor=nitobi.form.ControlFactory.instance.getEditor(this,cell.getColumnObject());
if(this.cellEditor==null){
return;
}
this.cellEditor.setEditCompleteHandler(this.editComplete);
this.cellEditor.bind(this,cell,_197);
this.cellEditor.mimic();
return false;
}else{
return;
}
};
nitobi.grid.Grid.prototype.editComplete=function(_199){
var cell=_199.cell;
var _19b=cell.getColumnObject();
var _19c=_199.databaseValue;
var _19d=_199.displayValue;
var _19e=new nitobi.grid.OnCellValidateEventArgs(this,cell,_19c,cell.getValue());
if(!this.fire("CellValidate",_19e)||!nitobi.event.evaluate(_19b.getOnCellValidateEvent(),_19e)){
return false;
}
cell.setValue(_19c,_19d);
_199.editor.hide();
var _19f=new nitobi.grid.OnAfterCellEditEventArgs(this,cell);
this.fire("AfterCellEdit",_19f);
nitobi.event.evaluate(_19b.getOnAfterCellEditEvent(),_19f);
this.focus();
};
nitobi.grid.Grid.prototype.autoSave=function(){
if(this.isAutoSaveEnabled()){
return this.save();
}
return false;
};
nitobi.grid.Grid.prototype.selectCellByCoords=function(row,_1a1){
this.setPosition(row,_1a1);
};
nitobi.grid.Grid.prototype.setPosition=function(row,_1a3){
if(row>=0&&_1a3>=0){
var avp=this.Scroller.getViewportByCoords(row,_1a3);
if(avp!=null){
avp.ViewNavigator.DomNode=avp.container;
avp.ViewNavigator.view=avp;
avp.ViewNavigator.setPosition(row,_1a3);
this.Scroller.activeView=avp;
this.setActiveCell(this.getCellElement(row,_1a3));
}
}
};
nitobi.grid.Grid.prototype.save=function(){
if(this.datatable.log.selectNodes("//"+nitobi.xml.nsPrefix+"data/*").length==0){
return;
}
if(!this.fire("BeforeSave")){
return;
}
this.datatable.save(nitobi.lang.close(this,this.saveCompleteHandler),this.getOnBeforeSaveEvent());
};
nitobi.grid.Grid.prototype.saveCompleteHandler=function(_1a5){
if(this.getDataSource().getHandlerError()){
this.fire("HandlerError",_1a5);
}
this.fire("AfterSave",_1a5);
};
nitobi.grid.Grid.prototype.activate=function(e){
var evt=(nitobi.browser.IE)?event:e;
var _1a8=new nitobi.grid.OnCellBlurEventArgs(this,this.activeCellObject);
this.fire("CellBlur",_1a8);
if(this.activeColumnObject){
nitobi.event.evaluate(this.activeColumnObject.getOnCellBlurEvent(),_1a8);
}
this.activeCell=this.Scroller.activeView.activeCell;
this.activeCellObject=this.getSelectedCellObject();
this.activeColumnObject=this.activeCellObject.getColumnObject();
var _1a9=this.activeCell;
this.fire("CellFocus",_1a9);
if(this.activeColumnObject){
nitobi.event.evaluate(this.activeColumnObject.getOnCellFocusEvent(),_1a9);
}
if(("click"==evt.type)||("mousedown"==evt.type)){
var _1aa=new nitobi.grid.OnCellClickEventArgs(this,this.activeCellObject);
this.fire("CellClick",_1aa);
if(this.activeColumnObject){
nitobi.event.evaluate(this.activeColumnObject.getOnCellClickEvent(),_1aa);
}
}
};
nitobi.grid.Grid.prototype.focus=function(){
try{
nitobi.html.getFirstChild(this.UiContainer).focus();
this.fire("Focus");
}
catch(e){
}
};
nitobi.grid.Grid.prototype.getRendererForColumn=function(col){
var _1ac=this.getColumnCount();
if(col>=_1ac){
col=_1ac-1;
}
var _1ad=this.getFrozenLeftColumnCount();
if(col<frozenLeft){
return this.MidLeftRenderer;
}else{
return this.MidCenterRenderer;
}
};
nitobi.grid.Grid.prototype.getColumnOuterTemplate=function(col){
return this.getRendererForColumn(col).xmlTemplate.selectSingleNode("//*[@match='ntb:e']/div/div["+col+"]");
};
nitobi.grid.Grid.prototype.getColumnInnerTemplate=function(col){
return this.getColumnOuterXslTemplate(col).selectSingleNode("*[2]");
};
nitobi.grid.Grid.prototype.makeXSL=function(){
var fL=this.getFrozenLeftColumnCount();
var fR=this.getfreezeright();
var cs=this.getColumnCount();
var rh=this.isRowHighlightEnabled();
var _1b4="_default";
if(this.datatable!=null){
_1b4=this.datatable.id;
}
var _1b5=0;
var _1b6=fL;
var sXml=nitobi.xml.serialize(this.model.selectSingleNode("state/nitobi.grid.Columns")).replace(/\#\&lt\;\#/g,"#<#").replace(/\#\&gt\;\#/g,"#>#").replace(/\&/g,"&amp;").replace(/\#<\#/g,"&lt;").replace(/\#>\#/g,"&gt;");
sXml=sXml.replace(/(\&amp;lt;xsl\:)(.*?)(\/&amp;gt;)/g,function(){
return "&lt;xsl:"+arguments[2].replace(/\&amp;/g,"&")+"/&gt;";
});
var _1b8=nitobi.xml.createXmlDoc(sXml);
this.TopLeftRenderer.generateXslTemplate(_1b8,this.rowXslGeneratorXslProc,_1b5,_1b6,this.isColumnIndicatorsEnabled(),this.isRowIndicatorsEnabled(),rh);
this.TopLeftRenderer.dataTableId=_1b4;
_1b5=fL;
_1b6=cs-fR-fL;
this.TopCenterRenderer.generateXslTemplate(_1b8,this.rowXslGeneratorXslProc,_1b5,_1b6,this.isColumnIndicatorsEnabled(),this.isRowIndicatorsEnabled(),rh);
this.TopCenterRenderer.dataTableId=_1b4;
this.MidLeftRenderer.generateXslTemplate(_1b8,this.rowXslGeneratorXslProc,0,fL,0,this.isRowIndicatorsEnabled(),rh);
this.MidLeftRenderer.dataTableId=_1b4;
this.MidCenterRenderer.generateXslTemplate(_1b8,this.rowXslGeneratorXslProc,fL,cs-fR-fL,0,0,rh);
this.MidCenterRenderer.dataTableId=_1b4;
this.fire("AfterMakeXsl");
};
nitobi.grid.Grid.prototype.render=function(){
this.generateCss();
this.updateCellRanges();
return;
this.Scroller.alignSurfaces();
this.Selection=new nitobi.grid.Selection(this);
this.stopMouseWait();
};
nitobi.grid.Grid.prototype.refilter=nitobi.grid.Grid.prototype.render;
nitobi.grid.Grid.prototype.getColumnDefinitions=function(){
return this.model.selectNodes("state/nitobi.grid.Columns/*");
};
nitobi.grid.Grid.prototype.initializeModelFromDeclaration=function(){
this.modelInitializerXslProc=nitobi.xml.createXslProcessor(nitobi.grid.modelFromDeclarationInitializerXslProc.stylesheet);
eval(nitobi.xml.transformToString(this.Interface,this.modelInitializerXslProc));
this.model.documentElement.setAttribute("ID",this.uid);
this.model.documentElement.setAttribute("uniqueID",this.uid);
};
nitobi.grid.Grid.prototype.initializeDataTable=function(){
};
nitobi.grid.Grid.prototype.setModelDefaults=function(_1b9,_1ba,_1bb){
var _1bc=this.API.selectNodes(_1bb);
for(var j=0;j<_1bc.length;j++){
var _1be=_1bc[j].getAttribute("htmltag")+"";
var _1bf=_1bc[j].getAttribute("name")+"";
var _1c0=_1ba.getAttribute(_1be)||_1ba.getAttribute(_1bf);
var _1c1=_1bc[j].getAttribute("default").replace(/\"/g,"");
_1c0=_1c0?_1c0:_1c1;
if(_1bc[j].getAttribute("type")=="bool"){
_1c0=nitobi.lang.boolToStr(nitobi.lang.toBool(_1c0));
}
_1b9.setAttribute(_1bc[j].getAttribute("name"),_1c0?_1c0:_1c1);
}
};
nitobi.grid.Grid.prototype.getNewRecordKey=function(){
var _1c2;
var key;
var _1c4;
do{
_1c2=new Date();
key=(_1c2.getTime()+"."+Math.round(Math.random()*99));
_1c4=this.datatable.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"e[@xk = '"+key+"']");
}while(_1c4!=null);
return key;
};
nitobi.grid.Grid.prototype.insertAfterCurrentRow=function(){
if(this.activeCell){
var _1c5=nitobi.grid.Cell.getRowNumber(this.activeCell);
this.insertRow(_1c5+1);
}else{
this.insertRow();
}
};
nitobi.grid.Grid.prototype.insertRow=function(_1c6){
var rows=parseInt(this.getDisplayedRowCount());
var xi=0;
if(_1c6!=null){
xi=parseInt((_1c6==null?rows:parseInt(_1c6)));
}
var _1c9=new nitobi.grid.OnBeforeRowInsertEventArgs(this,this.getRowObject(xi-1));
if(!this.isRowInsertEnabled()||!this.fire("BeforeRowInsert",_1c9)){
return;
}
var _1ca=this.datatable.getTemplateNode();
for(var i=0;i<this.columnCount();i++){
var _1cc=this.getColumnObject(i);
var _1cd=_1cc.getInitial();
if(_1cd==null||_1cd==""){
var _1ce=_1cc.getDataType();
if(_1ce==null||_1ce==""){
_1ce="text";
}
switch(_1ce){
case "text":
_1cd="";
break;
case "number":
_1cd=0;
break;
case "date":
_1cd="1900-01-01";
break;
}
}
var att=_1cc.getxdatafld().substr(1);
if(att!=null&&att!=""){
_1ca.setAttribute(att,_1cd);
}
}
this.clearSurfaces();
this.datatable.createRecord(_1ca,xi);
this.subscribeOnce("HtmlReady",this.handleAfterRowInsert,this,[xi]);
};
nitobi.grid.Grid.prototype.handleAfterRowInsert=function(xi){
this.fire("AfterRowInsert",new nitobi.grid.OnAfterRowInsertEventArgs(this,this.getRowObject(xi)));
};
nitobi.grid.Grid.prototype.deleteCurrentRow=function(){
if(this.activeCell){
this.deleteRow(nitobi.grid.Cell.getRowNumber(this.activeCell));
}else{
alert("First select a record to delete.");
}
};
nitobi.grid.Grid.prototype.deleteRow=function(_1d1){
var _1d2=new nitobi.grid.OnBeforeRowDeleteEventArgs(this,this.getRowObject(_1d1));
if(!this.isRowDeleteEnabled()||!this.fire("BeforeRowDelete",_1d2)){
return;
}
this.clearSurfaces();
var rows=this.getDisplayedRowCount();
var xi=rows-1;
this.datatable.deleteRecord(_1d1);
rows--;
this.subscribeOnce("HtmlReady",this.handleAfterRowDelete,this,[_1d1]);
};
nitobi.grid.Grid.prototype.handleAfterRowDelete=function(xi){
this.fire("AfterRowDelete",new nitobi.grid.OnBeforeRowDeleteEventArgs(this,this.getRowObject(xi)));
};
nitobi.grid.Grid.prototype.onNextPage=function(){
this.loadNextDataPage();
};
nitobi.grid.Grid.prototype.page=function(dir){
};
nitobi.grid.Grid.prototype.selectionMoved=function(h,v){
eval(this.onMove);
};
nitobi.grid.Grid.prototype.move=function(h,v){
if(this.Scroller.activeView!=null){
this.Scroller.activeView.ViewNavigator.blockNavigator.move(h,v);
}
};
nitobi.grid.Grid.prototype.loadNextDataPage=function(){
this.loadDataPage(this.getCurrentPageIndex()+1);
};
nitobi.grid.Grid.prototype.onPreviousPage=function(){
this.loadPreviousDataPage();
};
nitobi.grid.Grid.prototype.loadPreviousDataPage=function(){
this.loadDataPage(this.getCurrentPageIndex()-1);
};
nitobi.grid.Grid.prototype.GetPage=function(_1db){
ebaErrorReport("GetPage is deprecated please use loadDataPage instead","",EBA_DEBUG);
this.loadDataPage(_1db);
};
nitobi.grid.Grid.prototype.loadDataPage=function(_1dc){
};
nitobi.grid.Grid.prototype.getSelectedRow=function(rel){
try{
var nRow=-1;
var AC=this.activeCell;
if(AC!=null){
nRow=nitobi.grid.Cell.getRowNumber(AC);
if(rel){
nRow-=this.getfreezetop();
}
}
return nRow;
}
catch(err){
_ntbAssert(false,err.message);
}
};
nitobi.grid.Grid.prototype.handleHandlerError=function(){
var _1e0=this.getDataSource().getHandlerError();
if(_1e0){
this.fire("HandlerError");
}
};
nitobi.grid.Grid.prototype.getRowObject=function(_1e1,_1e2){
var _1e3=_1e2;
if(_1e2==null&&_1e1!=null){
_1e3=_1e1;
}
return new nitobi.grid.Row(this,_1e3);
};
nitobi.grid.Grid.prototype.getSelectedColumn=function(rel){
try{
var nCol=-1;
var AC=this.activeCell;
if(AC!=null){
nCol=parseInt(AC.getAttribute("col"));
if(rel){
nCol-=this.getFrozenLeftColumnCount();
}
}
return nCol;
}
catch(err){
_ntbAssert(false,err.message);
}
};
nitobi.grid.Grid.prototype.getSelectedColumnObject=function(){
return this.getColumnObject(this.getSelectedColumn());
};
nitobi.grid.Grid.prototype.columnCount=function(){
try{
var _1e7=this.getColumnDefinitions();
return _1e7.length;
}
catch(err){
_ntbAssert(false,err.message);
}
};
nitobi.grid.Grid.prototype.getCellObject=function(row,col){
if(typeof (col)=="string"){
var node=this.model.selectSingleNode("state/nitobi.grid.Columns/nitobi.grid.Column[@xdatafld_orig='"+col+"']");
if(node!=null){
col=parseInt(node.getAttribute("xi"));
}
}
var cell=new nitobi.grid.Cell(this,row,col);
return cell;
};
nitobi.grid.Grid.prototype.getCellText=function(row,col){
return this.getCellObject(row,col).getHtml();
};
nitobi.grid.Grid.prototype.getCellValue=function(row,col){
return this.getCellObject(row,col).getValue();
};
nitobi.grid.Grid.prototype.getCellElement=function(row,_1f1){
return document.getElementById("cell_"+row+"_"+_1f1+"_"+this.uid);
};
nitobi.grid.Grid.prototype.getSelectedRowObject=function(xi){
var obj=null;
if(this.Scroller.activeView!=null){
var r=nitobi.grid.Cell.getRowNumber(this.Scroller.activeView.activeCell);
obj=new nitobi.grid.Row(this,r);
}
return obj;
};
nitobi.grid.Grid.prototype.getColumnObject=function(_1f5){
var _1f6=null;
if(_1f5>=0){
_1f6=this.columns[_1f5];
if(_1f6==null){
var _1f7=this.getColumnDefinitions()[_1f5].getAttribute("DataType");
switch(_1f7){
case "number":
_1f6=new nitobi.grid.NumberColumn(this,_1f5);
break;
case "date":
_1f6=new nitobi.grid.DateColumn(this,_1f5);
break;
default:
_1f6=new nitobi.grid.TextColumn(this,_1f5);
break;
}
this.columns[_1f5]=_1f6;
}
}
if(_1f6.ModelNode==null){
return null;
}else{
return _1f6;
}
};
nitobi.grid.Grid.prototype.getSelectedCellObject=function(){
var obj=null;
if(this.Scroller.activeView!=null){
var _1f9=this.activeCell;
if(_1f9!=null){
var r=nitobi.grid.Cell.getRowNumber(_1f9);
var c=nitobi.grid.Cell.getColumnNumber(_1f9);
obj=this.getCellObject(r,c);
}
}
return obj;
};
nitobi.grid.Grid.prototype.autoAddRow=function(){
if(this.activeCell.innerText.replace(/\s/g,"")!=""&&this.autoAdd){
this.deactivateCell();
if(this.active=="Y"){
this.freezeCell();
}
eval(this.getOnRowBlurEvent());
this.insertRow();
this.go("HOME");
this.editCell();
}
};
nitobi.grid.Grid.prototype.setDisplayedRowCount=function(_1fc){
if(this.Scroller){
this.Scroller.view.midcenter.rows=_1fc;
this.Scroller.view.midleft.rows=_1fc;
}
this.displayedRowCount=_1fc;
};
nitobi.grid.Grid.prototype.incrementDisplayedRowCount=function(_1fd){
this.setDisplayedRowCount(this.getDisplayedRowCount()+(_1fd||1));
this.updateCellRanges();
};
nitobi.grid.Grid.prototype.decrementDisplayedRowCount=function(_1fe){
this.setDisplayedRowCount(this.getDisplayedRowCount()-(_1fe||1));
this.updateCellRanges();
};
nitobi.grid.Grid.prototype.getDisplayedRowCount=function(){
return this.displayedRowCount;
};
nitobi.grid.Grid.prototype.copy=function(){
var _1ff=this.Selection.getCoords();
var data=this.getTableForSelection(_1ff);
var _201=new nitobi.grid.OnCopyEventArgs(this,data,_1ff);
if(!this.isCopyEnabled()||!this.fire("BeforeCopy",_201)){
return;
}
if(!nitobi.browser.IE){
var _202=this.getClipboard();
_202.onkeyup=nitobi.lang.close(this,this.focus);
_202.value=data;
_202.focus();
_202.setSelectionRange(0,_202.value.length);
}
if(nitobi.browser.IE){
window.clipboardData.setData("Text",data);
}
this.fire("AfterCopy",_201);
};
nitobi.grid.Grid.prototype.getTableForSelection=function(_203){
var _204=this.getColumnMap(_203.top.x,_203.bottom.x);
var _205=nitobi.data.FormatConverter.convertEbaXmlToTsv(this.getDataSource().getDataXmlDoc(),_204,_203.top.y,_203.bottom.y);
return _205;
};
nitobi.grid.Grid.prototype.getColumnMap=function(_206,_207){
var _208=this.getColumnDefinitions();
_206=(_206==null)?0:_206;
_207=(_207==null)?_208.length-1:_207;
var map=new Array();
for(var i=_206;i<=_207&&(null!=_208[i]);i++){
map.push(_208[i].getAttribute("xdatafld").substr(1));
}
return map;
};
nitobi.grid.Grid.prototype.paste=function(){
if(!this.isPasteEnabled()){
return;
}
var _20b=this.getClipboard();
_20b.onkeyup=nitobi.lang.close(this,this.pasteDataReady,[_20b]);
_20b.focus();
return _20b;
};
nitobi.grid.Grid.prototype.pasteDataReady=function(_20c){
_20c.onkeyup=null;
var _20d=this.Selection;
var _20e=_20d.getCoords();
var _20f=_20e.top.x;
var _210=_20f+nitobi.data.FormatConverter.getDataColumns(_20c.value)-1;
var _211=true;
for(var i=_20f;i<=_210;i++){
var _213=this.getColumnObject(i);
if(_213){
if(!_213.isEditable()){
_211=false;
break;
}
}
}
if(!_211){
alert("Paste Failed: A column you are attempting to paste into is read-only.");
return;
}else{
var _214=this.getColumnMap(_20f,_210);
var _215=_20e.top.y;
var _216=Math.max(_215+nitobi.data.FormatConverter.getDataRows(_20c.value)-1,0);
this.getSelection().selectWithCoords(_215,_20f,_216,_20f+_214.length-1);
var _217=new nitobi.grid.OnPasteEventArgs(this,_20c.value,_20e);

if(!this.fire("BeforePaste",_217)){
return;
}
var _218=_20c.value;
var _219=null;
if(_218.substr(0,1)=="<"){
_219=nitobi.data.FormatConverter.convertHtmlTableToEbaXml(_218,_214,_215);
}else{
_219=nitobi.data.FormatConverter.convertTsvToEbaXml(_218,_214,_215);
}
if(_219.documentElement!=null){
this.datatable.mergeFromXml(_219,nitobi.lang.close(this,this.pasteComplete,[_219,_215,_216,_217]));
}
}
};
nitobi.grid.Grid.prototype.pasteComplete=function(_21a,_21b,_21c,_21d){
this.Scroller.reRender(_21b,_21c);
this.subscribeOnce("HtmlReady",this.handleAfterPaste,this,[_21d]);
};
nitobi.grid.Grid.prototype.handleAfterPaste=function(_21e){
this.fire("AfterPaste",_21e);
};
nitobi.grid.Grid.prototype.getClipboard=function(){
var _21f=document.getElementById(this.uid+"_ebaclipboard");
if(!_21f){
_21f=document.createElement("textarea");
_21f.name=this.uid+"_ebaclipboard";
_21f.id=this.uid+"_ebaclipboard";
_21f.style.position="absolute";
_21f.style.top=(-500)+"px";
_21f.style.left=(-500)+"px";
_21f.width=100;
_21f.height=100;
document.body.appendChild(_21f);
}
_21f.onkeyup=null;
_21f.value="";
return _21f;
};
nitobi.grid.Grid.prototype.handleHtmlReady=function(_220){
this.fire("HtmlReady",new nitobi.base.EventArgs(this));
};
nitobi.grid.Grid.prototype.fire=function(evt,args){
return nitobi.event.notify(evt+this.uid,args);
};
nitobi.grid.Grid.prototype.subscribe=function(evt,func,_225){
if(typeof (_225)=="undefined"){
_225=this;
}
return nitobi.event.subscribe(evt+this.uid,nitobi.lang.close(_225,func));
};
nitobi.grid.Grid.prototype.subscribeOnce=function(evt,func,_228,_229){
var guid=null;
var _22b=this;
var _22c=function(){
func.apply(_228||this,_229||[]);
_22b.unsubscribe(evt,guid);
};
guid=this.subscribe(evt,_22c);
};
nitobi.grid.Grid.prototype.unsubscribe=function(evt,guid){
return nitobi.event.unsubscribe(evt+this.uid,guid);
};
nitobi.grid.Grid.prototype.xGET=function(){
var val="";
if(this.model&&this.model.documentElement){
var node=this.model.documentElement.selectSingleNode(arguments[0]);
if(node!=null){
val=node.nodeValue;
}
}
return val;
};
nitobi.grid.Grid.prototype.xSET=function(){
if((arguments[1][0]!=null)&&(this.model)&&(this.model.documentElement)&&(this.model.documentElement.selectSingleNode(arguments[0]))){
var node=this.model.documentElement.selectSingleNode(arguments[0]);
if(typeof (arguments[1][0])=="boolean"){
node.nodeValue=nitobi.lang.boolToStr(arguments[1][0]);
}else{
node.nodeValue=arguments[1][0];
}
}
};
nitobi.grid.Grid.prototype.eSET=function(name,args){
var _234=args[0];
var _235=_234;
var _236=name.substr(2);
_236=_236.substr(0,_236.length-5);
if(typeof (_234)=="string"){
_235=function(){
return nitobi.event.evaluate(_234,arguments[0]);
};
}
if(this[name]!=null){
this.unsubscribe(_236,this[name]);
}
var guid=this.subscribe(_236,_235);
this.jSET(name,[guid]);
return guid;
};
nitobi.grid.Grid.prototype.jSET=function(name,val){
this[name]=val[0];
};
nitobi.grid.Grid.prototype.dispose=function(){
try{
this.element.jsObject=null;
editorXslProc=null;
for(var item in this){
if(this[item]!=null){
if(this[item].dispose instanceof Function){
this[item].dispose();
}
this[item]=null;
}
}
nitobi.form.ControlFactory.instance.dispose();
}
catch(e){
}
};
nitobi.Grid=nitobi.grid.Grid;
nitobi.grid.BlockNavigator=function(_23b){
this.DomNode=_23b;
this.rows=0;
this.columns=0;
this.currentRow=0;
this.currentColumn=0;
this.pathToRow="0/0/";
this.pathToColumn="";
this.pathToCell="/0";
this.getCellObject=function(){
return null;
};
};
nitobi.grid.BlockNavigator.prototype.move=function(h,v){
if(this.viewNavigator!=null){
var hs=1;
var vs=1;
h=(h*hs);
v=(v*vs);
if(this.currentColumn==this.DomNode.left&&h<0){
eval(this.onMovePastLeftEdge);
return;
}else{
if(this.currentColumn==this.DomNode.right-1&&h>0){
eval(this.onMovePastRightEdge);
return;
}else{
if(this.currentRow==this.DomNode.top&&v<0){
eval(this.onMovePastTopEdge);
return;
}else{
if(this.currentRow==this.DomNode.bottom&&v>0){
eval(this.onMovePastBottomEdge);
return;
}else{
if(v==-1&&this.currentRow==0){
return;
}
this.setPosition(this.currentRow+v,this.currentColumn+h,false);
}
}
}
}
eval(this.onMove);
this.showBox();
}
};
nitobi.grid.BlockNavigator.prototype.setPosition=function(row,_241,_242){
this.onBeforeMove?eval(this.onBeforeMove):"";
this.currentRow=row;
this.currentColumn=_241;
this.activeCell=this.viewNavigator.view.owner.getCellElement((row),(_241));
ntbAssert(this.activeCell!=null,"setPosition set acitveCell to null.");
if(_242==null||_242){
this.showBox();
}
};
nitobi.grid.BlockNavigator.prototype.edit=function(e){
var evt=(nitobi.browser.IE)?event:e;
eval(this.onEdit);
};
nitobi.grid.BlockNavigator.prototype.handleKey=function(o,e){
var evt=(nitobi.browser.IE)?event:e;
if(!nitobi.browser.IE){
window.event=evt;
}
var k=evt.keyCode;
var _249=this.activeCell;
k=k+(evt.shiftKey?256:0)+(evt.ctrlKey?512:0);
switch(k){
case 35:
break;
case 36:
break;
case 547:
break;
case 548:
break;
case 13:
var et=this.viewNavigator.view.owner.getEnterTab().toLowerCase();
var _24b=0;
var vert=1;
if(et=="left"){
_24b=-1;
vert=0;
}else{
if(et=="right"){
_24b=1;
vert=0;
}else{
if(et=="down"){
_24b=0;
vert=1;
}else{
if(et=="up"){
_24b=0;
vert=-1;
}
}
}
}
this.move(_24b,vert);
break;
case 40:
this.move(0,1);
break;
case 269:
case 38:
this.move(0,-1);
break;
case 265:
case 37:
this.move(-1,0);
break;
case 9:
case 39:
this.move(1,0);
break;
case 577:
break;
default:
this.edit(e);
}
nitobi.html.cancelBubble(evt);
};
nitobi.grid.BlockNavigator.prototype.activate=function(_24d,_24e){
this.activeCell=_24e;
this.currentRow=nitobi.grid.Cell.getRowNumber(this.activeCell);
this.currentColumn=nitobi.grid.Cell.getColumnNumber(this.activeCell);
this.rows=_24d.rows;
this.columns=_24d.columns;
this.DomNode=_24d;
this.showBox(this.activeCell);
};
nitobi.grid.BlockNavigator.prototype.showBox=function(){
this.viewNavigator.view.owner.Selection.collapse(this.activeCell);
};
nitobi.grid.BlockNavigator.prototype.dispose=function(){
this.DomNode=null;
};
nitobi.grid.Cell=function(grid,row,_251){
if(row==null){
return null;
}
this.Interface=grid.API.selectSingleNode("interfaces/interface[@name='nitobi.grid.Cell']");
eval(nitobi.xml.transformToString(this.Interface,grid.accessorGeneratorXslProc));
this.grid=grid;
var _252=null;
if(typeof (row)=="object"){
var cell=row;
row=Number(cell.getAttribute("xi"));
_251=cell.getAttribute("col");
_252=cell;
}else{
_252=this.grid.getCellElement(row,_251);
}
this.DomNode=_252;
this.row=Number(row);
this.Row=this.row;
this.column=Number(_251);
this.Column=this.column;
this.columnObject=this.grid.getColumnObject(this.Column);
this.dataIndex=this.Row;
var _254=this.grid.datatable;
this.DataNode=_254.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"e[@xi="+this.dataIndex+"]/"+_254.fieldMap[this.columnObject.getColumnName()]);
this.ModelNode=this.grid.model.selectSingleNode("//nitobi.grid.Columns/nitobi.grid.Column[@xi='"+this.column+"']");
};
nitobi.grid.Cell.prototype.setValue=function(_255,_256){
if(_255==this.getValue()){
return;
}
var _257="";
switch(this.columnObject.getType()){
case "PASSWORD":
for(var i=0;i<_255.length;i++){
_257+="*";
}
break;
case "NUMBER":
if(this.numberXsl==null){
this.numberXsl=nitobi.form.numberXslProc.stylesheet;
}
var _259=nitobi.xml.createXmlDoc("<root><number>"+_255+"</number><mask>"+this.columnObject.getMask()+"</mask><group>"+this.columnObject.getGroupingSeparator()+"</group><decimal>"+this.columnObject.getDecimalSeparator()+"</decimal></root>");
_257=nitobi.xml.transformToString(_259,this.numberXsl);
break;
case "DATE":
if(this.dateXsl==null){
this.dateXsl=nitobi.form.dateXslProc.stylesheet;
}
var _259=nitobi.xml.createXmlDoc("<root><date>"+_255+"</date><mask>"+this.columnObject.getMask()+"</mask></root>");
_257=nitobi.xml.transformToString(_259,this.dateXsl);
if(""==_257){
_257=this.DomNode.innerHTML;
_255=this.getValue();
}
break;
case "TEXTAREA":
_257=nitobi.html.encode(_255);
break;
case "LOOKUP":
var _25a=this.getColumnObject();
var _25b=_25a.ModelNode.getAttribute("DatasourceId");
var _25c=this.grid.data.getTable(_25b);
var _25d=_25a.ModelNode.getAttribute("DisplayFields");
var _25e=_25a.ModelNode.getAttribute("ValueField");
var _25f=_25c.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"e[@"+_25e+"='"+_255+"']/@"+_25d);
if(_25f!=null){
_257=_25f.nodeValue;
}else{
_257=_255;
}
break;
case "CHECKBOX":
var _25a=this.getColumnObject();
var _25b=_25a.ModelNode.getAttribute("DatasourceId");
var _25c=this.grid.data.getTable(_25b);
var _25d=_25a.ModelNode.getAttribute("DisplayFields");
var _25e=_25a.ModelNode.getAttribute("ValueField");
var _260=_25a.ModelNode.getAttribute("CheckedValue");
if(_260==""||_260==null){
_260=0;
}
var _261=_25c.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"e[@"+_25e+"='"+_255+"']/@"+_25d).nodeValue;
var _262=(_255==_260)?"checked":"unchecked";
_257="<div style=\"overflow:hidden;\"><div style=\"float:left;\" class=\"ebacheckbox ebacheckbox"+_262+" checkbox"+_262+"\" checked=\""+_255+"\">&nbsp;</div><span>"+nitobi.html.encode(_261)+"</span></div>";
break;
case "LISTBOX":
var _25a=this.getColumnObject();
var _25b=_25a.ModelNode.getAttribute("DatasourceId");
var _25c=this.grid.data.getTable(_25b);
var _25d=_25a.ModelNode.getAttribute("DisplayFields");
var _25e=_25a.ModelNode.getAttribute("ValueField");
_257=_25c.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"e[@"+_25e+"='"+_255+"']/@"+_25d).nodeValue;
break;
case "IMAGE":
break;
default:
_257=_255;
}
if(this.DomNode!=null){
this.DomNode.innerHTML=_257;
this.DomNode.setAttribute("value",_255);
}
this.grid.datatable.updateRecord(this.dataIndex,this.columnObject.getColumnName(),_255);
};
nitobi.grid.Cell.prototype.getValue=function(){
return this.GETDATA();
};
nitobi.grid.Cell.prototype.getHtml=function(){
return this.DomNode.innerHTML;
};
nitobi.grid.Cell.prototype.edit=function(){
this.grid.activeCell=this.DomNode;
this.grid.edit();
};
nitobi.grid.Cell.prototype.GETDATA=function(){
var node=this.DataNode;
if(node!=null){
return node.value;
}
};
nitobi.grid.Cell.prototype.xGETMETA=function(){
if(this.MetaNode==null){
return null;
}
var node=this.MetaNode;
node=node.selectSingleNode("@"+arguments[0]);
if(node!=null){
return node.value;
}
};
nitobi.grid.Cell.prototype.xSETMETA=function(){
var node=this.MetaNode;
if(node!=null){
node.setAttribute(arguments[0],arguments[1][0]);
}else{
alert("Cannot set property: "+arguments[0]);
}
};
nitobi.grid.Cell.prototype.xSETCSS=function(){
var node=this.DomNode;
if(node!=null){
node.style.setAttribute(arguments[0],arguments[1][0]);
}else{
alert("Cannot set property: "+arguments[0]);
}
};
nitobi.grid.Cell.prototype.xGET=function(){
var node=this.ModelNode;
node=node.selectSingleNode(arguments[0]);
if(node!=null){
return node.value;
}
};
nitobi.grid.Cell.prototype.xSET=function(){
var node=this.ModelNode;
node=node.selectSingleNode(arguments[0]);
if(node!=null){
node.nodeValue=arguments[1][0];
}
};
nitobi.grid.Cell.prototype.getStyle=function(){
return this.DomNode.style;
};
nitobi.grid.Cell.prototype.getColumnObject=function(){
if(typeof (this.columnObject)=="undefined"){
this.columnObject=this.grid.getColumnObject(this.getColumn());
}
return this.columnObject;
};
nitobi.grid.Cell.getCellElement=function(grid,row,_26b){
return $("cell_"+row+"_"+_26b+"_"+grid.uid);
};
nitobi.grid.Cell.getRowNumber=function(_26c){
return parseInt(_26c.getAttribute("xi"));
};
nitobi.grid.Cell.getColumnNumber=function(_26d){
return parseInt(_26d.getAttribute("col"));
};
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.CellEventArgs=function(_26e,cell){
this.grid=_26e;
this.cell=cell;
this.event=nitobi.html.Event;
};
nitobi.grid.CellEventArgs.prototype.getSource=function(){
return this.grid;
};
nitobi.grid.CellEventArgs.prototype.getCell=function(){
return this.cell;
};
nitobi.grid.CellEventArgs.prototype.getEvent=function(){
return this.event;
};
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.RowEventArgs=function(_270,row){
this.grid=_270;
this.row=row;
this.event=nitobi.html.Event;
};
nitobi.grid.RowEventArgs.prototype.getSource=function(){
return this.grid;
};
nitobi.grid.RowEventArgs.prototype.getRow=function(){
return this.row;
};
nitobi.grid.RowEventArgs.prototype.getEvent=function(){
return this.event;
};
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.SelectionEventArgs=function(_272,data,_274){
this.coords=_274;
this.data=data;
};
nitobi.grid.SelectionEventArgs.prototype.getCoords=function(){
return this.coords;
};
nitobi.grid.SelectionEventArgs.prototype.getData=function(){
return this.data;
};
nitobi.grid.Column=function(grid,_276){
this.grid=grid;
this.column=_276;
this.uid=nitobi.base.getUid();
this.Interface=this.grid.API.selectSingleNode("interfaces/interface[@name='nitobi.grid.Column']");
eval(nitobi.xml.transformToString(this.Interface,grid.accessorGeneratorXslProc));
var _277=null;
if(nitobi.browser.MOZ){
_277=this.grid.model.selectSingleNode("//state/nitobi.grid.Columns/nitobi.grid.Column["+(parseInt(_276)+1)+"]");
}else{
_277=this.grid.model.selectSingleNode("//state/nitobi.grid.Columns/nitobi.grid.Column["+(_276)+"]");
}
this.ModelNode=_277;
this.HeaderElement=nitobi.grid.Column.getColumnHeaderElement(grid,_276);
};
nitobi.grid.Column.prototype.getEditor=function(){
};
nitobi.grid.Column.prototype.getStyle=function(){
var _278=this.getClassName();
return nitobi.html.getClass(_278);
};
nitobi.grid.Column.prototype.getHeaderStyle=function(){
var _279="acolumnheader"+this.grid.uid+"_"+this.column;
return nitobi.html.getClass(_279);
};
nitobi.grid.Column.prototype.getDataStyle=function(){
var _27a="acolumndata"+this.grid.uid+"_"+this.column;
return nitobi.html.getClass(_27a);
};
nitobi.grid.Column.prototype.getEditor=function(){
return nitobi.form.ControlFactory.instance.getEditor(this.grid,this);
};
nitobi.grid.Column.prototype.xGETMODEL=function(){
var node=this.ModelNode;
node=node.selectSingleNode("@"+arguments[0]);
if(node!=null){
return node.value;
}
};
nitobi.grid.Column.prototype.xSETMODEL=function(){
var node=this.ModelNode;
if(node!=null){
node.setAttribute(arguments[0],arguments[1][0]);
}else{
alert("Cannot set model property: "+arguments[0]);
}
};
nitobi.grid.Column.prototype.xGET=function(){
var node=this.grid.model.documentElement;
node=node.selectSingleNode(arguments[0]);
if(node!=null){
return node.value;
}
};
nitobi.grid.Column.prototype.xSET=function(){
var node=this.grid.model.documentElement;
node=node.selectSingleNode(arguments[0]);
if(node!=null){
node.nodeValue=arguments[1][0];
}
};
nitobi.grid.Column.prototype.eSET=function(name,_280){
var _281=_280[0];
var _282=_281;
var _283=name.substr(2);
_283=_283.substr(0,_283.length-5);
if(typeof (_281)=="string"){
_282=function(_284){
return eval(_281);
};
}
if(typeof (this[name])!="undefined"){
alert("unsubscribe");
this.unsubscribe(_283,this[name]);
}
var guid=this.subscribe(_283,_282);
this.jSET(name,[guid]);
};
nitobi.grid.Column.prototype.jSET=function(name,val){
this[name]=val[0];
};
nitobi.grid.Column.prototype.fire=function(evt,args){
return nitobi.event.notify(evt+this.uid,args);
};
nitobi.grid.Column.prototype.subscribe=function(evt,func,_28c){
if(typeof (_28c)=="undefined"){
_28c=this;
}
return nitobi.event.subscribe(evt+this.uid,nitobi.lang.close(_28c,func));
};
nitobi.grid.Column.prototype.unsubscribe=function(evt,func){
return nitobi.event.unsubscribe(evt+this.uid,func);
};
nitobi.grid.Column.getColumnHeaderElement=function(grid,_290){
return document.getElementById("columnheader_"+_290+"_"+grid.uid);
};
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.ColumnEventArgs=function(_291,_292){
this.grid=_291;
this.column=_292;
this.event=nitobi.html.Event;
};
nitobi.grid.ColumnEventArgs.prototype.getSource=function(){
return this.grid;
};
nitobi.grid.ColumnEventArgs.prototype.getColumn=function(){
return this.column;
};
nitobi.grid.ColumnEventArgs.prototype.getEvent=function(){
return this.event;
};
nitobi.grid.ColumnResizer=function(grid){
this.grid=grid;
this.line=document.getElementById("ebagridresizeline_");
if(this.line==null){
this.line=document.createElement("div");
this.line.id="ebagridresizeline_";
document.body.appendChild(this.line);
this.line.className="ebacolumnresizeline";
}
this.lineStyle=this.line.style;
if(nitobi.browser.IE){
this.surface=document.getElementById("ebagridresizesurface_");
if(this.surface==null){
this.surface=document.createElement("div");
this.surface.id="ebagridresizesurface_";
this.surface.className="ebacolumnresizesurface";
document.body.appendChild(this.surface);
}
}
};
nitobi.grid.ColumnResizer.prototype.startResize=function(grid,_295,_296,_297){
this.grid=grid;
this.column=_295;
var _298=new nitobi.grid.OnBeforeColumnResizeEventArgs(this.grid,this.column);
if(!nitobi.event.evaluate(_295.getOnBeforeResizeEvent(),_298)){
return;
}
var x,y;
if(nitobi.browser.IE){
x=window.event.clientX+document.documentElement.scrollLeft+document.body.scrollLeft;
this.surface.style.visibility="visible";
nitobi.drawing.align(this.surface,this.grid.element,nitobi.drawing.align.SAMEHEIGHT|nitobi.drawing.align.SAMEWIDTH|nitobi.drawing.align.ALIGNTOP|nitobi.drawing.align.ALIGNLEFT);
}else{
x=_297.clientX+window.scrollX;
}
this.x=x;
nitobi.drawing.align(this.line,_296,nitobi.drawing.align.ALIGNTOP,0,0,nitobi.html.getHeight(_296)+1);
this.lineStyle.left=x;
this.lineStyle.height=parseInt(this.grid.Scroller.height)-parseInt(this.grid.getHeaderHeight());
this.lineStyle.visibility="visible";
nitobi.ui.startDragOperation(this.line,_297,false,true,this,this.endResize);
};
nitobi.grid.ColumnResizer.prototype.endResize=function(x,y){
if(nitobi.browser.IE){
this.surface.style.visibility="hidden";
}
this.lineStyle.visibility="hidden";
this.lineStyle.top=0;
this.lineStyle.left=0;
var _29d=this.column.getWidth();
var _29e=parseInt(_29d)+x-this.x;
if(isNaN(_29e)){
return;
}
if(_29e>10){
this.column.setWidth(_29e);
this.grid.updateCellRanges();
this.grid.generateCss();
this.grid.renderHeader();
this.grid.Scroller.swapPanes(true);
}
this.grid.Selection.collapse(this.grid.activeCell);
var _29f=new nitobi.grid.OnAfterColumnResizeEventArgs(this.grid,this.column);
nitobi.event.evaluate(this.column.getOnAfterResizeEvent(),_29f);
};
nitobi.grid.ColumnResizer.prototype.dispose=function(){
this.grid=null;
this.line=null;
this.lineStyle=null;
this.surface=null;
};
nitobi.grid.GridResizer=function(grid){
this.grid=grid;
this.box=document.getElementById("ebagridresizebox_");
if(this.box==null){
this.box=document.createElement("div");
this.box.id="ebagridresizebox_";
document.body.appendChild(this.box);
this.box.className="ebacolumnresizeline";
}
};
nitobi.grid.GridResizer.prototype.startResize=function(grid,_2a2){
this.grid=grid;
var _2a3=null;
var x,y;
if(nitobi.browser.IE){
x=window.event.clientX+document.documentElement.scrollLeft+document.body.scrollLeft;
y=window.event.clientY+document.documentElement.scrollTop+document.body.scrollTop;
}else{
x=_2a2.clientX+window.scrollX;
y=_2a2.clientY+window.scrollY;
}
this.x=x;
this.y=y;
var w=grid.getWidth();
var h=grid.getHeight();
var L=grid.element.offsetLeft;
var T=grid.element.offsetTop;
this.resizeW=(Math.abs((x-L)-w)<3)||((Math.abs((y-T)-h)<16)&&(Math.abs((x-L)-w)<16));
this.resizeH=(Math.abs((y-T)-h)<3)||((Math.abs((y-T)-h)<16)&&(Math.abs((x-L)-w)<16));
if(this.resizeW||this.resizeH){
this.box.style.cursor=(this.resizeW&&this.resizeH)?"NW-Resize":(this.resizeW)?"W-Resize":"N-Resize";
this.box.style.visibility="visible";
this.box.style.width=(x-L);
this.box.style.height=(y-T);
var _2aa=nitobi.drawing.align.SAMEWIDTH|nitobi.drawing.align.SAMEHEIGHT|nitobi.drawing.align.ALIGNTOP|nitobi.drawing.align.ALIGNLEFT;
nitobi.drawing.align(this.box,this.grid.element,_2aa,0,0,0,0,false);
nitobi.ui.DragDrop.prototype._onMouseMove=nitobi.ui.DragDrop.prototype.onMouseMove;
nitobi.ui.DragDrop.prototype.onMoveEvent=this.resize;
nitobi.ui.DragDrop.prototype.onMouseMove=function(_2ab){
this._onMouseMove(_2ab);
if(this.onMoveEvent!=null){
this.onMoveEvent.call(this.context,this.x,this.y);
}
};
nitobi.ui.startDragOperation(this.box,_2a2,false,false,this,this.endResize);
}
};
nitobi.grid.GridResizer.prototype.resize=function(x,y){
var L=this.grid.element.offsetLeft;
var T=this.grid.element.offsetTop;
this.box.style.visibility="visible";
if(this.resizeW){
this.box.style.width=(x-L);
}
if(this.resizeH){
this.box.style.height=(y-T);
}
};
nitobi.grid.GridResizer.prototype.endResize=function(x,y){
nitobi.ui.DragDrop.prototype.onMouseMove=nitobi.ui.DragDrop.prototype._onMouseMove;
nitobi.ui.DragDrop.prototype.onMoveEvent=null;
nitobi.ui.DragDrop.prototype._onMouseMove=null;
this.box.style.visibility="hidden";
var _2b2=this.grid.getWidth();
var _2b3=this.grid.getHeight();
var _2b4=parseInt(_2b2)+((this.resizeW)?x-this.x:0);
var _2b5=parseInt(_2b3)+((this.resizeH)?y-this.y:0);
if(isNaN(_2b4)||isNaN(_2b5)){
return;
}
if(_2b4>20&&_2b5>20){
this.grid.setWidth(_2b4);
this.grid.setHeight(_2b5);
this.grid.generateCss();
this.grid.alignSurfaces();
}
var _2b6=null;
this.grid.fire("AfterGridResize",{width:_2b4,height:_2b5});
};
nitobi.grid.GridResizer.prototype.dispose=function(){
this.grid=null;
};
nitobi.data.FormatConverter={};
nitobi.data.FormatConverter.convertHtmlTableToEbaXml=function(_2b7,_2b8,_2b9){
var s="<xsl:stylesheet version=\"1.0\" xmlns:ntb=\"http://www.nitobi.com\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\"><xsl:output encoding=\"UTF-8\" method=\"xml\" omit-xml-declaration=\"no\" />";
s+="<xsl:template match=\"//TABLE\"><ntb:data id=\"_default\">";
s+="<xsl:apply-templates /></ntb:data> </xsl:template>";
s+="<xsl:template match = \"//TR\">  <xsl:element name=\"ntb:e\"> <xsl:attribute name=\"xi\"><xsl:value-of select=\"position()-1+"+parseInt(_2b9)+"\"/></xsl:attribute>";
for(var _2bb=0;_2bb<_2b8.length;_2bb++){
s+="<xsl:attribute name=\""+_2b8[_2bb]+"\" ><xsl:value-of select=\"TD["+parseInt(_2bb+1)+"]\"/></xsl:attribute>";
}
s+="</xsl:element></xsl:template>";
s+="</xsl:stylesheet>";
var _2bc=nitobi.xml.createXmlDoc(_2b7);
var _2bd=nitobi.xml.createXslProcessor(s);
var _2be=nitobi.xml.transformToXml(_2bc,_2bd);
return _2be;
};
nitobi.data.FormatConverter.convertTsvToEbaXml=function(tsv,_2c0,_2c1){
var _2c2="<TABLE><TBODY>"+tsv.replace(/[\&\r]/g,"").replace(/([^\t\n]*)[\t]/g,"<TD>$1</TD>").replace(/([^\n]*?)\n/g,"<TR>$1</TR>").replace(/\>([^\<]*)\<\/TR/g,"><TD>$1</TD></TR")+"</TBODY></TABLE>";
if(_2c2.indexOf("<TBODY><TR>")==-1){
_2c2=_2c2.replace(/TBODY\>(.*)\<\/TBODY/,"TBODY><TR><TD>$1</TD></TR></TBODY");
}
return nitobi.data.FormatConverter.convertHtmlTableToEbaXml(_2c2,_2c0,_2c1);
};
nitobi.data.FormatConverter.convertEbaXmlToHtmlTable=function(_2c3,_2c4,_2c5,_2c6){
var s="<xsl:stylesheet version=\"1.0\" xmlns:ntb=\"http://www.nitobi.com\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\"><xsl:output encoding=\"UTF-8\" method=\"html\" omit-xml-declaration=\"yes\" /><xsl:template match = \"*\"><xsl:apply-templates /></xsl:template><xsl:template match = \"/\">";
s+="<TABLE><TBODY><xsl:for-each select=\"//ntb:e[@xi>"+parseInt(_2c5-1)+" and @xi &lt; "+parseInt(_2c6+1)+"]\" ><TR>";
for(var _2c8=0;_2c8<_2c4.length;_2c8++){
s+="<TD><xsl:value-of select=\"@"+_2c4[_2c8]+"\" /></TD>";
}
s+="</TR></xsl:for-each></TBODY></TABLE></xsl:template></xsl:stylesheet>";
var _2c9=nitobi.xml.createXslProcessor(s);
return nitobi.xml.transformToXml(_2c3,_2c9).xml.replace(/xmlns:ntb="http:\/\/www.nitobi.com"/,"");
};
nitobi.data.FormatConverter.convertEbaXmlToTsv=function(_2ca,_2cb,_2cc,_2cd){
var s="<xsl:stylesheet version=\"1.0\" xmlns:ntb=\"http://www.nitobi.com\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\"><xsl:output encoding=\"UTF-8\" method=\"text\" omit-xml-declaration=\"yes\" /><xsl:template match = \"*\"><xsl:apply-templates /></xsl:template><xsl:template match = \"/\">";
s+="<xsl:for-each select=\"//ntb:e[@xi>"+parseInt(_2cc-1)+" and @xi &lt; "+parseInt(_2cd+1)+"]\" >\n";
for(var _2cf=0;_2cf<_2cb.length;_2cf++){
s+="<xsl:value-of select=\"@"+_2cb[_2cf]+"\" />";
if(_2cf<_2cb.length-1){
s+="<xsl:text>&#x09;</xsl:text>";
}
}
s+="<xsl:text>&#xa;</xsl:text></xsl:for-each></xsl:template></xsl:stylesheet>";
var _2d0=nitobi.xml.createXslProcessor(s);
return nitobi.xml.transformToString(_2ca,_2d0).replace(/xmlns:ntb="http:\/\/www.nitobi.com"/,"");
};
nitobi.data.FormatConverter.getDataColumns=function(data){
var _2d2=0;
if(data!=null&&data!=""){
if(data.substr(0,1)=="<"){
_2d2=data.toLowerCase().substr(0,data.toLowerCase().indexOf("</tr>")).split("</td>").length-1;
}else{
_2d2=data.substr(0,data.indexOf("\n")).split("\t").length;
}
}else{
_2d2=0;
}
return _2d2;
};
nitobi.data.FormatConverter.getDataRows=function(data){
var _2d4=0;
if(data!=null&&data!=""){
if(data.substr(0,1)=="<"){
_2d4=data.toLowerCase().split("</tr>").length-1;
}else{
retValArray=data.split("\n");
_2d4=retValArray.length;
if(retValArray[retValArray.length-1]==""){
_2d4--;
}
}
}else{
_2d4=0;
}
return _2d4;
};
nitobi.grid.DateColumn=function(grid,_2d6){
nitobi.grid.DateColumn.baseConstructor.call(this,grid,_2d6);
this.Interface=grid.API.selectSingleNode("interfaces/interface[@name='EBADateColumn']");
eval(nitobi.xml.transformToString(this.Interface,grid.accessorGeneratorXslProc));
};
nitobi.lang.extend(nitobi.grid.DateColumn,nitobi.grid.Column);
nitobi.lang.defineNs("nitobi.grid.Declaration");
nitobi.grid.Declaration.parse=function(_2d7){
var _2d8={};
_2d8.grid=nitobi.xml.parseHtml(_2d7);
var _2d9=_2d7.firstChild;
while(_2d9!=null){
if(typeof (_2d9.tagName)!="undefined"){
var tag=_2d9.tagName.replace(/ntb\:/gi,"").toLowerCase();
if(tag=="inlinehtml"){
_2d8[tag]=_2d9;
}else{
var _2db="http://www.nitobi.com";
if(tag=="columndefinition"){
var sXml;
if(nitobi.browser.IE){
sXml=("<"+nitobi.xml.nsPrefix+"grid xmlns:ntb=\""+_2db+"\"><"+nitobi.xml.nsPrefix+"columns>"+_2d9.parentNode.innerHTML.substring(31).replace(/\=\s*([^\"^\s^\>]+)/g,"=\"$1\" ")+"</"+nitobi.xml.nsPrefix+"columns></"+nitobi.xml.nsPrefix+"grid>");
}else{
sXml="<"+nitobi.xml.nsPrefix+"grid xmlns:ntb=\""+_2db+"\"><"+nitobi.xml.nsPrefix+"columns>"+_2d9.parentNode.innerHTML.replace(/\=\s*([^\"^\s^\>]+)/g,"=\"$1\" ")+"</"+nitobi.xml.nsPrefix+"columns></"+nitobi.xml.nsPrefix+"grid>";
}
sXml=sXml.replace(/\&nbsp\;/gi," ");
_2d8["columndefinitions"]=nitobi.xml.createXmlDoc();
_2d8["columndefinitions"].validateOnParse=false;
_2d8["columndefinitions"]=nitobi.xml.loadXml(_2d8["columndefinitions"],sXml);
break;
}else{
_2d8[tag]=nitobi.xml.parseHtml(_2d9);
}
}
}
_2d9=_2d9.nextSibling;
}
return _2d8;
};
nitobi.grid.Declaration.loadDataSources=function(_2dd,grid){
var _2df=new Array();
if(_2dd["datasources"]){
_2df=_2dd.datasources.selectNodes("//"+nitobi.xml.nsPrefix+"datasources/*");
}
if(_2df.length>0){
for(var i=0;i<_2df.length;i++){
var id=_2df[i].getAttribute("id");
if(id!="_default"){
var _2e2=_2df[i].xml.replace(/fieldnames=/g,"FieldNames=").replace(/keys=/g,"Keys=");
_2e2="<ntb:grid xmlns:ntb=\"http://www.nitobi.com\"><ntb:datasources>"+_2e2+"</ntb:datasources></ntb:grid>";
var _2e3=new nitobi.data.DataTable("local",grid.getPagingMode()!=nitobi.grid.PAGINGMODE_NONE,{GridId:grid.getID()},{GridId:grid.getID()},grid.isAutoKeyEnabled());
_2e3.initialize(id,_2e2);
_2e3.initializeXml(_2e2);
grid.data.add(_2e3);
var _2e4=grid.model.selectNodes("//nitobi.grid.Column[@DatasourceId='"+id+"']");
for(var j=0;j<_2e4.length;j++){
grid.editorDataReady(_2e4[j]);
}
}
}
}
};
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.EditCompleteEventArgs=function(obj,_2e7,_2e8,cell){
this.editor=obj;
this.cell=cell;
this.databaseValue=_2e8;
this.displayValue=_2e7;
this.status="ok";
};
nitobi.grid.EditCompleteEventArgs.prototype.dispose=function(){
this.editor=null;
this.cell=null;
this.metadata=null;
};
nitobi.data.GetCompleteEventArgs=function(_2ea,_2eb,_2ec,_2ed,_2ee,_2ef,obj,_2f1,_2f2){
this.firstRow=_2ea;
this.lastRow=_2eb;
this.callback=_2f1;
this.dataSource=_2ef;
this.context=obj;
this.ajaxCallback=_2ee;
this.startXi=_2ec;
this.pageSize=_2ed;
this.lastPage=false;
this.numRowsReturned=_2f2;
this.lastRowReturned=_2eb;
};
nitobi.data.GetCompleteEventArgs.prototype.dispose=function(){
this.callback=null;
this.context=null;
this.dataSource=null;
this.ajaxCallback.clear();
this.ajaxCallback==null;
};
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.MODE_STANDARDPAGING="standard";
nitobi.grid.MODE_LOCALSTANDARDPAGING="localstandard";
nitobi.grid.MODE_LIVESCROLLING="livescrolling";
nitobi.grid.MODE_LOCALLIVESCROLLING="locallivescrolling";
nitobi.grid.MODE_NONPAGING="nonpaging";
nitobi.grid.MODE_LOCALNONPAGING="localnonpaging";
nitobi.grid.MODE_SMARTPAGING="smartpaging";
nitobi.grid.MODE_PAGEDLIVESCROLLING="pagedlivescrolling";
nitobi.grid.RENDERMODE_ONDEMAND="ondemand";
nitobi.lang.defineNs("nitobi.GridFactory");
nitobi.GridFactory.createGrid=function(_2f3,_2f4,_2f5){
var _2f6="";
var _2f7="";
var _2f8="";
_2f5=nitobi.html.getElement(_2f5);
if(_2f5!=null){
xDeclaration=nitobi.grid.Declaration.parse(_2f5);
_2f3=xDeclaration.grid.documentElement.getAttribute("mode");
var _2f9=nitobi.GridFactory.isGetHandler(xDeclaration);
var _2fa=nitobi.GridFactory.isDatasourceId(xDeclaration);
var _2fb=false;
if(_2f3==nitobi.grid.MODE_LOCALLIVESCROLLING){
_2f6=nitobi.grid.PAGINGMODE_LIVESCROLLING;
_2f7=nitobi.data.DATAMODE_LOCAL;
}else{
if(_2f3==nitobi.grid.MODE_LIVESCROLLING){
_2f6=nitobi.grid.PAGINGMODE_LIVESCROLLING;
_2f7=nitobi.data.DATAMODE_CACHING;
}else{
if(_2f3==nitobi.grid.MODE_NONPAGING){
_2fb=true;
_2f6=nitobi.grid.PAGINGMODE_NONE;
_2f7=nitobi.data.DATAMODE_LOCAL;
}else{
if(_2f3==nitobi.grid.MODE_LOCALNONPAGING){
_2f6=nitobi.grid.PAGINGMODE_NONE;
_2f7=nitobi.data.DATAMODE_CACHING;
}else{
if(_2f3==nitobi.grid.MODE_LOCALSTANDARDPAGING){
_2f6=nitobi.grid.PAGINGMODE_STANDARD;
_2f7=nitobi.data.DATAMODE_LOCAL;
}else{
if(_2f3==nitobi.grid.MODE_STANDARDPAGING){
_2f6=nitobi.grid.PAGINGMODE_STANDARD;
_2f7=nitobi.data.DATAMODE_PAGING;
}else{
if(_2f3==nitobi.grid.MODE_PAGEDLIVESCROLLING){
_2f6=nitobi.grid.PAGINGMODE_STANDARD;
_2f7=nitobi.data.DATAMODE_PAGING;
_2f8=nitobi.grid.RENDERMODE_ONDEMAND;
}else{
}
}
}
}
}
}
}
}
_2f3=(_2f3||nitobi.grid.MODE_STANDARDPAGING).toLowerCase();
var grid=null;
if(_2f3==nitobi.grid.MODE_LOCALSTANDARDPAGING){
grid=new nitobi.grid.GridLocalPage();
}else{
if(_2f3==nitobi.grid.MODE_LIVESCROLLING){
grid=new nitobi.grid.GridLiveScrolling();
}else{
if(_2f3==nitobi.grid.MODE_LOCALLIVESCROLLING){
grid=new nitobi.grid.GridLiveScrolling();
}else{
if(_2f3==nitobi.grid.MODE_NONPAGING||_2f3==nitobi.grid.MODE_LOCALNONPAGING){
grid=new nitobi.grid.GridNonpaging();
}else{
if(_2f3==nitobi.grid.MODE_STANDARDPAGING||_2f3==nitobi.grid.MODE_PAGEDLIVESCROLLING){
grid=new nitobi.grid.GridStandard();
}
}
}
}
}
grid.setPagingMode(_2f6);
grid.setDataMode(_2f7);
grid.setRenderMode(_2f8);
nitobi.GridFactory.processDeclaration(grid,_2f5,xDeclaration);
_2f5.jsObject=grid;
return grid;
};
nitobi.GridFactory.processDeclaration=function(grid,_2fe,_2ff){
if(_2ff!=null){
grid.setDeclaration(_2ff);
if(typeof (_2ff.inlinehtml)=="undefined"){
var _300=document.createElement("ntb:inlinehtml");
_300.setAttribute("parentid","grid"+grid.uid);
_2fe.insertAdjacentElement("beforeEnd",_300);
grid.Declaration.inlinehtml=_300;
}
if(this.data==null||this.data.tables==null||this.data.tables.length==0){
var _301=new nitobi.data.DataSet();
_301.initialize();
grid.connectToDataSet(_301);
}
grid.initializeModelFromDeclaration();
var _302=grid.Declaration.columndefinitions||grid.Declaration.columns;
if(typeof (_302)!="undefined"&&_302!=null&&_302.childNodes.length!=0&&_302.childNodes[0].childNodes.length!=0){
grid.defineColumns(_302.documentElement);
}
nitobi.grid.Declaration.loadDataSources(_2ff,grid);
grid.attachToParentDomElement(grid.Declaration.inlinehtml);
var _303=grid.getDataMode();
var _304=grid.getDatasourceId();
var _305=grid.getGetHandler();
if(_304!=null&&_304!=""){
grid.connectToTable(grid.data.getTable(_304));
}else{
grid.ensureConnected();
if(grid.mode.toLowerCase()==nitobi.grid.MODE_LIVESCROLLING&&_2ff!=null&&_2ff.datasources!=null){
var _306=_2ff.datasources.selectNodes("//ntb:datasource[@id='_default']/ntb:data/ntb:e").length;
if(_306>0){
var _307=grid.data.getTable("_default");
_307.initializeXmlData(_2ff.grid.xml);
_307.initializeXml(_2ff.grid.xml);
_307.descriptor.leap(0,_306*2);
_307.syncRowCount();
}
}
}
window.setTimeout(function(){
grid.bind();
},0);
}
};
nitobi.GridFactory.isLocal=function(_308){
var _309=_308.grid.documentElement.getAttribute("datasourceid");
var _30a=_308.grid.documentElement.getAttribute("gethandler");
if(_30a!=null&&_30a!=""){
return false;
}else{
if(_309!=null&&_309!=""){
return true;
}else{
throw ("Non-paging grid requires either a gethandler or a local datasourceid to be specified.");
}
}
};
nitobi.GridFactory.isGetHandler=function(_30b){
var _30c=_30b.grid.documentElement.getAttribute("gethandler");
if(_30c!=null&&_30c!=""){
return true;
}
return false;
};
nitobi.GridFactory.isDatasourceId=function(_30d){
var _30e=_30d.grid.documentElement.getAttribute("datasourceid");
if(_30e!=null&&_30e!=""){
return true;
}
return false;
};
nitobi.grid.hover=function(_30f,_310,_311){
if(!_311){
return;
}
var id=_30f.getAttribute("id");
var _313=id.replace(/__/g,"||");
var _314=_313.split("_");
var row=_314[3];
var uid=_314[5].replace(/\|\|/g,"__");
var _317=document.getElementById("cell_"+row+"_0_"+uid);
var _318=_317.parentNode;
var _319=_318.childNodes[_318.childNodes.length-1];
var id=_319.getAttribute("id");
var _314=id.split("_");
var _31a=document.getElementById("cell_"+row+"_"+(Number(_314[4])+1)+"_"+uid);
var _31b=null;
if(_31a!=null){
_31b=_31a.parentNode;
}
if(_310){
var _31c=nitobi.grid.RowHoverColor||"white";
_318.style.backgroundColor=_31c;
if(_31b){
_31b.style.backgroundColor=_31c;
}
}else{
_318.style.backgroundColor="";
if(_31b){
_31b.style.backgroundColor="";
}
}
if(_310){
nitobi.html.addClass(_30f,"ebacellhover");
}else{
nitobi.html.removeClass(_30f,"ebacellhover");
}
};
initEBAGrids=function(){
nitobi.initComponents();
};
nitobi.initGrids=function(){
var _31d=window.document.getElementsByTagName(nitobi.browser.MOZ?"ntb:grid":"grid");
for(var i=0;i<_31d.length;i++){
_31d[i].jsObject=nitobi.GridFactory.createGrid(null,null,_31d[i]);
}
};
nitobi.initGrid=function(id){
var grid=nitobi.html.getElement(id);
if(grid!=null){
grid.jsObject=nitobi.GridFactory.createGrid(null,null,grid);
}
return grid.jsObject;
};
nitobi.initComponents=function(){
nitobi.initGrids();
};
nitobi.getGrid=function(_321){
return document.getElementById(_321).jsObject;
};
nitobi.base.Registry.getInstance().register(new nitobi.base.Profile("nitobi.initGrid",null,false,"ntb:grid"));
nitobi.grid.GridLiveScrolling=function(_322,_323,_324){
nitobi.grid.GridLiveScrolling.baseConstructor.call(this);
this.mode="livescrolling";
this.setPagingMode(nitobi.grid.PAGINGMODE_LIVESCROLLING);
this.setDataMode(nitobi.data.DATAMODE_CACHING);
};
nitobi.lang.extend(nitobi.grid.GridLiveScrolling,nitobi.grid.Grid);
nitobi.grid.GridLiveScrolling.prototype.createChildren=function(){
var args=arguments;
nitobi.grid.GridLiveScrolling.base.createChildren.call(this,args);
nitobi.grid.GridLiveScrolling.base.createToolbars.call(this,nitobi.ui.Toolbars.VisibleToolbars.STANDARD);
};
nitobi.grid.GridLiveScrolling.prototype.bind=function(){
nitobi.grid.GridStandard.base.bind.call(this);
if(this.getGetHandler()!=""){
this.ensureConnected();
var rows=this.getRowsPerPage();
if(this.datatable.mode=="local"){
rows=null;
}
this.datatable.get(0,rows,this,this.getComplete);
}else{
this.finalizeRowCount(this.datatable.getRemoteRowCount());
this.bindComplete();
}
};
nitobi.grid.GridLiveScrolling.prototype.getComplete=function(_327){
nitobi.grid.GridLiveScrolling.base.getComplete.call(this,_327);
if(!this.columnsDefined){
this.defineColumnsFinalize();
}
this.bindComplete();
};
nitobi.grid.GridLiveScrolling.prototype.renderMiddle=function(){
};
nitobi.grid.GridLiveScrolling.prototype.pageSelect=function(dir){
var _329=this.Scroller.getRowRange();
var rows=_329.last-_329.first;
this.reselect(0,rows*dir);
};
nitobi.grid.GridLiveScrolling.prototype.page=function(dir){
var _32c=this.Scroller.getRowRange();
var rows=_32c.last-_32c.first;
this.move(0,rows*dir);
};
nitobi.grid.GridLiveScrolling.prototype.LiveScrollAdjustSize=function(){
if(!this.rowCountKnown){
}
};
nitobi.grid.LoadingScreen=function(grid){
this.loadingScreen=null;
this.grid=grid;
this.loadingImg=null;
};
nitobi.grid.LoadingScreen.prototype.initialize=function(){
this.loadingScreen=document.createElement("div");
var _32f=this.findCssUrl();
var msg="";
if(_32f==null){
msg="Loading...";
}else{
msg="<img src='"+_32f+"loading.gif'  class='ebaloadingIcon' valign='absmiddle'></img>";
}
this.loadingScreen.innerHTML="<table style='padding:0px;margin:0px;' border='0' width='100%' height='100%'><tr style='padding:0px;margin:0px;'><td style='padding:0px;margin:0px;text-align:center;font:verdana;font-size:10pt;'>"+msg+"</td></tr></table>";
this.loadingScreen.className="ebaloading";
var lss=this.loadingScreen.style;
lss.verticalAlign="middle";
lss.visibility="hidden";
lss.position="absolute";
lss.top="0px";
lss.left="0px";
};
nitobi.grid.LoadingScreen.prototype.attachToElement=function(_332){
_332.appendChild(this.loadingScreen);
};
nitobi.grid.LoadingScreen.prototype.findCssUrl=function(){
var _333=nitobi.html.findParentStylesheet(".ebaloadingIcon");
if(_333==null){
return null;
}
var _334=nitobi.html.normalizeUrl(_333.href);
if(nitobi.browser.IE){
while(_333.parentStyleSheet){
_333=_333.parentStyleSheet;
_334=nitobi.html.normalizeUrl(_333.href)+_334;
}
}
return _334;
};
nitobi.grid.LoadingScreen.prototype.show=function(){
try{
this.resize();
this.loadingScreen.style.visibility="visible";
this.loadingScreen.style.display="block";
}
catch(e){
}
};
nitobi.grid.LoadingScreen.prototype.resize=function(){
var _335=document.getElementById(this.grid.getID());
this.loadingScreen.style.width=this.grid.getWidth()+"px";
this.loadingScreen.style.height=this.grid.getHeight()+"px";
var top="-2px";
var left="-2px";
if(nitobi.browser.MOZ){
var rect=_335.getBoundingClientRect();
top=rect.top+"px";
left=rect.left+"px";
this.loadingScreen.style.top=top;
this.loadingScreen.style.left=left;
}
};
nitobi.grid.LoadingScreen.prototype.hide=function(){
this.loadingScreen.style.display="none";
};
nitobi.grid.GridLocalPage=function(_339,_33a,_33b){
nitobi.grid.GridLocalPage.baseConstructor.call(this);
this.mode="localpaging";
this.setPagingMode(nitobi.grid.PAGINGMODE_STANDARD);
this.setDataMode("local");
};
nitobi.lang.extend(nitobi.grid.GridLocalPage,nitobi.grid.Grid);
nitobi.grid.GridLocalPage.prototype.createChildren=function(){
var args=arguments;
nitobi.grid.GridLocalPage.base.createChildren.call(this,args);
nitobi.grid.GridLiveScrolling.base.createToolbars.call(this,nitobi.ui.Toolbars.VisibleToolbars.STANDARD|nitobi.ui.Toolbars.VisibleToolbars.PAGING);
this.toolbars.subscribe("NextPage",nitobi.lang.close(this,this.pageNext));
this.toolbars.subscribe("PreviousPage",nitobi.lang.close(this,this.pagePrevious));
this.subscribe("EndOfData",function(pct){
this.toolbars.pagingToolbar.getUiElements()["nextPage"+this.toolbars.uid].disable();
});
this.subscribe("TopOfData",function(pct){
this.toolbars.pagingToolbar.getUiElements()["previousPage"+this.toolbars.uid].disable();
});
this.subscribe("NotTopOfData",function(pct){
this.toolbars.pagingToolbar.getUiElements()["previousPage"+this.toolbars.uid].enable();
});
this.subscribe("NotEndOfData",function(pct){
this.toolbars.pagingToolbar.getUiElements()["nextPage"+this.toolbars.uid].enable();
});
};
nitobi.grid.GridLocalPage.prototype.pagePrevious=function(){
this.fire("BeforeLoadPreviousPage");
this.loadDataPage(Math.max(this.getCurrentPageIndex()-1,0));
this.fire("AfterLoadPreviousPage");
};
nitobi.grid.GridLocalPage.prototype.pageNext=function(){
this.fire("BeforeLoadNextPage");
this.loadDataPage(this.getCurrentPageIndex()+1);
this.fire("AfterLoadNextPage");
};
nitobi.grid.GridLocalPage.prototype.loadDataPage=function(_341){
this.fire("BeforeLoadDataPage");
if(_341>-1){
this.setCurrentPageIndex(_341);
this.setDisplayedRowCount(this.getRowsPerPage());
var _342=this.getCurrentPageIndex()*this.getRowsPerPage();
var rows=this.getRowsPerPage()-this.getfreezetop()-this.getfreezebottom();
this.setDisplayedRowCount(rows);
var _344=_342+rows;
if(_344>=this.getRowCount()){
this.fire("EndOfData");
}else{
this.fire("NotEndOfData");
}
if(_342==0){
this.fire("TopOfData");
}else{
this.fire("NotTopOfData");
}
this.clearSurfaces();
this.updateCellRanges();
this.scrollVertical(0);
}
this.fire("AfterLoadDataPage");
};
nitobi.grid.GridLocalPage.prototype.setRowsPerPage=function(rows){
this.setDisplayedRowCount(this.getRowsPerPage());
this.data.table.pageSize=this.getRowsPerPage();
};
nitobi.grid.GridLocalPage.prototype.pageStartIndexChanges=function(){
};
nitobi.grid.GridLocalPage.prototype.hitFirstPage=function(){
this.fire("FirstPage");
};
nitobi.grid.GridLocalPage.prototype.hitLastPage=function(){
this.fire("LastPage");
};
nitobi.grid.GridLocalPage.prototype.bind=function(){
nitobi.grid.GridStandard.base.bind.call(this);
this.finalizeRowCount(this.datatable.getRemoteRowCount());
this.bindComplete();
};
nitobi.grid.GridLocalPage.prototype.pageUpKey=function(){
this.pagePrevious();
};
nitobi.grid.GridLocalPage.prototype.pageDownKey=function(){
this.pageNext();
};
nitobi.grid.GridLocalPage.prototype.renderMiddle=function(){
nitobi.grid.GridLocalPage.base.renderMiddle.call(this,arguments);
var _346=this.getfreezetop();
endRow=this.getRowsPerPage()-1;
this.Scroller.view.midcenter.renderGap(_346,endRow,false);
};
nitobi.grid.GridNonpaging=function(_347,_348,_349){
nitobi.grid.GridNonpaging.baseConstructor.call(this);
this.mode="nonpaging";
this.setPagingMode(nitobi.grid.PAGINGMODE_NONE);
this.setDataMode(nitobi.data.DATAMODE_LOCAL);
};
nitobi.lang.extend(nitobi.grid.GridNonpaging,nitobi.grid.Grid);
nitobi.grid.GridNonpaging.prototype.createChildren=function(){
var args=arguments;
nitobi.grid.GridNonpaging.base.createChildren.call(this,args);
nitobi.grid.GridNonpaging.base.createToolbars.call(this,nitobi.ui.Toolbars.VisibleToolbars.STANDARD);
};
nitobi.grid.GridNonpaging.prototype.bind=function(){
nitobi.grid.GridStandard.base.bind.call(this);
if(this.getGetHandler()!=""){
this.ensureConnected();
this.datatable.get(0,null,this,this.getComplete);
}else{
this.finalizeRowCount(this.datatable.getRemoteRowCount());
this.bindComplete();
}
};
nitobi.grid.GridNonpaging.prototype.getComplete=function(_34b){
nitobi.grid.GridNonpaging.base.getComplete.call(this,_34b);
this.finalizeRowCount(_34b.numRowsReturned);
this.defineColumnsFinalize();
this.bindComplete();
};
nitobi.grid.GridNonpaging.prototype.renderMiddle=function(){
nitobi.grid.GridNonpaging.base.renderMiddle.call(this,arguments);
var _34c=this.getfreezetop();
endRow=this.getRowCount();
this.Scroller.view.midcenter.renderGap(_34c,endRow,false);
};
nitobi.grid.GridStandard=function(_34d,_34e,_34f){
nitobi.grid.GridStandard.baseConstructor.call(this);
this.mode="standard";
this.setPagingMode(nitobi.grid.PAGINGMODE_STANDARD);
this.setDataMode(nitobi.data.DATAMODE_PAGING);
};
nitobi.lang.extend(nitobi.grid.GridStandard,nitobi.grid.Grid);
nitobi.grid.GridStandard.prototype.createChildren=function(){
var args=arguments;
nitobi.grid.GridStandard.base.createChildren.call(this,args);
nitobi.grid.GridLiveScrolling.base.createToolbars.call(this,nitobi.ui.Toolbars.VisibleToolbars.STANDARD|nitobi.ui.Toolbars.VisibleToolbars.PAGING);
this.toolbars.subscribe("NextPage",nitobi.lang.close(this,this.pageNext));
this.toolbars.subscribe("PreviousPage",nitobi.lang.close(this,this.pagePrevious));
this.subscribe("EndOfData",this.disableNextPage);
this.subscribe("TopOfData",this.disablePreviousPage);
this.subscribe("NotTopOfData",this.enablePreviousPage);
this.subscribe("NotEndOfData",this.enableNextPage);
this.subscribe("TableConnected",nitobi.lang.close(this,this.subscribeToRowCountReady));
};
nitobi.grid.GridStandard.prototype.subscribeToRowCountReady=function(){
};
nitobi.grid.GridStandard.prototype.updateDisplayedRowCount=function(_351){
this.setDisplayedRowCount(_351.numRowsReturned);
};
nitobi.grid.GridStandard.prototype.disableNextPage=function(){
this.disableButton("nextPage");
};
nitobi.grid.GridStandard.prototype.disablePreviousPage=function(){
this.disableButton("previousPage");
};
nitobi.grid.GridStandard.prototype.disableButton=function(_352){
var t=this.getToolbars().pagingToolbar;
if(t!=null){
t.getUiElements()[_352+this.toolbars.uid].disable();
}
};
nitobi.grid.GridStandard.prototype.enableNextPage=function(){
this.enableButton("nextPage");
};
nitobi.grid.GridStandard.prototype.enablePreviousPage=function(){
this.enableButton("previousPage");
};
nitobi.grid.GridStandard.prototype.enableButton=function(_354){
var t=this.getToolbars().pagingToolbar;
if(t!=null){
t.getUiElements()[_354+this.toolbars.uid].enable();
}
};
nitobi.grid.GridStandard.prototype.pagePrevious=function(){
this.fire("BeforeLoadPreviousPage");
this.loadDataPage(Math.max(this.getCurrentPageIndex()-1,0));
this.fire("AfterLoadPreviousPage");
};
nitobi.grid.GridStandard.prototype.pageNext=function(){
this.fire("BeforeLoadNextPage");
this.loadDataPage(this.getCurrentPageIndex()+1);
this.fire("AfterLoadNextPage");
};
nitobi.grid.GridStandard.prototype.loadDataPage=function(_356){
this.fire("BeforeLoadDataPage");
if(_356>-1){
if(this.sortColumn){
if(this.datatable.sortColumn){
for(var i=0;i<this.getColumnCount();i++){
var _358=this.getColumnObject(i);
if(_358.getColumnName()==this.datatable.sortColumn){
this.setSortStyle(i,this.datatable.sortDir);
break;
}
}
}else{
this.setSortStyle(this.sortColumn.column,"",true);
}
}
this.setCurrentPageIndex(_356);
var _359=this.getCurrentPageIndex()*this.getRowsPerPage();
var rows=this.getRowsPerPage()-this.getfreezetop()-this.getfreezebottom();
this.datatable.flush();
this.datatable.get(_359,rows,this,this.afterLoadDataPage);
}
this.fire("AfterLoadDataPage");
};
nitobi.grid.GridStandard.prototype.afterLoadDataPage=function(_35b){
this.setDisplayedRowCount(_35b.numRowsReturned);
this.setRowCount(_35b.numRowsReturned);
if(_35b.numRowsReturned!=this.getRowsPerPage()){
this.fire("EndOfData");
}else{
this.fire("NotEndOfData");
}
if(this.getCurrentPageIndex()==0){
this.fire("TopOfData");
}else{
this.fire("NotTopOfData");
}
this.clearSurfaces();
this.updateCellRanges();
this.scrollVertical(0);
};
nitobi.grid.GridStandard.prototype.bind=function(){
nitobi.grid.GridStandard.base.bind.call(this);
this.setCurrentPageIndex(0);
this.disablePreviousPage();
this.enableNextPage();
this.ensureConnected();
this.datatable.get(0,this.getRowsPerPage(),this,this.getComplete);
};
nitobi.grid.GridStandard.prototype.getComplete=function(_35c){
this.afterLoadDataPage(_35c);
nitobi.grid.GridStandard.base.getComplete.call(this,_35c);
this.defineColumnsFinalize();
this.bindComplete();
};
nitobi.grid.GridStandard.prototype.renderMiddle=function(){
nitobi.grid.GridStandard.base.renderMiddle.call(this,arguments);
var _35d=this.getfreezetop();
endRow=this.getRowsPerPage()-1;
this.Scroller.view.midcenter.renderGap(_35d,endRow,false);
};
nitobi.grid.NumberColumn=function(grid,_35f){
nitobi.grid.NumberColumn.baseConstructor.call(this,grid,_35f);
this.Interface=grid.API.selectSingleNode("interfaces/interface[@name='EBANumberColumn']");
eval(nitobi.xml.transformToString(this.Interface,grid.accessorGeneratorXslProc));
};
nitobi.lang.extend(nitobi.grid.NumberColumn,nitobi.grid.Column);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnCopyEventArgs=function(_360,data,_362){
nitobi.grid.OnCopyEventArgs.baseConstructor.apply(this,arguments);
};
nitobi.lang.extend(nitobi.grid.OnCopyEventArgs,nitobi.grid.SelectionEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnPasteEventArgs=function(_363,data,_365){
nitobi.grid.OnPasteEventArgs.baseConstructor.apply(this,arguments);
};
nitobi.lang.extend(nitobi.grid.OnPasteEventArgs,nitobi.grid.SelectionEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnAfterCellEditEventArgs=function(_366,cell){
nitobi.grid.OnAfterCellEditEventArgs.baseConstructor.call(this,_366,cell);
};
nitobi.lang.extend(nitobi.grid.OnAfterCellEditEventArgs,nitobi.grid.CellEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnAfterColumnResizeEventArgs=function(_368,_369){
nitobi.grid.OnAfterColumnResizeEventArgs.baseConstructor.call(this,_368,_369);
};
nitobi.lang.extend(nitobi.grid.OnAfterColumnResizeEventArgs,nitobi.grid.ColumnEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnAfterRowDeleteEventArgs=function(_36a,row){
nitobi.grid.OnAfterRowDeleteEventArgs.baseConstructor.call(this,_36a,row);
};
nitobi.lang.extend(nitobi.grid.OnAfterRowDeleteEventArgs,nitobi.grid.RowEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnAfterRowInsertEventArgs=function(_36c,row){
nitobi.grid.OnAfterRowInsertEventArgs.baseConstructor.call(this,_36c,row);
};
nitobi.lang.extend(nitobi.grid.OnAfterRowInsertEventArgs,nitobi.grid.RowEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnAfterSortEventArgs=function(_36e,_36f,_370){
nitobi.grid.OnAfterSortEventArgs.baseConstructor.call(this,_36e,_36f);
this.direction=_370;
};
nitobi.lang.extend(nitobi.grid.OnAfterSortEventArgs,nitobi.grid.ColumnEventArgs);
nitobi.grid.OnAfterSortEventArgs.prototype.getDirection=function(){
return this.direction;
};
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnBeforeCellEditEventArgs=function(_371,cell){
nitobi.grid.OnBeforeCellEditEventArgs.baseConstructor.call(this,_371,cell);
};
nitobi.lang.extend(nitobi.grid.OnBeforeCellEditEventArgs,nitobi.grid.CellEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnBeforeColumnResizeEventArgs=function(_373,_374){
nitobi.grid.OnBeforeColumnResizeEventArgs.baseConstructor.call(this,_373,_374);
};
nitobi.lang.extend(nitobi.grid.OnBeforeColumnResizeEventArgs,nitobi.grid.ColumnEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnBeforeRowDeleteEventArgs=function(_375,row){
nitobi.grid.OnBeforeRowDeleteEventArgs.baseConstructor.call(this,_375,row);
};
nitobi.lang.extend(nitobi.grid.OnBeforeRowDeleteEventArgs,nitobi.grid.RowEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnBeforeRowInsertEventArgs=function(_377,row){
nitobi.grid.OnBeforeRowInsertEventArgs.baseConstructor.call(this,_377,row);
};
nitobi.lang.extend(nitobi.grid.OnBeforeRowInsertEventArgs,nitobi.grid.RowEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnBeforeSortEventArgs=function(_379,_37a,_37b){
nitobi.grid.OnBeforeSortEventArgs.baseConstructor.call(this,_379,_37a);
this.direction=_37b;
};
nitobi.lang.extend(nitobi.grid.OnBeforeSortEventArgs,nitobi.grid.ColumnEventArgs);
nitobi.grid.OnBeforeSortEventArgs.prototype.getDirection=function(){
return this.direction;
};
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnCellBlurEventArgs=function(_37c,cell){
nitobi.grid.OnCellBlurEventArgs.baseConstructor.call(this,_37c,cell);
};
nitobi.lang.extend(nitobi.grid.OnCellBlurEventArgs,nitobi.grid.CellEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnCellClickEventArgs=function(_37e,cell){
nitobi.grid.OnCellClickEventArgs.baseConstructor.call(this,_37e,cell);
};
nitobi.lang.extend(nitobi.grid.OnCellClickEventArgs,nitobi.grid.CellEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnCellDblClickEventArgs=function(_380,cell){
nitobi.grid.OnCellDblClickEventArgs.baseConstructor.call(this,_380,cell);
};
nitobi.lang.extend(nitobi.grid.OnCellDblClickEventArgs,nitobi.grid.CellEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnCellFocusEventArgs=function(_382,cell){
nitobi.grid.OnCellFocusEventArgs.baseConstructor.call(this,_382,cell);
};
nitobi.lang.extend(nitobi.grid.OnCellFocusEventArgs,nitobi.grid.CellEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnCellValidateEventArgs=function(_384,cell,_386,_387){
nitobi.grid.OnCellValidateEventArgs.baseConstructor.call(this,_384,cell);
this.oldValue=_387;
this.newValue=_386;
};
nitobi.lang.extend(nitobi.grid.OnCellValidateEventArgs,nitobi.grid.CellEventArgs);
nitobi.grid.OnContextMenuEventArgs=function(){
};
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.OnHeaderClickEventArgs=function(_388,_389){
nitobi.grid.OnHeaderClickEventArgs.baseConstructor.call(this,_388,_389);
};
nitobi.lang.extend(nitobi.grid.OnHeaderClickEventArgs,nitobi.grid.ColumnEventArgs);
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.PasteEventArgs=function(_38a){
this.grid=_38a;
this.event=nitobi.html.Event;
};
nitobi.grid.PasteEventArgs.prototype.getSource=function(){
return this.grid;
};
nitobi.grid.PasteEventArgs.prototype.getEvent=function(){
return this.event;
};
nitobi.grid.Row=function(grid,row){
this.grid=grid;
this.row=row;
this.Row=row;
this.Interface=this.grid.API.selectSingleNode("interfaces/interface[@name='nitobi.grid.Row']");
eval(nitobi.xml.transformToString(this.Interface,grid.accessorGeneratorXslProc));
this.DomNode=nitobi.grid.Row.getRowElement(grid,row);
this.DataNode=this.grid.datatable.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"data/"+nitobi.xml.nsPrefix+"e[@xi="+row+"]");
};
nitobi.grid.Row.prototype.getStyle=function(){
return this.DomNode.style;
};
nitobi.grid.Row.prototype.getCell=function(_38d){
return this.grid.getCellObject(this.row,_38d);
};
nitobi.grid.Row.prototype.getKey=function(_38e){
return this.grid.getCellObject(this.row,_38e);
};
nitobi.grid.Row.getRowElement=function(grid,row){
return nitobi.grid.Row.getRowElements(grid,row).mid;
};
nitobi.grid.Row.getRowElements=function(grid,row){
var _393=grid.getFrozenLeftColumnCount();
if(!_393){
return {left:null,mid:$("row_"+row+"_"+grid.uid)};
}
var rows={};
rows.left=nitobi.grid.Cell.getCellElement(grid,row,0).parentNode;
var cell=nitobi.grid.Cell.getCellElement(grid,row,_393);
rows.mid=cell?cell.parentNode:null;
return rows;
};
nitobi.grid.Row.getRowNumber=function(_396){
return parseInt(_396.getAttribute("xi"));
};
nitobi.grid.Row.prototype.xGETMETA=function(){
var node=this.MetaNode;
node=node.selectSingleNode("@"+arguments[0]);
if(node!=null){
return node.value;
}
};
nitobi.grid.Row.prototype.xSETMETA=function(){
var node=this.MetaNode;
if(null==node){
var meta=this.grid.data.selectSingleNode("//root/gridmeta");
var _39a=this.MetaNode=this.grid.data.createNode(1,"r","");
_39a.setAttribute("xi",this.row);
meta.appendChild(_39a);
node=this.MetaNode=_39a;
}
if(node!=null){
node.setAttribute(arguments[0],arguments[1][0]);
}else{
alert("Cannot set property: "+arguments[0]);
}
};
nitobi.grid.RowRenderer=function(_39b,_39c,_39d,_39e,_39f,_3a0){
this.rowHeight=_39d||23;
this.xmlDataSource=_39b;
this.dataTableId="";
this.firstColumn=_39e;
this.columns=_39f;
this.firstColumn=_39e;
this.uniqueId=_3a0;
};
nitobi.grid.RowRenderer.prototype.render=function(_3a1,rows,_3a3,_3a4,_3a5,_3a6){
if(this.xslTemplate==null){
return "";
}
var _3a1=Number(_3a1)||0;
var rows=Number(rows)||0;
if(EBA_DEBUG_MODE){
}
this.xslTemplate.addParameter("start",_3a1,"");
this.xslTemplate.addParameter("end",_3a1+rows,"");
this.xslTemplate.addParameter("activeColumn",_3a3,"");
this.xslTemplate.addParameter("activeRow",_3a4,"");
this.xslTemplate.addParameter("sortColumn",_3a5,"");
this.xslTemplate.addParameter("sortDirection",_3a6,"");
this.xslTemplate.addParameter("dataTableId",this.dataTableId,"");
var data=this.xmlDataSource.xmlDoc();
s2=nitobi.xml.transformToString(data,this.xslTemplate,"xml");
s2=s2.replace(/ATOKENTOREPLACE/g,"&nbsp;");
return s2;
};
nitobi.grid.RowRenderer.prototype.dataReady=function(_3a8){
};
nitobi.grid.RowRenderer.prototype.generateXslTemplate=function(_3a9,_3aa,_3ab,_3ac,_3ad,_3ae,_3af){
_3ad=_3ad||0;
_3ae=_3ae||0;
_3af=_3af||0;
this.columns=_3ac;
this.firstColumn=_3ab;
_3aa.addParameter("showIndicators",_3ae,"");
_3aa.addParameter("showHeaders",_3ad,"");
_3aa.addParameter("firstColumn",_3ab,"");
_3aa.addParameter("lastColumn",_3ab+_3ac,"");
_3aa.addParameter("uniqueId",this.uniqueId,"");
_3aa.addParameter("rowHover",_3af,"");
this.xmlTemplate=nitobi.xml.transformToXml(_3a9,_3aa);
try{
var path=(typeof (gApplicationPath)=="undefined"?window.location.href.substr(0,window.location.href.lastIndexOf("/")+1):gApplicationPath);
var imp=this.xmlTemplate.selectNodes("//xsl:import");
for(var i=0;i<imp.length;i++){
imp[i].setAttribute("href",path+"xsl/"+imp[i].getAttribute("href"));
}
}
catch(e){
}
this.xslTemplate=nitobi.xml.createXslProcessor(this.xmlTemplate);
};
nitobi.grid.RowRenderer.prototype.getViewableRows=function(_3b3){
return _3b3/this.rowHeight;
};
nitobi.grid.RowRenderer.prototype.getViewableColumns=function(){
};
nitobi.grid.RowRenderer.prototype.profileData=function(){
s=nitobi.xml.transformToString(data,rowXsl);
};
nitobi.grid.RowRenderer.prototype.dispose=function(){
this.xslTemplate=null;
this.xmlDataSource=null;
};
EBAScroller_RENDERTIMEOUT=50;
EBAScroller_VIEWPANES=new Array("topleft","topcenter","topright","midleft","midcenter","midright","bottomleft","bottomcenter","bottomright");
nitobi.grid.Scroller3x3=function(_3b4,_3b5,_3b6,top,_3b8,_3b9,left,_3bb,_3bc,rows,_3be,_3bf,_3c0,_3c1,_3c2,_3c3){
this.disposal=[];
this.scrollTop=0;
this.scrollLeft=0;
this.height=_3b6;
this.width=_3b5;
this.contentHeight=_3bc;
this.contentWidth=_3bb;
this.top=Math.min(Math.max(0,top),_3b6);
this.bottom=Math.min(Math.max(0,_3b9),_3b6-this.top);
this.mid=Math.max(0,_3b6-this.top-this.bottom);
this.left=Math.min(Math.max(0,left),_3b5);
this.right=Math.min(Math.max(0,_3b8),_3b5-this.left);
this.center=Math.max(0,_3b5-this.left-this.right);
this.rows=rows;
this.columns=_3be;
this.freezetop=_3bf;
this.freezeleft=_3c0;
this.freezebottom=_3c1;
this.freezeright=_3c2;
this.setSwapped(false);
this.status=0;
this.block=new Array();
this.lastScrollTop=-1;
this.uid=nitobi.base.getUid();
this.renderAll=_3c3;
this.owner=_3b4;
this.view={topleft:new nitobi.grid.Viewport(null,0,this.top,this.left),topcenter:new nitobi.grid.Viewport(null,1,this.top,this.center),topright:new nitobi.grid.Viewport(null,2,this.top,this.right),midleft:new nitobi.grid.Viewport(this.owner,3,this.mid,this.left,top,_3b8,_3b9,0),midcenter:new nitobi.grid.Viewport(this.owner,4,this.mid,this.center,top,_3b8,_3b9,left),midright:new nitobi.grid.Viewport(this.owner,5,this.mid,this.right),bottomleft:new nitobi.grid.Viewport(null,6,this.bottom,this.left),bottomcenter:new nitobi.grid.Viewport(null,7,this.bottom,this.center),bottomright:new nitobi.grid.Viewport(null,8,this.bottom,this.right)};
this.view.midleft.subscribe("HtmlReady",this.handleHtmlReady,this);
var sv=this.view;
var _3c5=this;
for(var i=0;i<3;i++){
sv[EBAScroller_VIEWPANES[i]].subscribe("HeaderUp",function(col){
_3c5.fire("HeaderUp",col);
});
sv[EBAScroller_VIEWPANES[i]].subscribe("HeaderDown",function(col){
_3c5.fire("HeaderDown",col);
});
sv[EBAScroller_VIEWPANES[i]].subscribe("HeaderClick",function(col){
_3c5.fire("HeaderClick",col);
});
}
this.setCellRanges();
this.activeView=null;
this.scrollSurface=null;
this.startRow=_3bf;
this.headerHeight=23;
this.rowHeight=23;
this.lastTimeoutId=0;
this.ScrollTopPercent=0;
this.ScrollLeftPercent=0;
};
nitobi.grid.Scroller3x3.prototype.updateCellRanges=function(cols,rows,frzL,frzT,frzR,frzB){
this.columns=cols;
this.rows=rows;
this.freezetop=frzT;
this.freezebottom=frzB;
this.freezeleft=frzL;
this.freezeright=frzR;
this.setCellRanges();
};
nitobi.grid.Scroller3x3.prototype.getTopOffset=function(){
var _3d0=0;
var _3d1=null;
return _3d0;
};
nitobi.grid.Scroller3x3.prototype.setCellRanges=function(){
var _3d2=this.getTopOffset();
var _3d3=null;
if(this.implementsStandardPaging()){
_3d3=this.getDisplayedRowCount();
}
this.view.topleft.setCellRanges(0+_3d2,this.freezetop,0,this.freezeleft);
this.view.topcenter.setCellRanges(0+_3d2,this.freezetop,this.freezeleft,this.columns-this.freezeleft-this.freezeright);
this.view.midleft.setCellRanges(_3d2+this.freezetop,(_3d3?_3d3:this.rows)-this.freezebottom-this.freezetop,0,this.freezeleft);
this.view.midcenter.setCellRanges(_3d2+this.freezetop,(_3d3?_3d3:this.rows)-this.freezebottom-this.freezetop,this.freezeleft,this.columns-this.freezeleft-this.freezeright);
this.view.midright.setCellRanges(_3d2+this.freezetop,(_3d3?_3d3:this.rows)-this.freezebottom-this.freezetop,this.columns-this.freezeright,this.freezeright);
this.view.bottomleft.setCellRanges(this.rows-1-this.freezebottom,this.freezebottom,0,this.freezeleft);
this.view.bottomcenter.setCellRanges(this.rows-1-this.freezebottom,this.freezebottom,this.freezeleft,this.columns-this.freezeleft-this.freezeright);
this.view.bottomright.setCellRanges(this.rows-1-this.freezebottom,this.freezebottom,this.columns-this.freezeright,this.freezeright);
};
nitobi.grid.Scroller3x3.prototype.resize=function(_3d4,_3d5,top,_3d7,_3d8,left,_3da,_3db){
this.height=_3d5;
this.width=_3d4;
this.contentHeight=_3db;
this.contentWidth=_3da;
this.top=Math.min(Math.max(0,top),_3d5);
this.bottom=Math.min(Math.max(0,_3d8),_3d5-this.top);
this.mid=Math.max(0,_3d5-this.top-this.bottom);
this.left=Math.min(Math.max(0,left),_3d4);
this.right=Math.min(Math.max(0,_3d7),_3d4-this.left);
this.center=Math.max(0,_3d4-this.left-this.right);
this.view.topleft.setPosition(this.top,this.left);
this.view.topcenter.setPosition(this.top,this.center);
this.view.midleft.setPosition(this.mid,this.left,top,_3d7,_3d8,left);
this.view.midcenter.setPosition(this.top,this.left,top,_3d7,_3d8,left);
this.view.midright.setPosition(this.mid,this.right);
this.view.bottomleft.setPosition(this.bottom,this.left);
this.view.bottomcenter.setPosition(this.bottom,this.center);
this.view.bottomright.setPosition(this.bottom,this.right);
};
nitobi.grid.Scroller3x3.prototype.setScrollLeftRelative=function(_3dc){
this.setScrollLeft(this.scrollLeft+_3dc);
};
nitobi.grid.Scroller3x3.prototype.setScrollLeftPercent=function(_3dd){
this.scrollLeftPercent=_3dd;
this.setScrollLeft(Math.round((this.view.midcenter.element.scrollWidth-this.view.midcenter.element.clientWidth)*_3dd));
};
nitobi.grid.Scroller3x3.prototype.setScrollLeft=function(_3de){
this.swapPanes(true);
this.scrollLeft=_3de;
this.view.midcenter.element.scrollLeft=_3de;
};
nitobi.grid.Scroller3x3.prototype.setScrollTopRelative=function(_3df){
this.setScrollTop(this.scrollTop+_3df);
};
nitobi.grid.Scroller3x3.prototype.setScrollTopPercent=function(_3e0){
this.scrollTopPercent=_3e0;
this.setScrollTop(Math.round((this.view.midcenter.element.scrollHeight-this.view.midcenter.element.clientHeight)*_3e0));
};
nitobi.grid.Scroller3x3.prototype.setScrollTop=function(_3e1){
this.swapPanes(false);
this.scrollTop=_3e1;
this.view.midcenter.element.scrollTop=_3e1;
this.render();
this.status=1;
};
nitobi.grid.Scroller3x3.prototype.updateSurface=function(){
};
nitobi.grid.Scroller3x3.prototype.clearSurfaces=function(_3e2,_3e3,_3e4,_3e5){
this.flushCache();
_3e4=true;
if(_3e2){
_3e3=true;
_3e4=true;
_3e5=true;
}
if(_3e3){
this.view.topleft.clear(true);
this.view.topcenter.clear(true);
}
if(_3e4){
this.view.midleft.clear(false,true,false,false);
this.view.midcenter.clear(false,false,true);
}
if(_3e5){
}
};
nitobi.grid.Scroller3x3.prototype.alignSurfaces=function(){
var v=this.view;
var fs=v.topcenter.surface.element;
var fh=v.topcenter.element;
var hp=v.topcenter.placeholder;
var ff=v.bottomcenter.surface.element;
var su=nitobi.html.getFirstChild(v.midcenter.element);
var da=v.midcenter.surface.element;
var le=v.midleft.placeholder;
var lb=v.midleft.element;
var lh=v.topleft.element;
var lf=v.bottomleft.element;
var ri=v.midright.placeholder;
var rb=v.midright.element;
var rf=v.bottomright.element;
var vp=v.midcenter.element;
var hb=v.topcenter.element;
var fb=v.bottomcenter.element;
da.style.height=this.contentHeight+"px";
su.style.height=this.contentHeight+"px";
le.style.height=this.contentHeight+"px";
ri.style.height=this.contentHeight+"px";
da.style.width=this.contentWidth+"px";
su.style.width=this.contentWidth+"px";
fs.style.width=(this.contentWidth-this.right)+"px";
ff.style.width=this.contentWidth+"px";
lb.style.width=this.left+"px";
lf.style.width="0px";
su.style.backgroundColor="#FFFFFF";
da.style.backgroundColor="#FFFFFF";
nitobi.drawing.align(su,vp,nitobi.drawing.align.ALIGNTOP|nitobi.drawing.align.ALIGNBOTTOM,0,0,0,0);
if(this.owner.getToolbars()!=null&&!this.owner.getToolbars().areAnyToolbarsDocked()){
}
nitobi.drawing.align(le,su,nitobi.drawing.align.SAMEHEIGHT|nitobi.drawing.align.ALIGNTOP|nitobi.drawing.align.ALIGNLEFT,0,0,this.top,this.view.midcenter.element.scrollLeft);
nitobi.drawing.align(lb,vp,nitobi.drawing.align.SAMEHEIGHT|nitobi.drawing.align.ALIGNTOP|nitobi.drawing.align.ALIGNLEFT,-(this.top+this.bottom),0,this.top,0);
nitobi.drawing.align(rb,vp,nitobi.drawing.align.SAMEHEIGHT|nitobi.drawing.align.ALIGNTOP|nitobi.drawing.align.ALIGNRIGHT,-(this.top+this.bottom),0,this.top,0);
nitobi.drawing.align(rf,vp,nitobi.drawing.align.ALIGNBOTTOM|nitobi.drawing.align.ALIGNRIGHT);
nitobi.drawing.align(lf,vp,nitobi.drawing.align.ALIGNBOTTOM|nitobi.drawing.align.ALIGNLEFT);
nitobi.drawing.align(hb,vp,nitobi.drawing.align.SAMEWIDTH|nitobi.drawing.align.ALIGNTOP,0,0,0,0);
nitobi.drawing.align(hp,vp,nitobi.drawing.align.SAMEWIDTH|nitobi.drawing.align.ALIGNTOP|nitobi.drawing.align.ALIGNLEFT,0,0,0,0);
nitobi.drawing.align(fb,vp,nitobi.drawing.align.ALIGNBOTTOM|nitobi.drawing.align.ALIGNLEFT,0,0,0,this.left);
if(nitobi.browser.IE){
fh.style.position="absolute";
}
nitobi.drawing.align(lh,vp,nitobi.drawing.align.ALIGNTOP|nitobi.drawing.align.ALIGNLEFT);
nitobi.drawing.align(da,su,269488128,0,0,this.top,0);
};
nitobi.grid.Scroller3x3.prototype.mapToHtml=function(_3f7){
if(_3f7.getAttribute("parentid")){
_3f7=document.getElementById(_3f7.getAttribute("parentid"));
}else{
_3f7=nitobi.html.getFirstChild(_3f7);
}
this.view.topleft.mapToHtml(nitobi.html.getDomNodeByPath(_3f7,"3"),nitobi.html.getDomNodeByPath(_3f7,"3/0"),null);
this.view.topcenter.mapToHtml(nitobi.html.getDomNodeByPath(_3f7,"7"),nitobi.html.getDomNodeByPath(_3f7,"7/0"),nitobi.html.getDomNodeByPath(_3f7,"0/0/3"));
this.view.midleft.mapToHtml(nitobi.html.getDomNodeByPath(_3f7,"1"),nitobi.html.getDomNodeByPath(_3f7,"1/0"),nitobi.html.getDomNodeByPath(_3f7,"0/0/1"));
this.view.midcenter.mapToHtml(nitobi.html.getDomNodeByPath(_3f7,"0"),nitobi.html.getDomNodeByPath(_3f7,"0/0/0"),null);
this.view.midright.mapToHtml(nitobi.html.getDomNodeByPath(_3f7,"2"),nitobi.html.getDomNodeByPath(_3f7,"2/0"),nitobi.html.getDomNodeByPath(_3f7,"0/0/2"));
this.view.bottomleft.mapToHtml(nitobi.html.getDomNodeByPath(_3f7,"4"),nitobi.html.getDomNodeByPath(_3f7,"4/0"),null);
this.view.bottomcenter.mapToHtml(nitobi.html.getDomNodeByPath(_3f7,"8"),nitobi.html.getDomNodeByPath(_3f7,"8/0"),nitobi.html.getDomNodeByPath(_3f7,"0/0/0/2"));
this.view.bottomright.mapToHtml(nitobi.html.getDomNodeByPath(_3f7,"6"),nitobi.html.getDomNodeByPath(_3f7,"6/0"),null);
this.scrollSurface=nitobi.html.getDomNodeByPath(_3f7,"0");
var sv=this.view;
for(var i=0;i<EBAScroller_VIEWPANES.length;i++){
sv[EBAScroller_VIEWPANES[i]].owner=this.owner;
sv[EBAScroller_VIEWPANES[i]].onFocus="this.owner.activate(e);";
sv[EBAScroller_VIEWPANES[i]].onEdit="this.owner.edit(evt);";
sv[EBAScroller_VIEWPANES[i]].onMove="this.owner.selectionMoved();";
}
};
nitobi.grid.Scroller3x3.prototype.getRowRange=function(){
var pair={first:this.freezetop,last:this.rows-1-this.freezetop-this.freezebottom};
if(!this.implementsShowAll()){
var top=0;
var _3fc=0;
var _3fd=0;
var _3fe=this.scrollSurface.scrollTop+this.top-this.headerHeight;
if(_3fd>this.startRow){
_3fd--;
}
if(top<_3fe){
_3fd+=Math.floor((_3fe-top)/this.rowHeight);
}
_3fd+=_3fc;
var _3ff=0;
var _400=0;
var _401=this.scrollSurface.clientHeight-this.top-this.bottom;
if(_3ff<_401){
_400+=Math.ceil((_401-_3ff)/this.rowHeight);
}
_400+=_3fd;
_400=Math.min(this.rows-1,_400+(_400-_3fd)+5);
_3fd=Math.max(_3fd,0);
if(this.implementsStandardPaging()){
var _402=0;
if(this.owner.getRenderMode()==nitobi.grid.RENDERMODE_ONDEMAND){
var _403=_3fd+_402;
var last=Math.min(_400+_402,_402+this.getDisplayedRowCount()-1);
pair={first:_403,last:last};
}else{
var _403=_402;
var last=_403+this.getDisplayedRowCount()-1;
pair={first:_403,last:last};
}
}else{
pair={first:_3fd,last:_400};
}
}
return pair;
};
nitobi.grid.Scroller3x3.prototype.fixPanes=function(){
this.swapPanes(true);
this.swapPanes(false);
};
nitobi.grid.Scroller3x3.prototype.swapPanes=function(_405){
if(_405){
if(!this.getSwapped()){
var _406=this.view.midleft.placeholder;
_406.style.left="0px";
_406.swapNode(this.view.midleft.surface.element);
_406.style.top=(0-this.view.midcenter.element.scrollTop)+"px";
var _407=this.view.midright.placeholder;
_407.swapNode(this.view.midright.surface.element);
_407.style.top=(0-this.view.midcenter.element.scrollTop)+"px";
_407.style.left="0px";
this.view.topcenter.placeholder.swapNode(this.view.topcenter.surface.element);
this.view.bottomcenter.placeholder.swapNode(this.view.bottomcenter.surface.element);
this.view.topcenter.surface.element.style.left=(this.left)+"px";
var oy=0;
if(!nitobi.browser.IE){
oy=this.scrollSurface.scrollTop;
}
nitobi.drawing.align(this.view.topcenter.surface.element,this.view.topcenter.element,1048576,0,0,oy,0);
this.view.topcenter.surface.element.style.zIndex=10000000;
this.view.topcenter.element.style.visibility="hidden";
this.view.bottomcenter.surface.element.style.left=(this.left)+"px";
nitobi.drawing.align(this.view.bottomcenter.surface.element,this.view.bottomcenter.element,1048576,0,0,oy,0);
this.view.bottomcenter.surface.element.style.zIndex=10000000;
this.view.bottomcenter.element.style.visibility="hidden";
this.view.midleft.element.style.visibility="visible";
this.view.midright.element.style.visibility="visible";
this.setSwapped(true);
}
}else{
if(this.getSwapped()){
this.view.midleft.surface.element.swapNode(this.view.midleft.placeholder);
this.view.midleft.placeholder.style.top=(-this.view.midcenter.element.scrollHeight+this.top)+"px";
this.view.midright.surface.element.swapNode(this.view.midright.placeholder);
if(nitobi.browser.IE){
nitobi.drawing.align(this.view.midright.placeholder,this.view.midright.element,16781312,0,0,0,0);
}else{
nitobi.drawing.align(this.view.midright.placeholder,this.view.midright.element,16781312,0,0,0,this.view.midcenter.element.scrollLeft);
}
this.view.midright.placeholder.style.top=(-(2*this.view.midcenter.element.scrollHeight)+this.top)+"px";
this.view.topcenter.placeholder.swapNode(this.view.topcenter.surface.element);
this.view.bottomcenter.placeholder.swapNode(this.view.bottomcenter.surface.element);
this.view.topcenter.surface.element.style.top="0px";
this.view.topcenter.surface.element.style.left=(0-this.view.midcenter.element.scrollLeft)+"px";
this.view.bottomcenter.surface.element.style.top="0px";
this.view.bottomcenter.surface.element.style.left=(0-this.view.midcenter.element.scrollLeft)+"px";
this.view.topcenter.element.style.visibility="visible";
this.view.bottomcenter.element.style.visibility="visible";
this.view.midleft.element.style.visibility="hidden";
this.view.midright.element.style.visibility="hidden";
this.view.midleft.placeholder.style.left=(this.view.midcenter.element.scrollLeft)+"px";
this.setSwapped(false);
}
}
};
nitobi.grid.Scroller3x3.prototype.render=function(){
if(this.owner.isBound()&&this.scrollSurface.scrollTop!=this.lastScrollTop){
var _409=this.getRowRange();
if(!this.rendered(_409)){
var _40a=nitobi.lang.close(this,this.renderReady,[]);
window.clearTimeout(this.lastTimeoutId);
this.lastTimeoutId=window.setTimeout(_40a,EBAScroller_RENDERTIMEOUT);
}else{
}
}
};
nitobi.grid.Scroller3x3.prototype.renderReady=function(){
var _40b=this.getRowRange();
if(this.view.midcenter.render(_40b)){
this.view.midleft.render(_40b);
}
this.fire("RenderComplete");
};
nitobi.grid.Scroller3x3.prototype.rendered=function(_40c){
if(_40c==null){
_40c=this.getRowRange();
}
var _40d=this.view.midcenter.cacheMap.gaps(_40c.first,_40c.last+10);
return Boolean(_40d[0]==null);
};
nitobi.grid.Scroller3x3.prototype.reRender=function(_40e,_40f){
var _410=this.view.midleft.getBlocks(_40e,_40f);
var _411=this.view.midcenter.getBlocks(_40e,_40f);
this.render();
for(var i=0;i<_410.length;i++){
_410[i].parentNode.removeChild(_410[i]);
}
_410=null;
for(var i=0;i<_411.length;i++){
_411[i].parentNode.removeChild(_411[i]);
}
_411=null;
};
nitobi.grid.Scroller3x3.prototype.flushCache=function(){
for(var i=0;i<EBAScroller_VIEWPANES.length;i++){
eval("this.view."+EBAScroller_VIEWPANES[i]+".flushCache()");
}
};
nitobi.grid.Scroller3x3.prototype.position=function(cell){
};
nitobi.grid.Scroller3x3.prototype.getViewportByCoords=function(row,_416){
var _417=this.getTopOffset();
if(row>=_417&&row<this.owner.getfreezetop()&&_416>=0&&_416<this.owner.frozenLeftColumnCount()){
return this.view.topleft;
}
if(row>=_417&&row<this.owner.getfreezetop()&&_416>=this.owner.getFrozenLeftColumnCount()&&_416<this.owner.getColumnCount()){
return this.view.topcenter;
}
if(row>=this.owner.getfreezetop()+_417&&row<this.owner.getDisplayedRowCount()+_417&&_416>=0&&_416<this.owner.getFrozenLeftColumnCount()){
return this.view.midleft;
}
if(row>=this.owner.getfreezetop()+_417&&row<this.owner.getDisplayedRowCount()+_417&&_416>=this.owner.getFrozenLeftColumnCount()&&_416<this.owner.getColumnCount()){
return this.view.midcenter;
}
};
nitobi.grid.Scroller3x3.prototype.getRowsPerPage=function(){
return this.owner.getRowsPerPage();
};
nitobi.grid.Scroller3x3.prototype.getDisplayedRowCount=function(){
return this.owner.getDisplayedRowCount();
};
nitobi.grid.Scroller3x3.prototype.getCurrentPageIndex=function(){
return this.owner.getCurrentPageIndex();
};
nitobi.grid.Scroller3x3.prototype.implementsStandardPaging=function(){
return Boolean(this.owner.getPagingMode().toLowerCase()=="standard");
};
nitobi.grid.Scroller3x3.prototype.implementsShowAll=function(){
return Boolean(this.owner.getPagingMode().toLowerCase()==nitobi.grid.PAGINGMODE_NONE);
};
nitobi.grid.Scroller3x3.prototype.setLeftPaneWidth=function(_418){
this.left=parseInt(_418);
};
nitobi.grid.Scroller3x3.prototype.getLeftPaneWidth=function(){
return this.left;
};
nitobi.grid.Scroller3x3.prototype.setDataTable=function(_419){
this.setViewportProperty("DataTable",_419);
};
nitobi.grid.Scroller3x3.prototype.setSwapped=function(_41a){
this.swapped=_41a;
};
nitobi.grid.Scroller3x3.prototype.getSwapped=function(){
return this.swapped;
};
nitobi.grid.Scroller3x3.prototype.handleHtmlReady=function(){
this.fire("HtmlReady");
};
nitobi.grid.Scroller3x3.prototype.dispose=function(){
try{
var _41b=this.disposal.length;
for(var i=0;i<_41b;i++){
if(typeof (this.disposal[i])=="function"){
this.disposal[i].call(this);
}
this.disposal[i]=null;
}
for(var v in this.view){
this.view[v].dispose();
}
for(var item in this){
if(this[item]!=null&&this[item].dispose instanceof Function){
this[item].dispose();
}
}
}
catch(e){
}
};
nitobi.grid.Scroller3x3.prototype.setRowHeight=function(_41f){
this.rowHeight=_41f;
this.setViewportProperty("RowHeight",_41f);
};
nitobi.grid.Scroller3x3.prototype.setHeaderHeight=function(_420){
this.headerHeight=_420;
this.setViewportProperty("HeaderHeight",_420);
};
nitobi.grid.Scroller3x3.prototype.setViewportProperty=function(_421,_422){
var sv=this.view;
for(var i=0;i<EBAScroller_VIEWPANES.length;i++){
sv[EBAScroller_VIEWPANES[i]]["set"+_421](_422);
}
};
nitobi.grid.Scroller3x3.prototype.fire=function(evt,args){
return nitobi.event.notify(evt+this.uid,args);
};
nitobi.grid.Scroller3x3.prototype.subscribe=function(evt,func,_429){
if(typeof (_429)=="undefined"){
_429=this;
}
return nitobi.event.subscribe(evt+this.uid,nitobi.lang.close(_429,func));
};
nitobi.grid.Selection=function(_42a){
nitobi.grid.Selection.baseConstructor.call(this,_42a);
this.owner=_42a;
var t=new Date();
this.selecting=false;
this.resizingRow=false;
this.created=false;
this.freezeTop=this.owner.getfreezetop();
this.freezeLeft=this.owner.getFrozenLeftColumnCount();
this.rowHeight=23;
};
nitobi.lang.extend(nitobi.grid.Selection,nitobi.collections.CellSet);
nitobi.grid.Selection.prototype.setRange=function(_42c,_42d,_42e,_42f){
nitobi.grid.Selection.base.setRange.call(this,_42c,_42d,_42e,_42f);
this.startCell=this.owner.getCellElement(_42c,_42d);
this.endCell=this.owner.getCellElement(_42e,_42f);
};
nitobi.grid.Selection.prototype.setRangeWithDomNodes=function(_430,_431){
this.setRange(nitobi.grid.Cell.getRowNumber(_430),nitobi.grid.Cell.getColumnNumber(_430),nitobi.grid.Cell.getRowNumber(_431),nitobi.grid.Cell.getColumnNumber(_431));
};
nitobi.grid.Selection.prototype.createBoxes=function(){
if(!this.created){
var _432="<div style=\"\" class=\"ebaselectionbackground\"></div>";
this.box=document.createElement("div");
this.box.id="selectbox"+this.owner.uid;
this.box.className="ebaselectionborder";
this.box.style.overflow="hidden";
this.box.style.height=10+"px";
this.box.style.width=10+"px";
this.box.innerHTML=_432;
this.boxtl=document.createElement("div");
this.boxtl.id="selectboxtl"+this.owner.uid;
this.boxtl.className="ebaselectionborder";
this.boxtl.style.overflow="hidden";
this.boxtl.style.height=10+"px";
this.boxtl.style.width=10+"px";
this.boxtl.innerHTML=_432;
this.boxt=document.createElement("div");
this.boxt.id="selectboxt"+this.owner.uid;
this.boxt.className="ebaselectionborder";
this.boxt.style.overflow="hidden";
this.boxt.style.height=10+"px";
this.boxt.style.width=10+"px";
this.boxt.innerHTML=_432;
this.boxl=document.createElement("div");
this.boxl.id="selectboxl"+this.owner.uid;
this.boxl.className="ebaselectionborder";
this.boxl.style.overflow="hidden";
this.boxl.style.height=10+"px";
this.boxl.style.width=10+"px";
this.boxl.zIndex=10000001;
this.boxl.innerHTML=_432;
this.events=[{"type":"mousemove","handler":this.shrink},{"type":"mouseup","handler":this.stopSelecting},{"type":"click","handler":this.handleClick},{"type":"dblclick","handler":this.handleClick}];
nitobi.html.attachEvents(this.box,this.events,this);
nitobi.html.attachEvents(this.boxl,this.events,this);
nitobi.html.attachEvents(this.boxt,this.events,this);
var sv=this.owner.Scroller.view;
sv.midcenter.surface.element.appendChild(this.box);
sv.topleft.element.appendChild(this.boxtl);
sv.topcenter.container.appendChild(this.boxt);
sv.midleft.container.firstChild.appendChild(this.boxl);
this.clear();
this.created=true;
}
};
nitobi.grid.Selection.prototype.clearBoxes=function(){
if(this.box!=null){
this.clearBox(this.box);
}
if(this.box1!=null){
this.clearBox(this.box1);
}
if(this.boxt!=null){
this.clearBox(this.boxt);
}
this.created=false;
};
nitobi.grid.Selection.prototype.clearBox=function(box){
nitobi.html.detachEvents(box,this.events);
if(box.parentNode!=null){
box.parentNode.removeChild(box);
}
box=null;
};
nitobi.grid.Selection.prototype.shrink=function(evt){
if(this.endCell!=this.startCell&&this.selecting){
var _436=this.owner.getScrollSurface();
var _437=this.endCell.getBoundingClientRect(_436.scrollTop+document.body.scrollTop,_436.scrollLeft+document.body.scrollLeft);
var _438=_437.top;
var _439=_437.left;
var _43a=nitobi.grid.Cell.getRowNumber(this.endCell);
var _43b=nitobi.grid.Cell.getColumnNumber(this.endCell);
var evtY=evt.clientY;
var evtX=evt.clientX;
if(_43a>nitobi.grid.Cell.getRowNumber(this.startCell)&&evtY<_438){
var diff=_438-evtY;
_43a=_43a-Math.floor(diff/this.rowHeight)-1;
}else{
if(evtY>_438+(_437.bottom-_438)){
var diff=evtY-_438;
_43a=_43a+Math.floor(diff/this.rowHeight);
}
}
if(_43b>nitobi.grid.Cell.getColumnNumber(this.startCell)&&evtX<_439){
_43b--;
}else{
if(evtX>_439+(_437.right-_439)){
_43b++;
}
}
var _43f=this.owner.getCellElement(_43a,_43b);
if(_43f!=null&&_43f!=this.endCell){
this.changeEndCellWithDomNode(_43f);
this.alignBoxes();
this.owner.Scroller.getViewportByCoords(_43a,_43b).ensureCellInView(_43f);
}
}
};
nitobi.grid.Selection.prototype.getHeight=function(){
var rect=this.box.getBoundingClientRect();
return rect.top-rect.bottom;
};
nitobi.grid.Selection.prototype.collapse=function(cell){
if(!cell){
cell=this.startCell;
}
if(!cell){
return;
}
this.setRangeWithDomNodes(cell,cell);
if((this.box==null)||(this.box.parentNode==null)||(this.boxl==null)||(this.boxl.parentNode==null)){
this.created=false;
this.createBoxes();
}
if(null==this.boxt.parentNode){
this.owner.Scroller.view.topcenter.container.appendChild(this.boxt);
}
this.alignBoxes();
this.selecting=false;
};
nitobi.grid.Selection.prototype.startSelecting=function(_442,_443){
this.selecting=true;
this.setRangeWithDomNodes(_442,_443);
this.shrink();
document.body.attachEvent("onselectstart",function(){
return false;
});
};
nitobi.grid.Selection.prototype.clearSelection=function(cell){
this.collapse(cell);
};
nitobi.grid.Selection.prototype.resizeSelection=function(cell){
this.endCell=cell;
this.shrink();
};
nitobi.grid.Selection.prototype.moveSelection=function(cell){
this.collapse(cell);
};
nitobi.grid.Selection.prototype.alignBoxes=function(){
var _447=this.endCell||this.startCell;
var sc=this.getCoords();
var _449=sc.top.y;
var _44a=sc.top.x;
var _44b=sc.bottom.y;
var _44c=sc.bottom.x;
var ox=(nitobi.browser.IE)?-2:-1;
var oy=(nitobi.browser.IE)?-2:-1;
if(_44c>=this.freezeLeft&&_44b>=this.freezeTop){
this.box.style.display="block";
this.align(this.box,this.startCell,_447,286265344,3,3,oy,ox);
}else{
this.box.style.display="none";
}
if(_44a<=this.freezeLeft&&_449<=this.freezeTop){
this.boxtl.style.display="block";
this.align(this.boxtl,this.startCell,_447,286265344,3,3,oy,ox);
}else{
this.boxtl.style.display="none";
}
if(_449<=this.freezeTop){
this.boxt.style.display="block";
this.align(this.boxt,this.startCell,_447,286265344,3,3,oy,ox);
}else{
this.boxt.style.display="none";
}
if(_44c<this.freezeLeft||_44a<this.freezeLeft){
this.boxl.style.display="block";
this.align(this.boxl,this.startCell,_447,286265344,3,3,oy,ox);
}else{
this.boxl.style.display="none";
}
};
nitobi.grid.Selection.prototype.redraw=function(cell){
if(!this.selecting){
this.setRangeWithDomNodes(cell,cell);
}else{
this.changeEndCellWithDomNode(cell);
}
this.alignBoxes();
};
nitobi.grid.Selection.prototype.changeStartCellWithDomNode=function(cell){
this.startCell=cell;
this.changeStartCell(nitobi.grid.Cell.getRowNumber(cell),nitobi.grid.Cell.getColumnNumber(cell));
};
nitobi.grid.Selection.prototype.changeEndCellWithDomNode=function(cell){
this.endCell=cell;
this.changeEndCell(nitobi.grid.Cell.getRowNumber(cell),nitobi.grid.Cell.getColumnNumber(cell));
};
nitobi.grid.Selection.prototype.init=function(cell){
this.createBoxes();
var t=new Date();
this.selecting=true;
this.setRangeWithDomNodes(cell,cell);
};
nitobi.grid.Selection.prototype.clear=function(){
if(!this.box){
return;
}
this.box.style.display="none";
this.box.style.top=-1000+"px";
this.box.style.left=-1000+"px";
this.box.style.width=1+"px";
this.box.style.height=1+"px";
this.boxtl.style.display="none";
this.boxtl.style.top=-1000+"px";
this.boxtl.style.left=-1000+"px";
this.boxtl.style.width=1+"px";
this.boxtl.style.height=1+"px";
this.boxt.style.display="none";
this.boxt.style.top=-1000+"px";
this.boxt.style.left=-1000+"px";
this.boxt.style.width=1+"px";
this.boxt.style.height=1+"px";
this.boxl.style.display="none";
this.boxl.style.top=-1000+"px";
this.boxl.style.left=-1000+"px";
this.boxl.style.width=1+"px";
this.boxl.style.height=1+"px";
this.selecting=false;
};
nitobi.grid.Selection.prototype.handleClick=function(evt){
if(!this.selected()){
if(NTB_SINGLECLICK==null){
NTB_SINGLECLICK=window.setTimeout(nitobi.lang.close(this,this.edit,[evt]),200);
}else{
window.clearTimeout(NTB_SINGLECLICK);
NTB_SINGLECLICK=null;
if(this.owner.handleDblClick(evt)){
this.edit(evt);
}
}
}else{
this.collapse();
}
};
nitobi.grid.Selection.prototype.edit=function(evt){
NTB_SINGLECLICK=null;
this.owner.edit(evt);
};
nitobi.grid.Selection.prototype.select=function(_456,_457){
this.selectWithCoords(_456.getRowNumber(),_456.getColumnNumber(),_457.getRowNumber(),_457.getColumnNumber());
};
nitobi.grid.Selection.prototype.selectWithCoords=function(_458,_459,_45a,_45b){
this.setRange(_458,_459,_45a,_45b);
this.createBoxes();
this.alignBoxes();
};
nitobi.grid.Selection.prototype.stopSelecting=function(){
this.selecting=true;
if(!this.selected()){
this.collapse(this.startCell);
}
this.selecting=false;
this.owner.Scroller.swapPanes(false);
};
nitobi.grid.Selection.prototype.getRowByCoords=function(_45c){
return (_45c.parentNode.offsetTop/_45c.parentNode.offsetHeight);
};
nitobi.grid.Selection.prototype.getColumnByCoords=function(_45d){
var _45e=(this.indicator?-2:0);
if(_45d.parentNode.parentNode.getAttribute("id").substr(0,6)!="freeze"){
_45e+=2-(this.freezeColumn*3);
}else{
_45e+=2;
}
return Math.floor((_45d.sourceIndex-_45d.parentNode.sourceIndex-_45e)/3);
};
nitobi.grid.Selection.prototype.selected=function(){
return (this.endCell==this.startCell)?false:true;
};
nitobi.grid.Selection.prototype.setRowHeight=function(_45f){
this.rowHeight=_45f;
};
nitobi.grid.Selection.prototype.getRowHeight=function(){
return this.rowHeight;
};
nitobi.grid.Selection.prototype.dispose=function(){
};
nitobi.grid.Selection.prototype.align=function(_460,_461,_462,_463,oh,ow,oy,ox,show){
oh=oh||0;
ow=ow||0;
oy=oy||0;
ox=ox||0;
var a=_463;
var td,sd,tt,tb,tl,tr,th,tw,st,sb,sl,sr,sh,sw;
if(!_461||!(_461.getBoundingClientRect)){
return;
}
ad=_461.getBoundingClientRect();
bd=_462.getBoundingClientRect();
sd=_460.getBoundingClientRect();
at=ad.top;
ab=ad.bottom;
al=ad.left;
ar=ad.right;
bt=bd.top;
bb=bd.bottom;
bl=bd.left;
br=bd.right;
tt=ad.top;
tb=bd.bottom;
tl=ad.left;
tr=bd.right;
th=Math.abs(tb-tt);
tw=Math.abs(tr-tl);
st=sd.top;
sb=sd.bottom;
sl=sd.left;
sr=sd.right;
sh=Math.abs(sb-st);
sw=Math.abs(sr-sl);
if(a&268435456){
_460.style.height=(Math.max(bb-at,ab-bt)+oh)+"px";
}
if(a&16777216){
_460.style.width=(Math.max(br-al,ar-bl)+ow)+"px";
}
if(a&1048576){
_460.style.top=(nitobi.html.getStyleTop(_460)+Math.min(tt,bt)-st+oy)+"px";
}
if(a&65536){
_460.style.top=(nitobi.html.getStyleTop(_460)+tt-st+th-sh+oy)+"px";
}
if(a&4096){
_460.style.left=(nitobi.html.getStyleLeft(_460)-sl+Math.min(tl,bl)+ox)+"px";
}
if(a&256){
_460.style.left=(nitobi.html.getStyleLeft(_460)-sl+tl+tw-sw+ox)+"px";
}
if(a&16){
_460.style.top=(nitobi.html.getStyleTop(_460)+tt-st+oy+Math.floor((th-sh)/2))+"px";
}
if(a&1){
_460.style.left=(nitobi.html.getStyleLeft(_460)-sl+tl+ox+Math.floor((tw-sw)/2))+"px";
}
};
nitobi.grid.Surface=function(_478,_479,_47a){
this.height=_479;
this.width=_478;
this.element=_47a;
};
nitobi.grid.Surface.prototype.dispose=function(){
this.element=null;
};
nitobi.grid.TextColumn=function(grid,_47c){
nitobi.grid.TextColumn.baseConstructor.call(this,grid,_47c);
this.Interface=grid.API.selectSingleNode("interfaces/interface[@name='EBATextColumn']");
eval(nitobi.xml.transformToString(this.Interface,grid.accessorGeneratorXslProc));
};
nitobi.lang.extend(nitobi.grid.TextColumn,nitobi.grid.Column);
nitobi.lang.defineNs("nitobi.ui");
nitobi.ui.Toolbars=function(_47d){
this.uid="nitobiToolbar_"+nitobi.base.getUid();
this.toolbars={};
this.visibleToolbars=_47d;
};
nitobi.ui.Toolbars.VisibleToolbars={};
nitobi.ui.Toolbars.VisibleToolbars.STANDARD=1;
nitobi.ui.Toolbars.VisibleToolbars.PAGING=1<<1;
nitobi.ui.Toolbars.prototype.initialize=function(){
this.enabled=true;
this.toolbarXml=nitobi.xml.createXmlDoc(nitobi.xml.serialize(nitobi.grid.toolbarDoc));
this.toolbarPagingXml=nitobi.xml.createXmlDoc(nitobi.xml.serialize(nitobi.grid.pagingToolbarDoc));
};
nitobi.ui.Toolbars.prototype.attachToParent=function(_47e){
this.initialize();
this.container=_47e;
if(this.standardToolbar==null&&this.visibleToolbars){
this.makeToolbar();
this.render();
}
};
nitobi.ui.Toolbars.prototype.setWidth=function(_47f){
this.width=_47f;
};
nitobi.ui.Toolbars.prototype.getWidth=function(){
return this.width;
};
nitobi.ui.Toolbars.prototype.setRowInsertEnabled=function(_480){
this.rowInsertEnabled=_480;
};
nitobi.ui.Toolbars.prototype.isRowInsertEnabled=function(){
return this.rowInsertEnabled;
};
nitobi.ui.Toolbars.prototype.setRowDeleteEnabled=function(_481){
this.rowDeleteEnabled=_481;
};
nitobi.ui.Toolbars.prototype.isRowDeleteEnabled=function(){
return this.rowDeleteEnabled;
};
nitobi.ui.Toolbars.prototype.makeToolbar=function(){
var _482=this.findCssUrl();
this.toolbarXml.documentElement.setAttribute("id","toolbar"+this.uid);
this.toolbarXml.documentElement.setAttribute("image_directory",_482);
var _483=this.toolbarXml.selectNodes("/toolbar/items/*");
for(var i=0;i<_483.length;i++){
if(_483[i].nodeType!=8){
_483[i].setAttribute("id",_483[i].getAttribute("id")+this.uid);
}
}
this.standardToolbar=new nitobi.ui.Toolbar(this.toolbarXml.xml,"toolbar"+this.uid);
this.toolbarPagingXml.documentElement.setAttribute("id","toolbarpaging"+this.uid);
this.toolbarPagingXml.documentElement.setAttribute("image_directory",_482);
_483=(this.toolbarPagingXml.selectNodes("/toolbar/items/*"));
for(var i=0;i<_483.length;i++){
if(_483[i].nodeType!=8){
_483[i].setAttribute("id",_483[i].getAttribute("id")+this.uid);
}
}
this.pagingToolbar=new nitobi.ui.Toolbar(this.toolbarPagingXml.xml,"toolbarpaging"+this.uid);
};
nitobi.ui.Toolbars.prototype.getToolbar=function(id){
return eval("this."+id);
};
nitobi.ui.Toolbars.prototype.findCssUrl=function(){
var _486=nitobi.html.Css.findParentStylesheet(".EbaToolbar");
if(_486==null){
_486=nitobi.html.Css.findParentStylesheet(".ebagrid");
if(_486==null){
nitobi.lang.throwError("The CSS for the toolbar could not be found.  Try moving the nitobi.grid.css file to a location accessible to the browser's javascript or moving it to the top of the stylesheet list. findParentStylesheet returned "+_486);
}
}
return nitobi.html.Css.getPath(_486);
};
nitobi.ui.Toolbars.prototype.isToolbarEnabled=function(){
return this.enabled;
};
nitobi.ui.Toolbars.prototype.render=function(){
var _487=this.container;
_487.style.visibility="hidden";
this.align();
var xsl=nitobi.ui.ToolbarXsl;
if(xsl.indexOf("xsl:stylesheet")==-1){
xsl="<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\"><xsl:output method=\"xml\" version=\"4.0\" />"+xsl+"</xsl:stylesheet>";
}
var _489=nitobi.xml.createXslDoc(xsl);
var _48a=nitobi.xml.createXmlDoc(this.standardToolbar.getXml());
var _48b=nitobi.xml.transformToString(_48a,_489,"xml");
_487.innerHTML=_48b;
_487.style.zIndex="1000";
_48a=nitobi.xml.createXmlDoc(this.pagingToolbar.getXml());
var _48c=nitobi.xml.transformToString(_48a,_489,"xml");
_487.innerHTML+=_48c;
_489=null;
_48a=null;
this.standardToolbar.attachToTag();
this.standardToolbar.dockEvent=nitobi.lang.close(this,this.onToolbarDock);
this.standardToolbar.undockEvent=nitobi.lang.close(this,this.onToolbarUnDock);
this.pagingToolbar.attachToTag();
this.pagingToolbar.dockEvent=nitobi.lang.close(this,this.onToolbarDock);
this.pagingToolbar.undockEvent=nitobi.lang.close(this,this.onToolbarUnDock);
this.resize();
var _48d=this;
var _48e=this.standardToolbar.getUiElements();
_48e["save"+this.uid].onClick=function(){
	var _48f=confirm("This will save all the marks entered by you. Is it OK to Save?");	
	if(_48f){
_48d.fire("Save");
	}
};
_48e["newRecord"+this.uid].onClick=function(){
_48d.fire("InsertRow");
};
if(!this.isRowInsertEnabled()){
_48e["newRecord"+this.uid].disable();
}
_48e["deleteRecord"+this.uid].onClick=function(){
_48d.fire("DeleteRow");
};
if(!this.isRowDeleteEnabled()){
_48e["deleteRecord"+this.uid].disable();
}
_48e["refresh"+this.uid].onClick=function(){
var _48f=confirm("Refreshing will discard any changes you have made. Is it OK to refresh?");
if(_48f){
_48d.fire("Refresh");
}
};
var _490=this.pagingToolbar.getUiElements();
var _48d=this;
_490["previousPage"+this.uid].onClick=function(){
_48d.fire("PreviousPage");
};
_490["previousPage"+this.uid].disable();
_490["nextPage"+this.uid].onClick=function(){
_48d.fire("NextPage");
};
if(this.visibleToolbars&nitobi.ui.Toolbars.VisibleToolbars.STANDARD){
this.standardToolbar.show();
}else{
this.standardToolbar.hide();
}
if(this.visibleToolbars&nitobi.ui.Toolbars.VisibleToolbars.PAGING){
this.pagingToolbar.show();
}else{
this.pagingToolbar.hide();
}
_487.style.visibility="visible";
};
nitobi.ui.Toolbars.prototype.align=function(){
};
nitobi.ui.Toolbars.prototype.resize=function(){
var _491=this.getWidth();
if(this.visibleToolbars&nitobi.ui.Toolbars.VisibleToolbars.PAGING){
_491=_491-2-parseInt(this.pagingToolbar.getWidth());
}
this.standardToolbar.setWidth(_491);
};
nitobi.ui.Toolbars.prototype.onToolbarDock=function(){
if(this.containerEmpty&&!this.areAllToolbarsDocked()){
this.fire("ToolbarsContainerNotEmpty");
}
this.containerEmpty=false;
};
nitobi.ui.Toolbars.prototype.areAllToolbarsDocked=function(){
return ((this.pagingToolbar!=null&&this.pagingToolbar.isFloating()||!this.pagingToolbar.isVisible())&&(this.standardToolbar!=null&&this.standardToolbar.isFloating()||!this.standardToolbar.isVisible()));
};
nitobi.ui.Toolbars.prototype.areAnyToolbarsDocked=function(){
return ((this.pagingToolbar!=null&&!this.pagingToolbar.isFloating()&&this.pagingToolbar.isVisible())||(this.standardToolbar!=null&&!this.standardToolbar.isFloating()&&this.standardToolbar.isVisible()));
};
nitobi.ui.Toolbars.prototype.onToolbarUnDock=function(){
if(this.areAllToolbarsDocked()){
this.fire("ToolbarsContainerEmpty");
this.containerEmpty=true;
}else{
this.containerEmpty=false;
}
};
nitobi.ui.Toolbars.prototype.fire=function(evt,args){
return nitobi.event.notify(evt+this.uid,args);
};
nitobi.ui.Toolbars.prototype.subscribe=function(evt,func,_496){
if(typeof (_496)=="undefined"){
_496=this;
}
return nitobi.event.subscribe(evt+this.uid,nitobi.lang.close(_496,func));
};
nitobi.ui.Toolbars.prototype.dispose=function(){
this.toolbarXml=null;
this.toolbarPagingXml=null;
if(this.toolbar&&this.toolbar.dispose){
this.toolbar.dispose();
this.toolbar=null;
}
if(this.toolbarPaging&&this.toolbarPaging.dispose){
this.toolbarPaging.dispose();
this.toolbarPaging=null;
}
};
nitobi.grid.ViewNavigator=function(_497){
this.DomNode=_497;
this.currentRow=0;
this.currentColumn=0;
this.currentBlock=null;
this.activeView=null;
this.top=123;
this.left=0;
this.bottom=0;
this.right=0;
this.blockNavigator=new nitobi.grid.BlockNavigator();
this.blockNavigator.onEdit="this.viewNavigator.edit(evt);";
this.blockNavigator.onMove="this.viewNavigator.move();this.viewNavigator.view.owner.activeCell=this.activeCell;";
this.blockNavigator.onMovePastLeftEdge="this.viewNavigator.setPosition(this.currentRow+v,this.currentColumn+h)";
this.blockNavigator.onMovePastRightEdge="this.viewNavigator.setPosition(this.currentRow+v,this.currentColumn+h)";
this.blockNavigator.onMovePastTopEdge="this.viewNavigator.setPosition(this.currentRow+v,this.currentColumn+h)";
this.blockNavigator.onMovePastBottomEdge="this.viewNavigator.setPosition(this.currentRow+v,this.currentColumn+h)";
this.view=null;
this.disposal=[];
};
nitobi.grid.ViewNavigator.prototype.setCellRanges=function(_498,rows,_49a,_49b){
this.startRow=_498;
this.rows=_498+rows;
this.startColumn=_49a;
this.columns=_49a+_49b;
};
nitobi.grid.ViewNavigator.prototype.move=function(h,v){
if(this.currentColumn==this.startColumn&&h==-1){
eval(this.onMovePastLeftEdge);
return;
}
if(this.currentColumn==this.columns-1&&h==1){
eval(this.onMovePastRightEdge);
return;
}
if(this.currentRow==this.startRow&&v==-1){
eval(this.onMovePastTopEdge);
return;
}
if(this.currentRow==this.rows-1&&v==1){
eval(this.onMovePastBottomEdge);
return;
}
eval(this.onMove);
};
nitobi.grid.ViewNavigator.prototype.setPosition=function(row,_49f){
if(_49f>=this.view.owner.getColumnCount()||_49f<0){
return;
}
this.currentBlock=this.locateBlock(row);
if(row>=this.startRow&&row<this.startRow+this.rows&&_49f>=this.startColumn&&_49f<this.startColumn+this.columns){
if(this.currentBlock!=null){
var _4a0=this;
this.blockNavigator.DomNode=this.currentBlock;
this.blockNavigator.viewNavigator=this;
this.disposal.push(function(){
_4a0.blockNavigator.viewNavigator=null;
});
this.blockNavigator.rows=this.currentBlock.bottom-this.currentBlock.top+1;
this.blockNavigator.setPosition(row,_49f);
}
}else{
this.currentRow=row;
this.currentColumn=_49f;
if(_49f<this.startColumn){
eval(this.onMovePastLeftEdge);
return;
}
if(_49f>this.columns-1){
eval(this.onMovePastRightEdge);
return;
}
if(row<this.startRow){
eval(this.onMovePastTopEdge);
return;
}
if(row>this.rows-1){
eval(this.onMovePastBottomEdge);
return;
}
}
};
nitobi.grid.ViewNavigator.prototype.locateBlock=function(row){
var _4a2=this.DomNode.childNodes;
for(var _4a3 in _4a2){
if(row>=_4a2[_4a3].top&&row<=_4a2[_4a3].bottom){
return _4a2[_4a3];
}
}
return null;
};
nitobi.grid.ViewNavigator.prototype.activate=function(_4a4,_4a5){
var _4a6=this;
this.blockNavigator.viewNavigator=this;
this.disposal.push(function(){
_4a6.blockNavigator.viewNavigator=null;
});
this.blockNavigator.activate(_4a4,_4a5);
};
nitobi.grid.ViewNavigator.prototype.edit=function(e){
var evt=(nitobi.browser.IE)?event:e;
this.view.activeCell=this.blockNavigator.activeCell;
eval(this.onEdit);
};
nitobi.grid.ViewNavigator.prototype.handleKey=function(o,e){
this.blockNavigator.handleKey(o,e);
};
nitobi.grid.ViewNavigator.prototype.mouseMove=function(o,e){
this.blockNavigator.mouseMove(o.e);
};
nitobi.grid.ViewNavigator.prototype.dispose=function(){
this.DomNode=null;
var _4ad=this.disposal.length;
for(var i=0;i<_4ad;i++){
this.disposal[i].call(this);
this.disposal[i]=null;
}
this.blockNavigator.dispose();
};
Viewport_TopLeft=0;
Viewport_TopCenter=1;
Viewport_TopRight=2;
Viewport_MidLeft=3;
Viewport_MidCenter=4;
Viewport_MidRight=5;
Viewport_BottomLeft=6;
Viewport_BottomCenter=7;
Viewport_BottomRight=8;
var EBA_SELECTION_BUFFER=15;
var NTB_SINGLECLICK=false;
nitobi.grid.Viewport=function(_4af,_4b0,_4b1,_4b2,top,_4b4,_4b5,left,_4b7,_4b8,_4b9){
this.disposal=[];
this.lag=500;
this.lastPause=0;
this.height=_4b1;
this.width=_4b2;
this.surface=_4b8||new nitobi.grid.Surface();
this.element=_4b7;
this.placeholder=_4b9;
this.rowHeight=23;
this.headerHeight=23;
this.lastGoodRow=0;
this.sortColumn=0;
this.sortDir=1;
this.uid=nitobi.base.getUid();
this.surfaceAdjustmentMultiplier=2;
this.region=_4b0;
top=(Boolean(top)&&!isNaN(top)?top:0);
this.top=Math.min(Math.max(0,top),_4b1);
this.bottom=Math.min(Math.max(0,_4b5),_4b1-this.top);
this.mid=Math.max(0,_4b1-this.top-this.bottom);
this.left=Math.min(Math.max(0,left),_4b2);
this.right=Math.min(Math.max(0,_4b4),_4b2-this.left);
this.center=Math.max(0,_4b2-this.left-this.right);
this.lastScrollTop=-1;
this.scrollIncrement=0;
this.pagingObject=_4af;
this.rowBindingSet="./Row";
this.columnBindingSet="./Cell";
this.ViewNavigator=new nitobi.grid.ViewNavigator();
this.ViewNavigator.view=this;
this.ViewNavigator.onEdit="this.view.edit(evt)";
this.ViewNavigator.onMove="this.view.move();this.view.setActiveCell(this.blockNavigator.activeCell)";
this.ViewNavigator.onMovePastLeftEdge="this.view.owner.setPosition(this.currentRow,this.currentColumn)";
this.ViewNavigator.onMovePastRightEdge="this.view.owner.setPosition(this.currentRow,this.currentColumn)";
this.ViewNavigator.onMovePastTopEdge="this.view.owner.setPosition(this.currentRow,this.currentColumn)";
this.ViewNavigator.onMovePastBottomEdge="this.view.owner.setPosition(this.currentRow,this.currentColumn)";
this.startRow=0;
this.rows=0;
this.startColumn=0;
this.columns=0;
this.activeBlock=null;
this.activeCell=null;
this.lastPage=false;
this.cacheMap=new nitobi.collections.CacheMap(-1,-1);
this.requestCacheMap=new nitobi.collections.CacheMap(-1,-1);
this.blockMap=new nitobi.collections.BlockMap();
this.rowRenderer=null;
this.columnResizer=new nitobi.grid.ColumnResizer(this.owner);
this.dataTable=null;
};
nitobi.grid.Viewport.prototype.mapToHtml=function(_4ba,_4bb,_4bc){
this.surface.element=_4bb;
this.element=_4ba;
this.placeholder=_4bc;
switch(this.region){
case 0:
case 1:
case 2:
case 6:
case 7:
case 8:
this.container=this.surface.element;
break;
case 3:
case 5:
this.container=this.placeholder;
break;
default:
this.container=this.element.childNodes[0].childNodes[0].childNodes[1];
}
};
nitobi.grid.Viewport.prototype.setCellRanges=function(_4bd,rows,_4bf,_4c0){
this.startRow=_4bd;
this.rows=rows;
this.startColumn=_4bf;
this.columns=_4c0;
this.ViewNavigator.setCellRanges(_4bd,rows,_4bf,_4c0);
};
nitobi.grid.Viewport.prototype.setPosition=function(_4c1,_4c2,top,_4c4,_4c5,left){
this.height=_4c1;
this.width=_4c2;
if(this.region==3){
ntbAssert(top>=0&&_4c1>=0,"top and height are incorrectly defined in viewport.setPosition. Viewport region: "+this.region+". (top,height) = "+top+","+_4c1);
}
this.top=Math.min(Math.max(0,top),_4c1);
this.bottom=Math.min(Math.max(0,_4c5),_4c1-this.top);
this.mid=Math.max(0,_4c1-this.top-this.bottom);
this.left=Math.min(Math.max(0,left),_4c2);
this.right=Math.min(Math.max(0,_4c4),_4c2-this.left);
this.center=Math.max(0,_4c2-this.left-this.right);
};
nitobi.grid.Viewport.prototype.clear=function(_4c7,_4c8,_4c9,_4ca){
if(this.surface.element&&_4c7){
this.surface.element.innerHTML="<div></div>";
}
if(this.placeholder&&_4c8){
this.placeholder.innerHTML="<div></div>";
}
if(this.element&&_4ca){
this.element.innerHTML="<div></div>";
}
if(this.surface.element&&_4c9){
this.element.childNodes[0].childNodes[0].childNodes[1].innerHTML="<div></div>";
}
this.lastScrollTop=-1;
};
nitobi.grid.Viewport.prototype.render=function(_4cb){
var _4cc=this.cacheMap.gaps(_4cb.first,_4cb.last);
var _4cd=(_4cb.first+_4cb.last==-1);
if(_4cc[0]!=null){
var low=_4cc[0].low;
var high=_4cc[0].high;
var rows=high-low+1;
var _4d1=this.getDataTable();
if(!_4d1.inCache(low,rows)){
_4d1.get(low,rows);
return false;
}else{
this.cacheMap.insert(low,high);
this.renderGap(low,high);
}
}else{
if(_4cd){
this.fire("HtmlReady");
}
}
return (_4cc[0]!=null||_4cd);
};
nitobi.grid.Viewport.prototype.dataReady=function(_4d2){
var low=_4d2.firstRow,high=_4d2.lastRow;
this.renderGap(low,high);
};
nitobi.grid.Viewport.prototype.setSort=function(_4d5,_4d6){
this.sortColumn=_4d5;
this.sortDir=_4d6;
};
nitobi.grid.Viewport.prototype.renderGap=function(top,_4d8){
var _4d9=_4d8;
var rows=_4d9-top+1;
var _4db=this.owner.activeCell;
var _4dc=0,_4dd=0;
if(_4db!=null){
_4dc=nitobi.grid.Cell.getColumnNumber(_4db);
_4dd=nitobi.grid.Cell.getRowNumber(_4db);
}
var s=this.rowRenderer.render(top,rows,_4dc,_4dd,this.sortColumn,this.sortDir);
var _4df=0;
var _4e0=(top-_4df)*this.rowHeight;
var o=document.createElement("div");
o.style.position="absolute";
o.style.top=(_4e0-this.top+this.headerHeight)+"px";
nitobi.html.attachEvent(o,"click",nitobi.lang.close(this,this.activate),this,false);
nitobi.html.attachEvent(o,"mouseup",nitobi.lang.close(this,this.mouseUp),this,false);
nitobi.html.attachEvent(o,"mousedown",nitobi.lang.close(this,this.mouseDown),this,false);
nitobi.html.attachEvent(o,"mousemove",nitobi.lang.close(this,this.mouseMove),this,false);
switch(this.region){
case Viewport_TopLeft:
case Viewport_MidLeft:
case Viewport_BottomLeft:
break;
case Viewport_TopCenter:
break;
case Viewport_MidCenter:
case Viewport_BottomCenter:
o.className="ebamidblockcontainer"+this.owner.uid;
break;
case Viewport_TopRight:
case Viewport_MidRight:
case Viewport_BottomRight:
o.style.left=this.left;
break;
}
o.setAttribute("description","block container");
o.top=top;
o.bottom=_4d9;
o.left=this.startColumn;
o.right=this.startColumn+this.columns;
o.setAttribute("id","block_"+this.region+"_"+top+"_"+_4d8+"_"+this.owner.uid);
this.container.appendChild(o);
o.innerHTML=s;
this.blockMap.insert(top,_4d8);
o.rows=rows;
o.columns=this.columns;
this.fire("HtmlReady");
};
nitobi.grid.Viewport.prototype.getBlocks=function(_4e2,_4e3){
var _4e4=this.blockMap.ranges(_4e2,_4e3);
var _4e5=new Array();
var _4e6=_4e2;
var _4e7=_4e3;
for(var _4e8 in _4e4){
var b=_4e4[_4e8];
_4e6=Math.min(b.low,_4e6);
_4e7=Math.max(b.high,_4e7);
_4e5.push(document.getElementById("block_"+this.region+"_"+b.low+"_"+b.high+"_"+this.owner.uid));
}
this.blockMap.remove(_4e6,_4e7);
this.cacheMap.remove(_4e6,_4e7);
return _4e5;
};
nitobi.grid.Viewport.prototype.activate=function(e,_4eb){
var evt=nitobi.html.Event;
var _4ed=this.findActiveCell(evt.srcElement);
var _4ee=_4ed.getAttribute("ebatype");
if(_4ee==null){
return;
}
if(!_4ed){
return;
}
if(_4ee=="columnheader"){
var _4ef=parseInt(_4ed.getAttribute("xi"));
this.fire("HeaderClick",_4ef);
}else{
if(_4ee=="cell"){
var _4f0=this.oldCell;
if(this.owner.Scroller.activeView!=null&&this.owner.Scroller.activeView!=this){
_4f0=this.owner.Scroller.activeView.activeCell;
}
var S=this.owner.Selection;
if(evt.shiftKey){
if(!S.selecting){
S.init(_4f0);
}
S.redraw(_4ed);
S.selecting=false;
}else{
this.activeBlock=_4eb;
if(!S.selected()){
S.init(this.activeCell);
S.selecting=false;
}else{
S.redraw(_4ed);
}
this.ViewNavigator.DomNode=this.container;
this.ViewNavigator.activate(_4eb,this.activeCell);
this.ensureCellInView();
if(nitobi.browser.IE){
NTB_SINGLECLICK=0;
}
if(this.owner.isSingleClickEditEnabled()){
this.owner.edit(e);
}
}
}
}
};
nitobi.grid.Viewport.prototype.edit=function(e){
var evt=(nitobi.browser.IE)?event:e;
eval(this.onEdit);
};
nitobi.grid.Viewport.prototype.move=function(){
this.ensureCellInView();
eval(this.onMove);
};
nitobi.grid.Viewport.prototype.handleKey=function(e){
var evt=(nitobi.browser.IE)?event:e;
if(typeof (this.ViewNavigator.blockNavigator.viewNavigator)=="undefined"){
this.ViewNavigator.activate(this.activeBlock,this.activeCell);
}
this.ViewNavigator.handleKey(this.activeBlock,e);
};
nitobi.grid.Viewport.prototype.mouseDown=function(e,_4f7){
var evt=nitobi.html.Event;
var _4f9=this.findActiveCell(evt.srcElement);
if(_4f9.getAttribute("ebatype")=="columnheader"){
var __x=evt.clientX;
var xFix=0;
if(nitobi.browser.MOZ){
var _4fc=this.owner.Scroller;
xFix=_4fc.scrollLeft;
}
var _4fd=_4f9.getBoundingClientRect().right-xFix;
if((__x<_4fd&&__x>_4fd-10)){
var _4fe=this.owner.getColumnObject(parseInt(_4f9.getAttribute("xi")));
this.columnResizer.startResize(this.owner,_4fe,_4f9,evt);
}else{
var _4ff=parseInt(_4f9.getAttribute("xi"));
this.fire("HeaderDown",_4ff);
}
}else{
if(!evt.shiftKey){
this.selectStart(_4f9);
this.setActiveCell(_4f9,evt.ctrlKey);
this.activeBlock=_4f7;
this.ViewNavigator.DomNode=this.container;
this.ViewNavigator.blockNavigator.currentRow=nitobi.grid.Cell.getRowNumber(this.activeCell);
this.ViewNavigator.blockNavigator.currentColumn=nitobi.grid.Cell.getColumnNumber(this.activeCell);
eval(this.onFocus);
}
}
};
nitobi.grid.Viewport.prototype.selectStart=function(_500){
var S=this.owner.Selection;
S.init(_500);
};
nitobi.grid.Viewport.prototype.setActiveCell=function(_502,_503){
this.oldCell=this.activeCell;
this.activeCell=_502;
this.owner.Scroller.activeView=this;
this.owner.setActiveCell(_502,_503);
};
nitobi.grid.Viewport.prototype.mouseUp=function(){
var evt=nitobi.html.Event;
var _505=this.findActiveCell(evt.srcElement);
if(_505.getAttribute("ebatype")=="columnheader"){
var _506=parseInt(_505.getAttribute("xi"));
this.fire("HeaderUp",_506);
}
};
nitobi.grid.Viewport.prototype.headerEvent=function(_507,_508,_509){
};
nitobi.grid.Viewport.prototype.clearSelect=function(cell){
var S=this.owner.Selection;
S.collapse(cell);
};
nitobi.grid.Viewport.prototype.mouseMove=function(e,o){
var evt=nitobi.html.Event;
var _50f=this.findActiveCell(evt.srcElement);
var _510=_50f.getAttribute("ebatype");
if(_510==null){
return;
}
var __x=evt.clientX;
var __y=evt.clientY;
if(_510!="cell"&&_510!="columnheader"){
return;
}
var S=this.owner.Selection;
var xFix=0;
if(nitobi.browser.MOZ){
var _515=this.owner.Scroller;
xFix=_515.scrollLeft;
}
if(_510=="columnheader"){
var rect=_50f.getBoundingClientRect();
nitobi.html.attachEvent(_50f,"mouseout",function(){
this.style.cursor="auto";
},_50f,false);
if((__x<(rect.right-xFix)&&__x>(rect.right-xFix)-10)){
_50f.style.cursor="w-resize";
}else{
_50f.style.cursor="auto";
}
}else{
if(S.selecting){
if(evt.button==1||(evt.button==0&&!nitobi.browser.IE)){
S.redraw(_50f);
this.ensureCellInView(_50f);
}else{
S.selecting=false;
}
}else{
this.owner.handleMouseMove(_50f.parentNode);
}
}
evt.cancelBubble=true;
evt.returnValue=false;
return false;
};
nitobi.grid.Viewport.prototype.flushCache=function(){
if(Boolean(this.cacheMap)){
this.cacheMap.flush();
}
if(Boolean(this.requestCacheMap)){
this.requestCacheMap.flush();
}
};
nitobi.grid.Viewport.prototype.ensureCellInView=function(cell){
this.owner.ensureCellInView(cell);
};
nitobi.grid.Viewport.prototype.getRowsPerPage=function(){
return this.pagingObject.getRowsPerPage();
};
nitobi.grid.Viewport.prototype.getCurrentPageIndex=function(){
return this.pagingObject.getCurrentPageIndex();
};
nitobi.grid.Viewport.prototype.implementsStandardPaging=function(){
return Boolean(this.pagingObject&&this.pagingObject.getPagingMode().toLowerCase()=="standard");
};
nitobi.grid.Viewport.prototype.findActiveCell=function(_518){
var _519=10;
for(var i=0;i<_519&&(_518.getAttribute&&(_518.getAttribute("ebatype")!="cell"&&_518.getAttribute("ebatype")!="columnheader"));i++){
_518=_518.parentNode;
}
if(i==_519){
_518==null;
}
return _518;
};
nitobi.grid.Viewport.prototype.setDataTable=function(_51b){
this.dataTable=_51b;
};
nitobi.grid.Viewport.prototype.getDataTable=function(){
return this.dataTable;
};
nitobi.grid.Viewport.prototype.setHeaderHeight=function(_51c){
this.headerHeight=_51c;
};
nitobi.grid.Viewport.prototype.setRowHeight=function(_51d){
this.rowHeight=_51d;
};
nitobi.grid.Viewport.prototype.dispose=function(){
this.element=null;
this.placeholder=null;
this.container=null;
this.activeCell=null;
(this.surface!=null?this.surface.dispose():"");
this.surface=null;
if(this.ViewNavigator!=null){
this.ViewNavigator.view=null;
this.ViewNavigator.dispose();
}
this.ViewNavigator=null;
(this.columnResizer!=null?this.columnResizer.dispose():"");
this.columnResizer=null;
(this.cacheMap!=null?this.cacheMap.flush():"");
this.cacheMap=null;
(this.requestCacheMap!=null?this.requestCacheMap.flush():"");
this.requestCacheMap=null;
(this.rowRenderer!=null?this.rowRenderer.dispose():"");
this.rowRenderer=null;
nitobi.lang.dispose(this,this.disposal);
return;
};
nitobi.grid.Viewport.prototype.fire=function(evt,args){
return nitobi.event.notify(evt+this.uid,args);
};
nitobi.grid.Viewport.prototype.subscribe=function(evt,func,_522){
if(typeof (_522)=="undefined"){
_522=this;
}
return nitobi.event.subscribe(evt+this.uid,nitobi.lang.close(_522,func));
};
nitobi.grid.Viewport.prototype.attach=function(evt,func,_525){
return nitobi.html.attachEvent(_525,evt,nitobi.lang.close(this,func));
};
nitobi.lang.defineNs("nitobi.data");
if(false){
nitobi.data=function(){
};
}
nitobi.data.DATAMODE_UNBOUND="unbound";
nitobi.data.DATAMODE_LOCAL="local";
nitobi.data.DATAMODE_REMOTE="remote";
nitobi.data.DATAMODE_CACHING="caching";
nitobi.data.DATAMODE_STATIC="static";
nitobi.data.DATAMODE_PAGING="paging";
nitobi.data.DataSet=function(){
};
nitobi.data.DataSet.prototype.initialize=function(){
this.tables=new Array();
};
nitobi.data.DataSet.prototype.add=function(_526){
this.tables[_526.id]=_526;
};
nitobi.data.DataSet.prototype.getTable=function(_527){
return this.tables[_527];
};
nitobi.data.DataSet.prototype.xmlDoc=function(){
var _528="http://www.nitobi.com";
var _529=nitobi.xml.createXmlDoc("<"+nitobi.xml.nsPrefix+"datasources xmlns:ntb=\""+_528+"\"></"+nitobi.xml.nsPrefix+"datasources>");
for(var i in this.tables){
if(this.tables[i].xmlDoc&&this.tables[i].xmlDoc.documentElement){
var _52b=this.tables[i].xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource").cloneNode(true);
_529.selectSingleNode("/"+nitobi.xml.nsPrefix+"datasources").appendChild(_52b);
}
}
return _529;
};
nitobi.data.DataSet.prototype.dispose=function(){
for(var _52c in this.tables){
this.tables[_52c].dispose();
}
};
nitobi.lang.defineNs("nitobi.data");
nitobi.data.DataTable=function(mode,_52e,_52f,_530,_531){
if(_52e==null){
}
this.estimateRowCount=_52e;
this.disposal=[];
this.version=3;
this.uid=nitobi.base.getUid();
this.mode=mode||"caching";
this.setAutoKeyEnabled(_531);
this.columns=new Array();
this.keys=new Array();
this.types=new Array();
this.defaults=new Array();
this.columnsConfigured=false;
this.pagingConfigured=false;
this.id="_default";
this.fieldMap={};
if(_52f){
this.saveHandlerArgs=_52f;
}else{
this.saveHandlerArgs={};
}
if(_530){
this.getHandlerArgs=_530;
}else{
this.getHandlerArgs={};
}
this.setGetHandlerParameter("RequestType","GET");
this.setSaveHandlerParameter("RequestType","SAVE");
this.batchInsert=false;
this.batchInsertRowCount=0;
};
nitobi.data.DataTable.DEFAULT_LOG="<"+nitobi.xml.nsPrefix+"grid "+nitobi.xml.nsDecl+"><"+nitobi.xml.nsPrefix+"datasources id='id'><"+nitobi.xml.nsPrefix+"datasource id=\"{id}\"><"+nitobi.xml.nsPrefix+"datasourcestructure /><"+nitobi.xml.nsPrefix+"data id=\"_default\"></"+nitobi.xml.nsPrefix+"data></"+nitobi.xml.nsPrefix+"datasource></"+nitobi.xml.nsPrefix+"datasources></"+nitobi.xml.nsPrefix+"grid>";
nitobi.data.DataTable.DEFAULT_DATA="<"+nitobi.xml.nsPrefix+"datasource "+nitobi.xml.nsDecl+" id=\"{id}\"><"+nitobi.xml.nsPrefix+"datasourcestructure FieldNames=\"{fields}\" Keys=\"{keys}\" types=\"{types}\" defaults=\"{defaults}\"></"+nitobi.xml.nsPrefix+"datasourcestructure><"+nitobi.xml.nsPrefix+"data id=\"{id}\"></"+nitobi.xml.nsPrefix+"data></"+nitobi.xml.nsPrefix+"datasource>";
nitobi.data.DataTable.prototype.initialize=function(_532,_533,_534,_535,_536,sort,_538,_539,_53a){
this.setGetHandlerParameter("TableId",_532);
this.setSaveHandlerParameter("TableId",_532);
this.id=_532;
this.datastructure=null;
this.descriptor=new nitobi.data.DataTableDescriptor(this,nitobi.lang.close(this,this.syncRowCount),this.estimateRowCount);
this.disposal.push(this.descriptor);
this.pageFirstRow=0;
this.pageRowCount=0;
this.pageSize=_536;
this.minPageSize=10;
this.requestCache=new nitobi.collections.CacheMap(-1,-1);
this.dataCache=new nitobi.collections.CacheMap(-1,-1);
this.flush();
this.sortColumn=sort;
this.sortDir=_538||"Asc";
this.filter=new Array();
this.onGenerateKey=_539;
this.remoteRowCount=0;
this.setRowCountKnown(false);
if(_535==null){
_535=0;
}
if(this.mode!="unbound"){
if(_533!=null){
this.ajaxCallbackPool=new nitobi.ajax.HttpRequestPool(nitobi.ajax.HttpRequestPool_MAXCONNECTIONS);
this.ajaxCallbackPool.context=this;
this.setGetHandler(_533);
this.setSaveHandler(_534);
}
this.ajaxCallback=new nitobi.ajax.HttpRequest();
this.ajaxCallback.responseType="xml";
}else{
if(_533!=null&&typeof (_533)!="string"){
this.initializeXml(_533);
}
}
this.dataTranslatorXslProc=nitobi.xml.createXslProcessor(nitobi.data.dataTranslatorXslProc.stylesheet);
this.updategramTranslatorXslProc=nitobi.xml.createXslProcessor(nitobi.data.updategramTranslatorXslProc.stylesheet);
this.adjustXiXslProc=nitobi.xml.createXslProcessor(nitobi.data.adjustXiXslProc.stylesheet);
this.addXidXslProc=nitobi.xml.createXslProcessor(nitobi.data.addXidXslProc.stylesheet);
this.sortXslProc=nitobi.xml.createXslProcessor(nitobi.data.sortXslProc.stylesheet);
this.mergeXslProc=nitobi.xml.createXslProcessor(nitobi.data.mergeEbaXmlXslProc.stylesheet);
this.mergeToLogXslProc=nitobi.xml.createXslProcessor(nitobi.data.mergeEbaXmlToLogXslProc.stylesheet);
this.fillColumnXslProc=nitobi.xml.createXslProcessor(nitobi.data.fillColumnXslProc.stylesheet);
this.requestQueue=new Array();
this.lastXid=-1;
this.async=true;
};
nitobi.data.DataTable.prototype.setOnGenerateKey=function(_53b){
this.onGenerateKey=_53b;
};
nitobi.data.DataTable.prototype.getOnGenerateKey=function(){
return this.onGenerateKey;
};
nitobi.data.DataTable.prototype.setAutoKeyEnabled=function(val){
this.autoKeyEnabled=val;
};
nitobi.data.DataTable.prototype.isAutoKeyEnabled=function(){
return this.autoKeyEnabled;
};
nitobi.data.DataTable.prototype.initializeXml=function(oXml){
this.replaceData(oXml);
var rows=this.xmlDoc.selectNodes("//"+nitobi.xml.nsPrefix+"e").length;
if(rows>0){
var s=this.xmlDoc.xml;
s=nitobi.xml.transformToString(this.xmlDoc,this.sortXslProc,"xml");
this.xmlDoc=nitobi.xml.loadXml(this.xmlDoc,s);
this.dataCache.insert(0,rows-1);
if(this.mode=="local"){
this.setRowCountKnown(true);
}
}
this.setRemoteRowCount(rows);
this.fire("DataInitalized");
};
nitobi.data.DataTable.prototype.initializeXmlData=function(oXml){
var sXml=oXml;
if(typeof (oXml)=="object"){
sXml=oXml.xml;
}
sXml=sXml.replace(/fieldnames=/g,"FieldNames=").replace(/keys=/g,"Keys=");
this.xmlDoc=nitobi.xml.loadXml(this.xmlDoc,sXml);
this.datastructure=this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"datasourcestructure");
};
nitobi.data.DataTable.prototype.replaceData=function(oXml){
this.initializeXmlData(oXml);
var _543=this.datastructure.getAttribute("FieldNames");
var keys=this.datastructure.getAttribute("Keys");
var _545=this.datastructure.getAttribute("Defaults");
var _546=this.datastructure.getAttribute("Types");
this.initializeColumns(_543,keys,_546,_545);
};
nitobi.data.DataTable.prototype.initializeSchema=function(){
var _547=this.columns.join("|");
var keys=this.keys.join("|");
var _549=this.defaults.join("|");
var _54a=this.types.join("|");
this.dataCache.flush();
this.xmlDoc=nitobi.xml.loadXml(this.xmlDoc,nitobi.data.DataTable.DEFAULT_DATA.replace(/\{id\}/g,this.id).replace(/\{fields\}/g,_547).replace(/\{keys\}/g,keys).replace(/\{defaults\}/g,_549).replace(/\{types\}/g,_54a));
this.datastructure=this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"datasourcestructure");
};
nitobi.data.DataTable.prototype.initializeColumns=function(_54b,keys,_54d,_54e){
if(null!=_54b){
var _54f=this.columns.join("|");
if(_54f==_54b){
return;
}
this.columns=_54b.split("|");
}
if(null!=keys){
this.keys=keys.split("|");
}
if(null!=_54d){
this.types=_54d.split("|");
}
if(null!=_54e){
this.defaults=_54e.split("|");
}
if(this.xmlDoc.documentElement==null){
this.initializeSchema();
}
this.datastructure=this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"datasourcestructure");
var ds=this.datastructure;
if(_54b){
ds.setAttribute("FieldNames",_54b);
}
if(keys){
ds.setAttribute("Keys",keys);
}
if(_54e){
ds.setAttribute("Defaults",_54e);
}
if(_54d){
ds.setAttribute("Types",_54d);
}
this.makeFieldMap();
this.fire("ColumnsInitialized");
};
nitobi.data.DataTable.prototype.getTemplateNode=function(_551){
var _552=null;
if(_551==null){
_551=this.defaults;
}
if(nitobi.browser.IE){
_552=this.xmlDoc.createNode(1,nitobi.xml.nsPrefix+"e","http://www.nitobi.com");
}else{
if(this.xmlDoc.createElementNS){
_552=this.xmlDoc.createElementNS("http://www.nitobi.com",nitobi.xml.nsPrefix+"e");
}
}
for(var i=0;i<this.columns.length;i++){
var _554=(i>25?String.fromCharCode(Math.floor(i/26)+97):"")+(String.fromCharCode(i%26+97));
_552.setAttribute(_554,this.defaults[i]);
}
return _552;
};
nitobi.data.DataTable.prototype.commitProperties=function(){
if(this.mode=="unbound"){
}
};
nitobi.data.DataTable.prototype.flush=function(){
if(this.mode=="caching"||this.mode=="paging"){
this.dataCache.flush();
}
if(this.mode!="unbound"){
this.requestCache.flush();
}
this.flushLog();
this.xmlDoc=nitobi.xml.createXmlDoc();
};
nitobi.data.DataTable.prototype.join=function(_555,_556,_557,_558){
};
nitobi.data.DataTable.prototype.merge=function(xd){
};
nitobi.data.DataTable.prototype.getField=function(_55a,_55b){
var r=this.getRecord(_55a);
var a=this.fieldMap[_55b];
if(a&&r){
return r.getAttribute(a.substring(1));
}else{
return null;
}
};
nitobi.data.DataTable.prototype.getRecord=function(_55e){
var data=this.xmlDoc.selectNodes("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data/"+nitobi.xml.nsPrefix+"e[@xi='"+_55e+"']");
if(data.length==0){
return null;
}
return data[0];
};
nitobi.data.DataTable.prototype.beginBatchInsert=function(){
this.batchInsert=true;
this.batchInsertRowCount=0;
};
nitobi.data.DataTable.prototype.commitBatchInsert=function(){
this.batchInsert=false;
var _560=this.batchInsertRowCount;
this.batchInsertRowCount=0;
this.setRemoteRowCount(this.remoteRowCount+_560);
if(_560>0){
this.fire("RowInserted",_560);
}
};
nitobi.data.DataTable.prototype.createRecord=function(_561,_562){
var xi=_562;
this.lastXid+=1;
this.adjustXiXslProc.addParameter("startingIndex",parseInt(xi),"");
this.adjustXiXslProc.addParameter("adjustment",1,"");
this.xmlDoc=nitobi.xml.loadXml(this.xmlDoc,nitobi.xml.transformToString(this.xmlDoc,this.adjustXiXslProc,"xml"));
if(this.log!=null){
this.log=nitobi.xml.loadXml(this.log,nitobi.xml.transformToString(this.log,this.adjustXiXslProc,"xml"));
this.logData=this.log.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data");
}
var data=this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data");
var _565=_561||this.getTemplateNode();
var _566=_565.cloneNode(true);
_566.setAttribute("xi",xi);
_566.setAttribute("xid",this.lastXid);
if(this.onGenerateKey){
var _567=this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasourcestructure").getAttribute("Keys").split("|");
var xml=null;
for(var j=0;j<_567.length;j++){
var _56a=this.fieldMap[_567[j]].substring(1);
var _56b=_566.getAttribute(_56a);
if(!_56b||_56b==""){
if(!xml){
xml=eval(this.onGenerateKey);
}
if(typeof (xml)=="string"||typeof (xml)=="number"){
_566.setAttribute(_56a,xml);
}else{
try{
var ck1=j%26;
var ck2=Math.floor(j/26);
var _56e=(ck2>0?String.fromCharCode(96+ck2):"")+String.fromCharCode(97+ck1);
_566.setAttribute(_56a,xml.selectSingleNode("//"+nitobi.xml.nsPrefix+"e").getAttribute(_56e));
}
catch(e){
}
}
}
}
}
data.appendChild(_566);
if(this.log!=null){
var _56f=_566.cloneNode(true);
_56f.setAttribute("xac","i");
_56f.setAttribute("xid",this.lastXid);
this.logData.appendChild(_56f);
}
this.dataCache.insertIntoRange(_562);
this.batchInsertRowCount++;
if(!this.batchInsert){
this.commitBatchInsert();
}
return _566;
};
nitobi.data.DataTable.prototype.updateRecord=function(xi,_571,_572){
var _573=this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"e[@xi='"+xi+"']");
var xid=_573.getAttribute("xid")||"error - unknown xid";
var _575=false;
var _576=(_573.getAttribute(_571)!=_572);
if(!_576&&!_575){
return;
}
if(_573.getAttribute(_571)==null&&this.fieldMap[_571]!=null){
_573.setAttribute(this.fieldMap[_571].substring(1),_572);
}else{
_573.setAttribute(_571,_572);
}
var _577="u";
var _578="u";
if(null==this.log){
this.flushLog();
}
var _579=_573.cloneNode(true);
_579.setAttribute("xac","u");
this.logData=this.log.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data");
var _57a=this.logData.selectSingleNode("./"+nitobi.xml.nsPrefix+"e[@xid='"+xid+"']");
if(null==_57a){
this.logData.appendChild(_579);
_579.setAttribute("xid",xid);
}else{
_579.setAttribute("xac",_57a.getAttribute("xac"));
this.logData.replaceChild(_579,_57a);
}
if((true==this.AutoSave)){
this.save();
}
};
nitobi.data.DataTable.prototype.deleteRecord=function(_57b){
var data=this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data");
this.logData=this.log.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data");
var _57d=data.selectSingleNode("*[@xi = '"+_57b+"']");
if(_57d==null){
throw "Index out of bounds in delete.";
}
var xDel=this.logData.selectSingleNode("*[@xi='"+_57b+"']");
var sTag="";
if(xDel!=null){
sTag=xDel.getAttribute("xac");
this.logData.removeChild(xDel);
}
if(sTag!="i"){
var _580=_57d.cloneNode(true);
_580.setAttribute("xac","d");
this.logData.appendChild(_580);
}
data.removeChild(_57d);
this.adjustXiXslProc.addParameter("startingIndex",parseInt(_57b)+1,"");
this.adjustXiXslProc.addParameter("adjustment",-1,"");
this.xmlDoc=nitobi.xml.loadXml(this.xmlDoc,nitobi.xml.transformToString(this.xmlDoc,this.adjustXiXslProc,"xml"));
if(this.log!=null){
this.log=nitobi.xml.loadXml(this.log,nitobi.xml.transformToString(this.log,this.adjustXiXslProc,"xml"));
this.logData=this.log.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data");
}
this.dataCache.removeFromRange(_57b);
this.setRemoteRowCount(this.remoteRowCount-1);
this.fire("RowDeleted");
};
nitobi.data.DataTable.prototype.setGetHandler=function(val){
this.getHandler=val;
for(var name in this.getHandlerArgs){
this.setGetHandlerParameter(name,this.getHandlerArgs[name]);
}
};
nitobi.data.DataTable.prototype.getGetHandler=function(){
return this.getHandler;
};
nitobi.data.DataTable.prototype.setSaveHandler=function(val){
this.postHandler=val;
for(var name in this.saveHandlerArgs){
this.setSaveHandlerParameter(name,this.saveHandlerArgs[name]);
}
};
nitobi.data.DataTable.prototype.getSaveHandler=function(){
return this.postHandler;
};
nitobi.data.DataTable.prototype.save=function(_585,_586){
if(!eval(_586||"true")){
return;
}
try{
if(this.version==2.8){
var _587=this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasourcestructure").getAttribute("FieldNames").split("|");
var _588=this.log.selectNodes("//"+nitobi.xml.nsPrefix+"e[@xac = 'i']");
for(var i=0;i<_588.length;i++){
for(var j=0;j<_587.length;j++){
var _58b=_588[i].getAttribute(this.fieldMap[_587[j]].substring(1));
if(!_58b){
_588[i].setAttribute(this.fieldMap[_587[j]].substring(1),"");
}
}
}
var _58c=this.log.selectNodes("//"+nitobi.xml.nsPrefix+"e[@xac = 'u']");
for(var i=0;i<_58c.length;i++){
for(var j=0;j<_587.length;j++){
var _58b=_58c[i].getAttribute(this.fieldMap[_587[j]].substring(1));
if(!_58b){
_58c[i].setAttribute(this.fieldMap[_587[j]].substring(1),"");
}
}
}
this.updategramTranslatorXslProc.addParameter("xkField",this.fieldMap["_xk"].substring(1),"");
this.updategramTranslatorXslProc.addParameter("fields",_587.join("|").replace(/\|_xk/,""));
this.log=nitobi.xml.transformToXml(this.log,this.updategramTranslatorXslProc);
}
var _58d=this.getSaveHandler();
(_58d.indexOf("?")==-1)?_58d+="?":_58d+="&";
_58d+="TableId="+this.id;
_58d+="&uid="+(new Date().getTime());
var _58e=this.ajaxCallbackPool.reserve();
_58e.handler=_58d;
_58e.responseType="xml";
_58e.context=this;
_58e.completeCallback=nitobi.lang.close(this,this.saveComplete);
_58e.params=new nitobi.grid.SaveCompleteEventArgs(_585);
if(this.version>2.8&&this.log.selectNodes("//"+nitobi.xml.nsPrefix+"e[@xac='i']").length>0&&this.isAutoKeyEnabled()){
_58e.async=false;
}
if(this.log.documentElement.nodeName=="root"){
this.log=nitobi.xml.loadXml(this.log,this.log.xml.replace(/xmlns:ntb=\"http:\/\/www.nitobi.com\"/g,""));
var _587=this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasourcestructure").getAttribute("FieldNames").split("|");
_587.splice(_587.length-1,1);
_587=_587.join("|");
this.log.documentElement.setAttribute("fields",_587);
this.log.documentElement.setAttribute("keys",_587);
}
if(this.isAutoKeyEnabled()&&this.version<3){
alert("AutoKey is not supported in this schema version. You must upgrade to Nitobi Grid Xml Schema version 3 or greater.");
}
_58e.post(this.log,this);
this.flushLog();
}
catch(err){
throw err;
}
};
nitobi.data.DataTable.prototype.flushLog=function(){
this.log=nitobi.xml.createXmlDoc(nitobi.data.DataTable.DEFAULT_LOG.replace(/\{id\}/g,this.id).replace(/\{fields\}/g,this.columns).replace(/\{keys\}/g,this.keys).replace(/\{defaults\}/g,this.defaults).replace(/\{types\}/g,this.types));
this.logData=this.log.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data");
};
nitobi.data.DataTable.prototype.updateAutoKeys=function(_58f){
try{
var _590=_58f.selectNodes("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data/"+nitobi.xml.nsPrefix+"e[@xac='i']");
if(typeof (_590)=="undefined"||_590==null){
nitobi.lang.throwError("When updating keys from the server for AutoKey support, the inserts could not be parsed.");
}
var keys=_58f.selectNodes("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"datasourcestructure")[0].getAttribute("keys").split("|");
if(typeof (keys)=="undefined"||keys==null||keys.length==0){
nitobi.lang.throwError("When updating keys from the server for AutoKey support, no keys could be found. Ensure that the keys are sent in the request response.");
}
for(var i=0;i<_590.length;i++){
var _593=this.getRecord(_590[i].getAttribute("xi"));
for(var j=0;j<keys.length;j++){
var att=this.fieldMap[keys[j]].substring(1);
_593.setAttribute(att,_590[i].getAttribute(att));
}
}
}
catch(err){
nitobi.lang.throwError("When updating keys from the server for AutoKey support, the inserts could not be parsed.",err);
}
};
nitobi.data.DataTable.prototype.saveComplete=function(_596){
var xd=_596.response;
var _596=_596.params;
try{
if(this.isAutoKeyEnabled()&&this.version>2.8){
this.updateAutoKeys(xd);
}
if(null!=_596.result){
}
var node=xd.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource")||xd.selectSingleNode("/root");
var e=null;
if(node){
e=node.getAttribute("error");
}
if(e){
this.setHandlerError(e);
}else{
this.setHandlerError(null);
}
var _59a=new nitobi.grid.OnAfterSaveEventArgs(this,xd);
_596.callback(_59a);
}
catch(err){
ebaErrorReport(err,"",EBA_ERROR);
}
};
nitobi.data.DataTable.prototype.makeFieldMap=function(){
var _59b=this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource");
var cf=0;
var ck=0;
this.fieldMap=new Array();
var cF=this.columns.length;
for(var i=0;i<cF;i++){
var _5a0=this.columns[i];
ck1=ck%26;
ck2=Math.floor(ck/26);
this.fieldMap[_5a0]="@"+(ck2>0?String.fromCharCode(96+ck2):"")+String.fromCharCode(97+ck1);
ck++;
}
};
nitobi.data.DataTable.prototype.find=function(_5a1,_5a2){
var _5a3=this.fieldMap[_5a1];
if(_5a3){
return this.xmlDoc.selectNodes("//"+nitobi.xml.nsPrefix+"e["+_5a3+"=\""+_5a2+"\"]");
}else{
return new Array();
}
};
nitobi.data.DataTable.prototype.sort=function(_5a4,dir,type,_5a7){
if(_5a7){
_5a4=this.fieldMap[_5a4];
_5a4=_5a4.substring(1);
dir=(dir=="Desc")?"descending":"ascending";
type=(type=="number")?"number":"text";
this.sortXslProc.addParameter("column",_5a4,"");
this.sortXslProc.addParameter("dir",dir,"");
this.sortXslProc.addParameter("type",type,"");
this.xmlDoc=nitobi.xml.loadXml(this.xmlDoc,nitobi.xml.transformToString(this.xmlDoc,this.sortXslProc,"xml"));
this.fire("DataSorted");
}else{
this.sortColumn=_5a4;
this.sortDir=dir||"Asc";
}
};
nitobi.data.DataTable.prototype.syncRowCount=function(){
this.setRemoteRowCount(this.descriptor.estimatedRowCount);
};
nitobi.data.DataTable.prototype.setRemoteRowCount=function(rows){
var _5a9=this.remoteRowCount;
this.remoteRowCount=rows;
if(this.remoteRowCount!=_5a9){
this.fire("RowCountChanged",rows);
}
};
nitobi.data.DataTable.prototype.getRemoteRowCount=function(){
return this.remoteRowCount;
};
nitobi.data.DataTable.prototype.getRows=function(){
return this.xmlDoc.selectNodes("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data/"+nitobi.xml.nsPrefix+"e").length;
};
nitobi.data.DataTable.prototype.getXmlDoc=function(){
return this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']");
};
nitobi.data.DataTable.prototype.getRowNodes=function(){
return this.xmlDoc.selectNodes("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data/"+nitobi.xml.nsPrefix+"e");
};
nitobi.data.DataTable.prototype.getColumns=function(){
return this.fieldMap.length;
};
nitobi.data.DataTable.prototype.setGetHandlerParameter=function(name,_5ab){
if(this.getHandler!=null&&this.getHandler!=""){
this.getHandler=nitobi.html.setUrlParameter(this.getHandler,name,_5ab);
}
this.getHandlerArgs[name]=_5ab;
};
nitobi.data.DataTable.prototype.setSaveHandlerParameter=function(name,_5ad){
if(this.postHandler!=null&&this.postHandler!=""){
this.postHandler=nitobi.html.setUrlParameter(this.getSaveHandler(),name,_5ad);
}
this.saveHandlerArgs[name]=_5ad;
};
nitobi.data.DataTable.prototype.getChangeLogSize=function(){
if(null==this.log){
return 0;
}
return this.log.selectNodes("//"+nitobi.xml.nsPrefix+"e").length;
};
nitobi.data.DataTable.prototype.getChangeLogXmlDoc=function(){
return this.log;
};
nitobi.data.DataTable.prototype.getDataXmlDoc=function(){
return this.xmlDoc;
};
nitobi.data.DataTable.prototype.dispose=function(){
this.flush();
this.dataCache.flush();
this.requestCache.flush();
this.ajaxCallbackPool.context=null;
for(var item in this){
if(this[item]!=null&&this[item].dispose instanceof Function){
this[item].dispose();
}
this[item]=null;
}
};
nitobi.data.DataTable.prototype.getTable=function(_5af,_5b0,_5b1){
this.errorCallback=_5b1;
var _5b2=this.ajaxCallbackPool.reserve();
var _5b3=this.getGetHandler();
_5b2.handler=_5b3;
_5b2.responseType="xml";
_5b2.context=this;
_5b2.completeCallback=nitobi.lang.close(this,this.getComplete);
_5b2.async=this.async;
_5b2.params=new nitobi.data.GetCompleteEventArgs(null,null,0,null,_5b2,this,_5af,_5b0);
if(typeof (_5b0)!="function"||this.async==false){
_5b2.async=false;
return this.getComplete({"response":_5b2.get(),"params":_5b2.params});
}else{
_5b2.get();
}
};
nitobi.data.DataTable.prototype.getComplete=function(_5b4){
var xd=_5b4.response;
var _5b6=_5b4.params;
if(this.mode!="caching"){
this.xmlDoc=nitobi.xml.createXmlDoc();
}
if(null==xd||null==xd.xml||""==xd.xml){
var _5b7="No parse error.";
if(nitobi.xml.hasParseError(xd)){
_5b7=nitobi.xml.getParseErrorReason(xd);
}
if(this.errorCallback){
this.errorCallback.call(this.context);
}
this.fire("DataReady",_5b6);
return _5b6;
}else{
if(typeof (this.successCallback)=="function"){
this.successCallback.call(this.context);
}
}
if(!this.configured){
this.configureFromData(xd);
}
xd=this.parseResponse(xd,_5b6);
xd=this.assignRowIds(xd);
var _5b8=null;
_5b8=xd.selectNodes("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data/"+nitobi.xml.nsPrefix+"e");
var _5b9;
var _5ba=_5b8.length;
if(_5b6.pageSize==null){
_5b6.pageSize=_5ba;
_5b6.lastRow=_5b6.startXi+_5b6.pageSize-1;
_5b6.firstRow=_5b6.startXi;
}
if(0!=_5ba){
_5b9=parseInt(_5b8[_5b8.length-1].getAttribute("xi"));
if(this.mode=="paging"){
this.dataCache.insert(0,_5b6.pageSize-1);
}else{
this.dataCache.insert(_5b6.firstRow,_5b9);
}
}else{
_5b9=-1;
_5b6.pageSize=0;
var pct=this.descriptor.lastKnownRow/this.descriptor.estimatedRowCount||0;
this.fire("PastEndOfData",pct);
}
_5b6.numRowsReturned=_5ba;
_5b6.lastRowReturned=_5b9;
var _5bc=_5b6.startXi;
var _5bd=_5b6.pageSize;
if(!isNaN(_5bc)&&!isNaN(_5bd)){
this.requestCache.remove(_5bc,_5bc+_5bd-1);
}
if(this.mode!="caching"){
this.replaceData(xd);
}else{
this.mergeData(xd);
}
this.updateFromDescriptor(_5b6);
this.fire("RowCountReady",_5b6);
if(null!=_5b6.ajaxCallback){
this.ajaxCallbackPool.release(_5b6.ajaxCallback);
}
this.executeRequests();
var node=xd.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource");
var e=null;
if(node){
e=node.getAttribute("error");
}
if(e){
this.setHandlerError(e);
}else{
this.setHandlerError(null);
}
this.fire("DataReady",_5b6);
if(null!=_5b6.callback&&null!=_5b6.context){
_5b6.callback.call(_5b6.context,_5b6);
_5b6.dispose();
_5b6=null;
}else{
return _5b6;
}
};
nitobi.data.DataTable.prototype.executeRequests=function(){
var _5c0=this.requestQueue;
this.requestQueue=new Array();
for(var i=0;i<_5c0.length;i++){
_5c0[i].call();
}
};
nitobi.data.DataTable.prototype.updateFromDescriptor=function(_5c2){
this.descriptor.update(_5c2);
if(this.mode=="paging"){
this.setRemoteRowCount(_5c2.numRowsReturned);
}else{
this.setRemoteRowCount(this.descriptor.estimatedRowCount);
}
this.setRowCountKnown(this.descriptor.isAtEndOfTable);
};
nitobi.data.DataTable.prototype.setRowCountKnown=function(_5c3){
var _5c4=this.rowCountKnown;
this.rowCountKnown=_5c3;
if(_5c3&&this.rowCountKnown!=_5c4){
this.fire("RowCountKnown",this.remoteRowCount);
}
};
nitobi.data.DataTable.prototype.getRowCountKnown=function(){
return this.rowCountKnown;
};
nitobi.data.DataTable.prototype.configureFromData=function(xd){
this.version=this.inferDataVersion(xd);
if(this.mode=="unbound"){
}
if(this.mode=="static"){
}
if(this.mode=="paging"){
}
if(this.mode=="caching"){
}
};
nitobi.data.DataTable.prototype.mergeData=function(xd){
if(this.xmlDoc.xml==""){
this.initializeXml(xd);
return;
}
var _5c7=xd.selectNodes("//"+nitobi.xml.nsPrefix+"datasource[@id = '"+this.id+"']//"+nitobi.xml.nsPrefix+"e");
var _5c8=this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data");
var len=_5c7.length;
for(var i=0;i<len;i++){
if(this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data/"+nitobi.xml.nsPrefix+"e[@xi='"+_5c7[i].getAttribute("xi")+"']")){
continue;
}
_5c8.appendChild(_5c7[i]);
}
};
nitobi.data.DataTable.prototype.assignRowIds=function(xd){
this.addXidXslProc.addParameter("startXid",this.lastXid,"");
xd=nitobi.xml.loadXml(xd,nitobi.xml.transformToString(xd,this.addXidXslProc,"xml"));
this.lastXid+=xd.selectNodes("//"+nitobi.xml.nsPrefix+"e").length;
return xd;
};
nitobi.data.DataTable.prototype.inferDataVersion=function(xd){
if(xd.selectSingleNode("/root")){
return 2.8;
}
return 3;
};
nitobi.data.DataTable.prototype.parseResponse=function(xd,_5ce){
if(this.version==2.8){
return this.parseLegacyResponse(xd,_5ce);
}else{
return this.parseStructuredResponse(xd,_5ce);
}
};
nitobi.data.DataTable.prototype.parseLegacyResponse=function(xd,_5d0){
var _5d1=this.mode=="paging"?0:_5d0.startXi;
this.dataTranslatorXslProc.addParameter("start",_5d1,"");
this.dataTranslatorXslProc.addParameter("id",this.id,"");
var _5d2=xd.selectSingleNode("/root").getAttribute("fields");
var _5d3=_5d2.split("|");
var i=_5d3.length;
var _5d5=(i>25?String.fromCharCode(Math.floor(i/26)+96):"")+(String.fromCharCode(i%26+97));
this.dataTranslatorXslProc.addParameter("xkField",_5d5,"");
xd=nitobi.xml.transformToXml(xd,this.dataTranslatorXslProc);
return xd;
};
nitobi.data.DataTable.prototype.parseStructuredResponse=function(xd,_5d7){
xd=nitobi.xml.loadXml(xd,"<ntb:grid xmlns:ntb=\"http://www.nitobi.com\"><ntb:datasources>"+xd.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']").xml+"</ntb:datasources></ntb:grid>");
var _5d8=xd.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.id+"']/"+nitobi.xml.nsPrefix+"data/"+nitobi.xml.nsPrefix+"e");
if(_5d8){
if(_5d8.getAttribute("xi")!=_5d7.startXi){
this.adjustXiXslProc.addParameter("startingIndex","0","");
this.adjustXiXslProc.addParameter("adjustment",_5d7.startXi,"");
xd=nitobi.xml.loadXml(xd,nitobi.xml.transformToString(xd,this.adjustXiXslProc,"xml"));
}
}
return xd;
};
nitobi.data.DataTable.prototype.forceGet=function(_5d9,_5da,_5db,_5dc,_5dd,_5de){
this.errorCallback=_5dd;
this.successCallback=_5de;
this.context=_5db;
var _5df=this.getGetHandler();
(_5df.indexOf("?")==-1)?_5df+="?":_5df+="&";
_5df+="StartRecordIndex=0&start=0&PageSize="+_5da+"&SortColumn="+(this.sortColumn||"")+"&SortDirection="+this.sortDir+"&TableId="+this.id+"&uid="+(new Date().getTime());
var _5e0=this.ajaxCallbackPool.reserve();
_5e0.handler=_5df;
_5e0.responseType="xml";
_5e0.context=this;
_5e0.completeCallback=nitobi.lang.close(this,this.getComplete);
_5e0.params=new nitobi.data.GetCompleteEventArgs(0,_5da-1,0,_5da,_5e0,this,_5db,_5dc);
_5e0.get();
return;
};
nitobi.data.DataTable.prototype.getPage=function(_5e1,_5e2,_5e3,_5e4,_5e5,_5e6){
var _5e7=_5e1+_5e2-1;
var _5e8=this.dataCache.gaps(0,_5e2-1);
var _5e9=_5e8.length;
if(_5e9){
var _5ea=this.requestCache.gaps(_5e1,_5e7);
if(_5ea.length==0){
var _5eb=nitobi.lang.close(this,this.get,arguments);
this.requestQueue.push(_5eb);
return;
}
this.getFromServer(_5e1,_5e7,_5e1,_5e7,_5e3,_5e4,_5e5);
}else{
this.getFromCache(_5e1,_5e2,_5e3,_5e4,_5e5);
}
};
nitobi.data.DataTable.prototype.get=function(_5ec,_5ed,_5ee,_5ef,_5f0){
this.errorCallback=_5f0;
var _5f1=null;
if(this.mode=="caching"){
_5f1=this.getCached(_5ec,_5ed,_5ee,_5ef,_5f0);
}
if(this.mode=="local"||this.mode=="static"){
_5f1=this.getTable(_5ee,_5ef,_5f0);
}
if(this.mode=="paging"){
_5f1=this.getPage(_5ec,_5ed,_5ee,_5ef,_5f0);
}
return _5f1;
};
nitobi.data.DataTable.prototype.inCache=function(_5f2,_5f3){
if(this.mode=="local"){
return true;
}
var _5f4=_5f2,_5f5=_5f2+_5f3-1;
var _5f6=this.getRemoteRowCount()-1;
if(this.getRowCountKnown()&&_5f6<_5f5){
_5f5=_5f6;
}
var _5f7=this.dataCache.gaps(_5f4,_5f5);
var _5f8=_5f7.length;
return !(_5f8>0);
};
nitobi.data.DataTable.prototype.getCached=function(_5f9,_5fa,_5fb,_5fc,_5fd,_5fe){
if(_5fa==null){
return this.getFromServer(_5ff,null,_5f9,null,_5fb,_5fc,_5fd);
}
var _5ff=_5f9,_600=_5f9+_5fa-1;
var _601=this.dataCache.gaps(_5ff,_600);
var _602=_601.length;
if(this.mode!="unbound"&&_602>0){
for(var i=0;i<_602;i++){
var low=_601[i].low;
var high=_601[i].high;
var _606=this.requestCache.gaps(low,high);
if(_606.length==0){
var _607=nitobi.lang.close(this,this.get,arguments);
this.requestQueue.push(_607);
return;
}
return this.getFromServer(_5ff,_600,low,high,_5fb,_5fc,_5fd);
}
}else{
this.getFromCache(_5f9,_5fa,_5fb,_5fc,_5fd);
}
};
nitobi.data.DataTable.prototype.getFromServer=function(_608,_609,low,high,_60c,_60d,_60e){
this.requestCache.insert(low,high);
var _60f=(_609==null?null:(high-low+1));
var _610=(_60f==null?"":_60f);
var _611=this.getGetHandler();
(_611.indexOf("?")==-1)?_611+="?":_611+="&";
_611+="StartRecordIndex="+low+"&start="+low+"&PageSize="+(_610)+"&SortColumn="+(this.sortColumn||"")+"&SortDirection="+this.sortDir+"&uid="+(new Date().getTime());
var _612=this.ajaxCallbackPool.reserve();
_612.handler=_611;
_612.responseType="xml";
_612.context=this;
_612.completeCallback=nitobi.lang.close(this,this.getComplete);
_612.async=this.async;
_612.params=new nitobi.data.GetCompleteEventArgs(_608,_609,low,_60f,_612,this,_60c,_60d);
return _612.get();
};
nitobi.data.DataTable.prototype.getFromCache=function(_613,_614,_615,_616,_617){
var _618=_613,_619=_613+_614-1;
if(_618>0||_619>0){
if(typeof (_616)=="function"){
var _61a=new nitobi.data.GetCompleteEventArgs(_618,_619,_618,_619-_618+1,null,this,_615,_616);
_61a.callback.call(_61a.context,_61a);
}
}
};
nitobi.data.DataTable.prototype.mergeFromXml=function(_61b,_61c){
var _61d=Number(_61b.documentElement.firstChild.getAttribute("xi"));
var _61e=Number(_61b.documentElement.lastChild.getAttribute("xi"));
var _61f=this.dataCache.gaps(_61d,_61e);
if(this.mode=="local"&&_61f.length==1){
this.dataCache.insert(_61f[0].low,_61f[0].high);
this.mergeFromXmlGetComplete(_61b,_61c,_61d,_61e);
this.batchInsertRowCount=(_61f[0].high-_61f[0].low+1);
this.commitBatchInsert();
return;
}
if(_61f.length==0){
this.mergeFromXmlGetComplete(_61b,_61c,_61d,_61e);
}else{
if(_61f.length==1){
this.get(_61f[0].low,_61f[0].high-_61f[0].low+1,this,nitobi.lang.close(this,this.mergeFromXmlGetComplete,[_61b,_61c,_61d,_61e]));
}else{
this.forceGet(_61d,_61e,this,nitobi.lang.close(this,this.mergeFromXmlGetComplete,[_61b,_61c,_61d,_61e]));
}
}
};
nitobi.data.DataTable.prototype.mergeFromXmlGetComplete=function(_620,_621,_622,_623){
var _624=null;
if(nitobi.browser.IE){
_624=this.xmlDoc.createNode(1,nitobi.xml.nsPrefix+"newdata","http://www.nitobi.com");
}else{
if(this.xmlDoc.createElementNS){
_624=this.xmlDoc.createElementNS("http://www.nitobi.com",nitobi.xml.nsPrefix+"newdata");
}
}
this.xmlDoc.documentElement.appendChild(_624);
_624.appendChild(_620.documentElement.cloneNode(true));
this.mergeXslProc.addParameter("startRowIndex",_622,"");
this.mergeXslProc.addParameter("endRowIndex",_623,"");
this.mergeXslProc.addParameter("startXid",this.lastXid,"");
this.xmlDoc=nitobi.xml.loadXml(this.xmlDoc,nitobi.xml.transformToString(this.xmlDoc,this.mergeXslProc,"xml"));
this.lastXid+=_620.documentElement.childNodes.length;
this.lastXid+=1;
if(nitobi.browser.IE){
_624=this.log.createNode(1,nitobi.xml.nsPrefix+"newdata","http://www.nitobi.com");
}else{
if(this.xmlDoc.createElementNS){
_624=this.log.createElementNS("http://www.nitobi.com",nitobi.xml.nsPrefix+"newdata");
}
}
this.log.documentElement.appendChild(_624);
_624.appendChild(this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"newdata").firstChild.cloneNode(true));
this.log=nitobi.xml.loadXml(this.log,nitobi.xml.transformToString(this.log,this.mergeToLogXslProc,"xml"));
this.xmlDoc.documentElement.removeChild(this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"newdata"));
this.log.documentElement.removeChild(this.log.selectSingleNode("//"+nitobi.xml.nsPrefix+"newdata"));
_621.call();
};
nitobi.data.DataTable.prototype.fillColumn=function(_625,_626){
this.fillColumnXslProc.addParameter("column",this.fieldMap[_625].substring(1));
this.fillColumnXslProc.addParameter("value",_626);
this.xmlDoc.loadXML(nitobi.xml.transformToString(this.xmlDoc,this.fillColumnXslProc,"xml"));
var _627=parseFloat((new Date()).getTime());
var _628=null;
if(nitobi.browser.IE){
_628=this.log.createNode(1,nitobi.xml.nsPrefix+"newdata","http://www.nitobi.com");
}else{
if(this.xmlDoc.createElementNS){
_628=this.log.createElementNS("http://www.nitobi.com",nitobi.xml.nsPrefix+"newdata");
}
}
this.log.documentElement.appendChild(_628);
_628.appendChild(this.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"data").cloneNode(true));
this.mergeToLogXslProc.addParameter("defaultAction","u");
this.log.loadXML(nitobi.xml.transformToString(this.log,this.mergeToLogXslProc,"xml"));
this.mergeToLogXslProc.addParameter("defaultAction","");
this.log.documentElement.removeChild(this.log.selectSingleNode("//"+nitobi.xml.nsPrefix+"newdata"));
};
nitobi.data.DataTable.prototype.setHandlerError=function(_629){
this.handlerError=_629;
};
nitobi.data.DataTable.prototype.getHandlerError=function(){
return this.handlerError;
};
nitobi.data.DataTable.prototype.dispose=function(){
this.dataTranslatorXslProc=null;
this.updategramTranslatorXslProc=null;
this.adjustXiXslProc=null;
this.sortXslProc=null;
this.requestQueue=null;
this.fieldMap=null;
};
nitobi.data.DataTable.prototype.fire=function(evt,args){
return nitobi.event.notify(evt+this.uid,args);
};
nitobi.data.DataTable.prototype.subscribe=function(evt,func,_62e){
if(typeof (_62e)=="undefined"){
_62e=this;
}
return nitobi.event.subscribe(evt+this.uid,nitobi.lang.close(_62e,func));
};
nitobi.lang.defineNs("nitobi.data");
nitobi.data.DataTableDescriptor=function(_62f,_630,_631){
this.disposal=[];
this.estimatedRowCount=0;
this.leapMultiplier=2;
this.estimateRowCount=(_631==null?true:_631);
this.lastKnownRow=0;
this.isAtEndOfTable=false;
this.table=_62f;
this.lowestEmptyRow=0;
this.tableProjectionUpdatedEvent=_630;
this.disposal.push(this.tableProjectionUpdatedEvent);
};
nitobi.data.DataTableDescriptor.prototype.startPeek=function(){
this.enablePeek=true;
this.peek();
};
nitobi.data.DataTableDescriptor.prototype.peek=function(){
var _632;
if(this.lowestEmptyRow>0){
var _633=this.lowestEmptyRow-this.lastKnownRow;
_632=this.lastKnownRow+Math.round(_633/2);
}else{
_632=(this.estimatedRowCount*this.leapMultiplier);
}
this.table.get(Math.round(_632),1,this,this.peekComplete);
};
nitobi.data.DataTableDescriptor.prototype.peekComplete=function(_634){
if(this.enablePeek){
window.setTimeout(nitobi.lang.close(this,this.peek),1000);
}
};
nitobi.data.DataTableDescriptor.prototype.stopPeek=function(){
this.enablePeek=false;
};
nitobi.data.DataTableDescriptor.prototype.leap=function(_635,_636){
if(this.lowestEmptyRow>0){
var _637=this.lowestEmptyRow-this.lastKnownRow;
this.estimatedRowCount=this.lastKnownRow+Math.round(_637/2);
}else{
if(_635==null||_636==null){
this.estimatedRowCount=0;
}else{
if(this.estimateRowCount){
this.estimatedRowCount=(this.estimatedRowCount*_635)+_636;
}
}
}
this.fireProjectionUpdatedEvent();
};
nitobi.data.DataTableDescriptor.prototype.update=function(_638,_639){
if(null==_639){
_639=false;
}
if(this.isAtEndOfTable&&!_639){
return false;
}
var _63a=(_638!=null&&_638.numRowsReturned==0&&_638.startXi==0);
var _63b=(_638!=null&&_638.lastRow!=_638.lastRowReturned);
if(null==_638){
_638={lastPage:false,pageSize:1,firstRow:0,lastRow:0,startXi:0};
}
var _63c=(_63a)||(_63b)||(this.isAtEndOfTable)||((this.lastKnownRow==this.estimatedRowCount-1)&&(this.estimatedRowCount==this.lowestEmptyRow));
if(_638.pageSize==0&&!_63c){
this.lowestEmptyRow=this.lowestEmptyRow>0?Math.min(_638.startXi,this.lowestEmptyRow):_638.startXi;
this.leap();
return true;
}
this.lastKnownRow=Math.max(_638.lastRowReturned,this.lastKnownRow);
if(_63c&&!_639){
if(_638.lastRowReturned>=0){
this.estimatedRowCount=_638.lastRowReturned+1;
this.isAtEndOfTable=true;
}else{
if(_63a){
this.estimatedRowCount=0;
this.isAtEndOfTable=true;
}else{
this.estimatedRowCount=this.lastKnownRow+Math.ceil((_638.lastRow-this.lastKnownRow)/2);
}
}
this.fireProjectionUpdatedEvent();
this.stopPeek();
return true;
}
if(!this.estimateRowCount){
this.estimatedRowCount=this.lastKnownRow+1;
}
if(this.estimatedRowCount==0){
this.estimatedRowCount=(_638.lastRow+1)*(this.estimateRowCount?2:1);
}
if((this.estimatedRowCount>(_638.lastRow+1)&&!_639)||!this.estimateRowCount){
return false;
}
if(!this.isAtEndOfTable){
this.leap(this.leapMultiplier,0);
return true;
}
return false;
};
nitobi.data.DataTableDescriptor.prototype.reset=function(){
this.estimatedRowCount=0;
this.leapMultiplier=2;
this.lastKnownRow=0;
this.isAtEndOfTable=false;
this.lowestEmptyRow=0;
this.fireProjectionUpdatedEvent();
};
nitobi.data.DataTableDescriptor.prototype.fireProjectionUpdatedEvent=function(_63d){
if(this.tableProjectionUpdatedEvent!=null){
this.tableProjectionUpdatedEvent(_63d);
}
};
nitobi.data.DataTableDescriptor.prototype.dispose=function(){
nitobi.lang.dispose(this,this.disposal);
};
nitobi.lang.defineNs("nitobi.data");
if(false){
nitobi.data=function(){
};
}
nitobi.data.DataTableEventArgs=function(_63e){
this.source=_63e;
this.event=nitobi.html.Event;
};
nitobi.data.DataTableEventArgs.prototype.getSource=function(){
return this.source;
};
nitobi.data.DataTableEventArgs.prototype.getEvent=function(){
return this.event;
};
nitobi.data.GetCompleteEventArgs=function(_63f,_640,_641,_642,_643,_644,obj,_646){
this.firstRow=_63f;
this.lastRow=_640;
this.callback=_646;
this.dataSource=_644;
this.context=obj;
this.ajaxCallback=_643;
this.startXi=_641;
this.pageSize=_642;
this.lastPage=false;
this.status="success";
};
nitobi.data.GetCompleteEventArgs.prototype.dispose=function(){
this.callback=null;
this.context=null;
this.dataSource=null;
this.ajaxCallback.clear();
this.ajaxCallback==null;
};
nitobi.grid.SaveCompleteEventArgs=function(_647){
this.callback=_647;
};
nitobi.grid.SaveCompleteEventArgs.prototype.initialize=function(){
};
nitobi.data.OnAfterSaveEventArgs=function(_648,_649,_64a){
nitobi.data.OnAfterSaveEventArgs.baseConstructor.call(this,_648);
this.success=_64a;
this.responseData=_649;
};
nitobi.lang.extend(nitobi.data.OnAfterSaveEventArgs,nitobi.data.DataTableEventArgs);
nitobi.data.OnAfterSaveEventArgs.prototype.getResponseData=function(){
return this.responseData;
};
nitobi.data.OnAfterSaveEventArgs.prototype.getSuccess=function(){
return this.success;
};
nitobi.lang.defineNs("nitobi.form");
if(false){
nitobi.form=function(){
};
}
nitobi.form.Control=function(){
};
nitobi.form.Control.prototype.owner=null;
nitobi.form.Control.prototype.cell=null;
nitobi.form.Control.prototype.element=null;
nitobi.form.Control.prototype.blur=false;
nitobi.form.Control.attachToParent=function(_64b){
};
nitobi.form.Control.prototype.mimic=function(){
};
nitobi.form.Control.prototype.deactivate=function(){
if(this.blur){
return false;
}
this.blur=true;
};
nitobi.form.Control.prototype.bind=function(_64c,cell){
this.owner=_64c;
this.cell=cell;
this.blur=false;
};
nitobi.form.Control.prototype.hide=function(){
this.control.style.left=-2000;
};
nitobi.form.Control.prototype.show=function(){
this.control.style.display="block";
};
nitobi.form.Control.prototype.focus=function(){
this.control.focus();
this.blur=false;
};
nitobi.form.Control.prototype.handleKey=function(o,e){
var evt=(nitobi.browser.IE)?event:e;
var k=evt.keyCode;
switch(k){
case 27:
this.control.onblur=null;
this.hide();
this.owner.focus();
break;
case 9:
this.deactivate();
var bn=this.owner.Scroller.activeView.ViewNavigator.blockNavigator;
if(nitobi.browser.IE){
evt.keyCode=" ";
}
var x=1;
if(evt.shiftKey){
x=-1;
}
bn.move(x,0);
bn.activeCell.focus();
nitobi.html.cancelBubble(evt);
break;
case 40:
case 38:
break;
case 13:
this.deactivate();
evt.returnValue=false;
break;
default:
}
};
nitobi.form.Control.prototype.render=function(){
};
nitobi.form.Control.prototype.setEditCompleteHandler=function(_654){
this.editCompleteHandler=_654;
};
nitobi.form.Control.prototype.commitProperties=function(){
};
nitobi.form.Control.prototype.dispose=function(){
};
nitobi.form.Text=function(){
nitobi.form.Text.baseConstructor.call(this);
this.control=document.createElement("input");
this.control.object=this;
this.control.style.position="absolute";
this.control.style["top"]=-3000;
this.control.style.zIndex=2000;
this.control.style.left=-3000;
this.control.className="ebainput";
this.control.setAttribute("maxlength",255);
};
nitobi.lang.extend(nitobi.form.Text,nitobi.form.Control);
nitobi.form.Text.prototype.initialize=function(){
document.body.appendChild(this.control);
nitobi.html.attachEvent(this.control,"keydown",this.handleKey,this,false);
nitobi.html.attachEvent(this.control,"blur",this.deactivate,this,false);
};
nitobi.form.Text.prototype.attachToParent=function(_655){
_655.appendChild(this.control);
};
nitobi.form.Text.prototype.bind=function(_656,cell,_658){
nitobi.form.Text.base.bind.apply(this,arguments);
if(_658!=null&&_658!=""){
this.control.value=_658;
}else{
this.control.value=cell.getValue();
}
var _659=this.cell.getColumnObject();
this.control.maxlength=_659.ModelNode.getAttribute("MaxLength");
};
nitobi.form.Text.prototype.render=function(){
this.domNode.appendChild(this.control);
};
nitobi.form.Text.prototype.mimic=function(){
var oY=0;
var oX=0;
if(nitobi.browser.MOZ){
oY=this.owner.Scroller.scrollSurface.scrollTop-nitobi.form.EDITOR_OFFSETY;
oX=this.owner.Scroller.scrollSurface.scrollLeft-nitobi.form.EDITOR_OFFSETX;
}
nitobi.drawing.align(this.control,this.cell.getDomNode(),286265344,0,0,-oY,-oX);
this.control.focus();
if(this.control.createTextRange){
var _65c=this.control.createTextRange();
_65c.collapse(false);
_65c.select();
}
};
nitobi.form.Text.prototype.deactivate=function(){
if(this.lastKeyCode==27){
return;
}
if(nitobi.form.Text.base.deactivate.apply(this,arguments)==false){
return;
}
var _65d=this.control.value;
if(this.editCompleteHandler!=null){
var _65e=new nitobi.grid.EditCompleteEventArgs(this,_65d,_65d,this.cell);
var _65f=this.editCompleteHandler.call(this.owner,_65e);
if(!_65f){
this.blur=false;
}
return _65f;
}
};
nitobi.form.Text.prototype.handleKey=function(evt){
var k=evt.keyCode;
this.lastKeyCode=k;
switch(k){
case 27:
this.control.onblur=null;
this.hide();
this.owner.focus();
break;
case 9:
var _662=this.deactivate();
if(!_662){
nitobi.html.cancelBubble(evt);
break;
}
var bn=this.owner.Scroller.activeView.ViewNavigator.blockNavigator;
if(nitobi.browser.IE){
evt.keyCode="";
}
var x=1;
if(evt.shiftKey){
x=-1;
}
bn.move(x,0);
nitobi.html.cancelBubble(evt);
break;
case 40:
case 38:
break;
case 13:
this.control.blur();
evt.returnValue=false;
break;
default:
}
};
nitobi.form.Text.prototype.dispose=function(){
this.control.object=null;
nitobi.html.detachEvent(this.control,"keydown",this.handleKey);
nitobi.html.detachEvent(this.control,"blur",this.deactivate);
var _665=this.control.parentNode;
_665.removeChild(this.control);
this.domNode=null;
this.control=null;
this.owner=null;
this.cell=null;
};
nitobi.form.Checkbox=function(){
};
nitobi.lang.extend(nitobi.form.Checkbox,nitobi.form.Control);
nitobi.form.Checkbox.prototype.initialize=function(){
this.DataSourceId="";
this.UnCheckedValue="0";
this.CheckedValue="1";
this.DisplayFields="";
this.ValueField="";
};
nitobi.form.Checkbox.prototype.bind=function(_666,cell,_668){
this.blur=false;
this.cell=cell;
this.owner=_666;
var _669=this.cell.getColumnObject();
this.DataSourceId=_669.ModelNode.getAttribute("DatasourceId");
this.dataTable=this.owner.data.getTable(this.DataSourceId);
};
nitobi.form.Checkbox.prototype.mimic=function(){
if(false==eval(this.owner.getOnCellValidateEvent())){
return;
}
this.toggle();
this.deactivate();
};
nitobi.form.Checkbox.prototype.deactivate=function(){
if(this.editCompleteHandler!=null){
var _66a=new nitobi.grid.EditCompleteEventArgs(this,this.value,this.value,this.cell);
this.editCompleteHandler.call(this.context,_66a);
}
this.context=null;
};
nitobi.form.Checkbox.prototype.toggle=function(){
var _66b=this.cell.getColumnObject();
this.DataSourceId=_66b.ModelNode.getAttribute("DatasourceId");
var _66c=this.owner.data.getTable(this.DataSourceId);
var _66d=_66b.ModelNode.getAttribute("DisplayFields");
var _66e=_66b.ModelNode.getAttribute("ValueField");
var _66f=_66b.ModelNode.getAttribute("CheckedValue");
if(_66f==""||_66f==null){
_66f=1;
}
var _670=_66b.ModelNode.getAttribute("UnCheckedValue");
if(_670==""||_670==null){
_670=0;
}
this.value=(this.cell.getDomNode().getAttribute("value")==_66f)?_670:_66f;
};
nitobi.form.Checkbox.prototype.hide=function(){
};
nitobi.form.Checkbox.prototype.dispose=function(){
this.element=null;
this.metadata=null;
this.owner=null;
this.context=null;
};
nitobi.form.Date=function(){
nitobi.form.Date.baseConstructor.call(this);
};
nitobi.lang.extend(nitobi.form.Date,nitobi.form.Text);
nitobi.form.Date.prototype.handleKey=function(e){
nitobi.form.Date.base.handleKey.call(this,e);
};
nitobi.lang.defineNs("nitobi.form");
nitobi.form.EDITOR_OFFSETX=null;
nitobi.form.EDITOR_OFFSETY=null;
nitobi.form.ControlFactory=function(){
this.editors={};
};
nitobi.form.ControlFactory.prototype.getEditor=function(_672,_673,_674){
var _675=null;
if(null==_673){
ebaErrorReport("getEditor: column parameter is null","",EBA_DEBUG);
return _675;
}
if(false==_673.isEditable()){
return _675;
}
var _676=_673.getType();
var _677=_673.getType();
var _678="nitobi.Grid"+_676+_677+"Editor";
if(this.editors[_678]!=null){
_675=this.editors[_678];
}else{
switch(_676){
case "LINK":
case "HYPERLINK":
_675=new nitobi.form.Link;
break;
case "IMAGE":
return null;
case "BUTTON":
return null;
case "LOOKUP":
_675=new nitobi.form.Lookup();
break;
case "LISTBOX":
_675=new nitobi.form.ListBox();
break;
case "PASSWORD":
_675=new nitobi.form.Password();
break;
case "TEXTAREA":
_675=new nitobi.form.TextArea();
break;
case "CHECKBOX":
_675=new nitobi.form.Checkbox();
break;
default:
if(_677=="DATE"){
_675=new nitobi.form.Date();
}else{
if(_677=="NUMBER"){
_675=new nitobi.form.Number();
}else{
_675=new nitobi.form.Text();
}
}
break;
}
}
_675.initialize();
_675.context=_672;
this.editors[_678]=_675;
return _675;
};
nitobi.form.ControlFactory.prototype.dispose=function(){
for(var _679 in this.editors){
this.editors[_679].dispose();
}
};
nitobi.form.ControlFactory.instance=new nitobi.form.ControlFactory();
nitobi.form.Link=function(){
};
nitobi.lang.extend(nitobi.form.Link,nitobi.form.Control);
nitobi.form.Link.prototype.initialize=function(){
this.url="";
};
nitobi.form.Link.prototype.bind=function(_67a,cell,_67c){
this.cell=cell;
this.url=this.cell.getValue();
this.blur=false;
this.owner=_67a;
};
nitobi.form.Link.prototype.mimic=function(){
if(false==eval(this.owner.getOnCellValidateEvent())){
return;
}
this.click();
this.deactivate();
};
nitobi.form.Link.prototype.deactivate=function(){
if(this.editCompleteHandler!=null){
var _67d=new nitobi.grid.EditCompleteEventArgs(this,this.value,this.value,this.cell);
this.editCompleteHandler.call(this.context,_67d);
}
this.context=null;
};
nitobi.form.Link.prototype.click=function(){
window.open(this.url);
this.value=this.url;
};
nitobi.form.Link.prototype.hide=function(){
};
nitobi.form.Link.prototype.dispose=function(){
this.element=null;
this.metadata=null;
this.owner=null;
this.context=null;
};
nitobi.form.ListBox=function(){
this.editCompleteHandler=null;
this.context=null;
this.element=null;
this.metadata=null;
this.blur=false;
};
nitobi.lang.extend(nitobi.form.ListBox,nitobi.form.Control);
nitobi.form.ListBox.prototype.initialize=function(){
this.placeholder=document.createElement("div");
document.body.appendChild(this.placeholder);
};
nitobi.form.ListBox.prototype.bind=function(_67e,cell,_680){
this.blur=false;
this.cell=cell;
this.owner=_67e;
var _681=cell.getColumnObject();
var _682=_681.ModelNode.getAttribute("DatasourceId");
this.dataTable=this.owner.data.getTable(_682);
this.bindComplete(_680);
};
nitobi.form.ListBox.prototype.bindComplete=function(){
var _683=this.dataTable.xmlDoc.selectSingleNode("//"+nitobi.xml.nsPrefix+"datasource[@id='"+this.dataTable.id+"']");
var _684=this.cell.getColumnObject();
var _685=_684.ModelNode.getAttribute("DisplayFields");
var _686=_684.ModelNode.getAttribute("ValueField");
nitobi.form.listboxXslProc.addParameter("DisplayFields",_685,"");
nitobi.form.listboxXslProc.addParameter("ValueField",_686,"");
nitobi.form.listboxXslProc.addParameter("val",this.cell.getValue(),"");
this.listXml=nitobi.xml.transformToXml(nitobi.xml.createXmlDoc(_683.xml),nitobi.form.listboxXslProc);
this.placeholder.innerHTML=this.listXml.xml;
this.control=this.placeholder.childNodes[0];
this.control.object=this;
this.control.style.position="absolute";
this.control.style["top"]=-1000;
this.control.style.left=-1000;
this.control.onkeydown=function(e){
this.object.handleKey(this,e);
};
this.control.onblur=function(e){
if(this.object!=null){
this.object.deactivate();
}
};
this.control.className=this.cell.DomNode.className;
var oY=0;
var oX=0;
if(nitobi.browser.MOZ){
if(this.context.Scroller.activeView.region==3||this.context.Scroller.activeView.region==4){
oY=this.context.Scroller.scrollSurface.scrollTop-nitobi.form.EDITOR_OFFSETY;
}
if(this.context.Scroller.activeView.region==1||this.context.Scroller.activeView.region==4){
oX=this.context.Scroller.scrollSurface.scrollLeft-nitobi.form.EDITOR_OFFSETX;
}
}
nitobi.drawing.align(this.control,this.cell.DomNode,286265344,0,0,-oY,-oX);
this.control.focus();
if(this.control.createTextRange){
var _68b=this.control.createTextRange();
_68b.collapse(false);
_68b.select();
}
};
nitobi.form.ListBox.prototype.deactivate=function(ok){
if(this.blur||this.selectClicked){
this.selectClicked=false;
return;
}
this.blur=true;
var c=this.control;
var text="",_68f="";
if(ok||ok==null){
text=c.options[c.selectedIndex].text;
_68f=c.options[c.selectedIndex].value;
}else{
_68f=this.cell.getValue();
var len=c.options.length;
for(var i=0;i<len;i++){
if(c.options[i].value==_68f){
text=c.options[i].text;
}
}
}
c.object=null;
if(this.editCompleteHandler!=null){
var _692=new nitobi.grid.EditCompleteEventArgs(this,nitobi.html.encode(text),_68f,this.cell);
_692.status=(_68f==this.cell.getValue()?false:true);
this.editCompleteHandler.call(this.context,_692);
}
};
nitobi.form.ListBox.prototype.handleKey=function(o,e){
var evt=(nitobi.browser.IE)?event:e;
var k=evt.keyCode;
switch(k){
case 27:
this.deactivate(false);
break;
case 40:
case 38:
evt.cancelBubble=true;
return false;
case 37:
case 39:
case 13:
case 27:
this.deactivate(true);
break;
default:
}
};
nitobi.form.ListBox.prototype.dispose=function(){
this.placeholder=null;
this.control.object=null;
this.control.onkeydown=null;
this.control.onblur=null;
this.control=null;
this.listXml=null;
this.element=null;
this.metadata=null;
this.owner=null;
};
nitobi.form.Lookup=function(){
this.selectClicked=false;
this.bVisible=false;
this.placeholder=document.createElement("span");
this.placeholder.object=this;
this.placeholder.setAttribute("id","lookup_span");
this.placeholder.style.position="absolute";
this.placeholder.style.zIndex=2000;
this.placeholder.style["top"]=-2000;
this.placeholder.style.left=-2000;
document.body.appendChild(this.placeholder);
this.textControl=document.createElement("input");
this.textControl.object=this;
this.textControl.className="ebainput ebalookuptext";
this.textControl.autocomplete="off";
this.textControl.style.zIndex=2000;
this.placeholder.appendChild(this.textControl);
nitobi.html.attachEvent(this.textControl,"keydown",this.handleKey,this);
nitobi.html.attachEvent(this.textControl,"keyup",this.filter,this);
nitobi.html.attachEvent(this.textControl,"blur",this.deactivate,this);
this.placeholder.appendChild(document.createElement("span"));
this.blur=false;
this.firstKeyup=false;
this.listXml=null;
this.listXmlLower=null;
this.editCompleteHandler=null;
this.delay=0;
this.timeoutId=null;
var xsl="<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\">";
xsl+="<xsl:output method=\"text\" version=\"4.0\"/><xsl:param name='searchValue'/>";
xsl+="<xsl:template match=\"/\"><xsl:apply-templates select='//option[starts-with(.,$searchValue)][1]' /></xsl:template>";
xsl+="<xsl:template match=\"option\"><xsl:value-of select='@rn' /></xsl:template></xsl:stylesheet>";
var _698=nitobi.xml.createXslDoc(xsl);
this.searchXslProc=nitobi.xml.createXslProcessor(_698);
_698=null;
};
nitobi.lang.extend(nitobi.form.Lookup,nitobi.form.Control);
nitobi.lang.implement(nitobi.form.Lookup,nitobi.ui.IDataBoundList);
nitobi.form.Lookup.prototype.initialize=function(){
this.firstKeyup=false;
};
nitobi.form.Lookup.prototype.mimic=function(){
};
nitobi.form.Lookup.prototype.hide=function(){
this.placeholder.style.top=-2000;
};
nitobi.form.Lookup.prototype.hideSelect=function(){
this.selectControl.style.display="none";
this.bVisible=false;
};
nitobi.form.Lookup.prototype.bind=function(_699,cell,_69b){
this.blur=false;
this.owner=_699;
this.cell=cell;
this.column=this.cell.getColumnObject();
var _69c=this.column.ModelNode;
this.datasourceId=_69c.getAttribute("DatasourceId");
this.getHandler=_69c.getAttribute("GetHandler");
this.pageSize=_69c.getAttribute("PageSize");
this.delay=parseInt(_69c.getAttribute("Delay"));
this.displayFields=_69c.getAttribute("DisplayFields");
this.valueField=_69c.getAttribute("ValueField");
nitobi.form.listboxXslProc.addParameter("DisplayFields",this.displayFields,"");
nitobi.form.listboxXslProc.addParameter("ValueField",this.valueField,"");
this.dataTable=this.owner.data.getTable(this.datasourceId);
this.dataTable.setGetHandler(this.getHandler);
this.dataTable.async=false;
if(_69b.length<=0){
_69b=this.cell.getValue();
}
this.get(_69b);
};
nitobi.form.Lookup.prototype.bindComplete=function(_69d){
var _69e=this.dataTable.getXmlDoc();
nitobi.form.listboxXslProc.addParameter("DisplayFields",this.displayFields,"");
nitobi.form.listboxXslProc.addParameter("ValueField",this.valueField,"");
nitobi.form.listboxXslProc.addParameter("val",nitobi.xml.constructValidXpathQuery(this.cell.getValue(),false),"");
this.listXml=nitobi.xml.transformToXml(nitobi.xml.createXmlDoc(_69e.xml),nitobi.form.listboxXslProc);
this.listXmlLower=nitobi.xml.createXmlDoc(this.listXml.xml.toLowerCase());
this.placeholder.childNodes[1].innerHTML=this.listXml.xml;
this.selectControl=this.placeholder.childNodes[1].firstChild;
this.selectControl.object=this;
this.selectControl.style.display="none";
this.selectControl.className="ebainput ebalookupoptions";
this.selectControl.size=4;
this.selectControl.onmousedown=function(){
this.object.selectClicked=true;
};
this.selectControl.onclick=function(){
this.object.textControl.value=this.options[this.selectedIndex].text;
this.object.hideSelect();
this.object.textControl.focus();
};
this.selectClicked=false;
this.bVisible=false;
var rn=this.search(_69d);
if(rn>0){
this.selectControl.selectedIndex=rn-1;
this.textControl.value=this.selectControl[this.selectControl.selectedIndex].text;
nitobi.html.highlight(this.textControl,this.textControl.value.length-(this.textControl.value.length-_69d.length));
}else{
var row=_69e.selectSingleNode("//"+nitobi.xml.nsPrefix+"e[@"+this.valueField+"='"+_69d+"']");
if(row!=null){
this.textControl.value=row.getAttribute(this.displayFields);
var rn=this.search(this.textControl.value);
this.selectControl.selectedIndex=parseInt(rn)-1;
}else{
this.textControl.value=_69d;
this.selectControl.selectedIndex=-1;
}
}
var oY=0;
var oX=0;
if(nitobi.browser.MOZ){
if(this.owner.Scroller.activeView.region==3||this.owner.Scroller.activeView.region==4){
oY=this.owner.Scroller.scrollSurface.scrollTop-nitobi.form.EDITOR_OFFSETY;
}
if(this.owner.Scroller.activeView.region==1||this.owner.Scroller.activeView.region==4){
oX=this.owner.Scroller.scrollSurface.scrollLeft-nitobi.form.EDITOR_OFFSETX;
}
}
var _6a3=this.cell.getDomNode();
nitobi.drawing.align(this.placeholder,_6a3,286265344,0,0,-oY,-oX);
this.textControl.style.height=nitobi.html.getHeight(_6a3);
var _6a4=this.placeholder.clientWidth;
this.selectControl.style.width=_6a4;
this.selectControl.style.display="inline";
this.textControl.style.width=_6a4;
this.textControl.focus();
return false;
};
nitobi.form.Lookup.prototype.deactivate=function(evt,o){
if(this.blur||this.selectClicked){
this.selectClicked=false;
return;
}
this.blur=true;
var sc=this.selectControl;
var tc=this.textControl;
var text="",_6aa="";
if(evt!=null&&evt!=false){
if(sc.selectedIndex>=0){
_6aa=sc.options[sc.selectedIndex].value;
text=sc.options[sc.selectedIndex].text;
}else{
_6aa=tc.value;
text=_6aa;
}
}else{
_6aa=this.cell.getValue();
var len=sc.options.length;
for(var i=0;i<len;i++){
if(sc.options[i].value==_6aa){
text=sc.options[i].text;
}
}
}
sc.object=null;
sc=null;
if(this.editCompleteHandler!=null){
var _6ad=new nitobi.grid.EditCompleteEventArgs(this,nitobi.html.encode(text),_6aa,this.cell);
_6ad.status=true;
this.editCompleteHandler.call(this.owner,_6ad);
}
};
nitobi.form.Lookup.prototype.handleKey=function(evt,_6af){
var k=evt.keyCode;
var tc=this.textControl;
var sc=this.selectControl;
if(k==27){
this.deactivate(false);
return;
}
if(evt.ctrlKey&&k==86){
return;
}
if(evt.ctrlKey){
return;
}
switch(k){
case 9:
this.deactivate(true);
break;
case 13:
evt.returnValue=false;
evt.cancelBubble=true;
if(nitobi.browser.IE){
evt.keyCode=32;
}else{
nitobi.html.cancelEvent(evt);
nitobi.html.createEvent("KeyEvents","keydown",evt,{keyCode:0,charCode:32});
}
this.deactivate(true);
break;
default:
if(!this.bVisible){
sc.style.display="inline";
}
}
};
nitobi.form.Lookup.prototype.search=function(_6b3){
_6b3=nitobi.xml.constructValidXpathQuery(_6b3,false);
this.searchXslProc.addParameter("searchValue",_6b3.toLowerCase(),"");
var _6b4=nitobi.xml.transformToString(this.listXmlLower,this.searchXslProc);
if(""==_6b4){
_6b4=0;
}else{
_6b4=parseInt(_6b4);
}
return _6b4;
};
nitobi.form.Lookup.prototype.filter=function(evt,o){
if(!this.firstKeyup){
this.firstKeyup=true;
return;
}
var k=evt.keyCode;
var tc=this.textControl;
var sc=this.selectControl;
switch(k){
case 38:
if(sc.selectedIndex==-1){
sc.selectedIndex=0;
}
if(sc.selectedIndex>0){
sc.selectedIndex--;
}
tc.value=sc.options[sc.selectedIndex].text;
nitobi.html.highlight(tc,tc.value.length);
tc.select();
break;
case 40:
if(sc.selectedIndex<(sc.length-1)){
sc.selectedIndex++;
}
tc.value=sc.options[sc.selectedIndex].text;
nitobi.html.highlight(tc,tc.value.length);
tc.select();
break;
default:
if(k<188&&k>46){
var _6ba=tc.value;
this.get(_6ba);
}
}
};
nitobi.form.Lookup.prototype.get=function(_6bb){
if(this.getHandler!=null&&this.getHandler!=""){
this.doGet(_6bb);
}
this.bindComplete(_6bb);
};
nitobi.form.Lookup.prototype.doGet=function(_6bc){
if(_6bc){
this.dataTable.setGetHandlerParameter("SearchString",_6bc);
}
this.dataTable.get(null,this.pageSize,this);
this.timeoutId=null;
};
nitobi.form.Lookup.prototype.dispose=function(){
this.placeholder.object=null;
this.placeholder=null;
this.textControl.object=null;
this.textControl.onkeydown=null;
this.textControl.onkeyup=null;
this.textControl.onblur=null;
this.textControl=null;
this.owner=null;
};
nitobi.form.Number=function(){
nitobi.form.Number.baseConstructor.call(this);
};
nitobi.lang.extend(nitobi.form.Number,nitobi.form.Text);
nitobi.form.Number.prototype.handleKey=function(e){
nitobi.form.Number.base.handleKey.call(this,e);
};
nitobi.form.Password=function(){
nitobi.form.Password.baseConstructor.call(this,true);
this.control.type="password";
};
nitobi.lang.extend(nitobi.form.Password,nitobi.form.Text);
nitobi.form.TextArea=function(){
};
nitobi.lang.extend(nitobi.form.TextArea,nitobi.form.Text);
nitobi.form.TextArea.prototype.initialize=function(){
this.control=document.createElement("textarea");
this.control.style.position="absolute";
this.control.style["top"]=-2000;
this.control.style.left=-2000;
this.control.className="ebainput";
this.control.style.zIndex=2000;
this.control.object=this;
document.body.appendChild(this.control);
nitobi.html.attachEvent(this.control,"keydown",this.handleKey,this,false);
nitobi.html.attachEvent(this.control,"blur",this.deactivate,this,false);
};
nitobi.form.TextArea.prototype.mimic=function(){
nitobi.form.TextArea.base.mimic.call(this);
var _6be=nitobi.html.getHeight(this.control);
var _6bf=nitobi.html.getWidth(this.control);
this.control.style.height=_6be*2;
this.control.style.width=_6bf*1.5;
};
nitobi.form.TextArea.prototype.handleKey=function(evt,o){
var k=evt.keyCode;
switch(k){
case 40:
break;
case 38:
break;
case 37:
break;
case 39:
break;
case 13:
evt.cancelBubble=true;
evt.returnValue=false;
if(nitobi.browser.IE){
evt.keyCode=32;
}
if(!evt.shiftKey){
if(nitobi.browser.MOZ){
nitobi.html.createEvent("KeyEvents","keydown",evt,{"keyCode":0,"charCode":32});
}
this.deactivate();
}else{
if(nitobi.browser.MOZ){
nitobi.html.createEvent("KeyEvents","keypress",evt,{"keyCode":13,"charCode":0});
}
if(this.control.createTextRange){
this.control.focus();
var _6c3=document.selection.createRange();
_6c3.text="\n";
_6c3.collapse(false);
_6c3.select();
}
}
break;
case 9:
break;
case 27:
this.control.onblur=null;
this.hide();
this.owner.focus();
break;
default:
}
};
nitobi.ui.UiElement=function(xml,xsl,id){
if(arguments.length>0){
this.initialize(xml,xsl,id);
}
};
nitobi.ui.UiElement.prototype.initialize=function(xml,xsl,id){
this.m_Xml=xml;
this.m_Xsl=xsl;
this.m_Id=id;
this.m_HtmlElementHandle=null;
};
nitobi.ui.UiElement.prototype.getHeight=function(){
return this.getHtmlElementHandle().style.height;
};
nitobi.ui.UiElement.prototype.setHeight=function(_6ca){
this.getHtmlElementHandle().style.height=_6ca;
};
nitobi.ui.UiElement.prototype.getId=function(){
return this.m_Id;
};
nitobi.ui.UiElement.prototype.setId=function(id){
this.m_Id=id;
};
nitobi.ui.UiElement.prototype.getWidth=function(){
return this.getHtmlElementHandle().style.width;
};
nitobi.ui.UiElement.prototype.setWidth=function(_6cc){
this.getHtmlElementHandle().style.width=_6cc;
};
nitobi.ui.UiElement.prototype.getXml=function(){
return this.m_Xml;
};
nitobi.ui.UiElement.prototype.setXml=function(xml){
this.m_Xml=xml;
};
nitobi.ui.UiElement.prototype.getXsl=function(){
return this.m_Xsl;
};
nitobi.ui.UiElement.prototype.setXsl=function(xsl){
this.m_Xsl=xsl;
};
nitobi.ui.UiElement.prototype.getHtmlElementHandle=function(){
if(!this.m_HtmlElementHandle){
this.m_HtmlElementHandle=document.getElementById(this.m_Id);
}
return this.m_HtmlElementHandle;
};
nitobi.ui.UiElement.prototype.setHtmlElementHandle=function(_6cf){
this.m_HtmlElementHandle=_6cf;
};
nitobi.ui.UiElement.prototype.hide=function(){
var tag=this.getHtmlElementHandle();
tag.style.visibility="hidden";
tag.style.position="absolute";
};
nitobi.ui.UiElement.prototype.show=function(){
var tag=this.getHtmlElementHandle();
tag.style.visibility="visible";
};
nitobi.ui.UiElement.prototype.isVisible=function(){
var tag=this.getHtmlElementHandle();
return tag.style.visibility=="visible";
};
nitobi.ui.UiElement.prototype.beginFloatMode=function(){
var tag=this.getHtmlElementHandle();
tag.style.position="absolute";
};
nitobi.ui.UiElement.prototype.isFloating=function(){
var tag=this.getHtmlElementHandle();
return tag.style.position=="absolute";
};
nitobi.ui.UiElement.prototype.setX=function(x){
var tag=this.getHtmlElementHandle();
tag.style.left=x;
};
nitobi.ui.UiElement.prototype.getX=function(){
var tag=this.getHtmlElementHandle();
return tag.style.left;
};
nitobi.ui.UiElement.prototype.setY=function(y){
var tag=this.getHtmlElementHandle();
tag.style.top=y;
};
nitobi.ui.UiElement.prototype.getY=function(){
var tag=this.getHtmlElementHandle();
return tag.style.top;
};
nitobi.ui.UiElement.prototype.render=function(_6db,_6dc,_6dd){
var xsl=this.m_Xsl;
if(xsl!=null&&xsl.indexOf("xsl:stylesheet")==-1){
xsl="<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\"><xsl:output method=\"html\" version=\"4.0\" />"+xsl+"</xsl:stylesheet>";
}
if(null==_6dc){
_6dc=nitobi.xml.createXslDoc(xsl);
}
if(null==_6dd){
_6dd=nitobi.xml.createXmlDoc(this.m_Xml);
}
Eba.Error.assert(nitobi.xml.isValidXml(_6dd),"Tried to render invalid XML according to Mozilla. The XML is "+_6dd.xml);
var html=nitobi.xml.transform(_6dd,_6dc);
if(html.xml){
html=html.xml;
}
if(null==_6db){
document.body.insertAdjacentHTML("beforeEnd",html);
}else{
_6db.innerHTML=html;
}
this.attachToTag();
};
nitobi.ui.UiElement.prototype.attachToTag=function(){
var _6e0=this.getHtmlElementHandle();
if(_6e0!=null){
_6e0.object=this;
_6e0.jsobject=this;
_6e0.javascriptObject=this;
}
};
nitobi.ui.UiElement.prototype.dispose=function(){
var _6e1=this.getHtmlElementHandle();
if(_6e1!=null){
_6e1.object=null;
}
this.m_Xml=null;
this.m_Xsl=null;
this.m_HtmlElementHandle=null;
};
nitobi.ui.InteractiveUiElement=function(_6e2){
this.enable();
};
nitobi.lang.extend(nitobi.ui.InteractiveUiElement,nitobi.ui.UiElement);
nitobi.ui.InteractiveUiElement.prototype.enable=function(){
this.m_Enabled=true;
};
nitobi.ui.InteractiveUiElement.prototype.disable=function(){
this.m_Enabled=false;
};
nitobi.ui.ButtonXsl="<xsl:template match=\"button\">"+"<div class=\"EbaButton\" onmousemove=\"return false;\" onmousedown=\"if (this.object.m_Enabled) this.className='EbaButtonDown';\" onmouseup=\"this.className='EbaButton';\" onmouseover=\"if (this.object.m_Enabled) this.className='EbaButtonHighlight';\" onmouseout=\"this.className='EbaButton';\" align=\"center\">"+"<xsl:attribute name=\"image_disabled\">"+"<xsl:choose>"+"<xsl:when test=\"../../@image_directory\">"+"<xsl:value-of select=\"concat(../../@image_directory,@image_disabled)\" />"+"</xsl:when>"+"<xsl:otherwise>"+"<xsl:value-of select=\"@image_disabled\" />"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:attribute>"+"<xsl:attribute name=\"image_enabled\">"+"<xsl:choose>"+"<xsl:when test=\"../../@image_directory\">"+"<xsl:value-of select=\"concat(../../@image_directory,@image)\" />"+"</xsl:when>"+"<xsl:otherwise>"+"<xsl:value-of select=\"@image\" />"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:attribute>"+"<xsl:attribute name=\"title\">"+"<xsl:value-of select=\"@tooltip_text\" />"+"</xsl:attribute>"+"<xsl:attribute name=\"onclick\">"+"<xsl:value-of select='concat(&quot;v&quot;,&quot;a&quot;,&quot;r&quot;,&quot; &quot;,&quot;e&quot;,&quot;=&quot;,&quot;&apos;&quot;,@onclick_event,&quot;&apos;&quot;,&quot;;&quot;,&quot;e&quot;,&quot;v&quot;,&quot;a&quot;,&quot;l&quot;,&quot;(&quot;,&quot;t&quot;,&quot;h&quot;,&quot;i&quot;,&quot;s&quot;,&quot;.&quot;,&quot;o&quot;,&quot;b&quot;,&quot;j&quot;,&quot;e&quot;,&quot;c&quot;,&quot;t&quot;,&quot;.&quot;,&quot;o&quot;,&quot;n&quot;,&quot;C&quot;,&quot;l&quot;,&quot;i&quot;,&quot;c&quot;,&quot;k&quot;,&quot;H&quot;,&quot;a&quot;,&quot;n&quot;,&quot;d&quot;,&quot;l&quot;,&quot;e&quot;,&quot;r&quot;,&quot;(&quot;,&quot;e&quot;,&quot;)&quot;,&quot;)&quot;,&quot;;&quot;,&apos;&apos;)' />"+"</xsl:attribute>"+"<xsl:attribute name=\"id\">"+"<xsl:value-of select=\"@id\" />"+"</xsl:attribute>"+"<xsl:attribute name=\"style\">"+"<xsl:choose>"+"<xsl:when test=\"../../@height\">"+"<xsl:value-of select=\"concat('float:left;width:',../../@height,'px;height:',../../@height - 1,'px')\" />"+"</xsl:when>"+"<xsl:otherwise>"+"<xsl:value-of select=\"concat('float:left;width:',@width,'px;height:',@height,'px')\" />"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:attribute>"+"<img border=\"0\">"+"<xsl:attribute name=\"src\">"+"<xsl:choose>"+"<xsl:when test=\"../../@image_directory\">"+"<xsl:value-of select=\"concat(../../@image_directory,@image)\" />"+"</xsl:when>"+"<xsl:otherwise>"+"<xsl:value-of select=\"@image\" />"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:attribute>"+"<xsl:attribute name=\"style\">"+"<xsl:variable name=\"top_offset\">"+"<xsl:choose>"+"<xsl:when test=\"@top_offset\">"+"<xsl:value-of select=\"@top_offset\" />"+"</xsl:when>"+"<xsl:otherwise>"+"0"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:variable>"+"<xsl:choose>"+"<xsl:when test=\"../../@height\">"+"<xsl:value-of select=\"concat('MARGIN-TOP:',((../../@height - @height) div 2) - 1 + number($top_offset),'px;MARGIN-BOTTOM:0px')\" />"+"</xsl:when>"+"<xsl:otherwise>"+"<xsl:value-of select=\"concat('MARGIN-TOP:',(@height - @image_height) div 2,'px;MARGIN-BOTTOM:0','px')\" />"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:attribute>"+"</img><![CDATA[ ]]>"+"</div>"+"</xsl:template>";
nitobi.ui.Button=function(xml,id){
this.initialize(xml,nitobi.ui.ButtonXsl,id);
this.enable();
};
nitobi.lang.extend(nitobi.ui.Button,nitobi.ui.InteractiveUiElement);
nitobi.ui.Button.prototype.onClickHandler=function(_6e5){
if(this.m_Enabled){
eval(_6e5);
}
};
nitobi.ui.Button.prototype.disable=function(){
nitobi.ui.Button.base.disable.call(this);
var _6e6=this.getHtmlElementHandle();
_6e6.childNodes[0].src=_6e6.getAttribute("image_disabled");
};
nitobi.ui.Button.prototype.enable=function(){
nitobi.ui.Button.base.enable.call(this);
var _6e7=this.getHtmlElementHandle();
_6e7.childNodes[0].src=_6e7.getAttribute("image_enabled");
};
nitobi.ui.Button.prototype.dispose=function(){
nitobi.ui.Button.base.dispose.call(this);
};
nitobi.ui.BinaryStateButtonXsl="<xsl:template match=\"binarystatebutton\">"+"<div class=\"EbaBinaryStateButton\" onmousemove=\"return false;\" onmousedown=\"if (this.object.m_Enabled) this.className='EbaButtonDown';\" onmouseup=\"(this.object.isChecked()?this.object.check():this.object.uncheck())\" onmouseover=\"if (this.object.m_Enabled) this.className='EbaButtonHighlight';\" onmouseout=\"(this.object.isChecked()?this.object.check():this.object.uncheck())\" align=\"center\">"+"<xsl:attribute name=\"image_disabled\">"+"<xsl:choose>"+"<xsl:when test=\"../../@image_directory\">"+"<xsl:value-of select=\"concat(../../@image_directory,@image_disabled)\" />"+"</xsl:when>"+"<xsl:otherwise>"+"<xsl:value-of select=\"@image_disabled\" />"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:attribute>"+"<xsl:attribute name=\"image_enabled\">"+"<xsl:choose>"+"<xsl:when test=\"../../@image_directory\">"+"<xsl:value-of select=\"concat(../../@image_directory,@image)\" />"+"</xsl:when>"+"<xsl:otherwise>"+"<xsl:value-of select=\"@image\" />"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:attribute>"+"<xsl:attribute name=\"title\">"+"<xsl:value-of select=\"@tooltip_text\" />"+"</xsl:attribute>"+"<xsl:attribute name=\"onclick\">"+"<xsl:value-of select='concat(\"this.object.toggle();\",&quot;v&quot;,&quot;a&quot;,&quot;r&quot;,&quot; &quot;,&quot;e&quot;,&quot;=&quot;,&quot;&apos;&quot;,@onclick_event,&quot;&apos;&quot;,&quot;;&quot;,&quot;e&quot;,&quot;v&quot;,&quot;a&quot;,&quot;l&quot;,&quot;(&quot;,&quot;t&quot;,&quot;h&quot;,&quot;i&quot;,&quot;s&quot;,&quot;.&quot;,&quot;o&quot;,&quot;b&quot;,&quot;j&quot;,&quot;e&quot;,&quot;c&quot;,&quot;t&quot;,&quot;.&quot;,&quot;o&quot;,&quot;n&quot;,&quot;C&quot;,&quot;l&quot;,&quot;i&quot;,&quot;c&quot;,&quot;k&quot;,&quot;H&quot;,&quot;a&quot;,&quot;n&quot;,&quot;d&quot;,&quot;l&quot;,&quot;e&quot;,&quot;r&quot;,&quot;(&quot;,&quot;e&quot;,&quot;)&quot;,&quot;)&quot;,&quot;;&quot;,&apos;&apos;)' />"+"</xsl:attribute>"+"<xsl:attribute name=\"id\">"+"<xsl:value-of select=\"@id\" />"+"</xsl:attribute>"+"<xsl:attribute name=\"style\">"+"<xsl:choose>"+"<xsl:when test=\"../../@height\">"+"<xsl:value-of select=\"concat('float:left;width:',../../@height,'px;height:',../../@height - 1,'px')\" />"+"</xsl:when>"+"<xsl:otherwise>"+"<xsl:value-of select=\"concat('float:left;width:',@width,'px;height:',@height,'px')\" />"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:attribute>"+"<img border=\"0\">"+"<xsl:attribute name=\"src\">"+"<xsl:choose>"+"<xsl:when test=\"../../@image_directory\">"+"<xsl:value-of select=\"concat(../../@image_directory,@image)\" />"+"</xsl:when>"+"<xsl:otherwise>"+"<xsl:value-of select=\"@image\" />"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:attribute>"+"<xsl:attribute name=\"style\">"+"<xsl:variable name=\"top_offset\">"+"<xsl:choose>"+"<xsl:when test=\"@top_offset\">"+"<xsl:value-of select=\"@top_offset\" />"+"</xsl:when>"+"<xsl:otherwise>"+"0"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:variable>"+"<xsl:choose>"+"<xsl:when test=\"../../@height\">"+"<xsl:value-of select=\"concat('MARGIN-TOP:',((../../@height - @height) div 2) - 1 + number($top_offset),'px;MARGIN-BOTTOM:0px')\" />"+"</xsl:when>"+"<xsl:otherwise>"+"<xsl:value-of select=\"concat('MARGIN-TOP:',(@height - @image_height) div 2,'px;MARGIN-BOTTOM:0','px')\" />"+"</xsl:otherwise>"+"</xsl:choose>"+"</xsl:attribute>"+"</img><![CDATA[ ]]>"+"</div>"+"</xsl:template>";
nitobi.ui.BinaryStateButton=function(xml,id){
this.initialize(xml,nitobi.ui.BinaryStateButtonXsl,id);
this.m_Checked=false;
};
nitobi.lang.extend(nitobi.ui.BinaryStateButton,nitobi.ui.Button);
nitobi.ui.BinaryStateButton.prototype.isChecked=function(){
return this.m_Checked;
};
nitobi.ui.BinaryStateButton.prototype.check=function(){
var _6ea=this.getHtmlElementHandle();
_6ea.className="EbaButtonChecked";
this.m_Checked=true;
};
nitobi.ui.BinaryStateButton.prototype.uncheck=function(){
var _6eb=this.getHtmlElementHandle();
_6eb.className="EbaButton";
this.m_Checked=false;
};
nitobi.ui.BinaryStateButton.prototype.toggle=function(){
var _6ec=this.getHtmlElementHandle();
if(_6ec.className=="EbaButtonChecked"){
this.uncheck();
}else{
this.check();
}
};
nitobi.ui.ToolbarXsl="<xsl:template match=\"//toolbar\">"+"<div class=\"EbaToolbar\" style=\"z-index:800\" padding=\"0px\" margin=\"0px\">"+"<xsl:attribute name=\"id\">"+"<xsl:value-of select=\"@id\" />"+"</xsl:attribute>"+"<xsl:attribute name=\"style\">float:left;"+"<xsl:value-of select=\"concat('width:',@width,'px;height:',@height,'px')\" />"+"</xsl:attribute>"+"<div id=\"ToolbarTitle\" onmousedown=\"this.parentNode.jsobject.dragWindow(event)\" ondblclick=\"this.parentNode.jsobject.dock()\" style=\"width:100%;position:absolute;visibility:hidden\">"+"<div class=\"EbaToolbarTitle\" >"+"<div style=\"float:right;\" onclick=\"this.parentNode.parentNode.parentNode.jsobject.dock();\">^</div>"+"<xsl:value-of select=\"@title\"/>"+"</div>"+"</div> "+"<div onmousedown=\"this.parentNode.jsobject.startDrag(event)\" id=\"handle\" style=\"width:10px;height:100%;float:left;\" class=\"EbaToolbarHandle\"><span></span></div>"+"<xsl:apply-templates />"+"</div>"+"</xsl:template>"+nitobi.ui.ButtonXsl+nitobi.ui.BinaryStateButtonXsl+"<xsl:template match=\"separator\">"+"<div align='center'>"+"<xsl:attribute name=\"style\">"+"<xsl:value-of select=\"concat('float:left;width:',@width,';height:',@height)\" />"+"</xsl:attribute>"+"<xsl:attribute name=\"id\">"+"<xsl:value-of select=\"@id\" />"+"</xsl:attribute>"+"<img border='0'>"+"<xsl:attribute name=\"src\">"+"<xsl:value-of select=\"concat(//@image_directory,@image)\" />"+"</xsl:attribute>"+"<xsl:attribute name=\"style\">"+"<xsl:value-of select=\"concat('MARGIN-TOP:3','px;MARGIN-BOTTOM:0','px')\" />"+"</xsl:attribute>"+"</img>"+"</div>"+"</xsl:template>";
nitobi.ui.Toolbar=function(xml,id){
nitobi.ui.Toolbar.baseConstructor.call(this);
this.initialize(xml,nitobi.ui.ToolbarXsl,id);
this.m_isFloating=false;
};
nitobi.lang.extend(nitobi.ui.Toolbar,nitobi.ui.InteractiveUiElement);
nitobi.ui.Toolbar.prototype.getUiElements=function(){
return this.m_UiElements;
};
nitobi.ui.Toolbar.prototype.setUiElements=function(_6ef){
this.m_UiElements=_6ef;
};
nitobi.ui.Toolbar.prototype.attachButtonObjects=function(){
if(!this.m_UiElements){
this.m_UiElements=new Array();
var tag=this.getHtmlElementHandle();
var _6f1=tag.childNodes;
for(var i=0;i<_6f1.length;i++){
var _6f3=_6f1[i];
if(_6f3.nodeType!=3&&_6f3.className!="EbaToolbarTitle"&&_6f3.className!="EbaToolbarHandle"){
var _6f4;
switch(_6f3.className){
case ("EbaButton"):
_6f4=new nitobi.ui.Button(null,_6f3.id);
break;
case ("EbaBinaryStateButton"):
_6f4=new nitobi.ui.BinaryStateButton(null,_6f3.id);
break;
default:
_6f4=new nitobi.ui.UiElement(null,null,_6f3.id);
break;
}
_6f4.attachToTag();
this.m_UiElements[_6f3.id]=_6f4;
}
}
}
};
nitobi.ui.Toolbar.prototype.render=function(_6f5){
nitobi.ui.Toolbar.base.base.render.call(this,_6f5);
this.attachButtonObjects();
};
nitobi.ui.Toolbar.prototype.disableAllElements=function(){
for(var i in this.m_UiElements){
if(this.m_UiElements[i].disable){
this.m_UiElements[i].disable();
}
}
};
nitobi.ui.Toolbar.prototype.enableAllElements=function(){
for(var i in this.m_UiElements){
if(this.m_UiElements[i].enable){
this.m_UiElements[i].enable();
}
}
};
nitobi.ui.Toolbar.prototype.attachToTag=function(){
nitobi.ui.Toolbar.base.base.attachToTag.call(this);
this.attachButtonObjects();
};
nitobi.ui.Toolbar.prototype.getGrabbyElement=function(){
var tag=this.getHtmlElementHandle();
return tag.childNodes[1];
};
nitobi.ui.Toolbar.prototype.dragStart=function(){
var tag=this.getHtmlElementHandle();
return tag.childNodes[1];
};
nitobi.ui.Toolbar.prototype.startDrag=function(_6fa){
var evt;
if(nitobi.browser.IE){
evt=window.event;
}else{
evt=_6fa;
}
var tag=this.getHtmlElementHandle();
var _6fd=this.getGrabbyElement();
_6fd.style.visibility="hidden";
_6fd.style.position="absolute";
this.dragDiv=document.getElementById("toolbar_window"+tag.id);
if(null==this.dragDiv){
this.dragDiv=document.createElement("toolbar_window"+tag.id);
document.body.appendChild(this.dragDiv);
this.dragDiv.jsobject=this;
}
tag.swapNode(this.dragDiv);
tag.style.position="absolute";
var This=this;
if(nitobi.browser.IE){
x=window.event.clientX+document.documentElement.scrollLeft+document.body.scrollLeft;
y=window.event.clientY+document.documentElement.scrollTop+document.body.scrollTop;
}else{
x=_6fa.clientX+window.scrollX;
y=_6fa.clientY+window.scrollY;
}
tag.style.top=y-5;
tag.style.left=x-5;
var _6ff=tag.childNodes[0].style;
_6ff.visibility="visible";
_6ff.position="";
tag.style.height="41px";
tag.className="EbaToolbarFloating";
nitobi.ui.startDragOperation(tag,_6fa);
if(!this.m_isFloating&&this.undockEvent){
this.m_isFloating=true;
this.undockEvent();
}else{
if(!this.m_isFloating){
this.m_isFloating=true;
}
}
};
nitobi.ui.Toolbar.prototype.dragWindow=function(_700){
var evt;
if(nitobi.browser.IE){
evt=window.event;
}else{
evt=_700;
}
nitobi.ui.startDragOperation(this.getHtmlElementHandle(),_700);
};
nitobi.ui.Toolbar.prototype.dock=function(){
var tag=this.getHtmlElementHandle();
tag.style.position="";
tag.style.height="23px";
tag.className="EbaToolbar";
var _703=tag.childNodes[0].style;
_703.position="absolute";
_703.visibility="hidden";
tag.swapNode(this.dragDiv);
var _704=this.getGrabbyElement();
_704.style.visibility="visible";
_704.style.position="";
this.m_isFloating=false;
if(this.dockEvent){
this.dockEvent();
}
tag=null;
_703=null;
};
nitobi.ui.Toolbar.prototype.dispose=function(){
if(typeof (this.m_UiElements)!="undefined"){
for(var _705 in this.m_UiElements){
this.m_UiElements[_705].dispose();
}
this.m_UiElements=null;
}
nitobi.ui.Toolbar.base.dispose.call(this);
};


var temp_ntb_apiDoc='<?xml version="1.0" ?><interfaces>	<interface name="nitobi.grid.Cell" tagname="ntb:cell" 			remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaCellApiDocumentation" 			examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets" 			summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaCellApiDocumentation">		<summary>nitobi.grid.Cell represents a single data cell in a Grid.</summary>		<properties>			<property name="Row" type="int" access="public" persist="js" default=""				readwrite="read" impact="xsl row" testvalue="1">			</property>			<property name="Column" type="int" access="public" persist="js" default=""				readwrite="read" impact="xsl row" testvalue="1">			</property>			<property name="DomNode" type="xml" access="public" persist="js" default=""				readwrite="read" impact="xsl row" testvalue="1">			</property>			<property name="DataNode" type="xml" access="public" persist="js" default=""				readwrite="read" impact="xsl row" testvalue="1">			</property>		</properties>		<methods>                                   <method name="getCellElement" access="private"></method>            <method name="getRowNumber" access="private"></method>            <method name="getColumnNumber" access="private"></method>                                   <method name="Focus" access="public"></method>		</methods>	</interface>		<interface name="nitobi.grid.Columns" ></interface>		<interface name="nitobi.grid.Column" tagname="ntb:column" 		remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaColumnApiDocumentation" 		examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets" 		summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaColumnApiDocumentation">		<summary>nitobi.grid.Column represents a single column of data in a Grid.</summary>		<properties>			<property name="Align" type="string" access="private" persist="model" model="Align" default="&quot;left&quot;"				readwrite="readwrite" impact="xsl row " htmltag="align" testvalue="&quot;&quot;">							</property>			<property name="ClassName" type="string" access="private" persist="model" model="ClassName" default="&quot;&quot;"				readwrite="readwrite" impact="xsl row " htmltag="classname" testvalue="&quot;&quot;">							</property>			<property name="CssStyle" type="string" access="private" persist="model" model="CssStyle" default="&quot;&quot;"				readwrite="readwrite" impact="xsl row " htmltag="cssstyle" testvalue="&quot;&quot;">							</property>			<property name="ColumnName" type="string" access="private" persist="model" model="ColumnName" default="&quot;&quot;"				readwrite="readwrite" impact="xsl row" htmltag="columnname" testvalue="&quot;&quot;">			</property>			<property name="HeaderElement" type="string" access="private" persist="js" default="&quot;&quot;"				readwrite="readwrite" impact="xsl row" htmltag="headerelement" testvalue="&quot;&quot;">			</property>			<property name="Type" type="string" access="private" persist="model" model="type" code="" default="&quot;text&quot;"				impact="row" readwrite="readwrite" htmltag="type" testvalue="&quot;pcm&quot;">			</property>			<property name="DataType" type="string" access="public" persist="model" model="DataType" default="text" 				readwrite="readwrite" impact="xsl row" code="" testvalue="&quot;text&quot;">			</property>			<property name="Editable" type="bool" access="public" persist="model" model="Editable" default="true" 				readwrite="readwrite" impact="model" htmltag="editable" testvalue="false">			</property>			<property name="Initial" type="string" access="public" default="&quot;&quot;" htmltag="initial"				readwrite="readwrite" persist="model" model="Initial" testvalue="&quot;test&quot;">			</property>			<property name="Label" model="Label" type="string" access="public" default="&quot;&quot;"				htmltag="label" readwrite="read" persist="model meta" impact="xsl row" testvalue="&quot;test&quot;">			</property>			<property name="GetHandler" type="string" access="private" default="&quot;&quot;"				persist="model" model="GetHandler" htmltag="gethandler" readwrite="readwrite" impact="xsl row" testvalue="&quot;test&quot;">			</property>						<property name="DataSource" type="string" access="private" default="&quot;&quot;"				persist="model" model="DataSource" htmltag="datasource" readwrite="readwrite" impact="xsl row" testvalue="&quot;test&quot;">			</property>			<property name="Template" type="string" access="private" default="&quot;&quot;"				persist="model" model="Template" htmltag="template" readwrite="readwrite" impact="xsl row" testvalue="&quot;test&quot;">			</property>			<property name="TemplateUrl" type="string" access="private" default="&quot;&quot;"				persist="model" model="TemplateUrl" htmltag="templateurl" readwrite="readwrite" impact="xsl row" testvalue="&quot;test&quot;">			</property>			<property name="MaxLength" type="int" access="public" default="255" htmltag="maxlength" readwrite="readwrite"				persist="model meta" impact="xsl row" model="maxlength" testvalue="200">			</property>			<property name="SortDirection" model="SortDirection" type="string" access="public"				default="&quot;Desc&quot;" htmltag="sortdirection" readwrite="readwrite" persist="model" impact="sort"				testvalue="&quot;Desc&quot;">			</property>			<property name="SortEnabled" model="SortEnabled" type="bool" access="public"				default="true" htmltag="sortenabled" readwrite="readwrite" persist="model" impact="sort"				testvalue="true">			</property>			<property name="Width" model="Width" type="int" access="public" default="100" htmltag="width"				readwrite="readwrite" persist="model" impact="size css row" testvalue="200">				<include path="//*[@id=\'widthsample\']" type="example"/>			</property>			<property name="Visible" model="Visible" type="bool" access="private" default="true" htmltag="visible"				readwrite="readwrite" persist="model" impact="size css row" testvalue="true">			</property>			<property name="xdatafld" type="string" access="public" default="&quot;&quot;" readwrite="read"				persist="meta model" model="xdatafld" htmltag="xdatafld">			</property>			<property name="Value" type="string" access="public" default="&quot;&quot;" readwrite="read"				persist="meta model" model="Value" htmltag="value">			</property>			<property name="xi" type="int" access="private" default="100" htmltag="xi" readwrite="read"				persist="meta model" model="xi" short="xi">			</property>			<property name="Editor" model="Editor" namespace="Eba.Grid" type="Editor" access="private" default="Eba.Grid.TextEditor" htmltag="editor"				readwrite="readwrite" persist="model" impact="" testvalue="true">			</property>		</properties>		<events>			<event name="OnCellClickEvent" model="OnCellClickEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="oncellclickevent"				persist="model"></event>			<event name="OnCellDblClickEvent" model="OnCellDblClickEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="oncelldblclickevent"				persist="model"></event>			<event name="OnHeaderDoubleClickEvent" model="OnHeaderDoubleClickEvent" type="string" access="private" default="&quot;&quot;"				readwrite="readwrite" htmltag="onheaderdoubleclickevent" persist="model"></event>			<event name="OnHeaderClickEvent" model="OnHeaderClickEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onheaderclickevent"				persist="model"></event>			<event name="OnBeforeResizeEvent" model="OnBeforeResizeEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onbeforeresizeevent"				persist="model"></event>			<event name="OnAfterResizeEvent" model="OnAfterResizeEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onafterresizeevent"				persist="model"></event>						<event name="OnCellValidateEvent" model="OnCellValidateEvent" type="string" access="private" default="&quot;&quot;" readwrite="readwrite" htmltag="oncellvalidateevent"				persist="model"></event>			<event name="OnBeforeCellEditEvent" model="OnBeforeCellEditEvent" type="String" access="private" default="&quot;&quot;" readwrite="readwrite" htmltag="onbeforecelleditevent"				persist="model"></event>			<event name="OnAfterCellEditEvent" model="OnAfterCellEditEvent" type="String" access="private" default="&quot;&quot;" readwrite="readwrite" htmltag="onaftercelleditevent"				persist="model"></event>			<event name="OnCellBlurEvent" model="OnCellBlurEvent" type="String" access="private" default="&quot;&quot;" readwrite="readwrite" htmltag="oncellblurevent"				persist="model"></event>			<event name="OnCellFocusEvent" model="OnCellFocusEvent" type="String" access="private" default="&quot;&quot;" readwrite="readwrite" htmltag="oncellfocusevent"				persist="model"></event>			<event name="OnBeforeSortEvent" model="OnBeforeSortEvent" type="String" access="private" default="&quot;&quot;" readwrite="readwrite" htmltag="onbeforesortevent"				persist="model"></event>			<event name="OnAfterSortEvent" model="OnAfterSortEvent" type="String" access="private" default="&quot;&quot;" readwrite="readwrite" htmltag="onaftersortevent"				persist="model"></event>			<event name="OnCellUpdateEvent" model="OnCellUpdateEvent" type="String" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="oncellupdateevent"				persist="model"></event>		</events>	</interface>	<interface name="EBADateColumn" tagname="ntb:datecolumn" 		remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaDateColumnApiDocumentation" 		examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets" 		summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaDateColumnApiDocumentation">		<properties>			<property name="Mask" htmltag="mask" type="string" persist="model" model="Mask"				access="public" readwrite="readwrite" default="&quot;M/d/yyyy&quot;">							</property>		</properties>	</interface>	<interface name="EBANumberColumn" tagname="ntb:numbercolumn" 		remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaDateColumnApiDocumentation" 		examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets" 		summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaDateColumnApiDocumentation">		<properties>			<property name="Align" type="string" access="private" persist="model" model="Align" default="&quot;right&quot;"				readwrite="readwrite" impact="xsl row " htmltag="align" testvalue="&quot;&quot;">							</property>			<property name="Mask" htmltag="mask" type="string" persist="model" model="Mask"				access="public" readwrite="readwrite" default="&quot;#,###.00&quot;">							</property>			<property name="GroupingSeparator" htmltag="groupingseparator" type="string" persist="model" model="GroupingSeparator"				access="public" readwrite="readwrite" default="&quot;,&quot;">							</property>			<property name="DecimalSeparator" htmltag="decimalseparator" type="string" persist="model" model="DecimalSeparator"				access="public" readwrite="readwrite" default="&quot;.&quot;">							</property>		</properties>	</interface>	<interface name="EBATextColumn" tagname="ntb:textcolumn" 		remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaTextApiDocumentation" 		examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets" 		summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaTextApiDocumentation">	</interface>	<interface name="EBALookupEditor" tagname="ntb:lookupeditor" 		remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaLookupEditor" 		examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets" 		summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaLookupEditor">				<properties>			<property name="DatasourceId" htmltag="datasourceid" type="string" persist="model" model="DatasourceId" 				access="public" readwrite="readwrite" default="">			</property>			<property name="Datasource" htmltag="datasource" type="string" persist="model" model="Datasource" 				access="public" readwrite="readwrite" default="">			</property>						<property name="GetHandler" htmltag="gethandler" type="string" persist="model" model="GetHandler" 				access="public" readwrite="readwrite" default="">			</property>			<property name="DisplayFields" htmltag="displayfields" type="string" persist="model" model="DisplayFields"				access="public" readwrite="readwrite" default="">			</property>			<property name="ValueField" htmltag="valuefield" type="string" persist="model" model="ValueField"				access="public" readwrite="readwrite" default="">			</property>			<property name="Delay" htmltag="delay" type="string" persist="model" model="Delay"				access="public" readwrite="readwrite" default="">			</property>					</properties>	</interface>	<interface name="EBACheckboxEditor" tagname="ntb:checkboxeditor" 		remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaCheckboxEditor" 		examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets" 		summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaCheckboxEditor">		<properties>			<property name="DatasourceId" htmltag="datasourceid" type="string" persist="model" model="DatasourceId" 				access="public" readwrite="readwrite" default="">								<include path="//*[@id=\'staticdatacheckboxeditor\']" type="example" />							</property>			<property name="Datasource" htmltag="datasource" type="string" persist="model" model="Datasource" 				access="public" readwrite="readwrite" default="">							</property>			<property name="GetHandler" htmltag="gethandler" type="string" persist="model" model="GetHandler" 				access="public" readwrite="readwrite" default="">				<summary>Specifies the URL of the CheckboxEditor\'s gethandler.  The gethandler must return valid XML data in the EBA format.</summary>								<include path="//*[@id=\'staticdatacheckboxeditor\']" type="example" />							</property>			<property name="DisplayFields" htmltag="displayfields" type="string" persist="model" model="DisplayFields"				access="public" readwrite="readwrite" default="">				<summary>Specifies what fields from the datasource specified by DatasourceId or by the GetHandler will populate the CheckboxEditor\'s listbox.</summary>				<remarks>DisplayFields is a pipe-delimited list of data fields (eg. "field1|field2|field3").</remarks>								<include path="//*[@id=\'staticdatacheckboxeditor\']" type="example" />			</property>			<property name="ValueField" htmltag="valuefield" type="string" persist="model" model="ValueField"				access="public" readwrite="readwrite" default="">				<summary>Specifies the field of the CheckboxEditor\'s data source that will populate the cell.</summary>								<include path="//*[@id=\'staticdatacheckboxeditor\']" type="example" />			</property>			<property name="CheckedValue" htmltag="checkedvalue" type="string" persist="model" model="CheckedValue"				access="public" readwrite="readwrite" default="">							</property>			<property name="UnCheckedValue" htmltag="uncheckedvalue" type="string" persist="model" model="UnCheckedValue"				access="public" readwrite="readwrite" default="">							</property>		</properties>	</interface>	<interface name="EBAImageEditor" tagname="ntb:imageeditor" 		remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaImageEditor" 		examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets" 		summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaImageEditor">				<properties>			<property name="ImageUrl" htmltag="imageurl" type="string" persist="model" model="ImageUrl"				access="public" readwrite="readwrite" default="">			</property>		</properties>	</interface>	<interface name="EBALinkEditor" tagname="ntb:linkeditor" 		remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaLinkEditor" 		examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets" 		summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaLinkEditor">		<properties>		</properties>	</interface>		<interface name="EBATextEditor" tagname="ntb:texteditor" 	remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaTextEditor"     examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets"     summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaTextEditor">		<properties>			<property name="MaxLength" htmltag="maxlength" type="int" persist="model" model="MaxLength"				access="public" readwrite="readwrite" default="255">							</property>		</properties>	</interface>	<interface name="EBATextareaEditor" tagname="ntb:textareaeditor" namespace="Eba.Grid" type="Eba.Grid.TextareaEditor" inherits="Editor" jstype="object" 	remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaTextAreaEditor"     examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets"     summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaTextAreaEditor">				<properties>			<property name="MaxLength" htmltag="maxlength" type="int" persist="model" model="MaxLength"				access="public" readwrite="readwrite" default="255">							</property>		</properties>	</interface>	<interface name="EBALinkEditor" tagname="ntb:linkeditor" 	remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaLinkEditor"     examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets"     summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaLinkEditor">		<properties>			<property name="OpenWindow" htmltag="openwindow" type="bool" persist="model" model="OpenWindow"				access="public" readwrite="readwrite" default="true">							</property>		</properties>	</interface>	<interface name="EBADateEditor" tagname="ntb:dateeditor" namespace="Eba.Grid" type="Eba.Grid.DateEditor" inherits="Editor" jstype="object" 	remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaDateEditor"     examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets"     summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaDateEditor">		<properties>			<property name="Mask" htmltag="mask" type="string" persist="model" model="Mask"				access="public" readwrite="readwrite" default="&quot;M/d/yyyy&quot;">							</property>		</properties>	</interface>	<interface name="EBAListboxEditor" tagname="ntb:listboxeditor" 	remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaListboxEditor"     examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets"     summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaListboxEditor">			<properties>			<property name="DatasourceId" htmltag="datasourceid" type="string" persist="model" model="DatasourceId" 				access="public" readwrite="readwrite" default="">							</property>			<property name="Datasource" htmltag="datasource" type="string" persist="model" model="Datasource" 				access="public" readwrite="readwrite" default="">							</property>			<property name="GetHandler" htmltag="gethandler" type="string" persist="model" model="GetHandler" 				access="public" readwrite="readwrite" default="">							</property>			<property name="DisplayFields" htmltag="displayfields" type="string" persist="model" model="DisplayFields"				access="public" readwrite="readwrite" default="">							</property>			<property name="ValueField" htmltag="valuefield" type="string" persist="model" model="ValueField"				access="public" readwrite="readwrite" default="">							</property>		</properties>	</interface>	<interface name="nitobi.grid.Row" tagname="ntb:e" namespace="Eba.Grid" type="Eba.Grid.Row" jstype="object" 	remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaRowApiDocumentation"     examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets"     summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaRowApiDocumentation">		<elements>		</elements>		<properties>			<property name="ClassName" type="string" access="private" persist="meta" default="&quot;&quot;"				readwrite="readwrite" impact="xsl row " htmltag="ClassName" testvalue="&quot;&quot;">							</property>			<property name="Height" default="23" code="" type="int" persist="meta" impact="row"				access="public" readwrite="readwrite" htmltag="Height" testvalue="50">							</property>		</properties>	</interface>			<interface name="nitobi.grid.Grid" tagname="ntb:grid" namespace="Eba" type="Eba.Grid.Grid" jstype="object" 	remarkfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaGridApiDocumentation"     examplefile="http://portal:8090/cgi-bin/trac.cgi/wiki/SharedCodeSnippets"     summaryfile="http://portal:8090/cgi-bin/trac.cgi/wiki/EbaGridApiDocumentation">		<elements>			<element name="EBADatasources" minoccurs="0" maxoccurs="1" />			<element name="nitobi.grid.Columns" minoccurs="0" maxoccurs="1" />		</elements>                <methods>                        <method name="selectRowByIndex" access="private">                                <summary>Selects a grid cell by row index.</summary>                                <param name="index" type="int">the row index</param>                                <returns type="nitobi.grid.Row"></returns>                                <include path="//*[@id=\'work1\']" type="example"/>                        </method>                                        <method name="selectRowByKey" access="private">                                                         <summary>Selects a grid cell by key.</summary>                                                          <param name="key" type="string">the key of grid data</param>                                                                                            <returns type="nitobi.grid.Row"></returns>                                                       </method>                                                       <method name="selectCellByCoords" access="public">                                <summary>Activates a grid cell. The activated cell is highlighted.                                 Subsequent function calls such as deleteCurrentRow, insertAfterCurrentRow, getActiveColumnObject, getActiveRowObject depends on the new active cell.                                  The row and colum index starts at 0.                                </summary>                                <param name="column" type="int">column number</param>                                <param name="row" type="int">row number</param>                                <returns type=""></returns>                                     <include type="remark" />                                               </method>                                        <method name="save" access="public">                                <summary>Saves data in the grid.</summary>                                <returns type=""></returns>                        </method>                                                       <method name="insertAfterCurrentRow" access="public">                                <summary>Insert a new row after the row of the active cell.</summary>                                <returns type=""></returns>                        </method>                                        <method name="deleteCurrentRow" access="public">                                <summary>Deletes currently selected row.</summary>                                <returns type=""></returns>                        </method>                                                <method name="insertRow" access="public">                                <summary>Inserts a new row into the grid</summary>                                <returns type=""></returns>                        </method>                                                                       <method name="getCellObject" access="public">                                <summary>Returns the cell object of a grid.</summary>                                <param name="column" type="int">column number</param>                                <param name="row" type="int">row number</param>                                <returns type="nitobi.grid.Cell"></returns>                        </method>                        <method name="getRowObject" access="public">                                <summary>Returns a row object.</summary>                                <param></param>                                <returns type="nitobi.grid.Row"></returns>                        </method>                                                <method name="getRowCount" access="public">                                <summary>Returns the number of rows in the grid.</summary>                                <returns type="int"></returns>                        </method>                                                                       <method name="getSelectedLookupKey" access="public">                                <summary>Returns the selected lookup key</summary>                                <returns type="string"></returns>                        </method>                                                <method name="getSelectedColumnNumber" access="public">                                <summary>Returns the column index of the selected cell. </summary>                                <param name="rel" type="bool">Specifies whether to compensate for frozen columns.</param>                                <returns type="int">Column index of the selected cell.</returns>                        </method>                        <method name="getSelectedColumnObject" access="public">                                <summary>Returns the nitobi.grid.Column object that the selected cell is part of.</summary>                                <returns type="nitobi.grid.Column">nitobi.grid.Column object of the selected cell.</returns>                                                        </method>                        <method name="getSelectedRow" access="private">                                <summary>Returns the row index of the selected cell. </summary>                                <param name="rel" type="bool">Specifies whether to compensate for frozen rows.</param>                                <returns type="int">Row index of the selected cell.</returns>                                                        </method>                        <method name="getSelectedRowObject" access="public">                                <summary>Returns the nitobi.grid.Row object that the selected cell is part of.</summary>                                <returns type="nitobi.grid.Column">nitobi.grid.Row object of the selected cell.</returns>                                                        </method>                        <method name="getSelectedCellObject" access="public">                                <summary>Returns a reference to the nitobi.grid.Cell object representing the currently selected cell in the Grid. </summary>                                                                <returns type="nitobi.grid.Cell">selected nitobi.grid.Cell object.</returns>                                <include  path="//*[@id=\'ebaxml_fielddef_getvalue\']" type="remarks" />                        </method>                        <method name="GridSelection" access="private">                                <summary>The selection object is used during select operations by the user. Its members provide the functionality for displaying the selected(highlighted blocks</summary>                                <param name="oGrid" type="object">A reference to the grid containing the selection</param>                        </method>                        <method name="selectionhighlight" access="private">                                <summary>Highlights the selected area</summary>                        </method>                        <method name="deselect" access="private">                                <summary>Acts as the opposite of highlight</summary>                        </method>                        <method name="containsSelection" access="private">                                <summary>Returns true if the grid contains a valid selection</summary>                        </method>                        <method name="cellIsInSelection" access="private">                                <summary>Returns true if the given Cell is situated inside the active grid selection and the selection is bigger than just one cell.</summary>                        </method>                        <method name="copy" access="private">                                <summary>Copys the current selection into the clipboard. This method stores the data as text with a tab for every column. This is the same format MS Excel uses and therefore the paste method also works with data copied from a MSExcel spreadsheet.</summary>                        </method>                        <method name="paste" access="private">                                <summary>Pasts data from the clipboard into the grid if it contains tabular data. Also pasts data from MSExcel as Excel places data to the clipboard in the form of tabular data as well.</summary>                        </method>                        <method name="getPendingSortColumn" access="public">                                <summary>Retrieves the pending sort column number.</summary>                                <returns type="int">Pending sort column number of the Grid.</returns>                                                        </method>                        <method name="loadNextDataPage" access="public">                                <summary>Loads the next page of data from the database.</summary>                                <remarks>This method requests the data from a getHandler which is a server-side script designed to deliver the requested data.</remarks>                                                                <include path="//*[@id=\'pagingexample\']" type="example" />                        </method>                        <method name="loadPreviousDataPage" access="public">                                <summary>Loads the previous page of data from the database.</summary>                                <remarks>This method requests the data from a getHandler which is a server-side script designed to deliver the requested data.</remarks>                                                                <include path="//*[@id=\'pagingexample\']" type="example" />                        </method>                        <method name="loadDataPage" access="public">                                <summary>Loads the specified page of data from the database.</summary>                                <param name="nStart" type="int">Recordnumber of record which should be display on top of the page.</param>                                                                <include path="//*[@id=\'pagingexample\']" type="example" />                        </method>                        <method name="makeXSL" access="private">                                <summary>Makes the main XSL</summary>                                <remarks>The makeXSL() method is normally called automatically when the grid is first instantiated.</remarks>                        </method>                </methods>		<properties>			<property name="ID" htmltag="id" type="string" access="public" persist="js" readwrite="read"></property>			<property name="Selection" type="EBASelection" access="public" persist="js" readwrite="read" default="null"></property>			<property name="Bound" type="bool" access="public" persist="js" readwrite="readwrite" default="false"></property>			<property name="RegisteredTo" htmltag="registeredto" type="string" access="public" persist="js" default="true"				readwrite="read" testvalue="test"></property>			<property name="LicenseKey" htmltag="licensekey" type="string" access="public" persist="js" default="true"				readwrite="read" testvalue="test"></property>			<property name="ToolbarContainerEmpty" type="bool" access="private" persist="xml" default="false"				readwrite="readwrite" testvalue="test">			</property>			<property name="Columns" htmltag="columns" namespace="Eba.Grid" type="Column" access="public" persist="js" default="true"				readwrite="read" testvalue="test"></property>			<property name="ColumnsDefined" htmltag="columnsdefined" type="bool" access="public" persist="js" default="false"				readwrite="readwrite" testvalue="true"></property>			<property name="Declaration" htmltag="declaration" type="xml" access="private" persist="js" default="&quot;&quot;"				readwrite="readwrite" testvalue="&quot;&quot;"></property>			<property name="Datasource" htmltag="datasource" namespace="Eba.Data" type="DatasourceManager" access="public" persist="js" default="true"				readwrite="read" testvalue="test"></property>			<property name="DatasourceId" htmltag="datasourceid" type="string" access="public" persist="xml" default=""				readwrite="read" testvalue="testds"></property>			<property name="CurrentPageIndex" htmltag="currentpageindex" type="int" access="public" persist="xml" default="0"				readwrite="read" testvalue="0"></property>			<property name="ColumnIndicatorsEnabled" htmltag="columnindicatorsenabled" type="bool" access="public" persist="xml" default="true"				readwrite="readwrite" testvalue="false"></property>			<property name="RowIndicatorsEnabled" type="bool" access="private" persist="xml" default="false"				readwrite="readwrite" testvalue="false">			</property>			<property name="ToolbarEnabled" htmltag="toolbarenabled" type="bool" access="public" persist="xml" default="true" readwrite="readwrite"				testvalue="false"></property>			<property name="RowHighlightEnabled" htmltag="rowhighlightenabled" type="bool" access="public" persist="xml" default="false" readwrite="readwrite"				testvalue="false"></property>			<property name="RowSelectEnabled" htmltag="rowselectenabled" type="bool" access="public" persist="xml" default="false" readwrite="readwrite"				testvalue="false" >			</property>			<property name="GridResizeEnabled" htmltag="gridresizeenabled" type="bool" access="public" persist="xml" default="false" readwrite="readwrite"				testvalue="false"></property>			<property name="SingleClickEditEnabled" htmltag="singleclickeditenabled" type="bool" access="public" persist="xml" default="false" readwrite="readwrite"				testvalue="false"></property>			<property name="AutoKeyEnabled" htmltag="autokeyenabled" type="bool" access="public" persist="xml" default="false" readwrite="readwrite"				testvalue="false">			</property>			<property name="ToolTipsEnabled" type="bool" access="private" persist="xml" default="true" readwrite="readwrite"				testvalue="false">			</property>			<property name="EnterTab" type="string" access="public" persist="xml" default="down" readwrite="readwrite"				htmltag="entertab" testvalue="up">			</property>			<property name="HScrollbarEnabled" type="bool" access="private" persist="xml" default="true" readwrite="readwrite"				testvalue="false">			</property>			<property name="VScrollbarEnabled" type="bool" access="private" persist="xml" default="true" readwrite="readwrite"				testvalue="false">			</property>			<property name="RowHeight" type="int" access="private" persist="xml" default="23" readwrite="read"				htmltag="rowheight" testvalue="50">			</property>			<property name="HeaderHeight" type="int" persist="xml" access="private" default="23" readwrite="readwrite"				htmltag="headerheight" testvalue="50">			</property>			<property name="cellWidth" type="int" persist="xml" access="private" default="100" readwrite="read"				testvalue="200">			</property>			<property name="top" default="0" type="int" persist="xml" access="private" readwrite="readwrite"				impact="css xsl row" testvalue="200">			</property>			<property name="bottom" default="0" type="int" persist="xml" access="private" readwrite="readwrite"				impact="css xsl row" testvalue="200">			</property>			<property name="left" default="0" type="int" persist="xml" access="private" readwrite="readwrite"				impace="css xsl row" testvalue="200">			</property> 			<property name="right" default="0" type="int" persist="xml" access="private" readwrite="readwrite"				impact="css xsl row" testvalue="200">			</property>			<property name="indicatorWidth" default="0" type="int" persist="xml" access="private" readwrite="readwrite"				testvalue="50">			</property>			<property name="scrollbarWidth" type="int" persist="xml" access="private" readwrite="readwrite"				testvalue="22" default="22">			</property>			<property name="scrollbarHeight" type="int" persist="xml" access="private" readwrite="readwrite"				testvalue="22" default="22">			</property>			<property name="freezetop" default="0" type="int" persist="xml" access="private" readwrite="readwrite"				impact="size css xsl row" testvalue="2">			</property>			<property name="freezebottom" default="0" type="int" persist="xml" access="private" readwrite="readwrite"				testvalue="2">			</property>			<property name="FrozenLeftColumnCount" htmltag="frozenleftcolumncount" default="0" type="int" persist="xml" access="public" readwrite=""				testvalue="2">							</property>			<property name="freezeright" default="0" type="int" persist="xml" access="private" readwrite="readwrite"				testvalue="2">							</property>			<property name="active" type="string" access="private" default="&quot;&quot;">			</property>			<property name="activeCell" type="nitobi.grid.Cell" access="private" default="null" readwrite="readwrite">			</property>			<property name="activeRow" type="object" access="private" persist="xml" default="null">							</property>			<property name="RowInsertEnabled" type="bool" access="public" persist="xml" default="true" htmltag="rowinsertenabled"				readwrite="readwrite">							</property>			<property name="RowDeleteEnabled" type="bool" persist="xml" access="public" default="true" htmltag="rowdeleteenabled" readwrite="readwrite">							</property>			<property name="Asynchronous" type="bool" access="private" persist="xml" default="true" readwrite="readwrite"				htmltag="asynchronous" testvalue="false">							</property>			<property name="AutoAdd" type="bool" access="private" default="false" htmltag="autoadd">							</property>			<property name="AutoSaveEnabled" type="bool" access="public" persist="xml" default="false" readwrite="readwrite"				htmltag="autosaveenabled" testvalue="true">							</property>			<property name="contentHeight" default="1000" type="int" persist="xml" access="private" readwrite="readwrite"				testvalue="2000">							</property>			<property name="contentWidth" default="1000" type="int" persist="xml" access="private" readwrite="readwrite"				testvalue="2000">							</property>			<property name="ColumnCount" type="int" access="public" persist="xml" default="0" readwrite="read"				 testvalue="20">							</property>			<property name="RowsPerPage" type="int" access="public" persist="xml" default="20" readwrite="readwrite"				htmltag="rowsperpage" testvalue="20">								<include path="//*[@id=\'pagingexample\']" type="example" />			</property>			<property name="element" code="" type="Span" persist="dom" access="private" readwrite="read">							</property>			<property name="entertab" type="string" access="private" persist="xml" default="&quot;RT&quot;"				htmltag="entertab">			</property>			<property name="forceValidate" type="bool" access="private" persist="xml" default="false"				readwrite="readwrite">			</property>			<property name="gridColor" type="string" access="private" persist="xml" default="&quot;#F0F0F0&quot;"				htmltag="gridColor">			</property>			<property name="Height" code="" persist="xml" type="int" access="public" default="100" readwrite="read"				htmltag="height" testvalue="200">							</property>			<property name="hwrap" type="bool" access="private" persist="xml" default="true" htmltag="hwrap">			</property>			<property name="keymode" type="string" access="private" default="&quot;&quot;" htmltag="keymode">			</property>			<property name="KeyGenerator" type="string" access="public" default="&quot;&quot;"				readwrite="readwrite" htmltag="keygenerator" persist="js">				<include path="//*[@id=\'keygeneration\']" type="example" />							</property>			<property name="LastError" type="string" access="public" default="&quot;&quot;" readwrite="read"				persist="xml" testvalue="&quot;testError&quot;">							</property>			<property name="lastSaveHandlerResponse" type="string" access="private" default="&quot;&quot;">							</property>			<property name="MultiRowSelectEnabled" type="bool" access="public" persist="xml" default="false" readwrite="readwrite"				testvalue="false" htmltag="multirowselectenabled">			</property>			<property name="MultiRowSelectField" type="string" access="public" persist="xml" default="" readwrite="readwrite"			 	testvalue="" htmltag="multirowselectfield">			</property>			<property name="MultiRowSelectAttr" type="string" access="private" persist="xml" default="" readwrite="readwrite"			 	>			</property>			<property name="scrolling" type="bool" access="private" default="false">			</property>			<property name="GetHandler" type="string" access="public" persist="xml" default="&quot;&quot;" htmltag="gethandler">								<include path="//*[@id=\'saveget\']" type="example" />			</property>			<property name="SaveHandler" type="string" access="public" persist="xml" default="&quot;&quot;" htmltag="savehandler">								<include path="//*[@id=\'saveget\']" type="example" />			</property>			<property name="scrollX" type="string" access="private" persist="xml" code="" readwrite="readwrite"				htmltag="scrollX" testvalue="&quot;scroll&quot;">							</property>			<property name="scrollY" type="string" access="private" persist="xml" default="&quot;auto&quot;"				readwrite="readwrite" htmltag="scrollY" testvalue="&quot;visible&quot;">							</property>			<property name="showErrors" type="bool" access="private" default="false" readwrite="readwrite"				htmltag="showErrors">							</property>			<property name="uniqueID" default="&quot;&quot;" code="" type="object" access="public" readwrite="read">							</property>			<property name="Version" default="3.01" code="" type="string" persist="js" access="public"				readwrite="read" htmltag="version">							</property>			<property name="vwrap" type="bool" access="private" persist="xml" default="true" htmltag="vwrap">			</property>			<property name="Width" type="int" access="public" persist="xml" readwrite="read" htmltag="width"				testvalue="1000">							</property>			<property name="PagingMode" type="string" access="public" persist="xml" readwrite="read" htmltag="pagingmode" default="&quot;LiveScrolling&quot;">							</property>			<property name="DataMode" type="string" access="public" persist="xml" readwrite="read" htmltag="datamode" default="&quot;Caching&quot;">							</property>			<property name="RenderMode" type="string" access="public" persist="xml" readwrite="read" htmltag="rendermode" default="&quot;&quot;">							</property>			<property name="LiveScrollingMode" type="string" access="public" persist="xml" readwrite="read" htmltag="livescrollingmode" default="&quot;Leap&quot;">			</property>			<property name="CopyEnabled" type="bool" access="public" persist="xml" readwrite="readwrite" htmltag="copyenabled" default="true">			</property>			<property name="PasteEnabled" type="bool" access="public" persist="xml" readwrite="readwrite" htmltag="pasteenabled" default="true">			</property>			<property name="SortEnabled" model="SortEnabled" type="string" access="public"				default="true" htmltag="sortenabled" readwrite="readwrite" persist="xml" impact="sort"				testvalue="true"></property>			<property name="SortMode" model="SortMode" type="string" access="public"				default="default" htmltag="sortmode" readwrite="readwrite" persist="xml" impact="sort"				testvalue="default"></property>		</properties>		<events>			<event name="OnCellClickEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="oncellclickevent" persist="event"></event>			<event name="OnCellDblClickEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="oncelldblclickevent" persist="event"></event>			<event name="OnDataReadyEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="ondatareadyevent" persist="event"></event>			<event name="OnHtmlReadyEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onhtmlreadyevent" persist="event"></event>			<event name="OnDataRenderedEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="ondatarenderevent" persist="event"></event>			<event name="OnCellDoubleClickEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="oncelldoubleclickevent"				persist="event">							</event>			<event name="OnBeforePagingEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onbeforepagingevent"				persist="event">			</event>			<event name="OnAfterPagingEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onafterpagingevent"				persist="event">			</event>			<event name="OnAfterLoadDataPageEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onafterloaddatapageevent"				persist="event">			</event>			<event name="OnBeforeCellEditEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onbeforecelleditevent"				persist="event">							</event>			<event name="OnAfterCellEditEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onaftercelleditevent"				persist="event">							</event>			<event name="OnBeforeRowInsertEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onbeforerowinsertevent"				persist="event">							</event>			<event name="OnAfterRowInsertEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onafterrowinsertevent"				persist="event">							</event>			<event name="OnBeforeSortEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onbeforesortevent"				persist="event">			</event>			<event name="OnAfterSortEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onaftersortevent"				persist="event">			</event>			<event name="OnBeforeRefreshEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onbeforerefreshevent"				persist="event">			</event>			<event name="OnAfterRefreshEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onafterrefreshevent"				persist="event">			</event>						<event name="OnBeforeSaveEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onbeforesaveevent"				persist="event">							</event>			<event name="OnAfterSaveEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onaftersaveevent"				persist="event">							</event>			<event name="OnHandlerErrorEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onhandlererrorevent"				persist="event">							</event>						<event name="OnRowBlurEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onrowblurevent"				persist="event">							</event>			<event name="OnCellFocusEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="oncellfocusevent"				persist="event">							</event>			<event name="OnAfterRowDeleteEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onafterrowdeleteevent"				persist="event">							</event>			<event name="OnBeforeRowDeleteEvent" type="string" access="public" default="&quot;true&quot;" readwrite="readwrite" htmltag="onbeforerowdeleteevent"				persist="event">							</event>			<event name="OnCellUpdateEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="oncellupdateevent"				persist="event">			</event>			<event name="OnRowFocusEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onrowfocusevent"				persist="event">							</event>			<event name="OnBeforeCopyEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onbeforecopyevent"				persist="event">							</event>			<event name="OnAfterCopyEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onaftercopyevent"				persist="event">							</event>			<event name="OnBeforePasteEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onbeforepasteevent"				persist="event">							</event>			<event name="OnAfterPasteEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onafterpasteevent"				persist="event">							</event>			<event name="OnErrorEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onerrorevent"				persist="event">							</event>			<event name="OnContextMenuEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="oncontextmenuevent"				persist="event">			</event>			<event name="OnFocusEvent" type="string" access="public" default="&quot;&quot;" readwrite="readwrite" htmltag="onfocusvent"				persist="event">							</event>			<event name="OnCellValidateEvent" type="string" access="private" default="&quot;&quot;"				readwrite="readwrite" persist="event" htmltag="oncellvalidateevent">				<include path="//*[@id=\'datavalidation\']" type="example" />							</event>		</events>	</interface></interfaces>';
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.apiDoc = nitobi.xml.createXmlDoc(temp_ntb_apiDoc);

var temp_ntb_modelDoc='<state	 xmlns:ntb="http://www.nitobi.com"	ID="mySheet"	Version="3.01" 	element="grid" 		uniqueID="_hkj342">    <nitobi.grid.Grid		Height="300"		Width="700"		skin="default"		cellWidth="100"			RowHeight="23"					indicatorHeight="23"		HeaderHeight="23"		indicatorWidth="30"		scrollX="0"		scrollY="0"		scrollbarWidth="26"		scrollbarHeight="26"		toolbarHeight="22"				top="23"		bottom="23"		left="100"		right="100"				minHeight="60"		minWidth="250"		PrimaryDatasourceSize="0" 		contentHeight="1000"		contentWidth="1500"				containerHeight=""		containerWidth=""		columnsdefined="0"		renderframe="0"		renderindicators="0"		renderheader="0"		renderfooter="0"		renderleft="0"		renderright="0"		rendercenter="0"		active="1"		selected="1"		activeRow=""		activeCell=""		activeView=""		activeBlock=""		highlightCell=""		scrolling="0"		prevCell=""		prevText=""		prevData=""		FrozenLeftColumnCount="0"		DatasourceSizeEstimate="0"    	DatasourceId=""  		freezeright="0"		freezetop="0"		freezebottom="0"		ToolbarEnabled="1"			GridResizeEnabled="0"		RowHighlightEnabled="0"		RowSelectEnabled="0"		MultiRowSelectEnabled="0"		AutoKeyEnabled="0"			ToolbarContainerEmpty="false"			ToolTipsEnabled="1"		RowIndicatorsEnabled="0"		ColumnIndicatorsEnabled="1"		HScrollbarEnabled="1"		VScrollbarEnabled="1"		rowselect="0"		AutoSaveEnabled="0"		autoAdd="0"		remoteSort="0"		forceValidate="0"		showErrors="0"		columnGraying="0"		hwrap="0"		vwrap="0"		keymode=""				entertab="RT"		keyboardPaging="0"		RowInsertEnabled="1"		RowDeleteEnabled="1"		allowEdit="1"		allowFormula="1"		PasteEnabled="1"		CopyEnabled="1"				expandRowsOnPaste="1"		expandColumnsOnPast="1"		datalog="myXMLLog"		xselect="//root"		xorder="@a"		asynchronous="1"		fieldMap=""    	GetHandler="" 		getHandler=""		SaveHandler=""		lastSaveHandlerResponse=""		sortColumn="0"		curSortColumn="0"		descending="0"		curSortColumnDesc="0"		RowCount="0"		ColumnCount="0"		nextXK="32"		CurrentPageIndex="0"		PagingMode="standard"		DataMode="caching"		RenderMode=""    	LiveScrollingMode="Leap"		RowsPerPage="20"		pageStart="0"		normalColor="#FFFFFF"		normalColor2="#FFFFFF"		activeColor="#FFFFFF"		selectionColor="#FFFFFF"		highlightColor="#FFFFFF"		columnGrayingColor="#FFFFFF"		gridColor="#FFFFFF"		LastError=""		SortEnabled="1"    	SortMode="default"    	EnterTab="down"	>    </nitobi.grid.Grid>    <nitobi.grid.Columns>    </nitobi.grid.Columns>    <Defaults>    	<nitobi.grid.Grid></nitobi.grid.Grid>		<nitobi.grid.Column 			Width="100"			type="TEXT"			Visible="1"			SortEnabled="1"			/>		<nitobi.grid.Row></nitobi.grid.Row>		<nitobi.grid.Cell></nitobi.grid.Cell>		<ntb:e />    </Defaults>    	<declaration>	</declaration>	<columnDefinitions>	</columnDefinitions></state>';
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.modelDoc = nitobi.xml.createXmlDoc(temp_ntb_modelDoc);

var temp_ntb_toolbarDoc='<?xml version="1.0" encoding="utf-8"?><toolbar id="toolbarthis.uid" title="Grid" height="23" width="110" image_directory="http://localhost/vss/EBALib/v13/Common/Toolbar/Styles/default">	<items>		<button id="save" onclick_event="this.onClick()" height="14" width="14" image="save.gif"			image_disabled="save_disabled.gif" tooltip_text="Save Changes" />		<!-- <button id="discardChanges" onclick_event="testclick(this);" height="17" width="16" top_offset="-2"			image="cancelsave.gif" image_disabled="cancelsave_disabled.gif" tooltip_text="Discard Changes" /> -->		<separator id="toolbar1_separator1" height="20" width="5" image="separator.jpg" />		<button id="newRecord" onclick_event="this.onClick()" height="11" width="14" image="newrecord.gif"			image_disabled="newrecord_disabled.gif" tooltip_text="New Record" />		<button id="deleteRecord" onclick_event="this.onClick()" height="11" width="14" image="deleterecord.gif"			image_disabled="deleterecord_disabled.gif" tooltip_text="Delete Record" />		<separator id="toolbar1_separator2" height="20" width="5" image="separator.jpg" />		<button id="refresh" onclick_event="this.onClick()" height="14" width="16" image="refresh.gif"			image_disabled="refresh_disabled.gif" tooltip_text="Refresh" />		<!--<separator id="toolbar1_separator3" height="20" width="5" image="separator.jpg" />		<button id="toolbar1_button4" onclick_event="testclick(this);" height="11" width="10" image="left.gif"			image_disabled="left_disabled.gif" tooltip_text="Previous Page" />		<button id="toolbar1_button5" onclick_event="testclick(this);" height="11" width="10" image="right.gif"			image_disabled="right_disabled.gif" tooltip_text="Next Page" />		-->	</items></toolbar>';
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.toolbarDoc = nitobi.xml.createXmlDoc(temp_ntb_toolbarDoc);

var temp_ntb_pagingToolbarDoc='<?xml version="1.0" encoding="utf-8"?><toolbar id="toolbarpagingthis.uid" title="Paging" height="23" width="60" image_directory="http://localhost/vss/EBALib/v13/Common/Toolbar/Styles/default">	<items>		<button id="previousPage" onclick_event="this.onClick()" height="14" width="14" image="left.gif"			image_disabled="left_disabled.gif" tooltip_text="Previous Page" />		<button id="nextPage" onclick_event="this.onClick()" height="14" width="16" image="right.gif"			image_disabled="right_disabled.gif" tooltip_text="Next Page" />	</items></toolbar>';
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.pagingToolbarDoc = nitobi.xml.createXmlDoc(temp_ntb_pagingToolbarDoc);


var temp_ntb_accessorGeneratorXslProc='<?xml version="1.0"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> <xsl:output method="text" encoding="utf-8" omit-xml-declaration="yes"/> <x:t- match="interface"> <x:ct-x:n-initJSDefaults"/> <x:at-/> </x:t-> <x:t-x:n-initJSDefaults"> </x:t-> <x:t- match="interface/properties"> <x:va-x:n-object"><x:v-x:s-ancestor::interface/@name" /></x:va-> <xsl:for-eachx:s-property"> <x:ct-x:n-generate-accessors"> <x:w-x:n-object"x:s-$object"></x:w-> </x:ct-> </xsl:for-each> </x:t-> <x:t- match="interface/methods"> <xsl:for-eachx:s-method"> <xsl:if test="@code"> this.<x:v-x:s-@name"/>= function(<xsl:for-eachx:s-parameters/parameter"><x:v-x:s-@name" /><xsl:if test="not(last())">,</xsl:if></xsl:for-each>) {<x:v-x:s-@code"/>}; </xsl:if> </xsl:for-each> </x:t-> <x:t- match="interface/events"> <x:va-x:n-object"><x:v-x:s-ancestor::interface/@name" /></x:va-> <xsl:for-eachx:s-event"> <x:ct-x:n-generate-accessors"> <x:w-x:n-object"x:s-$object"></x:w-> </x:ct-> </xsl:for-each> </x:t-> <x:t-x:n-generate-accessors"> <x:p-x:n-object"></x:p-> <x:va-x:n-name"> <xsl:if test="@xml"><x:v-x:s-$object"/>/<x:v-x:s-@xml" /></xsl:if> <xsl:if test="not(@xml)"><x:v-x:s-$object"/>/@<x:v-x:s-@name" /></xsl:if> </x:va-> <xsl:if test="\'a\'=\'a\'"> this.set<x:v-x:s-@name"/> = function() { <x:v-x:s-@precode"/> <xsl:if test="contains(@persist,\'event\')">this.eSET("<x:v-x:s-@name"/>",arguments);</xsl:if> <xsl:if test="contains(@persist,\'js\')">this.jSET("<x:v-x:s-@name"/>",arguments);</xsl:if> <xsl:if test="contains(@persist,\'xml\')">this.xSET("<x:v-x:s-$name"/>",arguments);</xsl:if> <xsl:if test="contains(@persist,\'data\')">this.SETDATA("<x:v-x:s-$name"/>",arguments);</xsl:if> <!-- <xsl:if test="contains(@persist,\'meta\')">this.xSETMETA("<x:v-x:s-@short"/>",arguments);</xsl:if> --> <xsl:if test="contains(@persist,\'model\')">this.xSETMODEL("<x:v-x:s-@model"/>",arguments);</xsl:if> <xsl:if test="contains(@persist,\'css\')">this.xSETCSS("<x:v-x:s-@htmltag"/>",arguments);</xsl:if> <xsl:if test="contains(@persist,\'dom\')">this.SETDOM("<x:v-x:s-@name"/>",arguments);</xsl:if> <xsl:if test="contains(@persist,\'tag\')">this.SETTAG("<x:v-x:s-@name"/>",arguments);</xsl:if> <x:v-x:s-@code"/> if (EBAAutoRender) { <xsl:if test="not($object=\'nitobi.grid.Grid\')"> <xsl:if test="contains(@impact,\'config\')">this.grid.initializeModelFromDeclaration();</xsl:if> <xsl:if test="contains(@impact,\'bind\')">this.grid.bind();</xsl:if> <xsl:if test="contains(@impact,\'css\')">this.grid.generateCss();</xsl:if> <xsl:if test="contains(@impact,\'frame\')">this.grid.renderFrame();</xsl:if> <xsl:if test="contains(@impact,\'align\')">this.grid.Scroller.alignSurfaces();</xsl:if> <xsl:if test="contains(@impact,\'size\')">this.grid.resize();</xsl:if> <xsl:if test="contains(@impact,\'xsl\')">this.grid.makeXSL();</xsl:if> <xsl:if test="contains(@impact,\'row\')">this.grid.refilter();</xsl:if> </xsl:if> <xsl:if test="$object=\'nitobi.grid.Grid\'"> <xsl:if test="contains(@impact,\'config\')">this.initializeModelFromDeclaration();</xsl:if> <xsl:if test="contains(@impact,\'bind\')">this.bind();</xsl:if> <xsl:if test="contains(@impact,\'css\')">this.generateCss();</xsl:if> <xsl:if test="contains(@impact,\'frame\')">this.renderFrame();</xsl:if> <xsl:if test="contains(@impact,\'xsl\')">this.makeXSL();</xsl:if> <xsl:if test="contains(@impact,\'row\')">this.refilter();</xsl:if> </xsl:if> }; }; </xsl:if> <x:va-x:n-accessor-prefix"> <x:c-> <x:wh- test="@type=\'bool\'"> <x:v-x:s-\'is\'"/> </x:wh-> <x:o-> <x:v-x:s-\'get\'"/> </x:o-> </x:c-> </x:va-> <xsl:if test="contains(@persist,\'js\') or contains(@persist,\'event\')">this.<x:v-x:s-$accessor-prefix"/><x:v-x:s-@name"/> = function() {return this.<x:v-x:s-@name"/>;};</xsl:if> <xsl:if test="contains(@persist,\'xml\')">this.<x:v-x:s-$accessor-prefix"/><x:v-x:s-@name"/> = function() {return <x:ct-x:n-cast-type"><x:w-x:n-type"x:s-@type"/><x:w-x:n-expression">this.xGET("<x:v-x:s-$name"/>",arguments)</x:w-><x:w-x:n-default"x:s-@default" /></x:ct->;};</xsl:if> <xsl:if test="contains(@persist,\'data\')">this.<x:v-x:s-$accessor-prefix"/><x:v-x:s-@name"/> = function() {return <x:ct-x:n-cast-type"><x:w-x:n-type"x:s-@type"/><x:w-x:n-expression">this.GETDATA("<x:v-x:s-$name"/>",arguments)</x:w-><x:w-x:n-default"x:s-@default" /></x:ct->;};</xsl:if> <xsl:if test="contains(@persist,\'meta\')">this.<x:v-x:s-$accessor-prefix"/><x:v-x:s-@name"/> = function() {return <x:ct-x:n-cast-type"><x:w-x:n-type"x:s-@type"/><x:w-x:n-expression">this.xGETMETA("<x:v-x:s-@short"/>",arguments)</x:w-><x:w-x:n-default"x:s-@default" /></x:ct->;};</xsl:if> <xsl:if test="contains(@persist,\'model\')">this.<x:v-x:s-$accessor-prefix"/><x:v-x:s-@name"/> = function() {return <x:ct-x:n-cast-type"><x:w-x:n-type"x:s-@type"/><x:w-x:n-expression">this.xGETMODEL("<x:v-x:s-@model"/>",arguments)</x:w-><x:w-x:n-default"x:s-@default" /></x:ct->;};</xsl:if> <xsl:if test="contains(@persist,\'dom\')">this.<x:v-x:s-$accessor-prefix"/><x:v-x:s-@name"/> = function() {return this.dGET("<x:v-x:s-@name"/>",arguments);};</xsl:if> <xsl:if test="contains(@persist,\'tag\')">this.<x:v-x:s-$accessor-prefix"/><x:v-x:s-@name"/> = function() {return this.GETTAG("<x:v-x:s-@name"/>",arguments);};</xsl:if> </x:t-> <x:t-x:n-cast-type"> <x:p-x:n-type"/> <x:p-x:n-expression"/> <x:p-x:n-default"x:s-\'true\'"/> <x:c-> <x:wh- test="$type=\'int\'">Number(<x:v-x:s-$expression"/>)</x:wh-> <x:wh- test="$type=\'bool\'">nitobi.lang.toBool(<x:v-x:s-$expression"/>, <x:v-x:s-$default"/>)</x:wh-> <x:o-><x:v-x:s-$expression"/></x:o-> </x:c-> </x:t-> <x:t- match="text()"/></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.accessorGeneratorXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_accessorGeneratorXslProc));

var temp_ntb_addXidXslProc='<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com"> <x:p-x:n-startXid"x:s-100" ></x:p-> <x:t- match="@* | node()" > <xsl:copy> <x:at-x:s-@*|node()" /> </xsl:copy> </x:t-> <x:t- match="//ntb:e"> <xsl:copy> <xsl:copy-ofx:s-@*" /> <x:a-x:n-xid"><x:v-x:s-position() + number($startXid)" /></x:a-> </xsl:copy> </x:t-></xsl:stylesheet> ';
nitobi.lang.defineNs("nitobi.data");
nitobi.data.addXidXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_addXidXslProc));

var temp_ntb_adjustXiXslProc='<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com"> <xsl:output method="xml" omit-xml-declaration="yes" /> <x:p-x:n-startingIndex"x:s-5"></x:p-> <x:p-x:n-startingGroup"x:s-5"></x:p-> <x:p-x:n-adjustment"x:s--1"></x:p-> <x:t- match="*|@*"> <xsl:copy> <x:at-x:s-@*|node()" /> </xsl:copy> </x:t-> <!--[@id=\'_default\']--> <x:t- match="//ntb:data/ntb:e|@*"> <x:c-> <x:wh- test="number(@xi) &gt;= number($startingIndex)"> <xsl:copy> <x:at-x:s-@*|node()" /> <x:ct-x:n-increment-xi" /> </xsl:copy> </x:wh-> <x:o-> <xsl:copy> <x:at-x:s-@*|node()" /> </xsl:copy> </x:o-> </x:c-> </x:t-> <x:t-x:n-increment-xi"> <x:a-x:n-xi"> <x:v-x:s-number(@xi) + number($adjustment)" /> </x:a-> </x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.data");
nitobi.data.adjustXiXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_adjustXiXslProc));

var temp_ntb_dataTranslatorXslProc='<?xml version="1.0"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com"> <xsl:output method="xml" omit-xml-declaration="yes" /> <x:p-x:n-start"x:s-0"></x:p-> <x:p-x:n-id"x:s-\'_default\'"></x:p-> <x:p-x:n-xkField"x:s-\'a\'"></x:p-> <x:t- match="//root"> <ntb:grid xmlns:ntb="http://www.nitobi.com"> <ntb:datasources> <ntb:datasource id="{$id}"> <xsl:if test="@error"> <x:a-x:n-error"><x:v-x:s-@error" /></x:a-> </xsl:if> <ntb:datasourcestructure id="{$id}"> <x:a-x:n-FieldNames"><x:v-x:s-@fields" />|_xk</x:a-> <x:a-x:n-Keys">_xk</x:a-> </ntb:datasourcestructure> <ntb:data id="{$id}"> <xsl:for-eachx:s-//e"> <x:at-x:s-."> <x:w-x:n-xi"x:s-position()-1"></x:w-> </x:at-> </xsl:for-each> </ntb:data> </ntb:datasource> </ntb:datasources> </ntb:grid> </x:t-> <x:t- match="e"> <x:p-x:n-xi"x:s-0"></x:p-> <ntb:e> <xsl:copy-ofx:s-@*[not(name() = \'xk\')]"></xsl:copy-of> <xsl:if test="not(@xi)"><x:a-x:n-xi"><x:v-x:s-$start + $xi" /></x:a-></xsl:if> <x:a-x:n-{$xkField}"><x:v-x:s-@xk" /></x:a-> </ntb:e> </x:t-> <x:t- match="lookups"></x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.data");
nitobi.data.dataTranslatorXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_dataTranslatorXslProc));

var temp_ntb_dateFormatTemplatesXslProc='<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com" xmlns:d="http://exslt.org/dates-and-times" xmlns:n="http://www.nitobi.com/exslt/numbers" extension-element-prefixes="d n"> <!-- http://java.sun.com/j2se/1.3/docs/api/java/text/SimpleDateFormat.html --><d:ms> <d:m l="31" a="Jan">January</d:m> <d:m l="28" a="Feb">February</d:m> <d:m l="31" a="Mar">March</d:m> <d:m l="30" a="Apr">April</d:m> <d:m l="31" a="May">May</d:m> <d:m l="30" a="Jun">June</d:m> <d:m l="31" a="Jul">July</d:m> <d:m l="31" a="Aug">August</d:m> <d:m l="30" a="Sep">September</d:m> <d:m l="31" a="Oct">October</d:m> <d:m l="30" a="Nov">November</d:m> <d:m l="31" a="Dec">December</d:m></d:ms><d:ds> <d:d a="Sun">Sunday</d:d> <d:d a="Mon">Monday</d:d> <d:d a="Tue">Tuesday</d:d> <d:d a="Wed">Wednesday</d:d> <d:d a="Thu">Thursday</d:d> <d:d a="Fri">Friday</d:d> <d:d a="Sat">Saturday</d:d></d:ds><x:t-x:n-d:format-date"> <x:p-x:n-date-time" /> <x:p-x:n-mask"x:s-\'MMM d, yy\'"/> <x:va-x:n-formatted"> <x:va-x:n-date-time-length"x:s-string-length($date-time)" /> <x:va-x:n-timezone"x:s-\'\'" /> <x:va-x:n-dt"x:s-substring($date-time, 1, $date-time-length - string-length($timezone))" /> <x:va-x:n-dt-length"x:s-string-length($dt)" /> <x:c-> <x:wh- test="substring($dt, 3, 1) = \':\' and substring($dt, 6, 1) = \':\'"> <!--that means we just have a time--> <x:va-x:n-hour"x:s-substring($dt, 1, 2)" /> <x:va-x:n-min"x:s-substring($dt, 4, 2)" /> <x:va-x:n-sec"x:s-substring($dt, 7)" /> <xsl:if test="$hour &lt;= 23 and $min &lt;= 59 and $sec &lt;= 60"> <x:ct-x:n-d:_format-date"> <x:w-x:n-year"x:s-\'NaN\'" /> <x:w-x:n-month"x:s-\'NaN\'" /> <x:w-x:n-day"x:s-\'NaN\'" /> <x:w-x:n-hour"x:s-$hour" /> <x:w-x:n-minute"x:s-$min" /> <x:w-x:n-second"x:s-$sec" /> <x:w-x:n-timezone"x:s-$timezone" /> <x:w-x:n-mask"x:s-$mask" /> </x:ct-> </xsl:if> </x:wh-> <x:o-> <!--($neg * -2)--> <x:va-x:n-year"x:s-substring($dt, 1, 4) * (0 + 1)" /> <x:va-x:n-month"x:s-substring($dt, 6, 2)" /> <x:va-x:n-day"x:s-substring($dt, 9, 2)" /> <x:c-> <x:wh- test="$dt-length = 10"> <!--that means we just have a date--> <x:ct-x:n-d:_format-date"> <x:w-x:n-year"x:s-$year" /> <x:w-x:n-month"x:s-$month" /> <x:w-x:n-day"x:s-$day" /> <x:w-x:n-timezone"x:s-$timezone" /> <x:w-x:n-mask"x:s-$mask" /> </x:ct-> </x:wh-> <x:wh- test="substring($dt, 14, 1) = \':\' and substring($dt, 17, 1) = \':\'"> <!--that means we have a date + time--> <x:va-x:n-hour"x:s-substring($dt, 12, 2)" /> <x:va-x:n-min"x:s-substring($dt, 15, 2)" /> <x:va-x:n-sec"x:s-substring($dt, 18)" /> <x:ct-x:n-d:_format-date"> <x:w-x:n-year"x:s-$year" /> <x:w-x:n-month"x:s-$month" /> <x:w-x:n-day"x:s-$day" /> <x:w-x:n-hour"x:s-$hour" /> <x:w-x:n-minute"x:s-$min" /> <x:w-x:n-second"x:s-$sec" /> <x:w-x:n-timezone"x:s-$timezone" /> <x:w-x:n-mask"x:s-$mask" /> </x:ct-> </x:wh-> </x:c-> </x:o-> </x:c-> </x:va-> <x:v-x:s-$formatted" /> </x:t-><x:t-x:n-d:_format-date"> <x:p-x:n-year" /> <x:p-x:n-month"x:s-1" /> <x:p-x:n-day"x:s-1" /> <x:p-x:n-hour"x:s-0" /> <x:p-x:n-minute"x:s-0" /> <x:p-x:n-second"x:s-0" /> <x:p-x:n-timezone"x:s-\'Z\'" /> <x:p-x:n-mask"x:s-\'\'" /> <x:va-x:n-char"x:s-substring($mask, 1, 1)" /> <x:c-> <x:wh- test="not($mask)" /> <!--replaced escaping with \' here/--> <x:wh- test="not(contains(\'GyMdhHmsSEDFwWakKz\', $char))"> <x:v-x:s-$char" /> <x:ct-x:n-d:_format-date"> <x:w-x:n-year"x:s-$year" /> <x:w-x:n-month"x:s-$month" /> <x:w-x:n-day"x:s-$day" /> <x:w-x:n-hour"x:s-$hour" /> <x:w-x:n-minute"x:s-$minute" /> <x:w-x:n-second"x:s-$second" /> <x:w-x:n-timezone"x:s-$timezone" /> <x:w-x:n-mask"x:s-substring($mask, 2)" /> </x:ct-> </x:wh-> <x:o-> <x:va-x:n-next-different-char"x:s-substring(translate($mask, $char, \'\'), 1, 1)" /> <x:va-x:n-mask-length"> <x:c-> <x:wh- test="$next-different-char"> <x:v-x:s-string-length(substring-before($mask, $next-different-char))" /> </x:wh-> <x:o-> <x:v-x:s-string-length($mask)" /> </x:o-> </x:c-> </x:va-> <x:c-> <!--took our the era designator--> <x:wh- test="$char = \'M\'"> <x:c-> <x:wh- test="$mask-length >= 3"> <x:va-x:n-month-node"x:s-document(\'\')/*/d:ms/d:m[number($month)]" /> <x:c-> <x:wh- test="$mask-length >= 4"> <x:v-x:s-$month-node" /> </x:wh-> <x:o-> <x:v-x:s-$month-node/@a" /> </x:o-> </x:c-> </x:wh-> <x:wh- test="$mask-length = 2"> <x:v-x:s-format-number($month, \'00\')" /> </x:wh-> <x:o-> <x:v-x:s-$month" /> </x:o-> </x:c-> </x:wh-> <x:wh- test="$char = \'E\'"> <x:va-x:n-month-days"x:s-sum(document(\'\')/*/d:ms/d:m[position() &lt; $month]/@l)" /> <x:va-x:n-days"x:s-$month-days + $day + boolean(((not($year mod 4) and $year mod 100) or not($year mod 400)) and $month &gt; 2)" /> <x:va-x:n-y-1"x:s-$year - 1" /> <x:va-x:n-dow"x:s-(($y-1 + floor($y-1 div 4) - floor($y-1 div 100) + floor($y-1 div 400) + $days) mod 7) + 1" /> <x:va-x:n-day-node"x:s-document(\'\')/*/d:ds/d:d[number($dow)]" /> <x:c-> <x:wh- test="$mask-length >= 4"> <x:v-x:s-$day-node" /> </x:wh-> <x:o-> <x:v-x:s-$day-node/@a" /> </x:o-> </x:c-> </x:wh-> <x:wh- test="$char = \'a\'"> <x:c-> <x:wh- test="$hour >= 12">PM</x:wh-> <x:o->AM</x:o-> </x:c-> </x:wh-> <x:wh- test="$char = \'z\'"> <x:c-> <x:wh- test="$timezone = \'Z\'">UTC</x:wh-> <x:o->UTC<x:v-x:s-$timezone" /></x:o-> </x:c-> </x:wh-> <x:o-> <x:va-x:n-padding"x:s-\'00\'" /> <!--removed padding--> <x:c-> <x:wh- test="$char = \'y\'"> <x:c-> <x:wh- test="$mask-length &gt; 2"><x:v-x:s-format-number($year, $padding)" /></x:wh-> <x:o-><x:v-x:s-format-number(substring($year, string-length($year) - 1), $padding)" /></x:o-> </x:c-> </x:wh-> <x:wh- test="$char = \'d\'"> <x:v-x:s-format-number($day, $padding)" /> </x:wh-> <x:wh- test="$char = \'h\'"> <x:va-x:n-h"x:s-$hour mod 12" /> <x:c-> <x:wh- test="$h"><x:v-x:s-format-number($h, $padding)" /></x:wh-> <x:o-><x:v-x:s-format-number(12, $padding)" /></x:o-> </x:c-> </x:wh-> <x:wh- test="$char = \'H\'"> <x:v-x:s-format-number($hour, $padding)" /> </x:wh-> <x:wh- test="$char = \'k\'"> <x:c-> <x:wh- test="$hour"><x:v-x:s-format-number($hour, $padding)" /></x:wh-> <x:o-><x:v-x:s-format-number(24, $padding)" /></x:o-> </x:c-> </x:wh-> <x:wh- test="$char = \'K\'"> <x:v-x:s-format-number($hour mod 12, $padding)" /> </x:wh-> <x:wh- test="$char = \'m\'"> <x:v-x:s-format-number($minute, $padding)" /> </x:wh-> <x:wh- test="$char = \'s\'"> <x:v-x:s-format-number($second, $padding)" /> </x:wh-> <x:wh- test="$char = \'S\'"> <x:v-x:s-format-number(substring-after($second, \'.\'), $padding)" /> </x:wh-> <x:wh- test="$char = \'F\'"> <x:v-x:s-floor($day div 7) + 1" /> </x:wh-> <x:o-> <x:va-x:n-month-days"x:s-sum(document(\'\')/*/d:ms/d:m[position() &lt; $month]/@l)" /> <x:va-x:n-days"x:s-$month-days + $day + boolean(((not($year mod 4) and $year mod 100) or not($year mod 400)) and $month &gt; 2)" /> <x:v-x:s-format-number($days, $padding)" /> <!--removed week in year--> <!--removed week in month--> </x:o-> </x:c-> </x:o-> </x:c-> <x:ct-x:n-d:_format-date"> <x:w-x:n-year"x:s-$year" /> <x:w-x:n-month"x:s-$month" /> <x:w-x:n-day"x:s-$day" /> <x:w-x:n-hour"x:s-$hour" /> <x:w-x:n-minute"x:s-$minute" /> <x:w-x:n-second"x:s-$second" /> <x:w-x:n-timezone"x:s-$timezone" /> <x:w-x:n-mask"x:s-substring($mask, $mask-length + 1)" /> </x:ct-> </x:o-> </x:c-></x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.dateFormatTemplatesXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_dateFormatTemplatesXslProc));

var temp_ntb_dateXslProc='<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com" xmlns:d="http://exslt.org/dates-and-times" extension-element-prefixes="d"> <xsl:output method="text" version="4.0" omit-xml-declaration="yes" /> <!-- http://java.sun.com/j2se/1.3/docs/api/java/text/SimpleDateFormat.html --><d:ms> <d:m l="31" a="Jan">January</d:m> <d:m l="28" a="Feb">February</d:m> <d:m l="31" a="Mar">March</d:m> <d:m l="30" a="Apr">April</d:m> <d:m l="31" a="May">May</d:m> <d:m l="30" a="Jun">June</d:m> <d:m l="31" a="Jul">July</d:m> <d:m l="31" a="Aug">August</d:m> <d:m l="30" a="Sep">September</d:m> <d:m l="31" a="Oct">October</d:m> <d:m l="30" a="Nov">November</d:m> <d:m l="31" a="Dec">December</d:m></d:ms><d:ds> <d:d a="Sun">Sunday</d:d> <d:d a="Mon">Monday</d:d> <d:d a="Tue">Tuesday</d:d> <d:d a="Wed">Wednesday</d:d> <d:d a="Thu">Thursday</d:d> <d:d a="Fri">Friday</d:d> <d:d a="Sat">Saturday</d:d></d:ds><x:t-x:n-d:format-date"> <x:p-x:n-date-time" /> <x:p-x:n-mask"x:s-\'MMM d, yy\'"/> <x:va-x:n-formatted"> <x:va-x:n-date-time-length"x:s-string-length($date-time)" /> <x:va-x:n-timezone"x:s-\'\'" /> <x:va-x:n-dt"x:s-substring($date-time, 1, $date-time-length - string-length($timezone))" /> <x:va-x:n-dt-length"x:s-string-length($dt)" /> <x:c-> <x:wh- test="substring($dt, 3, 1) = \':\' and substring($dt, 6, 1) = \':\'"> <!--that means we just have a time--> <x:va-x:n-hour"x:s-substring($dt, 1, 2)" /> <x:va-x:n-min"x:s-substring($dt, 4, 2)" /> <x:va-x:n-sec"x:s-substring($dt, 7)" /> <xsl:if test="$hour &lt;= 23 and $min &lt;= 59 and $sec &lt;= 60"> <x:ct-x:n-d:_format-date"> <x:w-x:n-year"x:s-\'NaN\'" /> <x:w-x:n-month"x:s-\'NaN\'" /> <x:w-x:n-day"x:s-\'NaN\'" /> <x:w-x:n-hour"x:s-$hour" /> <x:w-x:n-minute"x:s-$min" /> <x:w-x:n-second"x:s-$sec" /> <x:w-x:n-timezone"x:s-$timezone" /> <x:w-x:n-mask"x:s-$mask" /> </x:ct-> </xsl:if> </x:wh-> <x:o-> <!--($neg * -2)--> <x:va-x:n-year"x:s-substring($dt, 1, 4) * (0 + 1)" /> <x:va-x:n-month"x:s-substring($dt, 6, 2)" /> <x:va-x:n-day"x:s-substring($dt, 9, 2)" /> <x:c-> <x:wh- test="$dt-length = 10"> <!--that means we just have a date--> <x:ct-x:n-d:_format-date"> <x:w-x:n-year"x:s-$year" /> <x:w-x:n-month"x:s-$month" /> <x:w-x:n-day"x:s-$day" /> <x:w-x:n-timezone"x:s-$timezone" /> <x:w-x:n-mask"x:s-$mask" /> </x:ct-> </x:wh-> <x:wh- test="substring($dt, 14, 1) = \':\' and substring($dt, 17, 1) = \':\'"> <!--that means we have a date + time--> <x:va-x:n-hour"x:s-substring($dt, 12, 2)" /> <x:va-x:n-min"x:s-substring($dt, 15, 2)" /> <x:va-x:n-sec"x:s-substring($dt, 18)" /> <x:ct-x:n-d:_format-date"> <x:w-x:n-year"x:s-$year" /> <x:w-x:n-month"x:s-$month" /> <x:w-x:n-day"x:s-$day" /> <x:w-x:n-hour"x:s-$hour" /> <x:w-x:n-minute"x:s-$min" /> <x:w-x:n-second"x:s-$sec" /> <x:w-x:n-timezone"x:s-$timezone" /> <x:w-x:n-mask"x:s-$mask" /> </x:ct-> </x:wh-> </x:c-> </x:o-> </x:c-> </x:va-> <x:v-x:s-$formatted" /> </x:t-><x:t-x:n-d:_format-date"> <x:p-x:n-year" /> <x:p-x:n-month"x:s-1" /> <x:p-x:n-day"x:s-1" /> <x:p-x:n-hour"x:s-0" /> <x:p-x:n-minute"x:s-0" /> <x:p-x:n-second"x:s-0" /> <x:p-x:n-timezone"x:s-\'Z\'" /> <x:p-x:n-mask"x:s-\'\'" /> <x:va-x:n-char"x:s-substring($mask, 1, 1)" /> <x:c-> <x:wh- test="not($mask)" /> <!--replaced escaping with \' here/--> <x:wh- test="not(contains(\'GyMdhHmsSEDFwWakKz\', $char))"> <x:v-x:s-$char" /> <x:ct-x:n-d:_format-date"> <x:w-x:n-year"x:s-$year" /> <x:w-x:n-month"x:s-$month" /> <x:w-x:n-day"x:s-$day" /> <x:w-x:n-hour"x:s-$hour" /> <x:w-x:n-minute"x:s-$minute" /> <x:w-x:n-second"x:s-$second" /> <x:w-x:n-timezone"x:s-$timezone" /> <x:w-x:n-mask"x:s-substring($mask, 2)" /> </x:ct-> </x:wh-> <x:o-> <x:va-x:n-next-different-char"x:s-substring(translate($mask, $char, \'\'), 1, 1)" /> <x:va-x:n-mask-length"> <x:c-> <x:wh- test="$next-different-char"> <x:v-x:s-string-length(substring-before($mask, $next-different-char))" /> </x:wh-> <x:o-> <x:v-x:s-string-length($mask)" /> </x:o-> </x:c-> </x:va-> <x:c-> <!--took our the era designator--> <x:wh- test="$char = \'M\'"> <x:c-> <x:wh- test="$mask-length >= 3"> <x:va-x:n-month-node"x:s-document(\'\')/*/d:ms/d:m[number($month)]" /> <x:c-> <x:wh- test="$mask-length >= 4"> <x:v-x:s-$month-node" /> </x:wh-> <x:o-> <x:v-x:s-$month-node/@a" /> </x:o-> </x:c-> </x:wh-> <x:wh- test="$mask-length = 2"> <x:v-x:s-format-number($month, \'00\')" /> </x:wh-> <x:o-> <x:v-x:s-$month" /> </x:o-> </x:c-> </x:wh-> <x:wh- test="$char = \'E\'"> <x:va-x:n-month-days"x:s-sum(document(\'\')/*/d:ms/d:m[position() &lt; $month]/@l)" /> <x:va-x:n-days"x:s-$month-days + $day + boolean(((not($year mod 4) and $year mod 100) or not($year mod 400)) and $month &gt; 2)" /> <x:va-x:n-y-1"x:s-$year - 1" /> <x:va-x:n-dow"x:s-(($y-1 + floor($y-1 div 4) - floor($y-1 div 100) + floor($y-1 div 400) + $days) mod 7) + 1" /> <x:va-x:n-day-node"x:s-document(\'\')/*/d:ds/d:d[number($dow)]" /> <x:c-> <x:wh- test="$mask-length >= 4"> <x:v-x:s-$day-node" /> </x:wh-> <x:o-> <x:v-x:s-$day-node/@a" /> </x:o-> </x:c-> </x:wh-> <x:wh- test="$char = \'a\'"> <x:c-> <x:wh- test="$hour >= 12">PM</x:wh-> <x:o->AM</x:o-> </x:c-> </x:wh-> <x:wh- test="$char = \'z\'"> <x:c-> <x:wh- test="$timezone = \'Z\'">UTC</x:wh-> <x:o->UTC<x:v-x:s-$timezone" /></x:o-> </x:c-> </x:wh-> <x:o-> <x:va-x:n-padding"x:s-\'00\'" /> <!--removed padding--> <x:c-> <x:wh- test="$char = \'y\'"> <x:c-> <x:wh- test="$mask-length &gt; 2"><x:v-x:s-format-number($year, $padding)" /></x:wh-> <x:o-><x:v-x:s-format-number(substring($year, string-length($year) - 1), $padding)" /></x:o-> </x:c-> </x:wh-> <x:wh- test="$char = \'d\'"> <x:v-x:s-format-number($day, $padding)" /> </x:wh-> <x:wh- test="$char = \'h\'"> <x:va-x:n-h"x:s-$hour mod 12" /> <x:c-> <x:wh- test="$h"><x:v-x:s-format-number($h, $padding)" /></x:wh-> <x:o-><x:v-x:s-format-number(12, $padding)" /></x:o-> </x:c-> </x:wh-> <x:wh- test="$char = \'H\'"> <x:v-x:s-format-number($hour, $padding)" /> </x:wh-> <x:wh- test="$char = \'k\'"> <x:c-> <x:wh- test="$hour"><x:v-x:s-format-number($hour, $padding)" /></x:wh-> <x:o-><x:v-x:s-format-number(24, $padding)" /></x:o-> </x:c-> </x:wh-> <x:wh- test="$char = \'K\'"> <x:v-x:s-format-number($hour mod 12, $padding)" /> </x:wh-> <x:wh- test="$char = \'m\'"> <x:v-x:s-format-number($minute, $padding)" /> </x:wh-> <x:wh- test="$char = \'s\'"> <x:v-x:s-format-number($second, $padding)" /> </x:wh-> <x:wh- test="$char = \'S\'"> <x:v-x:s-format-number(substring-after($second, \'.\'), $padding)" /> </x:wh-> <x:wh- test="$char = \'F\'"> <x:v-x:s-floor($day div 7) + 1" /> </x:wh-> <x:o-> <x:va-x:n-month-days"x:s-sum(document(\'\')/*/d:ms/d:m[position() &lt; $month]/@l)" /> <x:va-x:n-days"x:s-$month-days + $day + boolean(((not($year mod 4) and $year mod 100) or not($year mod 400)) and $month &gt; 2)" /> <x:v-x:s-format-number($days, $padding)" /> <!--removed week in year--> <!--removed week in month--> </x:o-> </x:c-> </x:o-> </x:c-> <x:ct-x:n-d:_format-date"> <x:w-x:n-year"x:s-$year" /> <x:w-x:n-month"x:s-$month" /> <x:w-x:n-day"x:s-$day" /> <x:w-x:n-hour"x:s-$hour" /> <x:w-x:n-minute"x:s-$minute" /> <x:w-x:n-second"x:s-$second" /> <x:w-x:n-timezone"x:s-$timezone" /> <x:w-x:n-mask"x:s-substring($mask, $mask-length + 1)" /> </x:ct-> </x:o-> </x:c-></x:t-> <x:t- match="/"> <x:ct-x:n-d:format-date"> <x:w-x:n-date-time"x:s-//date" /> <x:w-x:n-mask"x:s-//mask" /> </x:ct-></x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.form");
nitobi.form.dateXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_dateXslProc));

var temp_ntb_declarationConverterXslProc='<?xml version="1.0" encoding="utf-8" ?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com"> <xsl:output method="xml" omit-xml-declaration="yes" /> <x:t- match="/"> <ntb:grid xmlns:ntb="http://www.nitobi.com"> <ntb:columns> <x:at-x:s-//ntb:columndefinition" mode="columndef" /> </ntb:columns> <ntb:datasources> <x:at-x:s-//ntb:columndefinition" mode="datasources" /> </ntb:datasources> </ntb:grid> </x:t-> <x:t- match="ntb:columndefinition" mode="columndef"> <x:c-> <x:wh- test="@type=\'TEXT\' or @type=\'TEXTAREA\' or @type=\'LISTBOX\' or @type=\'LOOKUP\' or @type=\'CHECKBOX\' or @type=\'LINK\' or @type=\'IMAGE\' or @type=\'\' or not(@type)"> <ntb:textcolumn> <xsl:copy-ofx:s-@*" /> <x:c-> <x:wh- test="@type=\'TEXT\'"> <ntb:texteditor><xsl:copy-ofx:s-@*" /></ntb:texteditor> </x:wh-> <x:wh- test="@type=\'TEXTAREA\'"> <ntb:textareaeditor><xsl:copy-ofx:s-@*" /></ntb:textareaeditor> </x:wh-> <x:wh- test="@type=\'LISTBOX\'"> <ntb:listboxeditor> <xsl:copy-ofx:s-@*" /> <x:a-x:n-DatasourceId">id_<x:v-x:s-position()"/></x:a-> <x:a-x:n-DisplayFields"> <x:c-> <x:wh- test="@show=\'value\'">b</x:wh-> <x:wh- test="@show=\'key\'">a</x:wh-> <x:o-></x:o-> </x:c-> </x:a-> <x:a-x:n-ValueField"> <x:c-> <x:wh- test="@show">a</x:wh-> <x:o-></x:o-> </x:c-> </x:a-> </ntb:listboxeditor> </x:wh-> <x:wh- test="@type=\'CHECKBOX\'"> <ntb:checkboxeditor> <xsl:copy-ofx:s-@*" /> <x:a-x:n-DatasourceId">id_<x:v-x:s-position()"/></x:a-> <x:a-x:n-DisplayFields"> <x:c-> <x:wh- test="@show=\'value\'">b</x:wh-> <x:wh- test="@show=\'key\'">a</x:wh-> <x:o-></x:o-> </x:c-></x:a-> <x:a-x:n-ValueField">a</x:a-> </ntb:checkboxeditor> </x:wh-> <x:wh- test="@type=\'LOOKUP\'"> <ntb:lookupeditor> <xsl:copy-ofx:s-@*" /> <x:a-x:n-DatasourceId">id_<x:v-x:s-position()"/></x:a-> <x:a-x:n-DisplayFields"> <x:c-> <x:wh- test="@show=\'key\'">a</x:wh-> <x:wh- test="@show=\'value\'">b</x:wh-> <x:o-></x:o-> </x:c-></x:a-> <x:a-x:n-ValueField"> <x:c-> <x:wh- test="@show">a</x:wh-> <x:o-></x:o-> </x:c-> </x:a-> </ntb:lookupeditor> </x:wh-> <x:wh- test="@type=\'LINK\'"> <ntb:linkeditor><xsl:copy-ofx:s-@*" /></ntb:linkeditor> </x:wh-> <x:wh- test="@type=\'IMAGE\'"> <ntb:imageeditor><xsl:copy-ofx:s-@*" /></ntb:imageeditor> </x:wh-> </x:c-> </ntb:textcolumn> </x:wh-> <x:wh- test="@type=\'NUMBER\'"> <ntb:numbercolumn><xsl:copy-ofx:s-@*" /></ntb:numbercolumn> </x:wh-> <x:wh- test="@type=\'DATE\' or @type=\'CALENDAR\'"> <ntb:datecolumn> <xsl:copy-ofx:s-@*" /> <x:c-> <x:wh- test="@type=\'DATE\'"> <ntb:dateeditor><xsl:copy-ofx:s-@*" /></ntb:dateeditor> </x:wh-> <x:wh- test="@type=\'CALENDAR\'"> <ntb:calendareditor><xsl:copy-ofx:s-@*" /></ntb:calendareditor> </x:wh-> </x:c-> </ntb:datecolumn> </x:wh-> </x:c-> </x:t-> <x:t- match="ntb:columndefinition" mode="datasources"> <xsl:if test="@values and @values!=\'\'"> <ntb:datasource> <x:a-x:n-id">id_<x:v-x:s-position()" /></x:a-> <ntb:datasourcestructure> <x:a-x:n-id">id_<x:v-x:s-position()" /></x:a-> <x:a-x:n-FieldNames">a|b</x:a-> <x:a-x:n-Keys">a</x:a-> </ntb:datasourcestructure> <ntb:data> <x:a-x:n-id">id_<x:v-x:s-position()" /></x:a-> <x:ct-x:n-values"> <x:w-x:n-valuestring"x:s-@values" /> </x:ct-> </ntb:data> </ntb:datasource> </xsl:if> </x:t-> <x:t-x:n-values"> <x:p-x:n-valuestring" /> <x:va-x:n-bstring"> <x:c-> <x:wh- test="contains($valuestring,\',\')"><x:v-x:s-substring-after(substring-before($valuestring,\',\'),\':\')" /></x:wh-> <x:o-><x:v-x:s-substring-after($valuestring,\':\')" /></x:o-> </x:c-> </x:va-> <ntb:e> <x:a-x:n-a"><x:v-x:s-substring-before($valuestring,\':\')" /></x:a-> <x:a-x:n-b"><x:v-x:s-$bstring" /></x:a-> </ntb:e> <xsl:if test="contains($valuestring,\',\')"> <x:ct-x:n-values"> <x:w-x:n-valuestring"x:s-substring-after($valuestring,\',\')" /> </x:ct-> </xsl:if> </x:t-> </xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.declarationConverterXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_declarationConverterXslProc));

var temp_ntb_frameCssXslProc='<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet version="1.0" xmlns:user="http://mycompany.com/mynamespace" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:output method="text" omit-xml-declaration="yes"/><xsl:keyx:n-style" match="//s" use="@k" /><x:t- match = "/"> <x:va-x:n-g"x:s-//state/nitobi.grid.Grid"></x:va-> <x:va-x:n-u"x:s-//state/@uniqueID"></x:va-> <x:va-x:n-frozen-columns-width"> <x:ct-x:n-get-pane-width"> <x:w-x:n-start-column"x:s-number(1)"/> <x:w-x:n-end-column"x:s-number($g/@FrozenLeftColumnCount)"/> <x:w-x:n-current-width"x:s-number(0)"/> </x:ct-> </x:va-> <x:va-x:n-unfrozen-columns-width"> <x:ct-x:n-get-pane-width"> <x:w-x:n-start-column"x:s-number($g/@FrozenLeftColumnCount)+1"/> <x:w-x:n-end-column"x:s-number($g/@ColumnCount)"/> <x:w-x:n-current-width"x:s-number(0)"/> </x:ct-> </x:va-> <x:va-x:n-total-columns-width"> <x:v-x:s-number($frozen-columns-width) + number($unfrozen-columns-width)"/> </x:va-> .grid<x:v-x:s-$u" /> {height:<x:v-x:s-$g/@Height" />px;width:<x:v-x:s-$g/@Width" />px; overflow:hidden;text-align:left; -moz-user-select: none; -khtml-user-select: none; user-select: none;} .gridviewport<x:v-x:s-$u" /> { height: <x:c-> <x:wh- test="($g/@ToolbarEnabled!=\'false\') and ($g/@ToolbarContainerEmpty=0)"> <x:v-x:s-number($g/@Height)-number($g/@scrollbarHeight)-number($g/@toolbarHeight)" />px; </x:wh-> <x:o-> <x:v-x:s-number($g/@Height)-number($g/@scrollbarHeight)" />px; </x:o-> </x:c-> width:<x:v-x:s-number($g/@Width)-number($g/@scrollbarWidth)" />px;overflow:hidden;text-align:left; } .gridsurface<x:v-x:s-$u" /> { height:<x:v-x:s-$g/@contentHeight" />px; width:<x:v-x:s-$total-columns-width"/>px; overflow:hidden; } /* This is a duplicate of gridsurface. I think there is a naming mixup. JG*/ .surface<x:v-x:s-$u" /> { height:<x:v-x:s-$g/@contentHeight" />px; width:<x:v-x:s-$total-columns-width"/>px; overflow:hidden; } /* Vertical sb is not yet done. */ .hScrollbarRange<x:v-x:s-$u" /> { width:<x:v-x:s-$total-columns-width"/>px; } .vScrollbarRange<x:v-x:s-$u" /> { height:<x:v-x:s-$g/@contentHeight" />px; } .leftpane<x:v-x:s-$u" /> { width:<x:v-x:s-$frozen-columns-width"/>px; height:<x:v-x:s-$g/@contentHeight" />px; overflow:hidden;position:relative;top:0;left:0;z-index:100; } .datapane<x:v-x:s-$u" /> { height:<x:v-x:s-$g/@contentHeight" />px; width:<x:v-x:s-$total-columns-width"/>px; /*width:<x:v-x:s-$g/@contentWidth" />;*/ overflow:hidden;position:relative;top:0;left:100;z-index:10; } .centerheader<x:v-x:s-$u" /> { width:<x:v-x:s-$unfrozen-columns-width"/>px; } .blocktable { table-layout:fixed; } .rightpane<x:v-x:s-$u" />{width:<x:v-x:s-$g/@right" />px;overflow:hidden;position:relative;top:0px;left:200px;z-index:100;display:none} .header<x:v-x:s-$u" /> {height:<x:v-x:s-$g/@HeaderHeight" />px;overflow:hidden;position:absolute;top:0px;left:0px;z-index:100;} .groups<x:v-x:s-$u" /> {height:<x:v-x:s-$g/@contentHeight" />px;} .footer<x:v-x:s-$u" /> {height:<x:v-x:s-$g/@bottom" />px;position:relative;top:0px;left:0px;z-index:20;} .rowindicator {overflow:hidden;height:<x:v-x:s-$g/@RowHeight" />px;width:<x:v-x:s-$g/@indicatorWidth" />px;-moz-box-sizing: border-box;float:left;} .columnindicator {overflow:hidden;height:<x:v-x:s-$g/@HeaderHeight" />px;-moz-box-sizing: border-box;float:left;} .columnheader {width:7500;height:<x:v-x:s-$g/@HeaderHeight" />px;display:block;-moz-box-sizing: border-box;clear:both;} .arow<x:v-x:s-$u" /> {height:<x:v-x:s-$g/@RowHeight" />px;margin:0px;-moz-box-sizing: border-box;clear:both;} .acell<x:v-x:s-$u" /> {overflow:hidden;height:<x:v-x:s-$g/@RowHeight" />px;padding-left:2px;padding-top:4px;padding-right:2px;background-position:4px 4px;background-repeat:no-repeat;-moz-box-sizing: border-box;margin:0px;} .ebamidblockcontainer<x:v-x:s-$u" /> { left:<x:v-x:s-$frozen-columns-width"/>px; } <x:at-x:s-state/nitobi.grid.Columns" />* {-moz-box-sizing: border-box;}</x:t-><x:t-x:n-get-pane-width"> <x:p-x:n-start-column"/> <x:p-x:n-end-column"/> <x:p-x:n-current-width"/> <x:c-> <x:wh- test="$start-column &lt;= $end-column"> <x:ct-x:n-get-pane-width"> <x:w-x:n-start-column"x:s-$start-column+1"/> <x:w-x:n-end-column"x:s-$end-column"/> <x:w-x:n-current-width"x:s-number($current-width) + number(//state/nitobi.grid.Columns/nitobi.grid.Column[$start-column]/@Width)"/> </x:ct-> </x:wh-> <x:o-> <x:v-x:s-$current-width"/> </x:o-> </x:c-> </x:t-><x:t- match="nitobi.grid.Columns"> <xsl:for-eachx:s-*"> <x:va-x:n-p"><x:v-x:s-position()"/></x:va-> <x:va-x:n-w"><x:v-x:s-@Width"/></x:va-> .acolumn<x:v-x:s-/state/@uniqueID" />_<xsl:number value="$p" /> {width:<x:v-x:s-$w" />px;} .acolumnheader<x:v-x:s-/state/@uniqueID" />_<xsl:number value="$p" /> {} .acolumndata<x:v-x:s-/state/@uniqueID" />_<xsl:number value="$p" /> {text-align:<x:v-x:s-@Align"/>;} </xsl:for-each></x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.frameCssXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_frameCssXslProc));

var temp_ntb_frameXslProc='<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet version="1.0" xmlns:ntb="http://www.nitobi.com" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:output method="text" omit-xml-declaration="yes"/><x:t- match = "/"><x:va-x:n-uniqueId"x:s-state/@uniqueID" /><x:va-x:n-Id"x:s-state/@ID" />&lt;div id="grid<x:v-x:s-$uniqueId" />" class="ebagrid grid<x:v-x:s-$uniqueId" />" tabIndex="1" &gt;&lt;div class="ebagridviewport gridviewport<x:v-x:s-$uniqueId" />" style="overflow:hidden;"&gt;&lt;div class="ebasurface surface<x:v-x:s-$uniqueId" />" style="overflow:hidden;"&gt;&lt;div class="ebadatapane datapane<x:v-x:s-$uniqueId" />" &gt;&lt;div style="overflow:hidden;position:relative;top:0px;left:0px;z-index:100000;"&gt;&lt;/div&gt;&lt;div&gt;&lt;/div&gt;&lt;div style="position:relative;top:0px;left:0px;z-index:20;" &gt;&lt;/div&gt;&lt;/div&gt;&lt;div class="ebaleftpane leftpane<x:v-x:s-$uniqueId" />" style="overflow:hidden;position:relative;top:0px;left:0px;z-index:100;"&gt;&lt;div&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class="ebarightpane rightpane<x:v-x:s-$uniqueId" />" style="overflow:hidden;position:relative;top:0px;left:200px;z-index:100;" &gt;&lt;div&gt;&lt;/div&gt;&lt;/div&gt;&lt;div style="overflow:hidden;position:relative;top:0px;left:0px;z-index:100000;"&gt;&lt;/div&gt;&lt;div class="ebafooter footer<x:v-x:s-$uniqueId" />" style="overflow:hidden;position:relative;top:0px;left:0px;z-index:100;"&gt;&lt;div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;div style="Z-INDEX:1000; LEFT:10px; OVERFLOW:hidden; POSITION:relative; TOP:15px; HEIGHT:578px" &gt;&lt;div&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class="ebarightpane rightpane<x:v-x:s-$uniqueId" />" style="Z-INDEX:1000; LEFT:610px; OVERFLOW:hidden; POSITION:relative; TOP:15px; HEIGHT:580px"&gt;&lt;div&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class="ebaleftpane leftpane<x:v-x:s-$uniqueId" /> header<x:v-x:s-$uniqueId" />" style="Z-INDEX:1000; LEFT:10px; OVERFLOW:hidden;POSITION:relative; TOP:15px;"&gt;&lt;div&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class="ebaleftpane leftpane<x:v-x:s-$uniqueId" /> footer<x:v-x:s-$uniqueId" />" style="Z-INDEX:1000; LEFT:10px; OVERFLOW:hidden;POSITION:relative; TOP:595px;"&gt;&lt;div&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class="ebarightpane rightpane<x:v-x:s-$uniqueId" /> header<x:v-x:s-$uniqueId" />" style="Z-INDEX:1010; LEFT:510px; OVERFLOW:hidden;POSITION:relative; TOP:15px;"&gt;&lt;div&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class="ebarightpane rightpane<x:v-x:s-$uniqueId" /> footer<x:v-x:s-$uniqueId" />" style="Z-INDEX:1010; LEFT:510px; OVERFLOW:hidden;POSITION:relative; TOP:595px;"&gt;&lt;div&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class="ebamidblockcontainer<x:v-x:s-$uniqueId" /> ebaheader header<x:v-x:s-$uniqueId" />" style="Z-INDEX:1000; OVERFLOW:hidden; WIDTH:100%; POSITION:relative; TOP:0px;"&gt;&lt;div class="ebaheader header<x:v-x:s-$uniqueId" /> centerheader<x:v-x:s-$uniqueId" /> " style="LEFT:0px;OVERFLOW:hidden;WIDTH:1000px;POSITION:relative;TOP:0px;"&gt;&lt;div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class="ebafooter footer<x:v-x:s-$uniqueId" />" style="Z-INDEX:1000; LEFT:110px; OVERFLOW:hidden; WIDTH:100%; POSITION:relative; TOP:595px; "&gt;&lt;div class="ebafooter footer<x:v-x:s-$uniqueId" />" style="LEFT:0px;OVERFLOW:hidden;WIDTH:1000px;POSITION:relative;TOP:0px;"&gt;&lt;div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class="ebavscrollbar" id="vscroll<x:v-x:s-$uniqueId" />" style="position:absolute;top:0px;left:0px;z-index:10000;OVERFLOW-X:hidden;OVERFLOW:scroll;WIDTH:22px;HEIGHT:600px"&gt;&lt;div class="vScrollbarRange<x:v-x:s-$uniqueId" />" style="WIDTH:1px;HEIGHT:1000px"&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class="ebahscrollbar" id="hscroll<x:v-x:s-$uniqueId" />" style="position:absolute;top:0;left:0;z-index:10000;OVERFLOW-Y:hidden;OVERFLOW:scroll;WIDTH:850px;HEIGHT:22px"&gt;&lt;div class="hScrollbarRange<x:v-x:s-$uniqueId" />" style="HEIGHT:1px"&gt;&lt;/div&gt;&lt;/div&gt;&lt;div class="ebatoollbarcontainer" id="toolbarContainer<x:v-x:s-$uniqueId" />" style="width:100%;position:absolute;height:25px;overflow:hidden;top:-1000px;left:0px;z-index:500;"&gt;&lt;/div&gt;&lt;div class="ebaresizecorner" id="resizecorner<x:v-x:s-$uniqueId" />"&gt;&lt;/div&gt;</x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.frameXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_frameXslProc));

var temp_ntb_listboxXslProc='<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com"> <xsl:output method="xml" omit-xml-declaration="yes"/> <x:p-x:n-DisplayFields"x:s-\'\'"></x:p-> <x:p-x:n-ValueField"x:s-\'\'"></x:p-> <x:p-x:n-val"x:s-\'\'"></x:p-> <x:t- match="/"> <!--<x:va-x:n-cell"x:s-/root/metadata/r[@xi=$row]/*[@xi=$col]"></x:va->--> <select> <!--<x:c-> <x:wh- test="$DatasourceId">--> <xsl:for-eachx:s-/ntb:datasource/ntb:data/*"> <xsl:sortx:s-@*[name(.)=substring-before($DisplayFields,\'|\')]" data-type="text" order="ascending" /> <option> <x:a-x:n-value"> <x:v-x:s-@*[name(.)=$ValueField]"></x:v-> </x:a-> <x:a-x:n-rn"> <x:v-x:s-position()"></x:v-> </x:a-> <xsl:if test="@*[name(.)=$ValueField and .=$val]"> <x:a-x:n-selected">true</x:a-> </xsl:if> <x:ct-x:n-print-displayfields"> <x:w-x:n-field"x:s-$DisplayFields" /> </x:ct-> </option> </xsl:for-each> <!--</x:wh-> <x:o-> </x:o-> </x:c->--> </select> </x:t-> <x:t-x:n-print-displayfields"> <x:p-x:n-field" /> <x:c-> <x:wh- test="contains($field,\'|\')" > <!-- Here we hardcode a spacer \', \' - this should probably be moved elsewhere. --> <x:v-x:s-concat(@*[name(.)=substring-before($field,\'|\')],\', \')"></x:v-> <x:ct-x:n-print-displayfields"> <x:w-x:n-field"x:s-substring-after($field,\'|\')" /> </x:ct-> </x:wh-> <x:o-> <x:v-x:s-@*[name(.)=$field]"></x:v-> </x:o-> </x:c-> </x:t-> </xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.form");
nitobi.form.listboxXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_listboxXslProc));

var temp_ntb_mergeEbaXmlToLogXslProc='<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com"> <xsl:output method="xml" omit-xml-declaration="yes"/> <x:p-x:n-defaultAction"></x:p-> <x:p-x:n-startXid"x:s-100" ></x:p-> <xsl:keyx:n-newData" match="/ntb:grid/ntb:newdata/ntb:data/ntb:e" use="@xid" /> <xsl:keyx:n-oldData" match="/ntb:grid/ntb:datasources/ntb:datasource/ntb:data/ntb:e" use="@xid" /> <x:t- match="@* | node()" > <xsl:copy> <x:at-x:s-@*|node()" /> </xsl:copy> </x:t-> <x:t- match="/ntb:grid/ntb:datasources/ntb:datasource/ntb:data/ntb:e"> <xsl:if test="not(key(\'newData\',@xid))"> <xsl:copy> <xsl:copy-ofx:s-@*" /> </xsl:copy> </xsl:if> </x:t-> <x:t- match="/ntb:grid/ntb:datasources/ntb:datasource/ntb:data"> <xsl:copy> <x:at-x:s-@*|node()" /> <xsl:for-eachx:s-/ntb:grid/ntb:newdata/ntb:data/ntb:e"> <xsl:copy> <xsl:copy-ofx:s-@*" /> <xsl:if test="$defaultAction"> <x:va-x:n-oldNode"x:s-key(\'oldData\',@xid)" /> <x:c-> <x:wh- test="$oldNode"> <x:va- name=\'xid\'x:s-@xid" /> <x:a-x:n-xac"><x:v-x:s-$oldNode/@xac" /></x:a-> </x:wh-> <x:o-> <x:a-x:n-xac"><x:v-x:s-$defaultAction" /></x:a-> </x:o-> </x:c-> </xsl:if> </xsl:copy> </xsl:for-each> </xsl:copy> </x:t-></xsl:stylesheet> ';
nitobi.lang.defineNs("nitobi.data");
nitobi.data.mergeEbaXmlToLogXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_mergeEbaXmlToLogXslProc));

var temp_ntb_mergeEbaXmlXslProc='<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com"> <xsl:output method="xml" omit-xml-declaration="no" /> <x:p-x:n-startRowIndex"x:s-100" ></x:p-> <x:p-x:n-endRowIndex"x:s-200" ></x:p-> <x:p-x:n-startXid"x:s-1"></x:p-> <xsl:keyx:n-newData" match="/ntb:grid/ntb:newdata/ntb:data/ntb:e" use="@xi" /> <xsl:keyx:n-oldData" match="/ntb:grid/ntb:datasources/ntb:datasource/ntb:data/ntb:e" use="@xi" /> <x:t- match="@* | node()" > <xsl:copy> <x:at-x:s-@*|node()" /> </xsl:copy> </x:t-> <x:t- match="/ntb:grid/ntb:datasources/ntb:datasource/ntb:data/ntb:e"> <x:c-> <x:wh- test="(number(@xi) &gt;= $startRowIndex) and (number(@xi) &lt;= $endRowIndex)"> <xsl:copy> <xsl:copy-ofx:s-@*" /> <xsl:copy-ofx:s-key(\'newData\',@xi)/@*" /> </xsl:copy> </x:wh-> <x:o-> <xsl:copy> <x:at-x:s-@*|node()" /> </xsl:copy> </x:o-> </x:c-> </x:t-> <x:t- match="/ntb:grid/ntb:datasources/ntb:datasource/ntb:data"> <xsl:copy> <x:at-x:s-@*|node()" /> <xsl:for-eachx:s-/ntb:grid/ntb:newdata/ntb:data/ntb:e"> <xsl:if test="not(key(\'oldData\',@xi))"> <xsl:elementx:n-ntb:e" namespace="http://www.nitobi.com"> <xsl:copy-ofx:s-@*" /> <x:a-x:n-xid"><x:v-x:s-position() + number($startXid)" /></x:a-> </xsl:element> </xsl:if> </xsl:for-each> </xsl:copy> </x:t-> <x:t- match="/ntb:grid/ntb:newdata/ntb:data/ntb:e"> <xsl:copy> <xsl:copy-ofx:s-@*" /> <x:c-> <x:wh- test="key(\'oldData\',@xi)"> <xsl:copy-ofx:s-key(\'oldData\',@xi)/@*" /> <xsl:copy-ofx:s-@*" /> <x:a-x:n-xac">u</x:a-> </x:wh-> <x:o-> <x:a-x:n-xid"><x:v-x:s-position() + number($startXid)" /></x:a-> <x:a-x:n-xac">i</x:a-> </x:o-> </x:c-> </xsl:copy> </x:t-> </xsl:stylesheet> ';
nitobi.lang.defineNs("nitobi.data");
nitobi.data.mergeEbaXmlXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_mergeEbaXmlXslProc));

var temp_ntb_mergeUpdateAttributesXslProc='<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/> <x:t-x:n-xmlUpdate"> <update></update> </x:t-> <x:t- match="@*|node()"> <xsl:copy> <x:at-x:s-@*|node()"/> </xsl:copy> </x:t-> <x:t- match="//update//@*"> <xsl:copy> <x:at-x:s-node()|@*"/> </xsl:copy> </x:t-> <!-- update the number of rows does not account for inserts! --> <x:t- match="//metadata/@numrows"> <x:a-x:n-{name(.)}"><x:v-x:s-. - count((document(\'\')//data[@id=\'_default\']/e[@xac=\'d\']))" /></x:a-> </x:t-> <!-- merge the updated attributes for each row --> <x:t- match="@*"> <x:va-x:n-currentXI"x:s-../@xi"/> <x:va-x:n-parentID"x:s-../../@id"/> <x:va-x:n-parentXI"x:s-../../@xi"/> <x:va-x:n-targetNode"x:s-(document(\'\')//*[@id=$parentID or @xi=$parentXI]/*[@xi=$currentXI and @xac=\'u\'])" /> <x:c-> <x:wh- test="($targetNode) and (name($targetNode)=name(..)) and (../@xi = $targetNode/@xi) and (name(../..) = name($targetNode/..))"> <xsl:copy> <x:at-x:s-node()|@*"/> </xsl:copy> <x:at-x:s-$targetNode/@*" /> </x:wh-> <x:o-> <xsl:copy> <x:at-x:s-node()|@*"/> </xsl:copy> </x:o-> </x:c-> </x:t-> <!-- delete rows --> <x:t- match="//root/*//node()"> <x:va-x:n-currentXI"x:s-@xi"/> <x:va-x:n-parentID"x:s-../@id"/> <x:va-x:n-parentXI"x:s-../@xi"/> <x:va-x:n-targetNode"x:s-(document(\'\')//*[@id=$parentID or @xi=$parentXI]/*[@xi=$currentXI and @xac=\'d\'])" /> <x:c-> <x:wh- test="($targetNode) and (name($targetNode/..)=name(..)) and (name() = name($targetNode))"> </x:wh-> <x:o-> <xsl:copy> <x:at-x:s-node()|@*"/> </xsl:copy> </x:o-> </x:c-> </x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.data");
nitobi.data.mergeUpdateAttributesXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_mergeUpdateAttributesXslProc));

var temp_ntb_modelFromDeclarationInitializerXslProc='<?xml version="1.0"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> <xsl:output method="text" encoding="utf-8" omit-xml-declaration="yes"/> <x:t- match="interface"> <x:ct-x:n-initJSDefaults"/> <x:at-/> </x:t-> <x:t-x:n-initJSDefaults"> var elem = this.Declaration.grid.documentElement; var valueFromHtml; </x:t-> <x:t- match="properties | events"> <xsl:for-eachx:s-*"> valueFromHtml = <x:c-><x:wh- test="@htmltag">elem.getAttribute("<x:v-x:s-@htmltag"/>")</x:wh-><x:o->elem.getAttribute("<x:v-x:s-@name"/>")</x:o-></x:c->; if (valueFromHtml) { this.set<x:v-x:s-@name"/>(valueFromHtml); } </xsl:for-each> </x:t-> <x:t- match="text()"/></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.modelFromDeclarationInitializerXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_modelFromDeclarationInitializerXslProc));

var temp_ntb_numberFormatTemplatesXslProc='<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com" xmlns:d="http://exslt.org/dates-and-times" xmlns:n="http://www.nitobi.com/exslt/numbers" extension-element-prefixes="d n"> <!--http://www.w3schools.com/xsl/func_formatnumber.asp--><xsl:decimal-formatx:n-ebaNumber" decimal-separator="." grouping-separator="," /><x:t-x:n-n:format"> <x:p-x:n-number"x:s-0" /> <x:p-x:n-mask"x:s-\'#.00\'" /> <x:p-x:n-group"x:s-\',\'" /> <x:p-x:n-decimal"x:s-\'.\'" /> <x:va-x:n-formattedNumber"> <x:v-x:s-format-number($number, $mask, \'ebaNumber\')" /> </x:va-> <xsl:if test="not(string($formattedNumber) = \'NaN\')"> <x:v-x:s-$formattedNumber" /> </xsl:if></x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.numberFormatTemplatesXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_numberFormatTemplatesXslProc));

var temp_ntb_numberXslProc='<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com" xmlns:d="http://exslt.org/dates-and-times" xmlns:n="http://www.nitobi.com/exslt/numbers" extension-element-prefixes="d n"><xsl:output method="text" version="4.0" omit-xml-declaration="yes" />  <!--http://www.w3schools.com/xsl/func_formatnumber.asp--><xsl:decimal-formatx:n-ebaNumber" decimal-separator="." grouping-separator="," /><x:t-x:n-n:format"> <x:p-x:n-number"x:s-0" /> <x:p-x:n-mask"x:s-\'#.00\'" /> <x:p-x:n-group"x:s-\',\'" /> <x:p-x:n-decimal"x:s-\'.\'" /> <x:va-x:n-formattedNumber"> <x:v-x:s-format-number($number, $mask, \'ebaNumber\')" /> </x:va-> <xsl:if test="not(string($formattedNumber) = \'NaN\')"> <x:v-x:s-$formattedNumber" /> </xsl:if></x:t-><x:t- match="/"> <x:ct-x:n-n:format"> <x:w-x:n-number"x:s-//number" /> <x:w-x:n-mask"x:s-//mask" /> <x:w-x:n-group"x:s-//group" /> <x:w-x:n-decimal"x:s-//decimal" /> </x:ct-></x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.form");
nitobi.form.numberXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_numberXslProc));

var temp_ntb_rowGeneratorXslProc='<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com" xmlns:d="http://exslt.org/dates-and-times" xmlns:n="http://www.nitobi.com/exslt/numbers" extension-element-prefixes="d n"><xsl:output method="text" omit-xml-declaration="yes"/><x:p-x:n-showIndicators"x:s-\'0\'" /><x:p-x:n-showHeaders"x:s-\'0\'" /><x:p-x:n-firstColumn"x:s-\'0\'" /><x:p-x:n-lastColumn"x:s-\'0\'" /><x:p-x:n-uniqueId"x:s-\'0\'" /><x:p-x:n-rowHover"x:s-\'0\'" /><x:t- match = "/">&lt;xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com" xmlns:d="http://exslt.org/dates-and-times" xmlns:n="http://www.nitobi.com/exslt/numbers" extension-element-prefixes="d n"&gt; &lt;!-- http://java.sun.com/j2se/1.3/docs/api/java/text/SimpleDateFormat.html --&gt;&lt;d:ms&gt; &lt;d:m l="31" a="Jan"&gt;January&lt;/d:m&gt; &lt;d:m l="28" a="Feb"&gt;February&lt;/d:m&gt; &lt;d:m l="31" a="Mar"&gt;March&lt;/d:m&gt; &lt;d:m l="30" a="Apr"&gt;April&lt;/d:m&gt; &lt;d:m l="31" a="May"&gt;May&lt;/d:m&gt; &lt;d:m l="30" a="Jun"&gt;June&lt;/d:m&gt; &lt;d:m l="31" a="Jul"&gt;July&lt;/d:m&gt; &lt;d:m l="31" a="Aug"&gt;August&lt;/d:m&gt; &lt;d:m l="30" a="Sep"&gt;September&lt;/d:m&gt; &lt;d:m l="31" a="Oct"&gt;October&lt;/d:m&gt; &lt;d:m l="30" a="Nov"&gt;November&lt;/d:m&gt; &lt;d:m l="31" a="Dec"&gt;December&lt;/d:m&gt;&lt;/d:ms&gt;&lt;d:ds&gt; &lt;d:d a="Sun"&gt;Sunday&lt;/d:d&gt; &lt;d:d a="Mon"&gt;Monday&lt;/d:d&gt; &lt;d:d a="Tue"&gt;Tuesday&lt;/d:d&gt; &lt;d:d a="Wed"&gt;Wednesday&lt;/d:d&gt; &lt;d:d a="Thu"&gt;Thursday&lt;/d:d&gt; &lt;d:d a="Fri"&gt;Friday&lt;/d:d&gt; &lt;d:d a="Sat"&gt;Saturday&lt;/d:d&gt;&lt;/d:ds&gt;&lt;x:t-x:n-d:format-date"&gt; &lt;x:p-x:n-date-time" /&gt; &lt;x:p-x:n-mask"x:s-\'MMM d, yy\'"/&gt; &lt;x:va-x:n-formatted"&gt; &lt;x:va-x:n-date-time-length"x:s-string-length($date-time)" /&gt; &lt;x:va-x:n-timezone"x:s-\'\'" /&gt; &lt;x:va-x:n-dt"x:s-substring($date-time, 1, $date-time-length - string-length($timezone))" /&gt; &lt;x:va-x:n-dt-length"x:s-string-length($dt)" /&gt; &lt;x:c-&gt; &lt;x:wh- test="substring($dt, 3, 1) = \':\' and substring($dt, 6, 1) = \':\'"&gt; &lt;!--that means we just have a time--&gt; &lt;x:va-x:n-hour"x:s-substring($dt, 1, 2)" /&gt; &lt;x:va-x:n-min"x:s-substring($dt, 4, 2)" /&gt; &lt;x:va-x:n-sec"x:s-substring($dt, 7)" /&gt; &lt;xsl:if test="$hour &amp;lt;= 23 and $min &amp;lt;= 59 and $sec &amp;lt;= 60"&gt; &lt;x:ct-x:n-d:_format-date"&gt; &lt;x:w-x:n-year"x:s-\'NaN\'" /&gt; &lt;x:w-x:n-month"x:s-\'NaN\'" /&gt; &lt;x:w-x:n-day"x:s-\'NaN\'" /&gt; &lt;x:w-x:n-hour"x:s-$hour" /&gt; &lt;x:w-x:n-minute"x:s-$min" /&gt; &lt;x:w-x:n-second"x:s-$sec" /&gt; &lt;x:w-x:n-timezone"x:s-$timezone" /&gt; &lt;x:w-x:n-mask"x:s-$mask" /&gt; &lt;/x:ct-&gt; &lt;/xsl:if&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;!--($neg * -2)--&gt; &lt;x:va-x:n-year"x:s-substring($dt, 1, 4) * (0 + 1)" /&gt; &lt;x:va-x:n-month"x:s-substring($dt, 6, 2)" /&gt; &lt;x:va-x:n-day"x:s-substring($dt, 9, 2)" /&gt; &lt;x:c-&gt; &lt;x:wh- test="$dt-length = 10"&gt; &lt;!--that means we just have a date--&gt; &lt;x:ct-x:n-d:_format-date"&gt; &lt;x:w-x:n-year"x:s-$year" /&gt; &lt;x:w-x:n-month"x:s-$month" /&gt; &lt;x:w-x:n-day"x:s-$day" /&gt; &lt;x:w-x:n-timezone"x:s-$timezone" /&gt; &lt;x:w-x:n-mask"x:s-$mask" /&gt; &lt;/x:ct-&gt; &lt;/x:wh-&gt; &lt;x:wh- test="substring($dt, 14, 1) = \':\' and substring($dt, 17, 1) = \':\'"&gt; &lt;!--that means we have a date + time--&gt; &lt;x:va-x:n-hour"x:s-substring($dt, 12, 2)" /&gt; &lt;x:va-x:n-min"x:s-substring($dt, 15, 2)" /&gt; &lt;x:va-x:n-sec"x:s-substring($dt, 18)" /&gt; &lt;x:ct-x:n-d:_format-date"&gt; &lt;x:w-x:n-year"x:s-$year" /&gt; &lt;x:w-x:n-month"x:s-$month" /&gt; &lt;x:w-x:n-day"x:s-$day" /&gt; &lt;x:w-x:n-hour"x:s-$hour" /&gt; &lt;x:w-x:n-minute"x:s-$min" /&gt; &lt;x:w-x:n-second"x:s-$sec" /&gt; &lt;x:w-x:n-timezone"x:s-$timezone" /&gt; &lt;x:w-x:n-mask"x:s-$mask" /&gt; &lt;/x:ct-&gt; &lt;/x:wh-&gt; &lt;/x:c-&gt; &lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:va-&gt; &lt;x:v-x:s-$formatted" /&gt; &lt;/x:t-&gt;&lt;x:t-x:n-d:_format-date"&gt; &lt;x:p-x:n-year" /&gt; &lt;x:p-x:n-month"x:s-1" /&gt; &lt;x:p-x:n-day"x:s-1" /&gt; &lt;x:p-x:n-hour"x:s-0" /&gt; &lt;x:p-x:n-minute"x:s-0" /&gt; &lt;x:p-x:n-second"x:s-0" /&gt; &lt;x:p-x:n-timezone"x:s-\'Z\'" /&gt; &lt;x:p-x:n-mask"x:s-\'\'" /&gt; &lt;x:va-x:n-char"x:s-substring($mask, 1, 1)" /&gt; &lt;x:c-&gt; &lt;x:wh- test="not($mask)" /&gt; &lt;!--replaced escaping with \' here/--&gt; &lt;x:wh- test="not(contains(\'GyMdhHmsSEDFwWakKz\', $char))"&gt; &lt;x:v-x:s-$char" /&gt; &lt;x:ct-x:n-d:_format-date"&gt; &lt;x:w-x:n-year"x:s-$year" /&gt; &lt;x:w-x:n-month"x:s-$month" /&gt; &lt;x:w-x:n-day"x:s-$day" /&gt; &lt;x:w-x:n-hour"x:s-$hour" /&gt; &lt;x:w-x:n-minute"x:s-$minute" /&gt; &lt;x:w-x:n-second"x:s-$second" /&gt; &lt;x:w-x:n-timezone"x:s-$timezone" /&gt; &lt;x:w-x:n-mask"x:s-substring($mask, 2)" /&gt; &lt;/x:ct-&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:va-x:n-next-different-char"x:s-substring(translate($mask, $char, \'\'), 1, 1)" /&gt; &lt;x:va-x:n-mask-length"&gt; &lt;x:c-&gt; &lt;x:wh- test="$next-different-char"&gt; &lt;x:v-x:s-string-length(substring-before($mask, $next-different-char))" /&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:v-x:s-string-length($mask)" /&gt; &lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:va-&gt; &lt;x:c-&gt; &lt;!--took our the era designator--&gt; &lt;x:wh- test="$char = \'M\'"&gt; &lt;x:c-&gt; &lt;x:wh- test="$mask-length &gt;= 3"&gt; &lt;x:va-x:n-month-node"x:s-document(\'\')/*/d:ms/d:m[number($month)]" /&gt; &lt;x:c-&gt; &lt;x:wh- test="$mask-length &gt;= 4"&gt; &lt;x:v-x:s-$month-node" /&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:v-x:s-$month-node/@a" /&gt; &lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$mask-length = 2"&gt; &lt;x:v-x:s-format-number($month, \'00\')" /&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:v-x:s-$month" /&gt; &lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$char = \'E\'"&gt; &lt;x:va-x:n-month-days"x:s-sum(document(\'\')/*/d:ms/d:m[position() &amp;lt; $month]/@l)" /&gt; &lt;x:va-x:n-days"x:s-$month-days + $day + boolean(((not($year mod 4) and $year mod 100) or not($year mod 400)) and $month &amp;gt; 2)" /&gt; &lt;x:va-x:n-y-1"x:s-$year - 1" /&gt; &lt;x:va-x:n-dow"x:s-(($y-1 + floor($y-1 div 4) - floor($y-1 div 100) + floor($y-1 div 400) + $days) mod 7) + 1" /&gt; &lt;x:va-x:n-day-node"x:s-document(\'\')/*/d:ds/d:d[number($dow)]" /&gt; &lt;x:c-&gt; &lt;x:wh- test="$mask-length &gt;= 4"&gt; &lt;x:v-x:s-$day-node" /&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:v-x:s-$day-node/@a" /&gt; &lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$char = \'a\'"&gt; &lt;x:c-&gt; &lt;x:wh- test="$hour &gt;= 12"&gt;PM&lt;/x:wh-&gt; &lt;x:o-&gt;AM&lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$char = \'z\'"&gt; &lt;x:c-&gt; &lt;x:wh- test="$timezone = \'Z\'"&gt;UTC&lt;/x:wh-&gt; &lt;x:o-&gt;UTC&lt;x:v-x:s-$timezone" /&gt;&lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:va-x:n-padding"x:s-\'00\'" /&gt; &lt;!--removed padding--&gt; &lt;x:c-&gt; &lt;x:wh- test="$char = \'y\'"&gt; &lt;x:c-&gt; &lt;x:wh- test="$mask-length &amp;gt; 2"&gt;&lt;x:v-x:s-format-number($year, $padding)" /&gt;&lt;/x:wh-&gt; &lt;x:o-&gt;&lt;x:v-x:s-format-number(substring($year, string-length($year) - 1), $padding)" /&gt;&lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$char = \'d\'"&gt; &lt;x:v-x:s-format-number($day, $padding)" /&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$char = \'h\'"&gt; &lt;x:va-x:n-h"x:s-$hour mod 12" /&gt; &lt;x:c-&gt; &lt;x:wh- test="$h"&gt;&lt;x:v-x:s-format-number($h, $padding)" /&gt;&lt;/x:wh-&gt; &lt;x:o-&gt;&lt;x:v-x:s-format-number(12, $padding)" /&gt;&lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$char = \'H\'"&gt; &lt;x:v-x:s-format-number($hour, $padding)" /&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$char = \'k\'"&gt; &lt;x:c-&gt; &lt;x:wh- test="$hour"&gt;&lt;x:v-x:s-format-number($hour, $padding)" /&gt;&lt;/x:wh-&gt; &lt;x:o-&gt;&lt;x:v-x:s-format-number(24, $padding)" /&gt;&lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$char = \'K\'"&gt; &lt;x:v-x:s-format-number($hour mod 12, $padding)" /&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$char = \'m\'"&gt; &lt;x:v-x:s-format-number($minute, $padding)" /&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$char = \'s\'"&gt; &lt;x:v-x:s-format-number($second, $padding)" /&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$char = \'S\'"&gt; &lt;x:v-x:s-format-number(substring-after($second, \'.\'), $padding)" /&gt; &lt;/x:wh-&gt; &lt;x:wh- test="$char = \'F\'"&gt; &lt;x:v-x:s-floor($day div 7) + 1" /&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:va-x:n-month-days"x:s-sum(document(\'\')/*/d:ms/d:m[position() &amp;lt; $month]/@l)" /&gt; &lt;x:va-x:n-days"x:s-$month-days + $day + boolean(((not($year mod 4) and $year mod 100) or not($year mod 400)) and $month &amp;gt; 2)" /&gt; &lt;x:v-x:s-format-number($days, $padding)" /&gt; &lt;!--removed week in year--&gt; &lt;!--removed week in month--&gt; &lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:o-&gt; &lt;/x:c-&gt; &lt;x:ct-x:n-d:_format-date"&gt; &lt;x:w-x:n-year"x:s-$year" /&gt; &lt;x:w-x:n-month"x:s-$month" /&gt; &lt;x:w-x:n-day"x:s-$day" /&gt; &lt;x:w-x:n-hour"x:s-$hour" /&gt; &lt;x:w-x:n-minute"x:s-$minute" /&gt; &lt;x:w-x:n-second"x:s-$second" /&gt; &lt;x:w-x:n-timezone"x:s-$timezone" /&gt; &lt;x:w-x:n-mask"x:s-substring($mask, $mask-length + 1)" /&gt; &lt;/x:ct-&gt; &lt;/x:o-&gt; &lt;/x:c-&gt;&lt;/x:t-&gt; &lt;!--http://www.w3schools.com/xsl/func_formatnumber.asp--&gt;&lt;xsl:decimal-formatx:n-ebaNumber" decimal-separator="." grouping-separator="," /&gt;&lt;x:t-x:n-n:format"&gt; &lt;x:p-x:n-number"x:s-0" /&gt; &lt;x:p-x:n-mask"x:s-\'#.00\'" /&gt; &lt;x:p-x:n-group"x:s-\',\'" /&gt; &lt;x:p-x:n-decimal"x:s-\'.\'" /&gt; &lt;x:va-x:n-formattedNumber"&gt; &lt;x:v-x:s-format-number($number, $mask, \'ebaNumber\')" /&gt; &lt;/x:va-&gt; &lt;xsl:if test="not(string($formattedNumber) = \'NaN\')"&gt; &lt;x:v-x:s-$formattedNumber" /&gt; &lt;/xsl:if&gt;&lt;/x:t-&gt;&lt;xsl:output method="xml" omit-xml-declaration="yes"/&gt;&lt;x:p-x:n-start" /&gt;&lt;x:p-x:n-end" /&gt;&lt;x:p-x:n-activeColumn"x:s-\'0\'" /&gt;&lt;x:p-x:n-activeRow"x:s-\'0\'" /&gt;&lt;x:p-x:n-sortColumn"x:s-\'0\'" /&gt;&lt;x:p-x:n-sortDirection"x:s-\'Asc\'" /&gt;&lt;x:p-x:n-dataTableId"x:s-\'_default\'" /&gt;&lt;xsl:keyx:n-data-source" match="//ntb:datasources/ntb:datasource" use="@id" /&gt;&lt;x:t- match = "/"&gt; &lt;div&gt; <xsl:if test="$showHeaders"> &lt;div class="ebacolumnheader" &gt; <xsl:if test="$showIndicators"> &lt;div ebatype="columnheader" xi="&lt;x:v-x:s-position()-1"/&gt; class="ebacolumn"&gt; &lt;a href="#" class="ebarowindicator" onclick="return false;" style=";float:left;"&gt; &lt;x:v-x:s-@xi"/&gt; &lt;/a&gt; &lt;/div&gt; </xsl:if> <xsl:for-eachx:s-*/*"> <xsl:if test="@Visible = \'1\'"> <xsl:if test="position() &gt; $firstColumn and position() &lt;= $lastColumn"> &lt;x:va-x:n-sortString<x:v-x:s-position()-1"/>"&gt; &lt;x:c-&gt; &lt;x:wh- test="$sortColumn=<x:v-x:s-position()-1"/> and $sortDirection=\'Asc\'"&gt;ascending&lt;/x:wh-&gt; &lt;x:wh- test="$sortColumn=<x:v-x:s-position()-1"/> and $sortDirection=\'Desc\'"&gt;descending&lt;/x:wh-&gt; &lt;x:o-&gt;&lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:va-&gt; &lt;a href="#" onclick="return false;" id="columnheader_<x:v-x:s-position()-1"/>_<x:v-x:s-$uniqueId" />" ebatype="columnheader" xi="<x:v-x:s-position()-1"/>"&gt; &lt;x:a-x:n-class"&gt; ebacolumnindicator&lt;x:v-x:s-$sortString<x:v-x:s-position()-1"/>" /&gt; ebacolumn acolumn<x:v-x:s-$uniqueId" />_<x:v-x:s-position()" /> acolumnheader<x:v-x:s-$uniqueId" />_<x:v-x:s-position()" /> columnindicator &lt;/x:a-&gt; <x:c-> <x:wh- test="@Label and not(@Label = \'\') and not(@Label = \' \')"><x:v-x:s-@Label" /></x:wh-> <x:o->ATOKENTOREPLACE</x:o-> </x:c-> &lt;/a&gt; </xsl:if> </xsl:if> </xsl:for-each> &lt;/div&gt; </xsl:if> &lt;table cellpadding="0" cellspacing="0" border="0" class="blocktable"&gt; &lt;x:at-x:s-key(\'data-source\', $dataTableId)/ntb:data/ntb:e[@xi&amp;gt;=$start and @xi&amp;lt; $end]" &gt; &lt;xsl:sortx:s-@xi" data-type="number" /&gt; &lt;/x:at-&gt; &lt;/table&gt; &lt;/div&gt;&lt;/x:t-&gt;&lt;x:t- match="ntb:e"&gt; &lt;x:va-x:n-xi"x:s-@xi" /&gt; &lt;x:va-x:n-rowClass"&gt; &lt;xsl:if test="position() mod 2 = 0"&gt;ebaalternaterow&lt;/xsl:if&gt; &lt;xsl:if test="<x:v-x:s-@rowselectattr=1"/>"&gt;ebarowselected&lt;/xsl:if&gt; &lt;/x:va-&gt; &lt;tr class="ebarow {$rowClass} arow<x:v-x:s-$uniqueId"/>" xi="{$xi}"&gt; &lt;x:a-x:n-id"&gt;row_&lt;x:v-x:s-$xi" /&gt;_<x:v-x:s-$uniqueId" />&lt;/x:a-&gt; <xsl:for-eachx:s-*/*"> <xsl:if test="@Visible = \'1\'"> &lt;x:va-x:n-sortString<x:v-x:s-position()-1"/>"&gt; &lt;x:c-&gt; &lt;x:wh- test="$sortColumn=<x:v-x:s-position()-1"/> and $sortDirection=\'Asc\'"&gt;ascending&lt;/x:wh-&gt; &lt;x:wh- test="$sortColumn=<x:v-x:s-position()-1"/> and $sortDirection=\'Desc\'"&gt;descending&lt;/x:wh-&gt; &lt;x:o-&gt;&lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:va-&gt; &lt;x:va-x:n-value<x:v-x:s-position()"/>" &gt; <x:c-> <x:wh- test="not(@xdatafld = \'\')">&lt;x:v-x:s-<x:v-x:s-@xdatafld" />" /&gt;</x:wh-> <!-- @Value will actuall have some escaped XSLT in it like any other bound property --> <x:o-><x:v-x:s-@Value" /></x:o-> </x:c-> &lt;/x:va-&gt; <xsl:if test="position() &gt; $firstColumn and position() &lt;= $lastColumn"> &lt;td ebatype="cell" xi="{$xi}" col="<x:v-x:s-position()-1"/>" value="{$value<x:v-x:s-position()"/>}" &gt; &lt;x:a-x:n-style"&gt;<x:v-x:s-@CssStyle"/>&lt;/x:a-&gt; &lt;x:a-x:n-id"&gt;cell_&lt;x:v-x:s-$xi" /&gt;_<x:v-x:s-position()-1" />_<x:v-x:s-$uniqueId" />&lt;/x:a-&gt; &lt;x:a-x:n-class"&gt;acell<x:v-x:s-$uniqueId"/> acolumn<x:v-x:s-$uniqueId"/>_<x:v-x:s-position()" /> acolumndata<x:v-x:s-$uniqueId"/>_<x:v-x:s-position()" /> ebacolumn&lt;x:v-x:s-$sortString<x:v-x:s-position()-1"/>" /&gt; ebacell <x:v-x:s-@ClassName"/>&lt;/x:a-&gt; &lt;x:ct-x:n-<x:c-><x:wh- test="@type and not(@type=\'\')"><x:v-x:s-@type" /></x:wh-><x:o->TEXT</x:o-></x:c->"&gt;&lt;x:w-x:n-value"x:s-$value<x:v-x:s-position()"/>" /&gt;&lt;x:w-x:n-mask" &gt;<x:v-x:s-@Mask"/>&lt;/x:w-&gt;&lt;x:w-x:n-datasource" &gt;<x:v-x:s-@DatasourceId"/>&lt;/x:w-&gt;&lt;x:w-x:n-valuefield" &gt;<x:v-x:s-@ValueField"/>&lt;/x:w-&gt;&lt;x:w-x:n-displayfields" &gt;<x:v-x:s-@DisplayFields"/>&lt;/x:w-&gt;&lt;x:w-x:n-checkedvalue" &gt;<x:v-x:s-@CheckedValue"/>&lt;/x:w-&gt;&lt;x:w-x:n-imageurl" &gt;<x:v-x:s-@ImageUrl"/>&lt;/x:w-&gt; &lt;/x:ct-&gt; &lt;/td&gt; </xsl:if> </xsl:if> </xsl:for-each> &lt;/tr&gt;&lt;/x:t-&gt;&lt;x:t-x:n-replaceblank"&gt; &lt;x:p-x:n-value" /&gt; &lt;x:c-&gt; &lt;x:wh- test="not($value) or $value = \'\' or $value = \' \'"&gt;ATOKENTOREPLACE&lt;/x:wh-&gt; &lt;x:o-&gt;&lt;x:v-x:s-$value" /&gt;&lt;/x:o-&gt; &lt;/x:c-&gt;&lt;/x:t-&gt;&lt;x:t-x:n-replace"&gt; &lt;x:p-x:n-text"/&gt; &lt;x:p-x:n-search"/&gt; &lt;x:p-x:n-replacement"/&gt; &lt;x:c-&gt; &lt;x:wh- test="contains($text, $search)"&gt; &lt;x:v-x:s-substring-before($text, $search)"/&gt; &lt;x:v-x:s-$replacement"/&gt; &lt;x:ct-x:n-replace"&gt; &lt;x:w-x:n-text"x:s-substring-after($text,$search)"/&gt; &lt;x:w-x:n-search"x:s-$search"/&gt; &lt;x:w-x:n-replacement"x:s-$replacement"/&gt; &lt;/x:ct-&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:v-x:s-$text"/&gt; &lt;/x:o-&gt; &lt;/x:c-&gt;&lt;/x:t-&gt;&lt;x:t-x:n-print-displayfields"&gt; &lt;x:p-x:n-field" /&gt; &lt;x:c-&gt; &lt;x:wh- test="contains($field,\'|\')" &gt; &lt;!-- Here we hardcode a spacer \', \' - this should probably be moved elsewhere. --&gt; &lt;x:v-x:s-concat(@*[name(.)=substring-before($field,\'|\')],\', \')" /&gt; &lt;x:ct-x:n-print-displayfields"&gt; &lt;x:w-x:n-field"x:s-substring-after($field,\'|\')" /&gt; &lt;/x:ct-&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:v-x:s-@*[name(.)=$field]" /&gt; &lt;/x:o-&gt; &lt;/x:c-&gt;&lt;/x:t-&gt;&lt;x:t-x:n-replace-break"&gt; &lt;x:p-x:n-text"/&gt; &lt;x:ct-x:n-replace"&gt; &lt;x:w-x:n-text"x:s-$text"/&gt; &lt;x:w-x:n-search"x:s-\'&amp;amp;#xa;\'"/&gt; &lt;x:w-x:n-replacement"x:s-\'&amp;lt;br/&amp;gt;\'"/&gt; &lt;/x:ct-&gt;&lt;/x:t-&gt;&lt;x:t-x:n-TEXT"&gt; &lt;x:p-x:n-value" /&gt; &lt;x:ct-x:n-replaceblank"&gt; &lt;x:w-x:n-value"x:s-$value" /&gt; &lt;/x:ct-&gt;&lt;/x:t-&gt;&lt;x:t-x:n-PASSWORD"&gt; &lt;x:p-x:n-value" /&gt; *********&lt;/x:t-&gt;&lt;x:t-x:n-TEXTAREA"&gt; &lt;x:p-x:n-value" /&gt; &lt;x:ct-x:n-replace-break"&gt; &lt;x:w-x:n-text"&gt; &lt;x:ct-x:n-replaceblank"&gt; &lt;x:w-x:n-value"x:s-$value" /&gt; &lt;/x:ct-&gt; &lt;/x:w-&gt; &lt;/x:ct-&gt;&lt;/x:t-&gt;&lt;x:t-x:n-NUMBER"&gt; &lt;x:p-x:n-value" /&gt; &lt;x:p-x:n-mask" /&gt; &lt;x:va-x:n-number-mask"&gt; &lt;x:c-&gt; &lt;x:wh- test="$mask"&gt;&lt;x:v-x:s-$mask" /&gt;&lt;/x:wh-&gt; &lt;x:o-&gt;#,###.00&lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:va-&gt; &lt;x:va-x:n-number"&gt; &lt;x:ct-x:n-n:format"&gt; &lt;x:w-x:n-number"x:s-$value" /&gt; &lt;x:w-x:n-mask"x:s-$number-mask" /&gt; &lt;/x:ct-&gt; &lt;/x:va-&gt; &lt;x:ct-x:n-replaceblank"&gt; &lt;x:w-x:n-value"x:s-$number" /&gt; &lt;/x:ct-&gt;&lt;/x:t-&gt;&lt;x:t-x:n-IMAGE"&gt; &lt;x:p-x:n-value" /&gt; &lt;x:p-x:n-imageurl" /&gt; &lt;x:va-x:n-url"&gt; &lt;x:c-&gt; &lt;x:wh- test="$imageurl"&gt;&lt;x:v-x:s-$imageurl" /&gt;&lt;/x:wh-&gt; &lt;x:o-&gt;&lt;x:v-x:s-$value" /&gt;&lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:va-&gt; <!-- image editor --> &lt;img border="0" src="{$url}" /&gt;&lt;/x:t-&gt;&lt;x:t-x:n-DATE"&gt; &lt;x:p-x:n-value" /&gt; &lt;x:p-x:n-mask" /&gt; &lt;x:va-x:n-date-mask"&gt; &lt;x:c-&gt; &lt;x:wh- test="$mask"&gt;&lt;x:v-x:s-$mask" /&gt;&lt;/x:wh-&gt; &lt;x:o-&gt;MMM d, yy&lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:va-&gt; &lt;x:va-x:n-date"&gt; &lt;x:ct-x:n-d:format-date"&gt; &lt;x:w-x:n-date-time"x:s-$value" /&gt; &lt;x:w-x:n-mask"x:s-$date-mask" /&gt; &lt;/x:ct-&gt; &lt;/x:va-&gt; &lt;x:ct-x:n-replaceblank"&gt; &lt;x:w-x:n-value"x:s-$date" /&gt; &lt;/x:ct-&gt;&lt;/x:t-&gt;&lt;x:t-x:n-LISTBOX"&gt; &lt;x:p-x:n-value" /&gt; &lt;x:p-x:n-datasource" /&gt; &lt;x:p-x:n-valuefield" /&gt; &lt;x:p-x:n-displayfields" /&gt; &lt;x:c-&gt; &lt;x:wh- test="$datasource"&gt; &lt;xsl:for-eachx:s-key(\'data-source\',$datasource)//*"&gt; &lt;xsl:if test="@*[name(.)=$valuefield and .=$value]"&gt; &lt;x:ct-x:n-replaceblank"&gt; &lt;x:w-x:n-value"&gt; &lt;x:ct-x:n-print-displayfields"&gt; &lt;x:w-x:n-field"x:s-$displayfields" /&gt; &lt;/x:ct-&gt; &lt;/x:w-&gt; &lt;/x:ct-&gt; &lt;/xsl:if&gt; &lt;/xsl:for-each&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:ct-x:n-replaceblank"&gt; &lt;x:w-x:n-value"x:s-$value" /&gt; &lt;/x:ct-&gt; &lt;/x:o-&gt; &lt;/x:c-&gt;&lt;/x:t-&gt;&lt;x:t-x:n-LOOKUP"&gt; &lt;x:p-x:n-value" /&gt; &lt;x:p-x:n-datasource" /&gt; &lt;x:p-x:n-valuefield" /&gt; &lt;x:p-x:n-displayfields" /&gt; &lt;x:c-&gt; &lt;x:wh- test="$valuefield = $displayfields"&gt; &lt;x:ct-x:n-TEXT"&gt; &lt;x:w-x:n-value"x:s-$value" /&gt; &lt;/x:ct-&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:ct-x:n-replaceblank"&gt; &lt;x:w-x:n-value"&gt; &lt;x:c-&gt; &lt;x:wh- test="$datasource"&gt; &lt;x:va-x:n-preset-value" &gt; &lt;xsl:for-eachx:s-key(\'data-source\',$datasource)//*"&gt; &lt;xsl:if test="@*[name(.)=$valuefield and .=$value]"&gt; &lt;x:ct-x:n-print-displayfields"&gt; &lt;x:w-x:n-field"x:s-$displayfields" /&gt; &lt;/x:ct-&gt; &lt;/xsl:if&gt; &lt;/xsl:for-each&gt; &lt;/x:va-&gt; &lt;x:c-&gt; &lt;x:wh- test="$preset-value=\'\'"&gt; &lt;x:v-x:s-$value"/&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:v-x:s-$preset-value"/&gt; &lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:wh-&gt; &lt;x:o-&gt; &lt;x:v-x:s-$value"/&gt; &lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:w-&gt; &lt;/x:ct-&gt; &lt;/x:o-&gt; &lt;/x:c-&gt;&lt;/x:t-&gt;&lt;x:t-x:n-CHECKBOX"&gt; &lt;x:p-x:n-value" /&gt; &lt;x:p-x:n-datasource" /&gt; &lt;x:p-x:n-valuefield" /&gt; &lt;x:p-x:n-displayfields" /&gt; &lt;x:p-x:n-checkedvalue" /&gt; &lt;xsl:for-eachx:s-key(\'data-source\',$datasource)//*"&gt; &lt;xsl:if test="@*[name(.)=$valuefield and .=$value]"&gt; &lt;x:va-x:n-checkString"&gt; &lt;x:c-&gt; &lt;x:wh- test="$value=$checkedvalue"&gt;checked&lt;/x:wh-&gt; &lt;x:o-&gt;unchecked&lt;/x:o-&gt; &lt;/x:c-&gt; &lt;/x:va-&gt; &lt;div style="overflow:hidden;"&gt; &lt;div style="float:left;" class="ebacheckbox ebacheckbox{$checkString} checkbox{$checkString}" checked="{$value}" width="10" &gt;ATOKENTOREPLACE&lt;/div&gt;&lt;span&gt;&lt;x:v-x:s-@*[name(.)=$displayfields]" /&gt;&lt;/span&gt; &lt;/div&gt; &lt;/xsl:if&gt; &lt;/xsl:for-each&gt;&lt;/x:t-&gt;&lt;x:t-x:n-LINK"&gt; &lt;x:p-x:n-value" /&gt; &lt;span class="ebahyperlinkeditor"&gt; &lt;x:ct-x:n-replaceblank"&gt; &lt;x:w-x:n-value"x:s-$value" /&gt; &lt;/x:ct-&gt; &lt;/span&gt;&lt;/x:t-&gt;<!--This can be used as an insertion point for column templates--> &lt;!--COLUMN-TYPE-TEMPLATES--&gt;&lt;/xsl:stylesheet&gt;</x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.grid");
nitobi.grid.rowGeneratorXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_rowGeneratorXslProc));

var temp_ntb_sortXslProc='<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com"> <xsl:output method="xml" omit-xml-declaration="yes" /> <x:p-x:n-column"x:s-@xi"> </x:p-> <x:p-x:n-dir"x:s-\'ascending\'"> </x:p-> <x:p-x:n-type"x:s-\'text\'"> </x:p-> <x:t- match="*|@*"> <xsl:copy> <x:at-x:s-@*|node()" /> </xsl:copy> </x:t-> <x:t- match="ntb:data"> <xsl:copy> <x:at-x:s-@*"/> <xsl:for-eachx:s-ntb:e"> <xsl:sortx:s-@*[name() =$column]" order="{$dir}" data-type="{$type}"/> <xsl:copy> <x:a-x:n-xi"> <x:v-x:s-position()-1" /> </x:a-> <x:at-x:s-@*" /> </xsl:copy> </xsl:for-each> </xsl:copy> </x:t-><x:t- match="@xi" /></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.data");
nitobi.data.sortXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_sortXslProc));

var temp_ntb_fillColumnXslProc='<?xml version="1.0" encoding="utf-8"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com"> <xsl:output method="xml" omit-xml-declaration="no" /> <x:p-x:n-startRowIndex"x:s-0" ></x:p-> <x:p-x:n-endRowIndex"x:s-10000" ></x:p-> <x:p-x:n-value"x:s-test"></x:p-> <x:p-x:n-column"x:s-a"></x:p-> <x:t- match="@* | node()" > <xsl:copy> <x:at-x:s-@*|node()" /> </xsl:copy> </x:t-> <x:t- match="/ntb:grid/ntb:datasources/ntb:datasource/ntb:data/ntb:e"> <x:c-> <x:wh- test="(number(@xi) &gt;= $startRowIndex) and (number(@xi) &lt;= $endRowIndex)"> <xsl:copy> <xsl:copy-ofx:s-@*" /> <x:a-x:n-{$column}"><x:v-x:s-$value" /></x:a-> </xsl:copy> </x:wh-> <x:o-> <xsl:copy> <x:at-x:s-@*|node()" /> </xsl:copy> </x:o-> </x:c-> </x:t-></xsl:stylesheet> ';
nitobi.lang.defineNs("nitobi.data");
nitobi.data.fillColumnXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_fillColumnXslProc));

var temp_ntb_updategramTranslatorXslProc='<?xml version="1.0"?><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ntb="http://www.nitobi.com"> <xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/> <x:p-x:n-datasource-id"x:s-\'_default\'"></x:p-> <x:p-x:n-xkField" ></x:p-> <x:t- match="/"> <root> <x:at-x:s-//ntb:datasource[@id=$datasource-id]/ntb:data/ntb:e" /> </root> </x:t-> <x:t- match="ntb:e"> <x:c-> <x:wh- test="@xac=\'d\'"> <delete xi="{@xi}" xk="{@*[name() = $xkField]}"></delete> </x:wh-> <x:wh- test="@xac=\'i\'"> <insert><xsl:copy-ofx:s-@*[not(name() = $xkField) and not(name() = \'xac\')]" /><x:a-x:n-xk"><x:v-x:s-@*[name() = $xkField]" /></x:a-></insert> </x:wh-> <x:wh- test="@xac=\'u\'"> <update><xsl:copy-ofx:s-@*[not(name() = $xkField) and not(name() = \'xac\')]" /><x:a-x:n-xk"><x:v-x:s-@*[name() = $xkField]" /></x:a-></update> </x:wh-> </x:c-> </x:t-></xsl:stylesheet>';
nitobi.lang.defineNs("nitobi.data");
nitobi.data.updategramTranslatorXslProc = nitobi.xml.createXslProcessor(nitobiXmlDecodeXslt(temp_ntb_updategramTranslatorXslProc));


