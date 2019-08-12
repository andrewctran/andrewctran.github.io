window.matchMedia||(window.matchMedia=function(){"use strict";var t=window.styleMedia||window.media;if(!t){var r=document.createElement("style"),e=document.getElementsByTagName("script")[0],n=null;r.type="text/css",r.id="matchmediajs-test",e.parentNode.insertBefore(r,e),n="getComputedStyle"in window&&window.getComputedStyle(r,null)||r.currentStyle,t={matchMedium:function(e){var t="@media "+e+"{ #matchmediajs-test { width: 1px; } }";return r.styleSheet?r.styleSheet.cssText=t:r.textContent=t,"1px"===n.width}}}return function(e){return{matches:t.matchMedium(e||"all"),media:e||"all"}}}()),function(r,s){"use strict";function n(e){for(var t,r,n,i,s,o=e||{},a=0,c=(t=o.elements||d.getAllElements()).length;a<c;a++)if(n=(r=t[a]).parentNode,i=undefined,s=undefined,r[d.ns]||(r[d.ns]={}),o.reevaluate||!r[d.ns].evaluated){if("PICTURE"===n.nodeName.toUpperCase()){if(d.removeVideoShim(n),!1===(i=d.getMatch(r,n)))continue}else i=undefined;("PICTURE"===n.nodeName.toUpperCase()||r.srcset&&!d.srcsetSupported||!d.sizesSupported&&r.srcset&&-1<r.srcset.indexOf("w"))&&d.dodgeSrcset(r),i?(s=d.processSourceSet(i),d.applyBestCandidate(s,r)):(s=d.processSourceSet(r),(r.srcset===undefined||r[d.ns].srcset)&&d.applyBestCandidate(s,r)),r[d.ns].evaluated=!0}}function e(){n();var e,t=setInterval(function(){n(),/^loaded|^i|^c/.test(s.readyState)&&clearInterval(t)},250);r.addEventListener&&r.addEventListener("resize",function(){r._picturefillWorking||(r._picturefillWorking=!0,r.clearTimeout(e),e=r.setTimeout(function(){n({reevaluate:!0}),r._picturefillWorking=!1},60))},!1)}if(r.HTMLPictureElement)r.picturefill=function(){};else{s.createElement("picture");var d={ns:"picturefill"};d.srcsetSupported="srcset"in s.createElement("img"),d.sizesSupported=r.HTMLImageElement.sizes,d.trim=function(e){return e.trim?e.trim():e.replace(/^\s+|\s+$/g,"")},d.endsWith=function(e,t){return e.endsWith?e.endsWith(t):-1!==e.indexOf(t,e.length-t.length)},d.restrictsMixedContent=function(){return"https:"===r.location.protocol},d.matchesMedia=function(e){return r.matchMedia&&r.matchMedia(e).matches},d.getDpr=function(){return r.devicePixelRatio||1},d.getWidthFromLength=function(e){return e=(e=e&&(0<parseFloat(e)||-1<e.indexOf("calc("))?e:"100vw").replace("vw","%"),d.lengthEl||(d.lengthEl=s.createElement("div"),s.documentElement.insertBefore(d.lengthEl,s.documentElement.firstChild)),d.lengthEl.style.cssText="position: absolute; left: 0; width: "+e+";",d.lengthEl.offsetWidth<=0&&(d.lengthEl.style.cssText="width: 100%;"),d.lengthEl.offsetWidth},d.types={},d.types["image/jpeg"]=!0,d.types["image/gif"]=!0,d.types["image/png"]=!0,d.types["image/svg+xml"]=s.implementation.hasFeature("http://www.w3.org/TR/SVG11/feature#Image","1.1"),d.types["image/webp"]=function(){var e=new r.Image,t="image/webp";e.onerror=function(){d.types[t]=!1,n()},e.onload=function(){d.types[t]=1===e.width,n()},e.src="data:image/webp;base64,UklGRh4AAABXRUJQVlA4TBEAAAAvAAAAAAfQ//73v/+BiOh/AAA="},d.verifyTypeSupport=function(e){var t=e.getAttribute("type");return null===t||""===t||("function"==typeof d.types[t]?(d.types[t](),"pending"):d.types[t])},d.parseSize=function(e){var t=/(\([^)]+\))?\s*(.+)/g.exec(e);return{media:t&&t[1],length:t&&t[2]}},d.findWidthFromSourceSize=function(e){for(var t,r=d.trim(e).split(/\s*,\s*/),n=0,i=r.length;n<i;n++){var s=r[n],o=d.parseSize(s),a=o.length,c=o.media;if(a&&(!c||d.matchesMedia(c))){t=a;break}}return d.getWidthFromLength(t)},d.parseSrcset=function(e){for(var t=[];""!==e;){var r,n=(e=e.replace(/^\s+/g,"")).search(/\s/g),i=null;if(-1!==n){if(","!==(r=e.slice(0,n))[r.length-1]&&""!==r||(r=r.replace(/,+$/,""),i=""),e=e.slice(n+1),null===i){var s=e.indexOf(",");-1!==s?(i=e.slice(0,s),e=e.slice(s+1)):(i=e,e="")}}else r=e,e="";(r||i)&&t.push({url:r,descriptor:i})}return t},d.parseDescriptor=function(e,t){var r,n=t||"100vw",i=e&&e.replace(/(^\s+|\s+$)/g,""),s=d.findWidthFromSourceSize(n);if(i)for(var o=i.split(" "),a=o.length+1;0<=a;a--)if(o[a]!==undefined){var c=o[a],l=c&&c.slice(c.length-1);if("h"!==l&&"w"!==l||d.sizesSupported){if("x"===l){var u=c&&parseFloat(c,10);r=u&&!isNaN(u)?u:1}}else r=parseFloat(parseInt(c,10)/s)}return r||1},d.getCandidatesFromSourceSet=function(e,t){for(var r=d.parseSrcset(e),n=[],i=0,s=r.length;i<s;i++){var o=r[i];n.push({url:o.url,resolution:d.parseDescriptor(o.descriptor,t)})}return n},d.dodgeSrcset=function(e){e.srcset&&(e[d.ns].srcset=e.srcset,e.removeAttribute("srcset"))},d.processSourceSet=function(e){var t=e.getAttribute("srcset"),r=e.getAttribute("sizes"),n=[];return"IMG"===e.nodeName.toUpperCase()&&e[d.ns]&&e[d.ns].srcset&&(t=e[d.ns].srcset),t&&(n=d.getCandidatesFromSourceSet(t,r)),n},d.applyBestCandidate=function(e,t){var r,n,i;e.sort(d.ascendingSort),i=e[(n=e.length)-1];for(var s=0;s<n;s++)if((r=e[s]).resolution>=d.getDpr()){i=r;break}i&&!d.endsWith(t.src,i.url)&&(d.restrictsMixedContent()&&"http:"===i.url.substr(0,"http:".length).toLowerCase()?typeof console!==undefined&&console.warn("Blocked mixed content image "+i.url):(t.src=i.url,t.currentSrc=t.src))},d.ascendingSort=function(e,t){return e.resolution-t.resolution},d.removeVideoShim=function(e){var t=e.getElementsByTagName("video");if(t.length){for(var r=t[0],n=r.getElementsByTagName("source");n.length;)e.insertBefore(n[0],r);r.parentNode.removeChild(r)}},d.getAllElements=function(){for(var e=[],t=s.getElementsByTagName("img"),r=0,n=t.length;r<n;r++){var i=t[r];("PICTURE"===i.parentNode.nodeName.toUpperCase()||null!==i.getAttribute("srcset")||i[d.ns]&&null!==i[d.ns].srcset)&&e.push(i)}return e},d.getMatch=function(e,t){for(var r,n=t.childNodes,i=0,s=n.length;i<s;i++){var o=n[i];if(1===o.nodeType){if(o===e)return r;if("SOURCE"===o.nodeName.toUpperCase()){null!==o.getAttribute("src")&&typeof console!==undefined&&console.warn("The `src` attribute is invalid on `picture` `source` element; instead, use `srcset`.");var a=o.getAttribute("media");if(o.getAttribute("srcset")&&(!a||d.matchesMedia(a))){var c=d.verifyTypeSupport(o);if(!0===c){r=o;break}if("pending"===c)return!1}}}}return r},e(),n._=d,"object"==typeof module&&"object"==typeof module.exports?module.exports=n:"function"==typeof define&&define.amd?define(function(){return n}):"object"==typeof r&&(r.picturefill=n)}}(this,this.document);