var T = [], globcol = 0, globo = null;

function initable( id, types, first, func, offtop ) {
 if( ( id.tagName||'' ).toLowerCase()==='table' ) { if( !id.id ) { id.id = 'table' + Math.random(); } id = id.id; }
 types = types || 0; first = first || 0; func = func || 0; offtop = offtop || 0;
 T[id] = {}; T[id].curcol = first; T[id].curdir = 'down'; T[id].rank = false; T[id].func = func; T[id].offtop = offtop;
 var a = window.document.getElementById( id );
 if(a) {
  var b = a.getElementsByTagName( 'thead' )[0].getElementsByTagName( 'th' ), i, j;
  for( i=0; i < b.length; i++ ) {
   if( !( offtop===false||offtop==='no' ) ) { b[i].style.position = 'relative'; }
   if( types[i] && types[i].toLowerCase().indexOf( 'rank' )===0 ) { addrank( id, i, types[i].substring( 4 ) ); T[id].rank = i; }
   else if( types[i]!=='no' && types[i]!==false ) { b[i].how = types[i]; b[i].onclick = gosortable; }
  }
  if( !( offtop===false||offtop==='no' ) ) {
   if( typeof window.onscroll!=='undefined' ) {
    window.onscroll = stickhead;
    window.onresize = stickhead;
   }else{
    window.setInterval( 'stickhead();', 2000 );
   }
  }
  if( typeof getcookie!=='undefined' && ( j = getcookie( 'sort' + id ) ) ) {
   if( Math.abs(j)!=first ) { first = Math.abs(j);
    sortable( id, first ); if( j<0 ) { sortable( id, first ); }
   }else{
    sorticon( b[first] );
   }
  }else{
   sorticon( b[first] );
  }
  globcol = first;
 }
}

function sortable( e, col ) { if( !e ) { alert( 'Argument bug!' ); return; }
 if( typeof e==='string' ) { e = window.document.getElementById( e ); }
 if( e && col ) { e = e.getElementsByTagName( 'thead' )[0].getElementsByTagName( 'th' )[col]; }
 var i = e, table = e, newcol = 0;
 if( !e ) { alert( arguments + '\nTable bug!' ); }
 while( ( table.tagName && table.tagName.toLowerCase()!=='table' ) ) { table = table.parentNode; }
 if( typeof col!=='undefined' ) { newcol = col; } else { while( ( i = i.previousSibling ) ) { if( i.tagName ) { newcol++; } } }
 var t = T[table.id],
  tbody = table.getElementsByTagName( 'tbody' )[0],
  newtbody = tbody.cloneNode( false ),
  rows = tbody.rows,
  newrows = [];
 i = rows.length; while (i--) {
  newrows[i] = rows[i].cloneNode( true );
 }

 var th=table.getElementsByTagName( 'thead' )[0].getElementsByTagName( 'th' )[t.curcol];
 th.className = th.className.replace( /\s?sorted/, '' );
 for( i = th.firstChild; i!==null; i = i.nextSibling ) {
  if( /\/sort-(up|down).gif$/.test( i.src || '' ) ) { th.removeChild( i ); break; }
 }

 if( newcol===t.curcol ) {
  t.curdir = t.curdir !== 'up' ? 'up' : 'down';
  newrows.reverse();
 } else {
  t.curcol = newcol; globcol = newcol;
  t.curdir = 'down';
  var h = ( e.how || '' ).toLowerCase(), how = window[ 'compare' + h.replace( /^r/, '' ) ];
  newrows.sort( typeof how==='function' ? how : compare );
  if( h.charAt()==='r' ) { newrows.reverse(); }
 }
 for( i=0; i<newrows.length; i++ ) {
  newtbody.appendChild( newrows[i] );
 }
 table.replaceChild( newtbody, tbody );
 sorticon( e, t.curdir );
 if( typeof t.rank==='number' ) { sortrank( table ); }
 if( typeof setcookie!=='undefined' ) {
  setcookie( 'sort' + table.id, newcol , 0, '/' );
 }
 eval(t.func);
}

function sortcursor( s, o ) { window.document.body.style.cursor = s; if( o ) { o.style.cursor = s; var a = o.getElementsByTagName('a'), i = a.length; while(i--) { a[i].style.cursor = s; } } }

function sorticon( o, dir ) {
 dir = dir || 'down';
 var i = window.document.createElement('img');
 i.src = 'http://4umi.com/image/icon/arrow/sort-' + dir + '.gif';
 i.width = 8;
 i.height = 8;
 i.alt = dir;
 i.style.position = 'absolute';
 i.style.padding = '1px';
// i.setAttribute( 'hspace', '1' );
// i.setAttribute( 'vspace', '1' );
 o.appendChild( i );
 o.className += ' sorted';
}

function sortrank( e ) {
 if( typeof e==='string' ) { e = window.document.getElementById(e); }
 var i, newcols = [], col = T[e.id].rank,
  rows = e.getElementsByTagName('tbody')[0].rows;
 i = rows.length; while (i--) {
  newcols[i] = rows[i].childNodes[col].cloneNode(true);
 }
 newcols.sort( function(a,b) { return parseInt( a.firstChild.nodeValue )-parseInt( b.firstChild.nodeValue ); } );
 i = rows.length; while (i--) {
  rows[i].replaceChild( newcols[i], rows[i].childNodes[col] );
 }
}

function gosortable( e, o ) { e = e||window.event||{}; o = o||e.srcElement||e.target; globo = o; sortcursor( 'wait', o ); window.setTimeout( 'sortable( globo ); sortcursor( \'\', globo );', 10 ); }

function cell( o ) { return o.childNodes[ globcol ] || ''; }

function comp( va, vb ) { return va===vb ? 0 : ( (!va && va!==0) || (va>vb && vb) ? 1 : -1); }

function compare(a, b) {
 var va = trim(gettext(cell(a))).toLowerCase();
 var vb = trim(gettext(cell(b))).toLowerCase();
 return comp( va, vb );
}
function comparecase(a, b) {
 var c = function(o) { return gettext(cell(o)); };
 return comp( c(a), c(b) );
}
function comparedate(a, b) {
 var c = function(o) { return Date.parse( gettext(cell(o)).replace( /\\/g, '/' ).replace( /[<>?]/g, '' ).replace( /'/, '20' ).replace(/^\s*(\d\d\d\d)\s*$/,'01/01/$1') ) || 0; };
 return comp( c(a), c(b) );
}
function comparehtml(a, b) {
 var c = function(o) { return cell(o).innerHTML; };
 return comp( c(a), c(b) );
}
function comparelength(a, b) {
 var c = function(o) { return gettext(cell(o)).length; };
 return comp( c(a), c(b) );
}
function comparemoney(a, b) {
 var c = function(o) { return parseFloat( '0' + gettext(cell(o)).replace( /[^\d\.]/g, '' ) ); };
 return comp( c(a), c(b) );
}
function comparename(a, b) {
 var reg = /^(d(e[lnrs]?|ella|i)|l[ae]|van(\sde[nr]?)?|von|te[nr]?|'s)\s+|o'/i;
 var va = gettext(cell(a)).replace(reg,''),
  vb = gettext(cell(b)).replace(reg,'');
 return comp( va, vb );
}
function comparenumber(a, b) {
 var c = function(o) { return parseFloat( gettext(cell(o)).replace(/,/g,'')||0 ); };
 return comp( c(a), c(b) );
}
function comparespan(a, b) {
 var c = function(o) { return parseFloat('0'+gettext(cell(o).getElementsByTagName('span')[0])); };
 return comp( c(a), c(b) );
}
function comparetime(a, b) {
 var va = gettext(cell(a)); while( va.length<9 ) { va='0'+va; }
 var vb = gettext(cell(b)); while( vb.length<9 ) { vb='0'+vb; }
 return comp( va, vb );
}
function comparetitle(a, b) {
 return comp( cell(a).title, cell(b).title );
}
function comparetitlenumber(a, b) {
 var c = function(o) { return parseFloat( cell(o).title.replace(/,/g,'') ); };
 return comp( c(a), c(b) );
}

function stickhead() {
 var d = window.document, a, b, c, i, x,
  y = ( typeof window.pageYOffset==='number' ? window.pageYOffset : d.documentElement && typeof d.documentElement.scrollTop==='number' ? d.documentElement.scrollTop : d.body.scrollTop );
 y -= parseInt( getstyle( window.document.body, 'margin-top' ), 10 );
 for( i in T ) {
  if( T[i].offtop!==false && ( a = d.getElementById( i ) ) ) {
   b = a; c = 0; do { c += b.offsetTop; } while ( ( b = b.offsetParent ) );
   if( ( b = a.getElementsByTagName( 'caption' )[0] ) ) { c += b.offsetHeight; }
   if( ( b = parseInt( getstyle( a.getElementsByTagName( 'th' )[0], 'border-width' ), 10 ) ) ) { c -= b; }
   c -= typeof T[i].offtop==='string' ? eval( T[i].offtop ) : T[i].offtop;
   x = Math.min( a.scrollHeight - 32, Math.max( 0, y - c-2 ) );
   b = a.getElementsByTagName( 'th' ); i = b.length;
   while(i--) { b[i].style.top = x + 'px'; }
  }
 }
 if( typeof beweeg==='function' ) { beweeg(); }
}

function addrank( id, col, str ) {
 col = col || 0;
 var d = window.document,
  th = d.createElement( 'th' ),
  td = d.createElement( 'td' ),
  a = d.getElementById( id ),
  row = a.getElementsByTagName( 'thead' )[0].rows[0],
  rows = a.getElementsByTagName( 'tbody' )[0].rows,
  b = a.getElementsByTagName( 'colgroup' ), i, j,
  start = parseInt( str, 10 )===0 ? 0 : parseInt( str, 10 ) || 1;
 if( b && ( i=b[0] ) && ( j=i.childNodes[col] ) ) {
  var c = d.createElement( 'col' ); c.className = 'rank'; i.insertBefore( c, j );
 }
 th.title = ' ' + row.childNodes.length + ' columns, \u000d ' + rows.length + ' rows. ';
 th.style.textAlign = 'center';
 if( !( T[id].offtop===false||T[id].offtop==='no' ) ) { th.style.position = 'relative'; }
 th.onclick = function() { window.scrollTo(0,0); };
 th.appendChild( d.createTextNode( str.replace( new RegExp( '^[\s0]*' + start + '\s*' ), '' ) || '#' ) );
 row.insertBefore( th, row.childNodes[col] );
 td.className = 'rank';
 td.style.textAlign = 'right';
 td.style.font = 'message-box';
 i = rows.length; while (i--) {
  j = td.cloneNode(true);
  j.appendChild( d.createTextNode( ( start + i ) + '.' ) );
  rows[i].insertBefore( j, rows[i].childNodes[col] );
 }
}

if(typeof trim==='undefined') { trim = function(s) { return s.replace( /^\s+|s+$/g, '' ); };}

if(typeof getstyle==='undefined') { getstyle = function(o,prop) {
 if(o.currentStyle) {
  prop = prop.replace(/-(\w)/, function( t, a ) { return a.toUpperCase(); } );
  return o.currentStyle[prop];  // backgroundColor
 }else if(window.getComputedStyle) {
  o = window.getComputedStyle( o, '' );
  return o.getPropertyValue(prop);  // background-color
 }
};}

if( typeof gettext==='undefined' ) { gettext = function(o) {
 var s = '', x = o.firstChild;
 if( x ) {
  for( ; x!==null; x = x.nextSibling ) {
   if( x.nodeType===3 ) {
    s += x.nodeValue;
   } else if( x.nodeType===1 ) {
    s += gettext( x );
   }
  }
 }else if(o.nodeValue) {
   s += o.nodeValue;
 }
 return s;
};}
