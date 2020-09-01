/**
 ****************** DOM EVENTS *********************************
 */


debug = false; /*Set true to see any console log*/

$(document).ready(function (e) {
    renderLandingPageFile($(this));
    
});

$('.fSwitch').on('click', function (e) {
    $('.sidebar-left .nano').css('width','auto');
    renderLandingPageFile($(this));
});


$('.root-link').on('click', function (e) {
    //$('.nav-main li a span').css('visibility','collapse');
    $('.sidebar-left .nano').css('width','auto');
    var rootPath = $(this).attr('data-root');
    var typeId = $(this).attr('id');
    localStorage.setItem('typeId',typeId);
    var pageHeaderText = $(this).attr('data-pageHeaderText');
    $('.page-header-text').empty().html(pageHeaderText);
    $('.breadcrumbText').empty().html(pageHeaderText);
    console.log(pageHeaderText);
    $('#panel-title').html('File');
    resizePanelbox();
    resetUI();
    log(rootPath);
    log(typeId);

    showTreeWrapper();
    hideLandingWrapper();

    $('#directoryTreeContainer_1').fileTree({
        //root: '../config/', /*must end with slash(/)*/
        root: rootPath, /*must end with slash(/)*/
        script: 'Read.php', /*Script file name*/
        expandSpeed: '-1',
        collapseSpeed: '-1'
    }, function (file) {
        readFileContent(file);
        resizePanelbox();
        
    });
});


function fileName(){ 
    $('.file-list').on('click', function () {
        var xmlFileName = $(this).html();
        console.log(xmlFileName);
        //alert(xmlFileName);
        $('#panel-title').html(xmlFileName);
    });
}

/**
 ************************ END OF DOM EVENTS ***********************
 */



/**
 ****************** Functions *********************************
 */
function log(obj) {
    if (debug == true) {
        console.log(obj);
    } else {
        console.log('script debug log is turned off by developer');
    }

}

function resetUI() {
    $('#read-message').empty().html('');
    $('#file-content').empty().html('');
    $('#read_file_name').empty().html('');
    $('#download-link').empty().html('');
    if (!$('.file-show-container').hasClass('container-scroll')) {
        $('.file-show-container').addClass('container-scroll');
    }
}

function hideLandingWrapper() {
    $('.landing-wrapper').addClass('hidden');
}

function showLandingWrapper() {
    $('.landing-wrapper').removeClass('hidden');
}

function showTreeWrapper() {
    $('.file-tree-wrapper').removeClass('hidden');
}

function hideTreeWrapper() {
    $('.file-tree-wrapper').addClass('hidden');
}

function renderLandingPageFile(domObj) {
    getLandingPageFile('../artifacts/');

    var file = domObj.attr('data-file');
    var subTitleAttr = domObj.attr('data-subTitle');

    defaultFile = (file == undefined) ? '/feature-overview.html' : '/' + file;
    var subTitle = (subTitleAttr == undefined) ? 'Feature Overview' : subTitleAttr;
    showLandingWrapper();
    hideTreeWrapper();
    $('.iframe').css('display', 'none');
    resizeIframe();
    $('.page-header-text').empty().html('Dashboard');
    $('.breadcrumbText').empty().html(subTitle);
    $('.landing-wrapper .panel-heading-text').empty().html(subTitle);
    
    getAnalyticsUrl();
    getABotReleaseNo();
}

function getLandingPageFile(dirName) {
    ajaxRequest.url = 'Read.php';
    ajaxRequest.method = 'POST';
    ajaxRequest.async = true;
    ajaxRequest.data = {requestId: 'readArtifacts', dir: dirName};
    ajaxRequest.beforeSend = function () {
        //console.log('before send - show ajax loader');
    };
    ajaxRequest.successListner = function (data) {
        resizePanelbox();
        //console.log('ajax success');
        //console.log(data[0]);
        //$('#myframe').attr('src',dirName+data[0]+'/report-'+data[0]+'/feature-overview.html');
        //var html = '<iframe src="' + dirName + data[0] + '/report-' + data[0] + defaultFile + '" id="myframe" frameborder="0" class="iframe" width="100%" height="500px">';
        /***Added object tag on reporing a url space bug on 06-10-2016***/
        var html = '<object width="100%" height="500px" data="' + dirName + data[0] + '/report-' + data[0] + defaultFile + '" class="fileObj" id="fileObj"></object>';
        $('#landing-file-container').empty().html(html);
        
        var objectHeight = $('.panel-body').height();
        $('#fileObj').css('height', objectHeight);
        
        $('#file-content-mask').css('display','block');
        $('#file-content-mask').css('height', objectHeight);
        
        $( "#landing-file-container" ).load( html, function() {
          console.log( "Load was performed." );
          landingObjectContent();    
        });
        
        //resizeIframe();
    };
    ajaxRequest.doRequest();
    ajaxRequest.abortRequest();
}

function readFileContent(file) {
    ajaxRequest.url = 'Read.php';
    ajaxRequest.method = 'POST';
    ajaxRequest.async = true;    
    ajaxRequest.data = {requestId: 'getFileContent', path: file};
    ajaxRequest.beforeSend = function () {
        console.log('before send - show ajax loader');
    };
    ajaxRequest.successListner = function (data) {
        //console.log(data); 
        if (data.containerScroll == false) {
            $('.file-show-container').removeClass('container-scroll');
        } else {
            if (!$('.file-show-container').hasClass('container-scroll')) {
                $('.file-show-container').addClass('container-scroll');
            }
        }
        $('#read-message').empty().html(data.message);
        $('#file-content').empty().html(data.content);
        $('#read_file_name').empty().html(data.file);        
        
        $( "#file-content" ).load( data.content, function() {
          console.log( "Load was performed." );
          resizeIframe();    
        });
        
        
        var objectHeight1 = $('.panel-body').height();
        $('#fileObject').css('height', objectHeight1);
        $('#xml-pre').css('height', objectHeight1);
        
        //console.log('call-me: '+objectHeight1);
        $('#file-contentmask').css('display', 'block');
        $('#file-contentmask').css('height', objectHeight1);
        
        objectContent();
        
        //var xmlFileName = $('.file-list').html();
        //console.log(xmlFileName);
        //var dataFileName = $('#fileObject').attr("data");        
        //var parts = dataFileName.split("/");
        //var result = parts[parts.length - 1]; // Or parts.pop();
        //console.log(result);
        //$('#panel-title').html(xmlFileName);
        //$('#panel-title').html(result);
        //var fileContentWidth = $('.panel-body').width();
        //$('#file-content-mask').css('width', fileContentWidth);

        

        if (data.showDownload == true) {
            $('#download-link').empty().html(data.download);
        } else {
            $('#download-link').empty().html('');
        }
    };
    ajaxRequest.doRequest();
    ajaxRequest.abortRequest();
}

function iframeContentLink() {
    console.log('Now Click on iFrame Content Link');
    $('#fileObj').contents().find("a").click(function () {
        console.log('Click Event Fire');
        $('#file-content-mask').css('display','block');
        resizeIframe();
        landingObjectContent();
    });
    $('#fileObject').contents().find("a").click(function () {
        console.log('Click Event Fire');
        $('#file-contentmask').css('display','block');
        resizeIframe();
        objectContent();
    });
}

function resizeIframe() {
    setTimeout(function () {
        refreshiframe();
    }, 1000);
    //Set timeout for iFrame Content Link Loaded
    setTimeout(function () {
        iframeContentLink();
    }, 1000);

}

function refreshiframe() {
    $('#myframe').css('height', "0");
    $('#myframe').css('display', 'block');
    $('#myframe').contents().find('.footer').css('display', 'none');
    $('#myframe').contents().find('#fullwidth_header').css('display', 'none');
    $('#myframe').contents().find('#fullwidth_gradient').css('margin-top', '0');
    $('#myframe').contents().find('.heading').css('margin-top', '0');
    $('#myframe').contents().find('.stats-table td').css({'word-wrap': 'break-word', 'word-break': 'break-all', 'white-space': 'normal'});
    var iframeHeight = $('#myframe').contents().height();
    $('#myframe').css('height', iframeHeight);
    resizePanelbox();
    $('#myframe').css('display', 'block');

}

function resizePanelbox() {
    var headerHeight = $('.header').height();
    var pageheaderHeight = $('.page-header').height();
    var contentbodypadding = 70;
    var panelheadingHeight = 40;
    var windowHeight = $(window).height();
    //console.log('headerHeight= ' + headerHeight + ' pageheaderHeight= ' + pageheaderHeight + ' panelheadingHeight= ' + panelheadingHeight + ' contentbodypadding=' + contentbodypadding + ' windowHeight= ' + windowHeight);

    var heightPanelbox = windowHeight - (headerHeight + pageheaderHeight + contentbodypadding + panelheadingHeight);
    $('.panel-body').css('height', heightPanelbox);
    setTimeout(function () {
        $('.sidebar-left .nano').css('width','');
    }, 600);
}

function objectContent() {
    setTimeout(function () {        
        console.log('call');
        $('#fileObject').contents().find('#fullwidth_header').css('display', 'none');
        $('#fileObject').contents().find('#fullwidth_header').css('display', 'none');
        $('#fileObject').contents().find('#fullwidth_gradient').css('margin-top', '0');
        $('#fileObject').contents().find('.heading').css('margin-top', '0');
        $('#fileObject').contents().find('.footer').css('display', 'none');
        $('#fileObject').contents().find('.stats-table td').css({'word-wrap': 'break-word', 'word-break': 'break-all', 'white-space': 'normal'});
        $('#file-contentmask').css('display', 'none');
    }, 1000);
}
function landingObjectContent(){    
    setTimeout(function () {
        $('#fileObj').contents().find('#fullwidth_header').css('display', 'none');
        console.log( "Header OFF." );
        $('#fileObj').contents().find('#fullwidth_header').css('display', 'none');
        $('#fileObj').contents().find('#fullwidth_gradient').css('margin-top', '0');
        $('#fileObj').contents().find('.heading').css('margin-top', '0');
        $('#fileObj').contents().find('.footer').css('display', 'none');
        $('#fileObj').contents().find('.stats-table td').css({'word-wrap': 'break-word', 'word-break': 'break-all', 'white-space': 'normal'});
        $('#file-content-mask').css('display','none');
    }, 1000);
}

function getAnalyticsUrl(){
  $.ajax({
        type: "POST",
        url: 'Read.php',
        data: {requestId: 'openAnalyticsUrl'},
        async: true,
        success: function(result, textStatus){
            console.log($(".nav-main").html())
            $(".nav-main").append(result)
        }
    });
}

function getABotReleaseNo(){
        $.ajax({
        type: "POST",
        url: 'Read.php',
        data: {requestId: 'getABotReleaseNo'},
        async: true,
        success: function(result, textStatus){
            console.log("Release No is: "+result)
            $("#release-no").html("<p>Release No: <span>"+result+"</span></p>")
        }
    });
}

/**
 ****************** End of Functions *********************************
 */