'use strict';

define(['app'], function (app) {

    app.directive('externalhtml', function() {
        return {
        restrict: 'E',
        scope: {
            src: '='
        },
        link: function(scope, element, attrs) {
            //var url = scope.$eval(attrs.src);
             scope.$watch('src', function(newValue, oldValue) {
                //console.log("url:- "+newValue+":"+oldValue);
                if (newValue != undefined && newValue != "")
                    console.log("I see a data change! -- Dont Delete -- "+ newValue );
                    element.replaceWith('<object type="text/html" data="' + newValue + '" class="'+attrs.class+'" width="'+attrs.width+'" height="'+attrs.height+'" name="'+attrs.id+'" id="'+attrs.id+'"></object>');
                    $('#fileObj').load(function(){
                        //console.log('object');

                        $('#fileObj').contents().find('#fullwidth_header').css('display', 'none');
                        $('#fileObj').contents().find('#fullwidth_gradient').css('margin-top', '0');
                        $('#fileObj').contents().find('.heading').css('margin-top', '0');
                        $('#fileObj').contents().find('.footer').css('display', 'none');
                        $('#fileObj').contents().find('.stats-table td').css({'word-wrap': 'break-word', 'word-break': 'break-all', 'white-space': 'normal'});
                        $('#file-content-mask').css('display','none');
                        
                        //var objectHeight = $('.panel-body').height();
                        var headerHeight = $('.header').height();
                        var pageheaderHeight = 50;
                        var footerHeight = 30;
                        var windowHeight = $(window).height();
                        var heightPanelbox = windowHeight - (headerHeight + pageheaderHeight + footerHeight + 7)+'px';
                        $('#fileObj').css('height',heightPanelbox);
                        
                        var baseuri = $('#fileObj').contents()[0].baseURI;
                        //console.log("37-- Dont Delete --", baseuri);
                        //console.log("42", baseuri.indexOf("feature-overview.html"));
                        if((baseuri.indexOf("feature-overview.html")<0) && (baseuri.indexOf("tag-overview.html") <0))
                        {
                            //console.log("41-- Dont Delete --");
                            $('.downloadArtifactsFolder').css('display', 'none');
                            $('.downloadReportFile').css('display', 'block');
                            
                            var selectedReportName = baseuri.split("/");
                            selectedReportName = selectedReportName[selectedReportName.length-1];
                            //console.log("46", selectedReportName);
                                                        
                            var featureValue = selectedReportName.split(".");
                            //console.log("50", featureValue);
                            //var reportName = featureValue.slice(0, featureValue.length - 2).join(".") + ".pdf";
                            var reportName = featureValue[0] + ".pdf";
							//console.log("51", reportName);
                           
                            //scope.reportName = selectedReportName[selectedReportName.length-1];
                            //$rootScope.reportName = selectedReportName[selectedReportName.length-1] ;
                            var tooltipVal = reportName
                            $("#download_btn").attr("title",tooltipVal);
                            $(".downloadReportFile").css("cursor", "pointer");
                            scope.fullFilePath = baseuri;
                        }
                    })
            });
           
        }
    };
    })
});

