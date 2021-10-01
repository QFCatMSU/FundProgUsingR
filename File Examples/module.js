/*
Future:
- <alomst> remove formatting from copied codeblock
   - Chrome adds a line feed, Edge keps format, FF works, Safari ??
- <done> add page map to long-click / right-click menu
- <almost done> remove depecated referencing (sectRef...)
- break up code functions
- look for Span within H6 for Title
- <done> Title in H6 means no numbers
- Class to add numbers
- <done> switch to addEventListener()
- <started> use encapObject whenever possible
- hold position of page when resized
- prevPage and nextPage: combine code
- <done> combine right-click and long-click in one function 
- fix overflow code
- fix wayward div in page
- <done> check MathJax version
- set equation color?
- <done> cannot put an email link inside H2,H3,H4 -- click event gets removed
    - switched innerHTML for insertAdjacentHTML
- <done - checking for Math element> MathJax is activating long-click menu
- multi-line equations stay on one line in MathJax (will MathJax fix?)
*/

// tabs in codeblocks are messing with the figures
// tabs are not aligned to the divs because the divs have been shifted
//    you can align by putting the tab inside the div
smallImageHeight = 100;				// set the height of flex-sized images when small 
imageHeight = new Array();			// the heights of all flex-sized images in a page
imageWidth = new Array();			// the widths of all flex-sized images in a page
minImageWidth = 700;					// minimum width for a flexSize image in expanded mode
scrollTopPosition = 0; 				// value saved for links-return-links within a page
overflowCalled = false;   			// check to see if there is a current check of code lines
//mathObjCount = 0;					// The number of equations in the lesson (deprecated w. MathJax3)
//count=0;prevCount=0;countNum=0;// used to keep track of the equations (deprecated w. MathJax3)
editURL = "";							// URL for the editting page 
referenceTimer = "";					// timer used to toggle the reference object
scrollFlag = 0;  						// counts when scrolling of page occurs due to reference links

// D2L variables 
redNum = -1;						// the number of the class 
instructorEmail = "Charlie Belinsky <belinsky@msu.edu>;";
lessonFolder = "";

// pre-onload functions
addStyleSheet();  // can be done before page load since this is called in the [head]

// resize the iframe in the parent window when the page gets resized
window.parent.addEventListener("resize", resizeIframeContent());

/*** Handling the long-press menu ****/
longClickTimer = null;
overRCMenu = false;
mouseX = 0; mouseY = 0;  // allow a little wiggle of the mouse

/***** Adding MathJax 3 ****/
var script = document.createElement('script');
script.type = "text/javascript";
script.id = "MathJax-script";
script.src = "https://cdn.jsdelivr.net/npm/mathjax@3.1.2/es5/tex-mml-svg.js";
script.async = "async";
document.head.appendChild(script); 
	
window.addEventListener("mousedown", function(event)
{
	// make sure it's a left-click and the MathJax Frame is not showing
	if(event.which == 1 && !document.querySelector("#MathJax_MenuFrame"))
	{
		longClickTimer = setTimeout(function() 
		{
			activateElement(event, encapObject.querySelector("#longClickMenu"));
			overRCMenu = true;
			encapObject.style.userSelect = "none";
			encapObject.style.msUserSelect = "none";
		}, 350);
		
		// get current mouse pointer position -- used to allow for wiggle in the mouse
		mouseX = parseInt(event.clientX);
		mouseY = parseInt(event.clientY);
	}
});

window.addEventListener("mouseup", function()
{
	clearInterval(longClickTimer);

	//	tried to avoid this with stopPropogation -- that did not work
	if(!overRCMenu)
	{
		encapObject.querySelector("#longClickMenu").style.visibility = "hidden";
		encapObject.querySelector("#longClickMenu").style.top = "0px";
		encapObject.style.userSelect = "";
		encapObject.style.msUserSelect = "";
	}
});

window.addEventListener("mousemove", function(event)
{
	mouseMoveX = Math.abs(parseInt(event.clientX) - mouseX);
	mouseMoveY = Math.abs(parseInt(event.clientY) - mouseY);
		
	// If the mouse has strayed more than 10 pixels in any direction
	if(mouseMoveX > 10 || mouseMoveY > 10)
	{
		clearInterval(longClickTimer);
	}
});

// will combine the following two functions later...
function activateNotification(e, type)
{
	// create a notification layer is there is not one
	if(!encapObject.querySelector("#notification"))
	{
		// create a new notification layer
		notifDiv = document.createElement("div");
		notifDiv.id = "notification";
		notifDiv.classList.add("rcMenu"); // use same style as menu
		encapObject.appendChild(notifDiv);
	}
	else
	{
		clearInterval(notifTimer);  // make sure the timer is not running
	}
	
	// set the text in the notificaytion layer
	if(type=="code")
	{
		notifDiv.innerHTML = "Codeblock copied to clipboard";
		displayTime = 1000;
		
	}
	else if(type=="scroll")
	{
		notifDiv.innerHTML = "Hold left mouse button to return to previous location";			
		displayTime = 2000;
	}
	
	activateElement(e, notifDiv, -2);

	// set timer for notfication layer
	notifTimer = setTimeout(function()
	{
		notifDiv.style.visibility = 'hidden';
		notifDiv.style.top = '0px';
	}, displayTime);
}

// used for long-click menu, code copying notification, and scrolling notification
function activateElement(e, element, offset = 5)
{			
	const[offsetLeft, offsetTop] = getIframeOffset();
	rcMenuDim = element.getBoundingClientRect();
	
	if(window.innerWidth - e.clientX < rcMenuDim.width)  
	{
		element.style.left = (window.scrollX + e.clientX - rcMenuDim.width + offset) + "px";
	}
	else
	{
		element.style.left = (window.scrollX + e.clientX - offset) + "px";
	}
	
	// need to check if the mouse click happened right above the bottom of the screen
	// or the bottom of the iframe window if in an iframe
	if( ( window.innerHeight - e.clientY < rcMenuDim.height) ||
	    ( window.parent.scrollY + window.parent.innerHeight - offsetTop - e.clientY < rcMenuDim.height ) )
	{
		element.style.top = (window.scrollY + e.clientY - rcMenuDim.height + offset) + "px";
	}
	else
	{
		element.style.top = (window.scrollY + e.clientY - offset) + "px";
	}
	
	element.style.visibility = "visible"; 
}

// don't do anything until the parent frame (d2L) loads 
// this still seems to work if there is no parent -- probably should check for this, though
parent.window.onload = function()
{		
	encapObject = document.body; 


	if(document.querySelectorAll('meta[content^="Joomla"]').length > 0) joomlaFixes();
	
	if(window.location.hostname == "d2l.msu.edu") 
	{
		d2lFixes();
		d2lAddHeader();
	}
	
	/**** Temp Hack -- D2L got rid of H6 -- switching Blockquote and
	      P within a blockquote to H6 ****/
	bq = document.getElementsByTagName("blockquote");

	for(i=0; i<bq.length; i++)
	{
		para = bq[i].getElementsByTagName("p");

		if(para.length > 0)
		{
			html = bq[i].innerHTML;
			html = html.trim();
			html = html.replace(/(?:\r\n|\r|\n)/g, '');	
			html = html.replace(/<\/p>\n/g, '<\/p>');	
			html = html.replace(/(?:\r\n|\r|\n)/g, '<br>');	
			html = html.replace(/<p/g, "<h6");
			html = html.replace(/<\/p/g, "<\/h6");
			bq[i].innerHTML = html;		
		}
		
		innerBQ = bq[i].getElementsByTagName("blockquote");
		if(innerBQ.length > 0)
		{
			html = bq[i].innerHTML;
			html = html.trim();
			html = html.replace(/(?:\r\n|\r|\n)/g, '');	
			html = html.replace(/<\/blockquote>\n/g, '<\/blockquote>');	
			html = html.replace(/(?:\r\n|\r|\n)/g, '<br>');	
			html = html.replace(/<blockquote/g, "<h6");
			html = html.replace(/<\/blockquote/g, "<\/h6");
			bq[i].innerHTML = html;		
		}
	}
	
	while(bq.length > 0)	
	{
		h6 = bq[0].getElementsByTagName("h6");
		
		if(h6.length > 0)
		{		
			bq[0].insertAdjacentHTML("beforebegin", bq[0].innerHTML);
			// get the element's parent node
			var parent = bq[0].parentNode;
			
			// move all children out of the element
	//		while (bq[0].firstChild) 
		//		parent.insertBefore(bq[0].firstChild, bq[0]);
			
			// remove the empty element
			parent.removeChild(bq[0]);
		}
		else
		{
			h6cb = document.createElement("h6");
			h6cb.innerHTML = bq[0].innerHTML;
			h6cb.id = bq[0].id;
			h6cb.className = bq[0].className;
			h6cb.title = bq[0].title;
			bq[0].parentNode.replaceChild(h6cb, bq[0]);
		}
	}

	
	// mathML() adds div to the beginning of the page -- needs to happen after header is set -- deprcated with MathJax 3.0
	//loadMathML();
	
	getClassInfoD2L(); // emails, lessons (works only in D2L for now)
	
	setClassNames();
	
	fixTitle();
	
	// allow users to resize images from small to full-size
	createFlexImages();
	
	// adds the caption class to all H5 elements
	addCaptions();
	
	createEmailLink();
	
	equationNumbering();
		
	// structure the page with DIVs based on the headers 
	addDivs();
	
	// add outline to the divs
	addOutline();
	
	// Create a right-click menu
	makeContextMenu();  // needs to happen after divs are created
		

	
	// adds code tags to all content within an [h6] tag
	// need to add divs before doing code tags becuase this includes the div codeblocks
	addCodeTags("H6");
	
	// allow user to toggle the size of the codeblock
	addCodeBlockTag();
	
	addReferences();
		
	// handling wordwrapped codelines (A little buggy -- avoiding for now)
	// overflowCodeLines();
	
	// convert "download" class to a download hyperlink 
	//		(because D2L does not allow you to specify this trait)
	addDownloadLinks();	
	
	// check the URL to see if there is a request to go to a specific part of the page
	checkURLForPos();
	
	// target most hyperlinks to a new window
	linksToNewWindow();
	
	// address tag used to create an emphasized textbox
	createTextBox();
	
	// wrap figure and captions together -- for accessibility
	captionFigures();
	
	// if this page was hyperlinked from elsewhere and a hash tag was added to the link
	if(window.location.hash.slice(1) != "") 
		scrollToElement(window.location.hash.slice(1), true);
}
	
function getClassInfoD2L()
{
	// find the information for the class
	if(redNum == 755411 || redNum == 704361 || redNum == 457124) 
		instructorEmail = "Charlie Belinsky <belinsky@msu.edu>;";
	else if(redNum == 748323)
		instructorEmail = "Travis Brenden <brenden@msu.edu>;";
	else if(redNum == 942384)
		instructorEmail = "Jim Bence <bence@msu.edu>;";		
	else if(redNum == 931321)
		instructorEmail = "Mike Jones <jonesm30@msu.edu>;";		
	else if(redNum == 952618)
		instructorEmail = "Juan Steibel <steibelj@msu.edu>;";		
}
function resizeIframeContent()
{
	// When the parent page gets resized, it causes the content in the iframe to get resized.
	//	But, the iframe only resizes when the content inside the iframe changes (D2L bug).
	
	// In D2L, the iframe's height is set to "auto" so we don't need to change its size.
	
	// get iframes from the parent windows:
	parentIFrames = window.parent.document.getElementsByTagName("iframe");
	if (parentIFrames[0] && parentIFrames[0].contentWindow.document.body)
	{
		// change to size of the document
		parentIFrames[0].height = parentIFrames[0].contentWindow.document.body.scrollHeight;
	}
	
	if(overflowCalled == false)
	{
		overflowCalled = true;
	}
	else
	{
		clearTimeout(overFlowTimer);
	}
	overFlowTimer = setTimeout(function() { overflowCodeLines(); }, 500);
}

function loadMathML()
{
	var script = document.createElement('script');
	script.onload = function () 
	{
		mathEdit(); // wait for mathML script to load before manipulating the script 
	};
	script.src = "/content/DEVELOPMENT/2018/courses/DEV-belinsky-2018-BackendTest/Programming/eqTest/MathML2.js";

	document.head.appendChild(script); //or something of the likes
}

function joomlaFixes()
{
	// In Joomla, the article is in a div of class "container"
	containers = document.querySelectorAll("div.container"); 
	containers[0].style.backgroundColor = "#003c3c";
	containers[0].style.padding = "9px";

	// Joomla uses these itemprprops -- need a better way to check for Joomla...
	itemPropDiv = document.querySelectorAll("div[itemprop]");
	if(itemPropDiv.length == 1)
	{
		// the lesson is encapsulated in the div with the itemprop
		encapObject = itemPropDiv[0];	
		
		// create the editing URL
		// in Joomla it is: URL of page - last section +
		// 			"?view=form&layout=edit&a_id=" + the page id
		theURL = window.location.href; 
		lastSlashIndex = theURL.lastIndexOf("/");
		editURL = theURL.substring(0, lastSlashIndex);
		pageID = theURL.substring((lastSlashIndex +1), theURL.indexOf("-"));
		editURL = editURL + "?view=form&layout=edit&a_id=" + pageID;
	}
	
	// will need to move this line to make it more general
	encapObject.style.backgroundColor = "rgb(0,60,60)";	
}

function d2lFixes()
{
	oldURL = String(window.parent.location); 
	// get rid of parameters (designated by "?")
	editURL = oldURL.split('?')[0];  
	// replace viewContent with contentFile
	editURL = editURL.replace("viewContent", "contentFile"); 
	// replace View with EditFile?fm=0
	editURL = editURL.replace("View", "EditFile?fm=0"); 	 	
				
	// remove the header in the D2L page (being paranoid in case D2L changes their backend)
	if(parent.document.querySelector(".d2l-page-header"))  // we might not be in an iframe
		parent.document.querySelector(".d2l-page-header").style.display = "none";
	if(parent.document.querySelector(".d2l-page-collapsepane-container"))
		parent.document.querySelector(".d2l-page-collapsepane-container").style.display = "none";
	if(parent.document.querySelector(".d2l-page-main-padding"))
		parent.document.querySelector(".d2l-page-main-padding").style.padding = "0";

}

// Add a header to the lesson which include a home, previous, and next page link --
// currently only works in D2L 
function d2lAddHeader()
{
	// check if there is a previous page link
	prevPage = document.body.children[0];
	if(prevPage && prevPage.tagName == "P")
	{
		if(prevPage.innerText.trim() != "")
		{
			prevText = "Previously: " + prevPage.innerText;
		}
		prevPage.parentNode.removeChild(prevPage);
	}
	
	// check if there is a next page link
	nextPage = document.body.children[0];
	if(nextPage && nextPage.tagName == "P")
	{
		if(nextPage.innerText.trim() != "")
		{
			nextText = "Up Next: " + nextPage.innerText;
		}
		nextPage.parentNode.removeChild(nextPage);
	}
		
	if(self != top)
	{	
		// create div at top of page that will hold the home page and page links
		divTop = document.createElement("div");
		divTop.classList.add("headerDiv");
		encapObject.prepend(divTop);
		
		// add home page link
		url = window.parent.location.href;
		classNum = url.match(/\/[0-9]{3,}\//); 
		redNum = classNum[0].substring(1, classNum[0].length-1); // get number of D2L class
		homePage = document.createElement("span");
		homePage.classList.add("lessonLink", "sameWin", "homePage");
		homeLink =  document.createElement("a");
		homeLink.innerHTML = "Home";
		homeLink.href = "https://d2l.msu.edu/d2l/home/" + redNum;
		homeLink.target = "_parent";
		homePage.appendChild(homeLink);
		divTop.appendChild(homePage);
			
		// add the previous page link if it exists
		if(typeof prevText !== 'undefined')
		{
			url = window.parent.document.getElementsByClassName("d2l-iterator-button-prev");
			newPrevPage = document.createElement("span");
			newPrevPage.classList.add("lessonLink", "sameWin", "previousLesson");
			newPrevPageLink = document.createElement("a");
			newPrevPageLink.innerHTML = prevText;
			newPrevPageLink.href = url[0].href;
			newPrevPageLink.target = "_parent";
			newPrevPage.appendChild(newPrevPageLink);
			divTop.insertBefore(newPrevPage, homePage);
		}
		
		// add the next page link if it exists
		if(typeof nextText !== 'undefined')
		{
			url = window.parent.document.getElementsByClassName("d2l-iterator-button-next");
			newNextPage = document.createElement("span");
			newNextPage.classList.add("lessonLink", "sameWin", "nextLesson");
			newNextPageLink = document.createElement("a");
			newNextPageLink.innerHTML = nextText;
			newNextPageLink.href = url[0].href;
			newNextPageLink.target = "_parent";
			newNextPage.appendChild(newNextPageLink);
			divTop.insertBefore(newNextPage, homePage);
		}		
	}
	else
	{
		// old system
		lessonLinks = encapObject.querySelectorAll(".previousLesson, .nextLesson, .nl, .pl");
		for(i=0; i<lessonLinks.length; i++)
		{
			lessonLinks[i].style.display = "none";
		}
	}
}

// add the full name of a class when the user has entered in the abbreviated name
function setClassNames()
{
	// add class names
	p = encapObject.getElementsByClassName("p");
	for(i=0; i<p.length; i++)
	{
		p[i].classList.add("partial");
	}

	nn = encapObject.getElementsByClassName("nn");
	for(i=0; i<nn.length; i++)
	{
		nn[i].classList.add("nonum", "partial");
	}
}

function fixTitle()
{
	// set title on webpage -- the first H1 on the page
	titleObj = encapObject.querySelector("h1");
	
	if(titleObj)  // there is a title 
	{
		window.document.title = titleObj.textContent;
		
		// create printer icon 
		printLink = document.createElement('a');
		printLink.classList.add("sameWin");
		printLink.href = "javascript:window.print()";
		printLink.style.marginLeft = "9px";
		printLink.innerHTML = "&#9113"; //"&#x1F5B6;";
	
		// add printer icon to title
		titleObj.appendChild(printLink);
	}
	else
	{
		window.document.title = "No Title";
	}
}

/* removes all of the [div] elements in the page and move the content inside the [div]
   up one level */
function removeDivs()
{
	
	// all DIVs not related to MathJax
	notMathJax = "DIV:not([class*='MathJax']) DIV:not([id*='MathJax'])"
	divElements = encapObject.querySelectorAll(notMathJax);
	
	// Remove all the divs from the page but keep the content 
	while(divElements.length > 0)  
	{		
		// get information inside the div and save it to a temp variable
		divContent = divElements[divElements.length-1].innerHTML
		
		// copy the content of the [div] before the [div] 
		divElements[divElements.length-1].insertAdjacentHTML("beforebegin", divContent);
		
		// remove the [div]
		divElements[divElements.length-1].parentElement.removeChild(
			divElements[divElements.length-1] );
	}
}

/*
Find all images within the page that have the "flexSize" class
and add click events that give the user the ability to change 
the size of the image.  Called on page load.
*/
function createFlexImages()
{
	// find all images that have the class name "flexSize" or "fs"
	var flexImage = encapObject.querySelectorAll('img.flexSize, img.fs');
	var flexVideo = encapObject.querySelectorAll('video.flexSize, video.fs');
	var flexIframe = encapObject.querySelectorAll("p.fs > iframe, p.flexsize > iframe");

	// switch to while (there are flexImages)??
	for(i=0; i<flexImage.length; i++)	// for each flexSize element
	{
		// add a click event that calls changeImageSize() to each flexSize image
		flexImage[i].addEventListener("click", function()
												{ changeImageSize(this) }, false); 
		
		/*** the strange behavior of JS and for loops: final value of the loop  ****/
		
		flexImage[i].myIndex = i;  	// give every image a unique index value
		
		// store the values of the images natural width and height
		imageHeight[i] = flexImage[i].naturalHeight;
		imageWidth[i] = flexImage[i].naturalWidth;
		
		// initalize the flex image to the small size
		changeImageSize(flexImage[i], "minimize");
	}
	
	// go through all the videos...
	for(let i=0; i<flexVideo.length; i++)	// for each flexSize element
	{
		let videoHeight = flexVideo[i].height;
		let videoWidth = flexVideo[i].width;
		flexVideo[i].width = smallImageHeight * videoWidth / videoHeight;
		flexVideo[i].height = smallImageHeight;
		flexVideo[i].addEventListener("play", 
			function()
			{
				this.width=videoWidth; 
				this.height=videoHeight;
			});
		flexVideo[i].addEventListener("ended", 
			function()
			{
				this.width=smallImageHeight * videoWidth / videoHeight;
				this.height=smallImageHeight;
			});
	}
		
	for(let i=0; i<flexIframe.length; i++)
	{
		let iframeHeight = flexIframe[i].height; 
		let iframeWidth = flexIframe[i].width; 
		flexIframe[i].height = smallImageHeight;
		flexIframe[i].width = smallImageHeight * iframeWidth / iframeHeight;

		// create a small span button 
		resizeButton = document.createElement("span");
		resizeButton.classList.add("flexButton");
		resizeButton.classList.add("noSelect");
		resizeButton.innerText = "\u{1f846}";
		resizeButton.addEventListener("click", 
			function()
			{
				if(flexIframe[i].width != iframeWidth)
				{
					flexIframe[i].width = iframeWidth; 
					flexIframe[i].height = iframeHeight; 
					flexIframe[i].src = flexIframe[i].src;
					this.innerText = "\u{1f844}";
				}
				else
				{
					flexIframe[i].width = smallImageHeight * iframeWidth / iframeHeight; 
					flexIframe[i].height = smallImageHeight;
					this.innerText = "\u{1f846}";
				}
			});
		flexIframe[i].parentElement.appendChild(resizeButton);
	}
}

/*
function called when a flexSize image is clicked --
changes the size of images between small and large

possible instruction values: minimize and maximize
*/
function changeImageSize(element, instruction="none")
{
	// get unique index of image
	imageIndex = element.myIndex;				
	
	// get the images natural width and height unsing the index
	origHeight = imageHeight[imageIndex];
	origWidth = imageWidth[imageIndex];
	
	// If image is in small sized mode and insruction is not "minimize"
	// The reason I do not put instruction == "minimize" 
	//			has to do with minimize/maximize all call
	if(element.style.height == smallImageHeight + "px" && instruction != "minimize")
	{
		// get the width of the images parent element, which is a [figure]
		screenWidth = element.parentElement.clientWidth;
		
		// if the width is less than the min width, increase the width to the min width
		if(screenWidth < minImageWidth)
		{
			screenWidth = minImageWidth;
		}
		
		// if the natural width of the image is smaller than the screen width...
		if(origWidth <= screenWidth)
		{
			// set the image to its natural size
			element.style.width = origWidth + "px";
			element.style.height = origHeight + "px";
		}
		else  // image's natural width is larger than screen width
		{
			// set the image width to the screen width and scale the height
			element.style.width = screenWidth + "px";
			element.style.height = (screenWidth/origWidth)*origHeight + "px";
		}
	}
	else if (instruction != "maximize")
	{
		// set the images height to the smallHeight value and scale the with to match
		element.style.height = smallImageHeight + "px";	
		element.style.width = (smallImageHeight/origHeight)*origWidth + "px";
	}
}

/* uses the header structure of the page to create a visual style with div elements --
	user passes in the elementType they want to structure 
	(H1, H2, and H3 are currently supported */ 
function addDivs()
{
	// find all element of the type asked for (H1, H2, and H3 currently supported)
	elements = encapObject.querySelectorAll("H1, H2, H3");
	
	// for each header element
	for(i=0; i<elements.length; i++)
	{
		// create a temporary element at the same location of the Header element
		currentElement = elements[i];
		nextSibling = null;
	
		newDiv = document.createElement("div");	// create a new div
					
		// get title from element -- transfer to new div
		// use data-title instead of title because 
		//		title will create a tooltip popup (which I don't want)
		if(elements[i].title != "")
		{
			newDiv.dataTitle = elements[i].title
		}
		else  // no title -- use text from header
		{
			newDiv.dataTitle = elements[i].innerText;
		}
		
		// insert the new div right before the Header element
		elements[i].parentNode.insertBefore(newDiv, elements[i]);
		/*
			Go from 
			<h2> Header title </H2>
				<p>more content</p>
				<p>more content</p>
				<p>more content</p>
			<h3>
			
			to
			
			<div class="">
				<h2> Header title </H2>
				<p>more content</p>
				<p>more content</p>
				<p>more content</p>
			</div>
			<h3>  -- this last element could also be <h2>, <div>, or end-of-page
		*/
		while(currentElement.nextElementSibling != null &&
				currentElement.nextElementSibling.tagName != "H1" &&
				currentElement.nextElementSibling.tagName != "H2" &&
				currentElement.nextElementSibling.tagName != "H3" &&
				!(currentElement.nextElementSibling.classList.contains("h1Div")) && 
				!(currentElement.nextElementSibling.classList.contains("h2Div")) && 
				!(currentElement.nextElementSibling.classList.contains("h3Div"))) 
		{
			nextSibling = currentElement.nextElementSibling;	// get the next element
			newDiv.appendChild(currentElement);						// add current element to div
			currentElement = nextSibling;					// set current element to next element
		}	

		// add the page title class to the div with H1
		if(elements[i].tagName == "H1")
		{	
			newDiv.classList.add("h1Div");
		}
		else if(elements[i].tagName == "H2")
		{	
			// add the class "h2Div" to div with H2
			newDiv.classList.add("h2Div", "contentDiv");
			
			// add "nonlinear" class for div that contain non-linear content
			if((elements[i].className != "" ) &&
				(elements[i].classList.contains("trap") ||
				elements[i].classList.contains("extension") ||
				elements[i].classList.contains("shortcut")) )
			{
				newDiv.classList.add("nonlinear");
			}
		}
		else if(elements[i].tagName == "H3")
		{	
			// add the class "h3Div" to div with "H3"
			newDiv.classList.add("h3Div", "contentDiv");
			
			// Check to see if the previous sibling (div with H2 or H3) has class "nonlinear"
			// if so -- then this div should also be class "nonlinear"
			if(newDiv.previousElementSibling && 
				newDiv.previousElementSibling.className != "" &&
				(newDiv.previousElementSibling.classList.contains("nonlinear") ))
			{
				newDiv.classList.add("nonlinear");
			}
		}	

		if(currentElement.nextElementSibling == null) // there is no next
		{
			// should change at some point -- probably indicates an error
			newDiv.classList.add("h2NextDiv");	
		}
		else if(currentElement.nextElementSibling.tagName == "H2" ||
					currentElement.nextElementSibling.classList.contains("h2Div"))
		{
			newDiv.classList.add("h2NextDiv");	// it is the end of a section
		}
		else if(currentElement.nextElementSibling.tagName == "H3" ||
					currentElement.nextElementSibling.classList.contains("h3Div"))
		{
			newDiv.classList.add("h3NextDiv");	// it is the middle of a section
		}
		newDiv.appendChild(currentElement);	// add content to the new div
	}
}

// add outline to H2 and H3 elements
function addOutline()
{
	level1 = 0;
	level2 = 0;
	divElement = encapObject.getElementsByTagName("div");
	
	for(i=0; i<divElement.length; i++)
	{
		// find what the first element in the div is
		if(divElement[i].firstChild && divElement[i].firstChild.tagName == "H2")
		{
			level1++;			
			level2=0;
			divElement[i].firstChild.insertAdjacentHTML("afterbegin", level1 + " - ");
			divElement[i].dataTitle = divElement[i].firstChild.textContent;
		}
		else if(divElement[i].firstChild && divElement[i].firstChild.tagName == "H3")
		{
			level2++;
			divElement[i].firstChild.insertAdjacentHTML("afterbegin", level1 + "." + level2 + " - ");
			divElement[i].dataTitle = divElement[i].firstChild.textContent;
			
			// find H4 elements within H3
			h4Elements = divElement[i].getElementsByTagName("H4");
			
			level3 = 0;
			for(j=0; j<h4Elements.length; j++)
			{
				level3++;
				h4Elements[j].insertAdjacentHTML("afterbegin", level1 + "." + level2 + "." + level3 + " - ");
				h4Elements[j].dataTitle = h4Elements[j].textContent;
			}
		}
	}
}

/* call from right-click menu in page to either minimize or maximize (param)
	all the flex-sized images in the page */
function changeAllPicSize(param)
{
	var flexImage = encapObject.querySelectorAll('.flexSize, .fs');
	for(i=0; i<flexImage.length; i++)
	{
		/* calll changeImageSize passing each flexSize object in an array */
		changeImageSize(flexImage[i], param)
	}
}

/* Linkback function */
function goBackToPrevLocation()
{
	leftPos = window.parent.scrollX; 	// get the left position of the scroll

	prevLocLink = document.getElementById("previousLocMenuItem");
	prevLocLink.classList.add("disabledLink"); 
	// scroll the page vertically to the position the page was
	// at when the link was originally clicked (stored as a global variable)
	window.parent.scrollTo(leftPos, scrollTopPosition);
	//return false;	// so the page does not reload (don't ask why!)
}
	
/* link to external CSS file 
	This is in the javascript because D2L will rewrite links in the HTML file */
function addStyleSheet()
{
	var CSSFile = document.createElement("link");
	scripts = document.getElementsByTagName("script");
	for(i=0; i<scripts.length; i++)
	{
		jsIndex = scripts[i].src.indexOf("module.js");
		if(jsIndex != -1) //scripts[i].src.includes("module.js"))
		{
			//cssFile = scripts[i].src.slice(0,-2) + "css"; -- old system, when on Github
			cssFile = scripts[i].src.substring(0,jsIndex) + "module.css";
		}
	}
	CSSFile.href = cssFile;	// location depends on platform
	CSSFile.type = "text/css";
	CSSFile.rel = "stylesheet";
	CSSFile.media = "screen,print";
	document.getElementsByTagName("head")[0].appendChild(CSSFile);
}

/* adds the class "eqNum" to all H5 lines that have the dotum font (it's a hack for D2L) */
function equationNumbering()
{
	// currently using font family: dotum; to indicate equation number (thanks, D2L!)
	var newEQs = encapObject.querySelectorAll("span[style*='dotum']");
	
	for(i=0; i<newEQs.length; i++)
	{
		newEQs[i].classList.add("eqNum");
	}
	
	// find all elements of elementType (initially it is H5)
	var equations = encapObject.getElementsByClassName("eqNum");
	
	// add the equation number after the equation
	for(i=0; i<equations.length; i++)
	{
		if(equations[i].textContent.trim() != "")
		{		
			// should move most of this to module.css
			equations[i].style.display = "inline-flex";
			
			eqNumber = document.createElement("span");
			eqNumber.textContent =  "\u00a0( " + (i+1) + " )";
			eqNumber.style.fontSize = "14px";
			eqNumber.style.alignSelf = "center";
			eqNumber.style.whiteSpace = "nowrap";

			equations[i].appendChild(eqNumber);
		}
	}
}

/* adds the class "caption" to all H5 lines */
function addCaptions()
{
	// find all elements of elementType (initially it is H5)
	//var captionLines = encapObject.getElementsByTagName("h5");
	var captionLines = encapObject.querySelectorAll("h5, .fig");

	// this is deprecated in DreamWeaver
	for(i=0; i<captionLines.length; i++)
	{
		if(!(captionLines[i].classList.contains("eqNum")))
		{
			captionLines[i].classList.add("caption");	
		}
	}
	
	// In D2L, H5 was used to signify a caption;
	// In DW: the class .caption is an option
	captionLines = encapObject.getElementsByClassName("caption");
	for(i=0; i<captionLines.length; i++)
	{
		if(captionLines[i].innerText.trim() != "")  // there is text in the caption
		{
			captionLines[i].insertAdjacentHTML("afterbegin", "Fig " + (i+1) + ": ");
		}	
	}
}

/* add the tag: [code] to each line inside a [pre] block --
  the real trick is that there are multiple ways in which D2L will code a set of lines */
function addCodeTags(elementType)
{
	/* this part works if we are using <h6> with class="code" */
	var codeLines = encapObject.getElementsByTagName(elementType);  

	/* count the number of H6 tags
	   note: if you use codeLines.length in the for loop, the length will change
		as you add [h6] tags -- creating an infinite loop */
	numCodeTags = codeLines.length;

	// first go through [H6] elements and check for [br] tag -- switch to [H6]
	for(i=0; i<numCodeTags; i++)
	{
		// need to be very careful in for loops where the counted element is changing
		codeElement = codeLines[i];
				
		/* fix the situation where code lines are broken up by [br] --
			usually happens when code was copied/pasted into editor */
		if(codeLines[i].getElementsByTagName("br").length > 0)
		{ 
			// count how many lines of code there are, which is the number of <br> + 1
			// 	because we need to add a break for the last line
			numLines = codeLines[i].getElementsByTagName("br").length +1; 

			var codeText = new Array();
			for(j=0; j<numLines; j++)
			{
				// copy all the lines of code into an array
				codeText[j] = codeLines[i].innerHTML.split("<br>")[j];
			}
			for(j=0; j<numLines; j++)
			{
				newElement = document.createElement(elementType);	// create an [H6] 
				newElement.innerHTML = codeText[j];						// insert code into [H6]
				if(j == 0)
				{
					// transfer title information to only the first element
					newElement.title = codeLines[i].title;	
					// transfer the class list to the first element					
					newElement.classList =  codeLines[i].classList; 
				}
				// add the new code line to the script
				codeElement.parentElement.insertBefore(newElement, codeElement);  
			}
			// remove all the original code lines
			codeElement.parentElement.removeChild(codeElement);	
			
			/********
			the number of code tags increased -- so codeLines[] has been updated to match
			*********/
			// increase numCodeTags to the current codeline length
			numCodeTags = codeLines.length; 
			
			// increase i by the number of codelines just added (don't need to check those)
			i = i + numLines -1; 
		}
	}

	firstLine = true;

	// now, go through all H6 including new ones generated from above
	for(i=0; i<codeLines.length; i++)
	{
		// add "code" class to line
		codeLines[i].classList.add("code");
		
		/* D2L-only fix: when code is copied and pasted in D2L, the class names can also 
			be copy/pasted -- removes erroneous class names */
		if(codeLines[i].classList.contains("firstLine"))
		{
			codeLines[i].classList.remove("firstLine")
		}
		if(codeLines[i].classList.contains("lastLine"))
		{
			codeLines[i].classList.remove("lastLine")
		}			
		
		if(firstLine == true)  // this is the first line of the code-block
		{
			// create a [div] for the code-block and give it class "codeBlock"
			codeBlockDiv = document.createElement("div");
			
			// check if the codelines or any of its children (D2L issue) has the class "partial"
			if(codeLines[i].classList.contains("partial")  || 
				codeLines[i].querySelectorAll(".partial").length != 0)
			{
				codeBlockDiv.classList.add("partial");
			}		
			// check if the codelines or any of its children (D2L issue) has the class "nonum"
			if(codeLines[i].classList.contains("nonum")  || 
				codeLines[i].querySelectorAll(".nonum").length != 0)
			{
				codeBlockDiv.classList.add("nonum");
			}		
			// check if the codelines or any of its children (D2L issue) has the class "text"
			if(codeLines[i].classList.contains("text") || 
				codeLines[i].querySelectorAll(".text").length != 0) 
			{
				codeBlockDiv.classList.add("text");
			}				
			// check if the codelines or any of its children (D2L issue) has the class "brackets" or "bx"
			if(codeLines[i].classList.contains("brackets") || codeLines[i].classList.contains("bx") ||
				codeLines[i].querySelectorAll(".brackets").length != 0 || 
				codeLines[i].querySelectorAll(".bx").length != 0) 
			{
				codeBlockDiv.classList.add("brackets");
			}
			// check if the codeline has a title 
			if(codeLines[i].title.trim() != "" ) 
			{
				codeBlockDiv.title = codeLines[i].title;
			}				
			codeBlockDiv.classList.add("codeBlock");
			
			// when double-clicked, select all the children (text) within the codeblock
			codeBlockDiv.addEventListener("dblclick", function(event){ 
				document.getSelection().selectAllChildren(this); 
				document.execCommand("copy"); 
				activateNotification(event, "code");
			});
			
			// disable short-cut menu on scroll (mousemoves are not triggered on scroll)
			codeBlockDiv.addEventListener("scroll", function(event){ 
				clearInterval(longClickTimer);
			});
			
			// do this only for codeblocks
			codeBlockDiv.addEventListener("copy", function(e) {
			  const text_only = document.getSelection().trimEnd().toString();  // trimEnd() converts weird spaces to regular spaces
			  const clipdata = e.clipboardData; // || window.clipboardData;  
			  clipdata.setData("text/plain", text_only);
			  e.preventDefault();
			});
			
			// add the codeBock div as a parent to the codeLine
			codeLines[i].parentElement.insertBefore(codeBlockDiv, codeLines[i]);
			
			// check if this is a partial codeblock or a full codeblock
			if(codeBlockDiv.classList.contains("brackets"))
			{
				/**** added formatting to put in {} ************/
				// create a line that just has a start curly bracket ( { )
				startCodeLine = document.createElement(elementType);
				startCodeLine.setAttribute("data-text", "{");  // so it does not appear as text when selected
				startCodeLine.classList.add("code", "firstLine", "noSelect", "noCode");

				codeBlockDiv.appendChild(startCodeLine);
				i++;  // another element was added so we need to increment the index
				/*****************************************/
			}
			else  
			{
				// make this codeLine the first line 
				codeLines[i].classList.add("firstLine");	
			}
			
			// numbering
			if( codeBlockDiv.title != "" && !isNaN(codeLines[i].title) )
			{
				codeBlockDiv.style.counterReset = "codeLines " + (codeLines[i].title -1);
			}
			firstLine = false;
		}

		// add a space to empty lines -- when copying/pasting it can treat an 
		//			empty line as not a line (might be deprecated, but not sure...)
		if(codeLines[i].innerText == "")
		{
			codeLines[i].innerText = " ";
		}	
		
		if(codeBlockDiv.classList.contains("brackets"))
		{
			codeLines[i].insertAdjacentHTML("afterbegin", "  ");
		}
			
		// check if the next element after this codeLine is an [H6] -- 
		//		if not than this is the last line
		if(codeLines[i].nextElementSibling == null || 
			codeLines[i].nextElementSibling.tagName != elementType)
		{
			// check if this is a codeblock that needs curly brackets
			if(codeBlockDiv.classList.contains("brackets"))
			{
				codeBlockDiv.appendChild(codeLines[i]);
				/**** added formatting to put in curly brackets {} **********/
				// create a line that just has a start curly bracket ( { )
				lastCodeLine = document.createElement(elementType);
				lastCodeLine.setAttribute("data-text", "}");
				lastCodeLine.classList.add("code", "lastLine", "noSelect", "noCode");
				codeBlockDiv.appendChild(lastCodeLine);
				i++;  // another element was added so we need to increment the index
				/*****************************************/
			}
			else
			{
				codeLines[i].classList.add("lastLine");
				codeBlockDiv.appendChild(codeLines[i]);
			}
			firstLine = true;
		}		
		else // this is not the last line of the codeblock
		{			
			// add the code line to the codeblock */
			codeBlockDiv.appendChild(codeLines[i]);
		}
	}
}

function addCodeBlockTag()
{
	codeBlockDivs = encapObject.querySelectorAll(".codeBlock");
		
	for(i=0; i<codeBlockDivs.length; i++)
	{
		// need to check if there is a title in the first element of the codeblock
		codeBlockTitle = "";
		if(codeBlockDivs[i].title.trim() != "" && isNaN(codeBlockDivs[i].title.trim())) 			
		{
			codeBlockTitle = codeBlockDivs[i].title;
		}
		else 
		{
			// if not, check the children elements to see if there is a title (this is a D2L bug)
			cbChild = codeBlockDivs[i].querySelector("[title]");
			if(cbChild && cbChild.title.trim() != "" && isNaN(cbChild.title.trim()))
			{
				codeBlockTitle = cbChild.title;
			}
		}

		// add a tab to the codeblock
		if(codeBlockTitle != "")	
		{
			par = document.createElement("p");
			par.classList.add("noSelect");
			par.style.textAlign = "left";
			tabSpan = document.createElement("span");
			tabSpan.classList.add("codeBlockTab", "noSelect", "noCode", "nonum");
			tabSpan.setAttribute("data-text", codeBlockTitle);
			par.appendChild(tabSpan);
			codeBlockDivs[i].insertBefore(par, codeBlockDivs[i].children[0]);
		}
	}
}

// this function is still buggy and does not get called
function overflowCodeLines()
{
	// find all code elements (<p> with class = "code")
	/*** Tried to use encapObject but the bounded rectangle function did
		not work the second time -- don't know why ***/
	codeLines = document.getElementsByClassName("code");	

	if(codeLines.length > 0)
	{
		// get original height of codelines -- only need to do this once in code 
		//				(maybe? what if page is magnified?)
		elem = encapObject.querySelector('.code');
		style = getComputedStyle(elem);
		lineHeight = parseInt(style.lineHeight);

		// for each line of code in the page
		for(i=0; i<codeLines.length; i++)
		{
			// get the actual height the codeline 
			actualHeight = codeLines[i].getBoundingClientRect().height;  
			// find how many times bigger the actual height is compared to the original height
			lineHeightMult = Math.round(actualHeight/lineHeight);	
			// get the number of arrows attched to the line (last resize's multiple)
			numArrows = codeLines[i].querySelectorAll("span.overflowArrow");
			
			
			if(lineHeightMult != (numArrows.length +1)) 
			{
				// remove all current overflow arrow (later -- compare to multiplier)
				for(j=0; j<numArrows.length; j++)
				{
					codeLines[i].removeChild(numArrows[j]);
				}
				if(lineHeightMult > 1)	// if the codeline has length >1 (there is overflow)
				{
					for(j=1; j<lineHeightMult; j++)	// for each overflow line, add an arrow
					{
						arrowObj = document.createElement("span");  // create a new arrow object
						arrowObj.classList.add("overflowArrow");	// add overflowArrow class
						arrowObj.innerHTML = "&#x2937;";			// add arrow character
						
						// top position of arrow is top position of line offset by number of lines
						arrowObj.style.top = (codeLines[i].offsetTop + (j * lineHeight) )+  "px";
						arrowObj.style.left = (codeLines[i].offsetLeft + 80) + "px";
						codeLines[i].appendChild(arrowObj);	
					}
				}
			}		
		}
	}
	overFlowTimer = false;
}

function goToTopOfPage()
{
	// save current scroll position
	scrollTopPosition = window.parent.scrollY;  
	// scroll to position 0
	window.parent.scrollTo(window.parent.scrollX, 0);
	enablePrevious();
}

function makeContextMenu(funct, param = null)
{	
	var elemDiv = document.createElement('div');
	elemDiv.id = "longClickMenu";
	elemDiv.classList.add("rcMenu");
	elemDiv.addEventListener("mouseenter", function() {overRCMenu = true;}); 
	elemDiv.addEventListener("mouseleave", function() {overRCMenu = false;}); 
	
	var scTitle = document.createElement('a');
	elemDiv.innerHTML = "<b>Shortcut Menu</b>";
	elemDiv.style.display = "block";
	elemDiv.classList.add("sameWin", "noSelect");
	elemDiv.appendChild(scTitle);
	
	// check if the user is has editing privileges by seeing if the Edit HTML button is there
	editButton = parent.document.querySelectorAll("button.d2l-button"); // look at all buttons
	hasEditAccess = false;
	for(i=0; i<editButton.length; i++)
	{
		if(editButton[i].textContent.includes("Edit HTML"))
		{
			hasEditAccess = true; 
		}
	}
	
	if(hasEditAccess == true) // use has editing right -- show Edit option in menu
	{
		oldURL = String(window.parent.location);  // otherwise you will edit the URL
		newURL = oldURL.replace("viewContent", "contentFile"); 
		newURL = newURL.replace("View", "EditFile?fm=0"); 
		menuLinks(elemDiv, "Edit Page", function(){window.open(newURL, '_blank')}, "editPage");
	}
	menuLinks(elemDiv, "Return to previous location", goBackToPrevLocation, "previousLocMenuItem", false);
	menuLinks(elemDiv, "Go to Top of Page", goToTopOfPage, "topMenuItem");
	menuLinks(elemDiv, "Print/ Save as PDF", function(){document.getElementById("longClickMenu").style.visibility = "hidden"; window.print()}, "printToPDF");
	menuLinks(elemDiv, "Maximize All Images", function() {changeAllPicSize('maximize')}, "maxAllImages");
	menuLinks(elemDiv, "Minimize All Images", function() {changeAllPicSize('minimize')}, "minAllImages");
	
	encapObject.appendChild(elemDiv);
}

function menuLinks(menu, text, command, linkid="", enable=true)  
{
	// create a block span to encapsulate the hyperlink
	spanEncap = document.createElement('span');
	spanEncap.style.display = "block";
	

	
	link = document.createElement('a');
	if(!enable)
		link.classList.add("disabledLink");
	link.id = linkid;
	link.innerText = text;
	link.classList.add("sameWin", "jsLink");
	link.addEventListener("mouseup", 
								 function(event) 
								 { 
									command(); 	
									document.getElementById("longClickMenu").style.visibility = "hidden"; 
									document.getElementById("longClickMenu").style.top = "0px"; 
								 });
	spanEncap.appendChild(link);
	
	menu.appendChild(spanEncap);
}

function scrollToElementReturn(elementID)
{
	// this resolves the fact that variables are function scoped in JavaScript
	//   -- not block scoped
	return function() 
	{
		scrollToElement(elementID);	
	}
}

function copySelectedText()
{
	var text = "";
	if (window.getSelection)   // if there is something selected on the page
	{
		// works in all browsers except Firefox (current bug as of version 51)
		text = window.getSelection().toString();	// convert selected stuff to a string
		a = document.execCommand("copy");			// copy stuff to clipboard
	} 
}

function addDownloadLinks()
{
	downloadLinks = encapObject.getElementsByClassName("download");

	for(i=0; i<downloadLinks.length; i++)
	{
		// add the download property to all objects with class="download"
		downloadLinks[i].download = "";
	}
}

// checks in the references is on a block-displayed object.  If so,
// we need to create an inline-display object inside and put the 
// reference there
function fixBlockReferences()
{
	var references = encapObject.querySelectorAll(".ref");

	for(i=0; i<references.length; i++)
	{
		// get the display type of the reference element
		displayType = window.getComputedStyle(references[i], "").display;
		
		// if the element is block or list-item -- both take up the whole line
		if(displayType == "block" || displayType == "list-item")
		{
			// create a new <span> and copy the contents of the ref element
			newRef = document.createElement("span");
			newRef.innerHTML = references[i].innerHTML;
			
			// copy the id and add ref class to <span>
			newRef.id = references[i].id;
			newRef.classList.add("ref");
			
			// remove all content, id, and ref class from reference element
			references[i].innerHTML = "";
			references[i].id = "";
			references[i].classList.remove("ref");
			
			// append the new <span> inside the reference element
			references[i].appendChild(newRef);	
		}
	}
}

/* finds all section references in the page and add the correct numerical reference */
function addReferences()
{
	fixBlockReferences();
	
	/**** convert old system of references to the new system ****/
	var references = encapObject.querySelectorAll(".sectRef, .figureRef, .eqRef, .linkTo");
	for(i=0; i<references.length; i++)
	{
		// old system to new system
		references[i].classList.add("ref");
	}
	
	// new system for references
	var references = encapObject.querySelectorAll(".ref, .reference");
	for(i=0; i<references.length; i++)
	{
		fullRefID = references[i].id; // Get the ID for the reference
		refID = fullRefID.slice(2);	// remove the "r-" at the beginning of the ID
	
		// check if the reference has no ID
		if(fullRefID == "")  
		{
			// this situation is currently handled in editor.CSS
		}
		// no text associated with the reference
		else if (references[i].innerText.trim() == "")
		{
			// this situation is currently handled in editor.CSS			
		}
		// check if ID has any invalid characters
		else if(isValid(refID) == false)
		{
			references[i].classList.add("error");
			references[i].innerText = "**Invalid characters in ID: " + 
												references[i].innerText + "** ";
		}
		// check if the ID starts with a number
		else if(isNaN(refID[0]) == false)
		{
			references[i].classList.add("error");
			references[i].innerText = "**Cannot start ID with number: " + 
												references[i].innerText + "** ";
		}
		// this is a URL link to a different page
		else if(references[i].hasAttribute("href"))
		{
			// check to see if the href already has a "?" in it --
			// the ? indicates there are already parameters attached to the URL
			if(references[i].href.includes("?"))  // add another param called ref
			{
				references[i].href = references[i].href + "&ref=" + refID;
			}
			else  // add first param called ref
			{
				references[i].href = references[i].href + "?ref=" + refID;		
			}
		}
		// uses the title instead of a URL to indicate a ref to an outside lesson
		else if (references[i].title != "")
		{
			url = window.location.protocol + "//" + window.location.hostname + 
					window.location.pathname;
			n = url.lastIndexOf("/");  // find the last front slash
			lessonFolder = url.substr(0, n+1);
			newLessonURL = lessonFolder + references[i].title + "#" + refID;
			references[i].addEventListener("click", function() {window.open(newLessonURL)});
		}
		// reference link does not exist in the page
		else if(!(encapObject.querySelector("#" + refID)))
		{
			references[i].classList.add("error");
			references[i].innerText = "**Invalid Link: " + 
												references[i].innerText + "** ";				
		}
		// there is no content at the link (not sure this is neccessary...)
		else if (encapObject.querySelector("#" + refID).innerText.trim() == "")
		{
			references[i].classList.add("error");
			references[i].innerText = "**No content at link: "  + 
												references[i].innerText + "** ";					
		}
		// if this is a reference to an equation -- 
		//			this handles the situation where H5 is used and not
		else if(encapObject.querySelector("#" + refID).classList.contains("eqNum")) 
		{
			caption = encapObject.querySelector("#" + refID).innerText;

			/* find the last "(" in the line -- represents ( EQ# )
			   split the line right after the "(" -- so you have EQ#) left
				grab the number from the split of section */
			eqRef = parseInt(caption.slice( (caption.lastIndexOf("("))+1 ));
			
			addNumToReference(references[i], eqRef);
		}
		// if this is a figure ref (has h5 tag and does not have eqNum class)
		else if(encapObject.querySelector("#" + refID).nodeName.toLowerCase() == "h5" || // old system
              encapObject.querySelector("#" + refID).classList.contains("fig"))        // new system
		{
			caption = encapObject.querySelector("#" + refID).innerText;
			strIndex = caption.indexOf(":");  // find the location of the first semicolon
			
			//cheap fix -- use grep to check for numbers (future fix)
			figRef = caption.slice(4, strIndex); // get "Fig. #"
			
			addNumToReference(references[i], figRef);
		}
		// this links to a section header (h2-h4)
		else if(encapObject.querySelector("#" + refID).nodeName.toLowerCase() == "h2" ||
				  encapObject.querySelector("#" + refID).nodeName.toLowerCase() == "h3" ||
				  encapObject.querySelector("#" + refID).nodeName.toLowerCase() == "h4") 
		{
			// get first number from section ID (div)
			sectNum = parseFloat(encapObject.querySelector("#" + refID).innerText);
			
			addNumToReference(references[i], sectNum);
		}
		// for codelines
		else if(encapObject.querySelector("#" + refID).nodeName.toLowerCase() == "h6" ||
		        encapObject.querySelector("#" + refID).nodeName.toLowerCase() == "code")
		{
		//	Note: there is no way to access the CSS pseudo counter in JavaScript
		// Fix: Need to check for offset number
		
			cl = encapObject.querySelector("#" + refID);
			clParent = cl.parentNode;
			lineNum = Array.prototype.indexOf.call(clParent.children, cl);

			// the title of the codeblockdiv potentially has the numbering offset
			if(cl.parentNode.title && !isNaN(cl.parentNode.title))
			{
				lineNum = lineNum + parseInt(cl.parentNode.title);
			}				
			
			addNumToReference(references[i], lineNum);
		}
		// for all other elements referenced in the page -- often these elements
		// are <span> inside another element (a D2L bug) -- so we need to check parent
		// elements 
		else 
		{
			refObject = encapObject.querySelector("#" + refID);
			parentObj = refObject.parentNode.nodeName.toLowerCase();
			refNum = -1;
			
			// if the parent object is an H5 -- so it is a figure reference
			if(parentObj && parentObj == "h5")
			{
				strIndex = caption.indexOf(":");  // find the location of the first semicolon
				refNum = parentObj.innerText.slice(0, strIndex);
			}
			else if(parentObj && parentObj.firstElementChild &&
					  parentObj == "div" && 
								(parentObj.firstElementChild.nodeName.toLowerCase() == "h2" ||
								 parentObj.firstElementChild.nodeName.toLowerCase() == "h3" ||
								 parentObj.firstElementChild.nodeName.toLowerCase() == "h4") )
			{
				strIndex = caption.indexOf("-");  // find the location of the first dash
				refNum = parentObj.firstElementChild.innerText.slice(0, (strIndex-2));
			}
			else if(parentObj.parentNode)
			{
				grandParent = parentObj.parentNode.nodeName.toLowerCase();
				if(grandParent == "div" && 
								(grandParent.firstElementChild.nodeName.toLowerCase() == "h2" ||
								 grandParent.firstElementChild.nodeName.toLowerCase() == "h3" ||
								 grandParent.firstElementChild.nodeName.toLowerCase() == "h4") )
				{
					strIndex = caption.indexOf("-");  // find the location of the first dash
					refNum = parentObj.firstElementChild.innerText.slice(0, (strIndex-2));
				}
			}
			
			if(refNum != -1)
			{
				str = references[i].innerText;
				var pos = str.lastIndexOf('##');
				references[i].innerText = str.substring(0,pos) + eqRef + str.substring(pos+2);
			}
			
			// make the reference linkable as long as the nolink class is not 
			//				specified (not working yet...)
			if( !(references[i].classList.contains("nolink")) )
			{
				references[i].addEventListener("click", scrollToElementReturn(refID));
			}
		}
	}
}

function addNumToReference(refObj, refNum)
{
	refIndex = refObj.innerText.indexOf("##");
	
	if(refIndex != -1)
	{
		str = refObj.innerText;
		var pos = str.lastIndexOf('##');
		refObj.innerText = str.substring(0,pos) + 
								 refNum + str.substring(pos+2);
	}
	
	// make the reference linkable as long as the nolink class is not 
	//		specified (not working yet...)
	if( !(refObj.classList.contains("nolink")) )
	{
		refObj.addEventListener("click", scrollToElementReturn(refID));
	}
}

function checkURLForPos()
{
	// In D2L, the page is inside an iframe -- so need to check the parent
	var urlString = parent.window.location.href;
	var url = new URL(urlString);
	var ref = url.searchParams.get("ref");
	
	if(ref != null)
	{
		scrollToElement(ref);
	}
}

function scrollToElement(elementID, outsideCall = false)
{		
	var element = encapObject.querySelector("#" + elementID); 
	var windowHeight = window.parent.innerHeight;// height of the webpage with the lesson
	var windowScroll = window.parent.scrollY; 	// amount window has been scrolled
	var divWindowScroll = 0;							// for object in a scrolling div
	
	// find the position of the iframe -- if content is not in iframe this will return 0,0
	const [offsetLeft, offsetTop] = getIframeOffset();
	
	// check if the referenced element is a codeline in a div that has a scrollbar
	if(element.classList.contains("code")  &&   // part of a codeBlock
		element.parentNode.scrollHeight > element.parentNode.clientHeight) // scrollbar on codeblock
	{
		// line is scrolled out of view
		if(element.offsetTop < element.parentNode.scrollTop || 
			element.offsetTop > element.parentNode.scrollTop + element.parentNode.offsetHeight) 
		{
			element.parentNode.scrollTop = element.offsetTop - 20;  // scroll line back into view
		}
		divWindowScroll = element.parentNode.scrollTop;  // get the current scroll position
	}

	// calc the vertical position of the linked element in the parent page
	elementYPos = element.offsetParent.offsetTop + element.offsetTop + offsetTop - divWindowScroll; 
	
	// if the element is not on the screen
	if(elementYPos < windowScroll || elementYPos > (windowScroll+(2*windowHeight)))
	{
		// add some padding so the object does not appear right at the top of the page
		if(element.classList.contains("caption"))
		{
			offsetPadding = 200;	// add more padding if this is an image
		}
		else
		{
			offsetPadding = 50;
		}
		
		// save the current value of the scroll position so we can return to this spot
		scrollTopPosition = window.parent.scrollY; 
		
		// scroll the parent to the vertical position of the linkTo element
		window.parent.scrollTo(element.offsetLeft, (elementYPos -offsetPadding) );	
		
		scrollFlag = scrollFlag +1;
		if(scrollFlag <= 2) {activateNotification(event, "scroll");}
		enablePrevious();
	}
	// if the scrolling-to element is within one page
	else if(elementYPos >  (windowScroll+windowHeight) && elementYPos < (windowScroll+ (2*windowHeight)))
	{
		offsetPadding = windowHeight - 200;
		
		// save the current value of the scroll position so we can return to this spot
		scrollTopPosition = window.parent.scrollY; 
		
		// scroll the parent to the vertical position of the linkTo element
		window.parent.scrollTo(element.offsetLeft, (elementYPos -offsetPadding) );	
		enablePrevious();
	}
	
	highLightObject(element, 2000);
}

function highLightObject(element, time=2000)
{
	// check if there already is an object being highlighted
	if(encapObject.querySelector(".refObjHighlight"))
	{
		encapObject.querySelector(".refObjHighlight").classList.remove("refObjHighlight");
		clearInterval(referenceTimer);
	}

	element.classList.add("refObjHighlight");
	referenceTimer = setTimeout(function() 
	{
		element.classList.remove("refObjHighlight");
	}, time);
}

// get the top and left position of the iframe within the parent window
function getIframeOffset()
{
	offsetLeft = 0;
	offsetTop = 0;	
	
	// check if the lesson is in an iframe
	if (window.self !== window.top)  // we are in an iframe
	{
		// get iframes from the parent windows:
		parentIFrames = window.parent.document.getElementsByTagName("iframe");
			
		// go through iframe to find which has the same source as this lesson  
		// 	(i.e., the iframe that contains this page)
		for(i=0; i<parentIFrames.length; i++)	// most likely there is only one iframe!
		{
			// this is the iframe that conatins the lesson
			if (window.location.href == parentIFrames[i].src) 
			{
				// distance between the top of this iFrame at the top of the parent window
				offsetLeft = parentIFrames[i].offsetLeft; 	
				offsetTop = parentIFrames[i].offsetTop; 
				break;  // don't need to check any more iframes
			}
		}
	}
	return[offsetLeft, offsetTop];
}

function enablePrevious()
{	
	// change the right-click menu to show the return link
	prevLocLink = document.getElementById("previousLocMenuItem");
	prevLocLink.classList.remove("disabledLink");
}

function linksToNewWindow()
{
	links = encapObject.querySelectorAll('a[href]');
	
	for(i=0; i<links.length; i++)
	{
		if(links[i].href.trim() != "" && !(links[i].classList.contains("sameWin")) &&
					!(links[i].classList.contains("download")) && 
					(links[i].target == "_self" || !(links[i].target)) )
		{
			links[i].target = "_blank";
		}
	}
}

function createEmailLink()
{
	emailLink = encapObject.getElementsByClassName("email");

	for(i=0; i<emailLink.length; i++)
	{
		// the title of the element should be an email address
		emailLink[i].addEventListener("click", function() {openEmailWindow(this.title);});
	}
}

function openEmailWindow(emailAddress)
{
	emailWindow = window.open("https://d2l.msu.edu/d2l/le/email/" + 
										redNum + "/ComposePopup");
	  
	emailWindow.onload = function() 
	{		
		header = emailWindow.document.body.querySelector(".vui-heading-1");
		header.innerText = "Send Message to Instructor";
			
		addressControl = emailWindow.document.getElementById("ToAddresses$control");
		addressControl.click();
		address = emailWindow.document.getElementById("ToAddresses");
		address.focus(); 
		if(emailAddress == "") emailAddress = instructorEmail;  // no email given -- go to default
		address.value = emailAddress;			
		
		subject = emailWindow.document.getElementById("Subject");
		subject.value = window.document.title;
	};
}

function fixIframeSize()
{
	iFrame = window.parent.document.getElementsByClassName("d2l-iframe");
	if (iFrame[0])
	{
		/* This might only be a FireFox Developers Edition issue -- 
			in which case it can be removed */
		iFrame[0].style.height = document.documentElement.scrollHeight + "px";
		setTimeout(function() 
					{
						iFrame[0].style.height = document.documentElement.scrollHeight + "px";
					}, 9000);
	}
}

function isValid(str)
{
	return !/[~`!#$%\^&*+=\[\]\\';,/{}|\\":<>\?]/g.test(str);
}

function createTextBox()
{
	textLine = encapObject.querySelectorAll("address");
	
	firstLine = true;
	lastLine = false;
	for(i=0; i<textLine.length; i++)
	{
		if(firstLine == true)
		{
			// start a new div
			textBoxDiv = document.createElement("div");
			textBoxDiv.classList.add("textBox");
			textBoxParent = textLine[i].parentNode;
			textBoxParent.insertBefore(textBoxDiv, textLine[i]);
			firstLine = false;
		}
		// check if the next line is an address
		if(!(textLine[i].nextElementSibling) || textLine[i].nextElementSibling.tagName != "ADDRESS")
		{
			firstLine = true;
		}
		
		// add textLine to div
		textBoxDiv.appendChild(textLine[i]);
	}
}

function captionFigures()
{
	// find all objects with class="caption" (usually H5)
	captions = encapObject.querySelectorAll(".caption");
	
	for(i=0; i<captions.length; i++)
	{
		// get the previous sibling for the caption (probably a <p>)
		prevSibling = captions[i].previousElementSibling;
		
		// don't attach a caption to an already existing figure or another caption
		//  -- no recursive figure-ing!
		if(prevSibling.tagName.toLowerCase() != "figure" &&
			!(prevSibling.classList.contains("caption")) )
		{		
			// find the first image within the prevSibling (should only be one)
			//figureObj = prevSibling.querySelector("img");

			// create a new figure caption -- copy old caption
			figureCaption = document.createElement("figcaption");	
			figureCaption.classList = captions[i].classList;
			figureCaption.innerHTML = captions[i].innerHTML; // need ID?
			figureCaption.id = captions[i].id; // need ID?
			
			// create a new figure -- copy from previous sibling and add caption
			figureElement = document.createElement("figure");
			
			// put new figure element at same position as the caption
			prevSibling.parentNode.insertBefore(figureElement, prevSibling);
			
			//figureElement.innerHTML = prevSibling.innerHTML;
			figureElement.appendChild(prevSibling);
			figureElement.appendChild(figureCaption);
			
			// remove the old caption and the previous element
			captions[i].parentNode.removeChild(captions[i]);
		}
	}
}


/**** DEPRECATED FUNCTIONS ****/
/*function fixMathJaxEQs()
{
	// change the display type of all math objects so they all display 
	//						in the same way (this is a D2L issue)
	// this works if it happens before mathjax javascript is executed 
	var m = document.querySelectorAll('math');
	
	for(i=0; i<m.length; i++)
	{
		m[i].setAttribute("display", "block");   // still needed??
	}
	
	// this works if it happens after mathjax javascript is executed 
	mathSpan = document.querySelectorAll("span.MathJax_Preview");
	//mathDis = document.querySelectorAll(".MathJax_Display");
	//mathPro = document.querySelectorAll(".MathJax_Processing");
	//mathPro2 = document.querySelectorAll(".MathJax_Processed");
	
	// MathJax/IE bug where annotations take up space but are not displayed
	// Might not be needed anymore 
	if(window.navigator.userAgent.indexOf("Edge ") > -1 || 
		window.navigator.userAgent.indexOf("MSIE "))
	{
		mathObj = document.getElementsByClassName("MJX_Assistive_MathML");
		for(i=0; i<mathObj.length; i++)
		{
			mathObj[i].style.cssText += ";display: none !important;";
		}
	}
}*/

/*
function mathEdit()
{
	// get all Math object in the page
	var mathObj = document.querySelectorAll('math');
	mathObjCount = mathObj.length;
	
	// switch the display to block for each math element
	// note: this is not the same as the CSS style block
	//     display = inline means math characters are resized to fit inline
	//     diaplay = block means math characters are styled naturally
	for(i=0; i<mathObj.length; i++)
	{
		mathObj[i].setAttribute("display", "block");
	}
	
	// if there are math objects, then
	if(mathObjCount > 0)
	{
		// execute the MathJax code
		D2LMathML2.DesktopInit(
			'https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.6/latest.js?config=MML_HTMLorMML',
			'https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.6/latest.js?config=TeX-AMS-MML_HTMLorMML%2cSafe'); 
		
		// do post mathJax manipulation
		postMathJax();
	}
}*/

/**** Changes to D2L MathJax code
  1) Need to stop loading 		
		D2LMathML.DesktopInit('https://s.brightspace.com/lib/mathjax/2.6.1/MathJax.js?config=MML_HTMLorMML',
		'https://s.brightspace.com/lib/mathjax/2.6.1/MathJax.js?config=TeX-AMS-MML_HTMLorMML%2cSafe');
     onDOMContent -- same as my code.
  2) MathJS error b.parentNode prevents move from MathJax_Preview -> MathJax_Display
****/	
/*
function postMathJax()
{
	// MathJax will change all math objects into class="MathJax_Display" --
	// find all mathJaxDisplay objects --
	// note: MathJax is running asynchronously, 
	//			so these objects will appear at different times
	mathDis = document.querySelectorAll(".MathJax_Display");
	countNum++;
	
	// For each MathJax_Display object
	for(i=0; i<mathDis.length; i++)
	{
		// if it has not been changed to display:inline, change it to display:inline
		if(mathDis[i].getAttribute("style") != "display: inline !important;" &&
			mathDis[i].classList.length == 1)
		{
			// When display=block is set, MathJax overcpmpensates and 
			// sets all style display to block !important.  Switching this to inline makes the formula 
			// more flexible and matches the style in the D2L editor
			mathDis[i].setAttribute("style", "display: inline !important;");
			count++;
		}
	}
	prevCount = count;
	
	// We are still waiting for MathJax to change all math objects
	if(count < mathObjCount)
	{
		// recursive call in 300ms
		setTimeout("postMathJax()", 300);
	}
	else  // we are done -- see if we need to scroll page
	{	
		if(window.location.hash.slice(1) != "") 
			scrollToElement(window.location.hash.slice(1), true);
		
		moveEqNum();
	}
}*/
/* takes
<p><img src="ImgSrc"></p>
<p class="caption">Caption text </p>

and converts it to

<figure>
	<img src="ImgSrc">
	<figCaption">Caption text </figCaption>
</figure>
UNUSED function -- too many complications in implementation!
function captionImages()
{
	// get all the images in the page (can later expand to tables, code-blocks...)
	var imagesInPage = encapObject.getElementsByTagName("img");
	
	/* should have this in D2L:
		[p]      <-- parent of image
		  [img]  <-- looking at images
		[/p]
		[p class="caption]	   <-- nextElementSibling of parent with caption
		[/p]
		
		and converting it to this:
		[p]
		   [figure]
		     [img]
			  [figcaption]  <-- old caption with "Fig. #:" appended
		   [/figure]
		[/p]
	
	for(i=0; i<imagesInPage.length; i++)
	{	
		// trying to find the paragraph [p] parent of the image --
		// the problem is that there might be [b], [i], or [span] ancestors in the way
		parElement = imagesInPage[i].parentElement;

		while(parElement && parElement.tagName != "P")
		{
			parElement = parElement.parentElement;
		}
		
		/*** Add error onscreen if parent [p] not found?? ***
		// first make sure that we actally got an element and not end-of-page
		if(parElement)  
		{
			/* need to find a class="caption" element in the next element 
				sibling's descendants again, same issue as before where you should have
			      [p class="caption"] 
					but could have
					[p][span][b][i][span class="caption"]    
					
			if(parElement.nextElementSibling)  // if there is a next sibling
			{
				// go to the next sibling (likely a [p])
				capElement = parElement.nextElementSibling;  
			
				while(capElement.childElementCount != 0 && 
						!(capElement.classList.contains("caption")) )
				{
					capElement = capElement.childNodes[0];
				}

				/*** Add error onscreen if caption not found?? **
				// make sure we found an element with class = "caption"
				if(capElement.classList.contains("caption"))
				{
					// create a [figure] element
					figure = document.createElement("figure");	

					// create a [figcaption] element					
					figCaption = document.createElement("figCaption");	
					
					// copy caption in [figcaption] element and preprend with the figure number
					figCaption.innerHTML = capElement.innerText;	
					figCaption.classList.add("caption");		// add caption class to [figCaption]
					figure.appendChild(imagesInPage[i]);		// add image to [figure]
					figure.appendChild(figCaption);				// add [figcaption] to [figure]
					
					// remove the original caption
					capElement.parentElement.removeChild(capElement);
					
					// add figure to parent of image
					parElement.appendChild(figure);
				}
			}
		}
	}
}


function addCodeBlockToggle()
{
	codeBlocks = document.body.querySelectorAll(".codeBlock");

	for(i=0; i<codeBlocks.length; i++)
	{
		if(codeBlocks[i].childElementCount > 8)
		{
			if(codeBlocks.id == "") codeBlocks.id = "codeblock" + i
			
			par = document.createElement("p");
			par.classList.add("noSelect");
			par.style.textAlign = "right";
			tabSpan = document.createElement("span");
			tabSpan.classList.add("codeTab");
			tabSpan.classList.add("codeTabTop");
			tabSpan.classList.add("noSelect");
			tabSpan.innerHTML = "\u2013";
			tabSpan.addEventListener("click", function() {toggleCodeBlock(this, "top");} );
			par.appendChild(tabSpan);
			codeBlocks[i].insertBefore(par, codeBlocks[i].children[0]);
			
			par = document.createElement("p");
			par.classList.add("noSelect");
			par.style.textAlign = "left";
			tabSpan = document.createElement("span");
			tabSpan.classList.add("codeTab");
			tabSpan.classList.add("codeTabBottom");
			tabSpan.classList.add("noSelect");
			tabSpan.innerHTML = "\u2013";
			tabSpan.addEventListener("click", function() {toggleCodeBlock(this, "bottom");} );
			par.appendChild(tabSpan);
			codeBlocks[i].appendChild(par);
		
		}
	}
}

function toggleCodeBlock(tab, position)
{
	cb = tab.parentNode.parentNode;
	codeLines = cb.querySelectorAll(".code");

	if(position == "top")
	{
		otherTab = cb.lastElementChild.children[0];
	}
	else
	{
		otherTab = cb.children[0].children[0];
	}

	if(tab.innerText != "\u25A1")
	{
		tab.innerText =  "\u25A1";	// make a hollow square
		otherTab.innerText =  "\u25A1";	// make a hollow square
		
		for(i=3; i<codeLines.length; i++)  // start at the third line
		{
			codeLines[i].style.display = "none";		
		}
	}
	else
	{
		tab.innerText =  "\u2013"; 		// make an endash
		otherTab.innerText =  "\u2013"; // make an endash
		
		for(i=3; i<codeLines.length; i++)  // start at the third line
		{
			codeLines[i].style.display = "block";		
		}
	}
}

*/

/* For all equations that have a number --
   moves the number to an appropriate spot if the equation has multiple lines.
	This is hacky! 
	I belive this has now been deprecated by display: inline-flex and other stuff
function moveEqNum()
{
	// get all elements with class = eqNum
	eqNumObj = document.querySelectorAll("span.eqNum");

	// find all elements that use the clip style
	for(i=0; i<eqNumObj.length; i++)
	{	
		// remove the font-family style using in the D2L editor (Dotum)
		eqNumObj[i].style.fontFamily = null;
		
		// get the parent node of the eqNum object
		eqNumParent = eqNumObj[i].parentNode;
		
		// get through each child element of eqNum 
		for(j=0; j<eqNumObj[i].childElementCount; j++)
		{
			// move children up one level (basically, this makes eqNum a last sibling instead of a parent)
			eqNumParent.insertBefore(eqNumObj[i].firstChild, eqNumObj[i]);
		}
		
		// find all multiple-line equations -- which all use the style MathJax_FullWidth 
		// multiple-line equations cause problems with the eqNum object
		if(FW = eqNumObj[i].parentNode.querySelector("span.MathJax_FullWidth"))
		{
			/**** setting the top position of the equation number ***
			// set the eqNum position to relativ to allow it to move
			eqNumObj[i].style.position = "relative";
			
			// get the bounding rectangles of the equation and the equation number
			eqNumRect = eqNumObj[i].getBoundingClientRect();
			eqRect = FW.getBoundingClientRect() 

			// use the height and top values to move the equation number 
			eqNumObj[i].style.top = ( eqRect.top - eqNumRect.top ) + 
											(eqRect.height/2 - eqNumRect.height) + "px";


			/**** setting the left position of the equation number 
					issue: need to find the widest line in the multi-line equation ***
			// the bounding box of each line in the equation uniquely has a margin-left style
			spanClips = eqNumParent.querySelectorAll("span[style*=margin-left]");
			
			maxLineWidth = 0;  // initial state value
			
			// go through each span clip to find which is the widest
			for(j=0; j<spanClips.length; j++)
			{
				lineWidth = spanClips[j].getBoundingClientRect().width; // get width of current EQ line

				if(lineWidth > maxLineWidth)
				{
					maxLineWidth = lineWidth;
					eqLeftPos = spanClips[j].getBoundingClientRect().left; // get left of current EQ line
				}
			}	
			
			// use the height and top values to move the equation number to the appropriate left pos
			eqNumObj[i].style.left = ( maxLineWidth + eqLeftPos - eqNumRect.left + 10) + "px";
		}
	}
}
*/	