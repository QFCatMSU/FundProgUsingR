smallImageHeight=100,imageHeight=new Array,imageWidth=new Array,minImageWidth=700,scrollTopPosition=0,overflowCalled=!1,editURL="",referenceTimer="",scrollFlag=0,redNum=-1,instructorEmail="Charlie Belinsky <belinsky@msu.edu>;",lessonFolder="",addStyleSheet(),window.parent.addEventListener("resize",resizeIframeContent()),longClickTimer=null,overRCMenu=!1,mouseX=0,mouseY=0;var script=document.createElement("script");function activateNotification(e,t){encapObject.querySelector("#notification")?clearInterval(notifTimer):(notifDiv=document.createElement("div"),notifDiv.id="notification",notifDiv.classList.add("rcMenu"),encapObject.appendChild(notifDiv)),"code"==t?(notifDiv.innerHTML="Codeblock copied to clipboard",displayTime=1e3):"scroll"==t&&(notifDiv.innerHTML="Hold left mouse button to return to previous location",displayTime=2e3),activateElement(e,notifDiv,-2),notifTimer=setTimeout(function(){notifDiv.style.visibility="hidden",notifDiv.style.top="0px"},displayTime)}function activateElement(e,t,n=5){var[,i]=getIframeOffset();rcMenuDim=t.getBoundingClientRect(),window.innerWidth-e.clientX<rcMenuDim.width?t.style.left=window.scrollX+e.clientX-rcMenuDim.width+n+"px":t.style.left=window.scrollX+e.clientX-n+"px",window.innerHeight-e.clientY<rcMenuDim.height||window.parent.scrollY+window.parent.innerHeight-i-e.clientY<rcMenuDim.height?t.style.top=window.scrollY+e.clientY-rcMenuDim.height+n+"px":t.style.top=window.scrollY+e.clientY-n+"px",t.style.visibility="visible"}function getClassInfoD2L(){755411==redNum||704361==redNum||457124==redNum?instructorEmail="Charlie Belinsky <belinsky@msu.edu>;":748323==redNum?instructorEmail="Travis Brenden <brenden@msu.edu>;":942384==redNum?instructorEmail="Jim Bence <bence@msu.edu>;":931321==redNum?instructorEmail="Mike Jones <jonesm30@msu.edu>;":952618==redNum&&(instructorEmail="Juan Steibel <steibelj@msu.edu>;")}function resizeIframeContent(){parentIFrames=window.parent.document.getElementsByTagName("iframe"),parentIFrames[0]&&parentIFrames[0].contentWindow.document.body&&(parentIFrames[0].height=parentIFrames[0].contentWindow.document.body.scrollHeight),0==overflowCalled?overflowCalled=!0:clearTimeout(overFlowTimer),overFlowTimer=setTimeout(function(){overflowCodeLines()},500)}function loadMathML(){var e=document.createElement("script");e.onload=function(){mathEdit()},e.src="/content/DEVELOPMENT/2018/courses/DEV-belinsky-2018-BackendTest/Programming/eqTest/MathML2.js",document.head.appendChild(e)}function joomlaFixes(){containers=document.querySelectorAll("div.container"),containers[0].style.backgroundColor="#003c3c",containers[0].style.padding="9px",itemPropDiv=document.querySelectorAll("div[itemprop]"),1==itemPropDiv.length&&(encapObject=itemPropDiv[0],theURL=window.location.href,lastSlashIndex=theURL.lastIndexOf("/"),editURL=theURL.substring(0,lastSlashIndex),pageID=theURL.substring(lastSlashIndex+1,theURL.indexOf("-")),editURL=editURL+"?view=form&layout=edit&a_id="+pageID),encapObject.style.backgroundColor="rgb(0,60,60)"}function d2lFixes(){oldURL=String(window.parent.location),editURL=oldURL.split("?")[0],editURL=editURL.replace("viewContent","contentFile"),editURL=editURL.replace("View","EditFile?fm=0"),parent.document.querySelector(".d2l-page-header")&&(parent.document.querySelector(".d2l-page-header").style.display="none"),parent.document.querySelector(".d2l-page-collapsepane-container")&&(parent.document.querySelector(".d2l-page-collapsepane-container").style.display="none"),parent.document.querySelector(".d2l-page-main-padding")&&(parent.document.querySelector(".d2l-page-main-padding").style.padding="0")}function d2lAddHeader(){if(prevPage=document.body.children[0],prevPage&&"P"==prevPage.tagName&&(""!=prevPage.innerText.trim()&&(prevText="Previously: "+prevPage.innerText),prevPage.parentNode.removeChild(prevPage)),nextPage=document.body.children[0],nextPage&&"P"==nextPage.tagName&&(""!=nextPage.innerText.trim()&&(nextText="Up Next: "+nextPage.innerText),nextPage.parentNode.removeChild(nextPage)),self!=top)divTop=document.createElement("div"),divTop.classList.add("headerDiv"),encapObject.prepend(divTop),url=window.parent.location.href,classNum=url.match(/\/[0-9]{3,}\//),redNum=classNum[0].substring(1,classNum[0].length-1),homePage=document.createElement("span"),homePage.classList.add("lessonLink","sameWin","homePage"),homeLink=document.createElement("a"),homeLink.innerHTML="Home",homeLink.href="https://d2l.msu.edu/d2l/home/"+redNum,homeLink.target="_parent",homePage.appendChild(homeLink),divTop.appendChild(homePage),"undefined"!=typeof prevText&&(url=window.parent.document.getElementsByClassName("d2l-iterator-button-prev"),newPrevPage=document.createElement("span"),newPrevPage.classList.add("lessonLink","sameWin","previousLesson"),newPrevPageLink=document.createElement("a"),newPrevPageLink.innerHTML=prevText,newPrevPageLink.href=url[0].href,newPrevPageLink.target="_parent",newPrevPage.appendChild(newPrevPageLink),divTop.insertBefore(newPrevPage,homePage)),"undefined"!=typeof nextText&&(url=window.parent.document.getElementsByClassName("d2l-iterator-button-next"),newNextPage=document.createElement("span"),newNextPage.classList.add("lessonLink","sameWin","nextLesson"),newNextPageLink=document.createElement("a"),newNextPageLink.innerHTML=nextText,newNextPageLink.href=url[0].href,newNextPageLink.target="_parent",newNextPage.appendChild(newNextPageLink),divTop.insertBefore(newNextPage,homePage));else for(lessonLinks=encapObject.querySelectorAll(".previousLesson, .nextLesson, .nl, .pl"),i=0;i<lessonLinks.length;i++)lessonLinks[i].style.display="none"}function setClassNames(){for(p=encapObject.getElementsByClassName("p"),i=0;i<p.length;i++)p[i].classList.add("partial");for(nn=encapObject.getElementsByClassName("nn"),i=0;i<nn.length;i++)nn[i].classList.add("nonum","partial")}function fixTitle(){titleObj=encapObject.querySelector("h1"),titleObj?(window.document.title=titleObj.textContent,printLink=document.createElement("a"),printLink.classList.add("sameWin"),printLink.href="javascript:window.print()",printLink.style.marginLeft="9px",printLink.innerHTML="&#9113",titleObj.appendChild(printLink)):window.document.title="No Title"}function removeDivs(){for(notMathJax="DIV:not([class*='MathJax']) DIV:not([id*='MathJax'])",divElements=encapObject.querySelectorAll(notMathJax);0<divElements.length;)divContent=divElements[divElements.length-1].innerHTML,divElements[divElements.length-1].insertAdjacentHTML("beforebegin",divContent),divElements[divElements.length-1].parentElement.removeChild(divElements[divElements.length-1])}function createFlexImages(){var e=encapObject.querySelectorAll("img.flexSize, img.fs"),t=encapObject.querySelectorAll("video.flexSize, video.fs"),n=encapObject.querySelectorAll("p.fs > iframe, p.flexsize > iframe");for(i=0;i<e.length;i++)e[i].addEventListener("click",function(){changeImageSize(this)},!1),e[i].myIndex=i,imageHeight[i]=e[i].naturalHeight,imageWidth[i]=e[i].naturalWidth,changeImageSize(e[i],"minimize");for(let e=0;e<t.length;e++){var l=t[e].height,o=t[e].width;t[e].width=smallImageHeight*o/l,t[e].height=smallImageHeight,t[e].addEventListener("play",function(){this.width=o,this.height=l}),t[e].addEventListener("ended",function(){this.width=smallImageHeight*o/l,this.height=smallImageHeight})}for(let e=0;e<n.length;e++){var a=n[e].height,r=n[e].width;n[e].height=smallImageHeight,n[e].width=smallImageHeight*r/a,resizeButton=document.createElement("span"),resizeButton.classList.add("flexButton"),resizeButton.classList.add("noSelect"),resizeButton.innerText="🡆",resizeButton.addEventListener("click",function(){n[e].width!=r?(n[e].width=r,n[e].height=a,n[e].src=n[e].src,this.innerText="🡄"):(n[e].width=smallImageHeight*r/a,n[e].height=smallImageHeight,this.innerText="🡆")}),n[e].parentElement.appendChild(resizeButton)}}function changeImageSize(e,t="none"){imageIndex=e.myIndex,origHeight=imageHeight[imageIndex],origWidth=imageWidth[imageIndex],e.style.height==smallImageHeight+"px"&&"minimize"!=t?(screenWidth=e.parentElement.clientWidth,screenWidth<minImageWidth&&(screenWidth=minImageWidth),origWidth<=screenWidth?(e.style.width=origWidth+"px",e.style.height=origHeight+"px"):(e.style.width=screenWidth+"px",e.style.height=screenWidth/origWidth*origHeight+"px")):"maximize"!=t&&(e.style.height=smallImageHeight+"px",e.style.width=smallImageHeight/origHeight*origWidth+"px")}function addDivs(){for(elements=encapObject.querySelectorAll("H1, H2, H3"),i=0;i<elements.length;i++){for(currentElement=elements[i],nextSibling=null,newDiv=document.createElement("div"),""!=elements[i].title?newDiv.dataTitle=elements[i].title:newDiv.dataTitle=elements[i].innerText,elements[i].parentNode.insertBefore(newDiv,elements[i]);null!=currentElement.nextElementSibling&&"H1"!=currentElement.nextElementSibling.tagName&&"H2"!=currentElement.nextElementSibling.tagName&&"H3"!=currentElement.nextElementSibling.tagName&&!currentElement.nextElementSibling.classList.contains("h1Div")&&!currentElement.nextElementSibling.classList.contains("h2Div")&&!currentElement.nextElementSibling.classList.contains("h3Div");)nextSibling=currentElement.nextElementSibling,newDiv.appendChild(currentElement),currentElement=nextSibling;"H1"==elements[i].tagName?newDiv.classList.add("h1Div"):"H2"==elements[i].tagName?(newDiv.classList.add("h2Div","contentDiv"),""!=elements[i].className&&(elements[i].classList.contains("trap")||elements[i].classList.contains("extension")||elements[i].classList.contains("shortcut"))&&newDiv.classList.add("nonlinear")):"H3"==elements[i].tagName&&(newDiv.classList.add("h3Div","contentDiv"),newDiv.previousElementSibling&&""!=newDiv.previousElementSibling.className&&newDiv.previousElementSibling.classList.contains("nonlinear")&&newDiv.classList.add("nonlinear")),null==currentElement.nextElementSibling||"H2"==currentElement.nextElementSibling.tagName||currentElement.nextElementSibling.classList.contains("h2Div")?newDiv.classList.add("h2NextDiv"):"H3"!=currentElement.nextElementSibling.tagName&&!currentElement.nextElementSibling.classList.contains("h3Div")||newDiv.classList.add("h3NextDiv"),newDiv.appendChild(currentElement)}}function addOutline(){for(level1=0,level2=0,divElement=encapObject.getElementsByTagName("div"),i=0;i<divElement.length;i++)if(divElement[i].firstChild&&"H2"==divElement[i].firstChild.tagName)level1++,level2=0,divElement[i].firstChild.insertAdjacentHTML("afterbegin",level1+" - "),divElement[i].dataTitle=divElement[i].firstChild.textContent;else if(divElement[i].firstChild&&"H3"==divElement[i].firstChild.tagName)for(level2++,divElement[i].firstChild.insertAdjacentHTML("afterbegin",level1+"."+level2+" - "),divElement[i].dataTitle=divElement[i].firstChild.textContent,h4Elements=divElement[i].getElementsByTagName("H4"),level3=0,j=0;j<h4Elements.length;j++)level3++,h4Elements[j].insertAdjacentHTML("afterbegin",level1+"."+level2+"."+level3+" - "),h4Elements[j].dataTitle=h4Elements[j].textContent}function changeAllPicSize(e){var t=encapObject.querySelectorAll(".flexSize, .fs");for(i=0;i<t.length;i++)changeImageSize(t[i],e)}function goBackToPrevLocation(){leftPos=window.parent.scrollX,prevLocLink=document.getElementById("previousLocMenuItem"),prevLocLink.classList.add("disabledLink"),window.parent.scrollTo(leftPos,scrollTopPosition)}function addStyleSheet(){var e=document.createElement("link");for(scripts=document.getElementsByTagName("script"),i=0;i<scripts.length;i++)jsIndex=scripts[i].src.indexOf("module.js"),-1!=jsIndex&&(cssFile=scripts[i].src.substring(0,jsIndex)+"module.css");e.href=cssFile,e.type="text/css",e.rel="stylesheet",e.media="screen,print",document.getElementsByTagName("head")[0].appendChild(e)}function equationNumbering(){var e=encapObject.querySelectorAll("span[style*='dotum']");for(i=0;i<e.length;i++)e[i].classList.add("eqNum");var t=encapObject.getElementsByClassName("eqNum");for(i=0;i<t.length;i++)""!=t[i].textContent.trim()&&(t[i].style.display="inline-flex",eqNumber=document.createElement("span"),eqNumber.textContent=" ( "+(i+1)+" )",eqNumber.style.fontSize="14px",eqNumber.style.alignSelf="center",eqNumber.style.whiteSpace="nowrap",t[i].appendChild(eqNumber))}function addCaptions(){var e=encapObject.querySelectorAll("h5, .fig");for(i=0;i<e.length;i++)e[i].classList.contains("eqNum")||e[i].classList.add("caption");for(e=encapObject.getElementsByClassName("caption"),i=0;i<e.length;i++)""!=e[i].innerText.trim()&&e[i].insertAdjacentHTML("afterbegin","Fig "+(i+1)+": ")}function addCodeTags(e){var t=encapObject.getElementsByTagName(e);for(numCodeTags=t.length,i=0;i<numCodeTags;i++)if(codeElement=t[i],0<t[i].getElementsByTagName("br").length){numLines=t[i].getElementsByTagName("br").length+1;var n=new Array;for(j=0;j<numLines;j++)n[j]=t[i].innerHTML.split("<br>")[j];for(j=0;j<numLines;j++)newElement=document.createElement(e),newElement.innerHTML=n[j],0==j&&(newElement.title=t[i].title,newElement.classList=t[i].classList),codeElement.parentElement.insertBefore(newElement,codeElement);codeElement.parentElement.removeChild(codeElement),numCodeTags=t.length,i=i+numLines-1}for(firstLine=!0,i=0;i<t.length;i++)t[i].classList.add("code"),t[i].classList.contains("firstLine")&&t[i].classList.remove("firstLine"),t[i].classList.contains("lastLine")&&t[i].classList.remove("lastLine"),1==firstLine&&(codeBlockDiv=document.createElement("div"),!t[i].classList.contains("partial")&&0==t[i].querySelectorAll(".partial").length||codeBlockDiv.classList.add("partial"),!t[i].classList.contains("nonum")&&0==t[i].querySelectorAll(".nonum").length||codeBlockDiv.classList.add("nonum"),!t[i].classList.contains("text")&&0==t[i].querySelectorAll(".text").length||codeBlockDiv.classList.add("text"),(t[i].classList.contains("brackets")||t[i].classList.contains("bx")||0!=t[i].querySelectorAll(".brackets").length||0!=t[i].querySelectorAll(".bx").length)&&codeBlockDiv.classList.add("brackets"),""!=t[i].title.trim()&&(codeBlockDiv.title=t[i].title),codeBlockDiv.classList.add("codeBlock"),codeBlockDiv.addEventListener("dblclick",function(e){document.getSelection().selectAllChildren(this),document.execCommand("copy"),activateNotification(e,"code")}),codeBlockDiv.addEventListener("scroll",function(e){clearInterval(longClickTimer)}),codeBlockDiv.addEventListener("copy",function(e){var t=document.getSelection().trimEnd().toString();const n=e.clipboardData;n.setData("text/plain",t),e.preventDefault()}),t[i].parentElement.insertBefore(codeBlockDiv,t[i]),codeBlockDiv.classList.contains("brackets")?(startCodeLine=document.createElement(e),startCodeLine.setAttribute("data-text","{"),startCodeLine.classList.add("code","firstLine","noSelect","noCode"),codeBlockDiv.appendChild(startCodeLine),i++):t[i].classList.add("firstLine"),""==codeBlockDiv.title||isNaN(t[i].title)||(codeBlockDiv.style.counterReset="codeLines "+(t[i].title-1)),firstLine=!1),""==t[i].innerText&&(t[i].innerText=" "),codeBlockDiv.classList.contains("brackets")&&t[i].insertAdjacentHTML("afterbegin","  "),null==t[i].nextElementSibling||t[i].nextElementSibling.tagName!=e?(codeBlockDiv.classList.contains("brackets")?(codeBlockDiv.appendChild(t[i]),lastCodeLine=document.createElement(e),lastCodeLine.setAttribute("data-text","}"),lastCodeLine.classList.add("code","lastLine","noSelect","noCode"),codeBlockDiv.appendChild(lastCodeLine),i++):(t[i].classList.add("lastLine"),codeBlockDiv.appendChild(t[i])),firstLine=!0):codeBlockDiv.appendChild(t[i])}function addCodeBlockTag(){for(codeBlockDivs=encapObject.querySelectorAll(".codeBlock"),i=0;i<codeBlockDivs.length;i++)(codeBlockTitle="")!=codeBlockDivs[i].title.trim()&&isNaN(codeBlockDivs[i].title.trim())?codeBlockTitle=codeBlockDivs[i].title:(cbChild=codeBlockDivs[i].querySelector("[title]"),cbChild&&""!=cbChild.title.trim()&&isNaN(cbChild.title.trim())&&(codeBlockTitle=cbChild.title)),""!=codeBlockTitle&&(par=document.createElement("p"),par.classList.add("noSelect"),par.style.textAlign="left",tabSpan=document.createElement("span"),tabSpan.classList.add("codeBlockTab","noSelect","noCode","nonum"),tabSpan.setAttribute("data-text",codeBlockTitle),par.appendChild(tabSpan),codeBlockDivs[i].insertBefore(par,codeBlockDivs[i].children[0]))}function overflowCodeLines(){if(codeLines=document.getElementsByClassName("code"),0<codeLines.length)for(elem=encapObject.querySelector(".code"),style=getComputedStyle(elem),lineHeight=parseInt(style.lineHeight),i=0;i<codeLines.length;i++)if(actualHeight=codeLines[i].getBoundingClientRect().height,lineHeightMult=Math.round(actualHeight/lineHeight),numArrows=codeLines[i].querySelectorAll("span.overflowArrow"),lineHeightMult!=numArrows.length+1){for(j=0;j<numArrows.length;j++)codeLines[i].removeChild(numArrows[j]);if(1<lineHeightMult)for(j=1;j<lineHeightMult;j++)arrowObj=document.createElement("span"),arrowObj.classList.add("overflowArrow"),arrowObj.innerHTML="&#x2937;",arrowObj.style.top=codeLines[i].offsetTop+j*lineHeight+"px",arrowObj.style.left=codeLines[i].offsetLeft+80+"px",codeLines[i].appendChild(arrowObj)}overFlowTimer=!1}function goToTopOfPage(){scrollTopPosition=window.parent.scrollY,window.parent.scrollTo(window.parent.scrollX,0),enablePrevious()}function makeContextMenu(e,t){var n=document.createElement("div");n.id="longClickMenu",n.classList.add("rcMenu"),n.addEventListener("mouseenter",function(){overRCMenu=!0}),n.addEventListener("mouseleave",function(){overRCMenu=!1});var l=document.createElement("a");for(n.innerHTML="<b>Shortcut Menu</b>",n.style.display="block",n.classList.add("sameWin","noSelect"),n.appendChild(l),editButton=parent.document.querySelectorAll("button.d2l-button"),hasEditAccess=!1,i=0;i<editButton.length;i++)editButton[i].textContent.includes("Edit HTML")&&(hasEditAccess=!0);1==hasEditAccess&&(oldURL=String(window.parent.location),newURL=oldURL.replace("viewContent","contentFile"),newURL=newURL.replace("View","EditFile?fm=0"),menuLinks(n,"Edit Page",function(){window.open(newURL,"_blank")},"editPage")),menuLinks(n,"Return to previous location",goBackToPrevLocation,"previousLocMenuItem",!1),menuLinks(n,"Go to Top of Page",goToTopOfPage,"topMenuItem"),menuLinks(n,"Print/ Save as PDF",function(){document.getElementById("longClickMenu").style.visibility="hidden",window.print()},"printToPDF"),menuLinks(n,"Maximize All Images",function(){changeAllPicSize("maximize")},"maxAllImages"),menuLinks(n,"Minimize All Images",function(){changeAllPicSize("minimize")},"minAllImages"),encapObject.appendChild(n)}function menuLinks(e,t,n,i="",l=!0){spanEncap=document.createElement("span"),spanEncap.style.display="block",link=document.createElement("a"),l||link.classList.add("disabledLink"),link.id=i,link.innerText=t,link.classList.add("sameWin","jsLink"),link.addEventListener("mouseup",function(e){n(),document.getElementById("longClickMenu").style.visibility="hidden",document.getElementById("longClickMenu").style.top="0px"}),spanEncap.appendChild(link),e.appendChild(spanEncap)}function scrollToElementReturn(e){return function(){scrollToElement(e)}}function copySelectedText(){window.getSelection&&(window.getSelection().toString(),a=document.execCommand("copy"))}function addDownloadLinks(){for(downloadLinks=encapObject.getElementsByClassName("download"),i=0;i<downloadLinks.length;i++)downloadLinks[i].download=""}function fixBlockReferences(){var e=encapObject.querySelectorAll(".ref");for(i=0;i<e.length;i++)displayType=window.getComputedStyle(e[i],"").display,"block"!=displayType&&"list-item"!=displayType||(newRef=document.createElement("span"),newRef.innerHTML=e[i].innerHTML,newRef.id=e[i].id,newRef.classList.add("ref"),e[i].innerHTML="",e[i].id="",e[i].classList.remove("ref"),e[i].appendChild(newRef))}function addReferences(){fixBlockReferences();var e=encapObject.querySelectorAll(".sectRef, .figureRef, .eqRef, .linkTo");for(i=0;i<e.length;i++)e[i].classList.add("ref");var t,e=encapObject.querySelectorAll(".ref, .reference");for(i=0;i<e.length;i++)fullRefID=e[i].id,refID=fullRefID.slice(2),""==fullRefID||""==e[i].innerText.trim()||(0==isValid(refID)?(e[i].classList.add("error"),e[i].innerText="**Invalid characters in ID: "+e[i].innerText+"** "):0==isNaN(refID[0])?(e[i].classList.add("error"),e[i].innerText="**Cannot start ID with number: "+e[i].innerText+"** "):e[i].hasAttribute("href")?e[i].href.includes("?")?e[i].href=e[i].href+"&ref="+refID:e[i].href=e[i].href+"?ref="+refID:""!=e[i].title?(url=window.location.protocol+"//"+window.location.hostname+window.location.pathname,n=url.lastIndexOf("/"),lessonFolder=url.substr(0,n+1),newLessonURL=lessonFolder+e[i].title+"#"+refID,e[i].addEventListener("click",function(){window.open(newLessonURL)})):encapObject.querySelector("#"+refID)?""==encapObject.querySelector("#"+refID).innerText.trim()?(e[i].classList.add("error"),e[i].innerText="**No content at link: "+e[i].innerText+"** "):encapObject.querySelector("#"+refID).classList.contains("eqNum")?(caption=encapObject.querySelector("#"+refID).innerText,eqRef=parseInt(caption.slice(caption.lastIndexOf("(")+1)),addNumToReference(e[i],eqRef)):"h5"==encapObject.querySelector("#"+refID).nodeName.toLowerCase()||encapObject.querySelector("#"+refID).classList.contains("fig")?(caption=encapObject.querySelector("#"+refID).innerText,strIndex=caption.indexOf(":"),figRef=caption.slice(4,strIndex),addNumToReference(e[i],figRef)):"h2"==encapObject.querySelector("#"+refID).nodeName.toLowerCase()||"h3"==encapObject.querySelector("#"+refID).nodeName.toLowerCase()||"h4"==encapObject.querySelector("#"+refID).nodeName.toLowerCase()?(sectNum=parseFloat(encapObject.querySelector("#"+refID).innerText),addNumToReference(e[i],sectNum)):"h6"==encapObject.querySelector("#"+refID).nodeName.toLowerCase()||"code"==encapObject.querySelector("#"+refID).nodeName.toLowerCase()?(cl=encapObject.querySelector("#"+refID),clParent=cl.parentNode,lineNum=Array.prototype.indexOf.call(clParent.children,cl),cl.parentNode.title&&!isNaN(cl.parentNode.title)&&(lineNum+=parseInt(cl.parentNode.title)),addNumToReference(e[i],lineNum)):(refObject=encapObject.querySelector("#"+refID),parentObj=refObject.parentNode.nodeName.toLowerCase(),refNum=-1,parentObj&&"h5"==parentObj?(strIndex=caption.indexOf(":"),refNum=parentObj.innerText.slice(0,strIndex)):parentObj&&parentObj.firstElementChild&&"div"==parentObj&&("h2"==parentObj.firstElementChild.nodeName.toLowerCase()||"h3"==parentObj.firstElementChild.nodeName.toLowerCase()||"h4"==parentObj.firstElementChild.nodeName.toLowerCase())?(strIndex=caption.indexOf("-"),refNum=parentObj.firstElementChild.innerText.slice(0,strIndex-2)):parentObj.parentNode&&(grandParent=parentObj.parentNode.nodeName.toLowerCase(),"div"!=grandParent||"h2"!=grandParent.firstElementChild.nodeName.toLowerCase()&&"h3"!=grandParent.firstElementChild.nodeName.toLowerCase()&&"h4"!=grandParent.firstElementChild.nodeName.toLowerCase()||(strIndex=caption.indexOf("-"),refNum=parentObj.firstElementChild.innerText.slice(0,strIndex-2))),-1!=refNum&&(str=e[i].innerText,t=str.lastIndexOf("##"),e[i].innerText=str.substring(0,t)+eqRef+str.substring(t+2)),e[i].classList.contains("nolink")||e[i].addEventListener("click",scrollToElementReturn(refID))):(e[i].classList.add("error"),e[i].innerText="**Invalid Link: "+e[i].innerText+"** "))}function addNumToReference(e,t){var n;refIndex=e.innerText.indexOf("##"),-1!=refIndex&&(str=e.innerText,n=str.lastIndexOf("##"),e.innerText=str.substring(0,n)+t+str.substring(n+2)),e.classList.contains("nolink")||e.addEventListener("click",scrollToElementReturn(refID))}function checkURLForPos(){var e=parent.window.location.href,e=new URL(e).searchParams.get("ref");null!=e&&scrollToElement(e)}function scrollToElement(e,t){var n=encapObject.querySelector("#"+e),i=window.parent.innerHeight,l=window.parent.scrollY,o=0,[,e]=getIframeOffset();n.classList.contains("code")&&n.parentNode.scrollHeight>n.parentNode.clientHeight&&((n.offsetTop<n.parentNode.scrollTop||n.offsetTop>n.parentNode.scrollTop+n.parentNode.offsetHeight)&&(n.parentNode.scrollTop=n.offsetTop-20),o=n.parentNode.scrollTop),elementYPos=n.offsetParent.offsetTop+n.offsetTop+e-o,elementYPos<l||elementYPos>l+2*i?(offsetPadding=n.classList.contains("caption")?200:50,scrollTopPosition=window.parent.scrollY,window.parent.scrollTo(n.offsetLeft,elementYPos-offsetPadding),scrollFlag+=1,scrollFlag<=2&&activateNotification(event,"scroll"),enablePrevious()):elementYPos>l+i&&elementYPos<l+2*i&&(offsetPadding=i-200,scrollTopPosition=window.parent.scrollY,window.parent.scrollTo(n.offsetLeft,elementYPos-offsetPadding),enablePrevious()),highLightObject(n,2e3)}function highLightObject(e,t=2e3){encapObject.querySelector(".refObjHighlight")&&(encapObject.querySelector(".refObjHighlight").classList.remove("refObjHighlight"),clearInterval(referenceTimer)),e.classList.add("refObjHighlight"),referenceTimer=setTimeout(function(){e.classList.remove("refObjHighlight")},t)}function getIframeOffset(){if(offsetLeft=0,offsetTop=0,window.self!==window.top)for(parentIFrames=window.parent.document.getElementsByTagName("iframe"),i=0;i<parentIFrames.length;i++)if(window.location.href==parentIFrames[i].src){offsetLeft=parentIFrames[i].offsetLeft,offsetTop=parentIFrames[i].offsetTop;break}return[offsetLeft,offsetTop]}function enablePrevious(){prevLocLink=document.getElementById("previousLocMenuItem"),prevLocLink.classList.remove("disabledLink")}function linksToNewWindow(){for(links=encapObject.querySelectorAll("a[href]"),i=0;i<links.length;i++)""==links[i].href.trim()||links[i].classList.contains("sameWin")||links[i].classList.contains("download")||"_self"!=links[i].target&&links[i].target||(links[i].target="_blank")}function createEmailLink(){for(emailLink=encapObject.getElementsByClassName("email"),i=0;i<emailLink.length;i++)emailLink[i].addEventListener("click",function(){openEmailWindow(this.title)})}function openEmailWindow(e){emailWindow=window.open("https://d2l.msu.edu/d2l/le/email/"+redNum+"/ComposePopup"),emailWindow.onload=function(){header=emailWindow.document.body.querySelector(".vui-heading-1"),header.innerText="Send Message to Instructor",addressControl=emailWindow.document.getElementById("ToAddresses$control"),addressControl.click(),address=emailWindow.document.getElementById("ToAddresses"),address.focus(),""==e&&(e=instructorEmail),address.value=e,subject=emailWindow.document.getElementById("Subject"),subject.value=window.document.title}}function fixIframeSize(){iFrame=window.parent.document.getElementsByClassName("d2l-iframe"),iFrame[0]&&(iFrame[0].style.height=document.documentElement.scrollHeight+"px",setTimeout(function(){iFrame[0].style.height=document.documentElement.scrollHeight+"px"},9e3))}function isValid(e){return!/[~`!#$%\^&*+=\[\]\\';,/{}|\\":<>\?]/g.test(e)}function createTextBox(){for(textLine=encapObject.querySelectorAll("address"),firstLine=!0,lastLine=!1,i=0;i<textLine.length;i++)1==firstLine&&(textBoxDiv=document.createElement("div"),textBoxDiv.classList.add("textBox"),textBoxParent=textLine[i].parentNode,textBoxParent.insertBefore(textBoxDiv,textLine[i]),firstLine=!1),textLine[i].nextElementSibling&&"ADDRESS"==textLine[i].nextElementSibling.tagName||(firstLine=!0),textBoxDiv.appendChild(textLine[i])}function captionFigures(){for(captions=encapObject.querySelectorAll(".caption"),i=0;i<captions.length;i++)prevSibling=captions[i].previousElementSibling,"figure"==prevSibling.tagName.toLowerCase()||prevSibling.classList.contains("caption")||(figureCaption=document.createElement("figcaption"),figureCaption.classList=captions[i].classList,figureCaption.innerHTML=captions[i].innerHTML,figureCaption.id=captions[i].id,figureElement=document.createElement("figure"),prevSibling.parentNode.insertBefore(figureElement,prevSibling),figureElement.appendChild(prevSibling),figureElement.appendChild(figureCaption),captions[i].parentNode.removeChild(captions[i]))}script.type="text/javascript",script.id="MathJax-script",script.src="https://cdn.jsdelivr.net/npm/mathjax@3.1.2/es5/tex-mml-svg.js",script.async="async",document.head.appendChild(script),window.addEventListener("mousedown",function(e){1!=e.which||document.querySelector("#MathJax_MenuFrame")||(longClickTimer=setTimeout(function(){activateElement(e,encapObject.querySelector("#longClickMenu")),overRCMenu=!0,encapObject.style.userSelect="none",encapObject.style.msUserSelect="none"},350),mouseX=parseInt(e.clientX),mouseY=parseInt(e.clientY))}),window.addEventListener("mouseup",function(){clearInterval(longClickTimer),overRCMenu||(encapObject.querySelector("#longClickMenu").style.visibility="hidden",encapObject.querySelector("#longClickMenu").style.top="0px",encapObject.style.userSelect="",encapObject.style.msUserSelect="")}),window.addEventListener("mousemove",function(e){mouseMoveX=Math.abs(parseInt(e.clientX)-mouseX),mouseMoveY=Math.abs(parseInt(e.clientY)-mouseY),(10<mouseMoveX||10<mouseMoveY)&&clearInterval(longClickTimer)}),parent.window.onload=function(){for(encapObject=document.body,0<document.querySelectorAll('meta[content^="Joomla"]').length&&joomlaFixes(),"d2l.msu.edu"==window.location.hostname&&(d2lFixes(),d2lAddHeader()),bq=document.getElementsByTagName("blockquote"),i=0;i<bq.length;i++)para=bq[i].getElementsByTagName("p"),0<para.length&&(html=bq[i].innerHTML,html=html.trim(),html=html.replace(/(?:\r\n|\r|\n)/g,""),html=html.replace(/<\/p>\n/g,"</p>"),html=html.replace(/(?:\r\n|\r|\n)/g,"<br>"),html=html.replace(/<p/g,"<h6"),html=html.replace(/<\/p/g,"</h6"),bq[i].innerHTML=html),innerBQ=bq[i].getElementsByTagName("blockquote"),0<innerBQ.length&&(html=bq[i].innerHTML,html=html.trim(),html=html.replace(/(?:\r\n|\r|\n)/g,""),html=html.replace(/<\/blockquote>\n/g,"</blockquote>"),html=html.replace(/(?:\r\n|\r|\n)/g,"<br>"),html=html.replace(/<blockquote/g,"<h6"),html=html.replace(/<\/blockquote/g,"</h6"),bq[i].innerHTML=html);for(;0<bq.length;)h6=bq[0].getElementsByTagName("h6"),0<h6.length?(bq[0].insertAdjacentHTML("beforebegin",bq[0].innerHTML),bq[0].parentNode.removeChild(bq[0])):(h6cb=document.createElement("h6"),h6cb.innerHTML=bq[0].innerHTML,h6cb.id=bq[0].id,h6cb.className=bq[0].className,h6cb.title=bq[0].title,bq[0].parentNode.replaceChild(h6cb,bq[0]));getClassInfoD2L(),setClassNames(),fixTitle(),createFlexImages(),addCaptions(),createEmailLink(),equationNumbering(),addDivs(),addOutline(),makeContextMenu(),addCodeTags("H6"),addCodeBlockTag(),addReferences(),addDownloadLinks(),checkURLForPos(),linksToNewWindow(),createTextBox(),captionFigures(),""!=window.location.hash.slice(1)&&scrollToElement(window.location.hash.slice(1),!0)};