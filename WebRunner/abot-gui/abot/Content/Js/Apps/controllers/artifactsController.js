/* 
 Created on : 14 March, 2017, 10:31:40 AM
 Author     : Joydeep
 */
'use strict';

define(['app'], function (app) {
	
    var injectParams = ['$scope', '$state', '$rootScope', '$timeout', '$interval', 'dialogs', '$window', '$mdDialog', 'AppConfig', 'growl', '$sce', 'uuid', 'PyService'];
    var artifactsController = function ($scope, $state, $rootScope, $timeout, $interval, dialogs, $window, $mdDialog, AppConfig, growl,  $sce, uuid, PyService) {
        
    	$scope.rootPath = "";
    	$scope.selectedFileType = "";
    	$scope.selectedItemType = "";
    	var TYPE_FILE = "file";
    	var TYPE_FOLDER= "folder";
    	var TYPE_REPORT = "report";
    	
    	$timeout(function(){
    		$(".panel-left").resizable({
 			   handleSelector: ".splitter",
 			   resizeHeight: false
 			 });

 			 $(".panel-top").resizable({
 			   handleSelector: ".splitter-horizontal",
 			   resizeWidth: false
 			 });
 			 
 			 ////----------- Adjusting Panel height -----------------------------
 			$("#artifactsLeftTree").height($(window).height() - 200);
 			$("#artifactsSplitter").height($(window).height() - 165);
 			$("#artifactsContent").height($(window).height() - 165);
 			$("#artifactsFeature").height($(window).height() - 165);
 			//$("#artifactsContainer").height($(window).height() - 231);
    	},50);
    	
       $scope.init = function() {
    	   PyService.GetArtifactTreeView('artifacts/', "artifactsFiles").then(function(response){
    		//    console.log('Artifacts Tree view :: ', response);
    		   $scope.treedata = response.data.tree_list;
    	   });
       }
       
       $scope.downlodFolderAsZip = function(){
    	   PyService.GetArtifactFolder($scope, $scope.selectedArtifactFolder).then(function(response){
    		   var downloadedFolder = response.data.result+".zip";
    		   if(response != ""){
    			   if (window.location.port != "") {
                       $window.open('http://' + window.location.hostname + ':' + window.location.port + '/artifacts/' + downloadedFolder)
    			   } else {
                       $window.open('http://' + window.location.hostname + '/artifacts/' + downloadedFolder)
    			   }
    		   } 
    	   });
       };
       
       $scope.downloadReport = function($event){
           var baseuri = $('#artifactsFeature').contents()[0].baseURI;
           var selectedReportName = baseuri.split("/");
           //$scope.selectedFileNameDownload = selectedReportName[selectedReportName.length-4];
           $scope.filepath = selectedReportName.slice(Math.max(selectedReportName.length - 4, 1))
           $scope.fullFilePath = AppConfig.pathToData+ $scope.filepath.join("/");
           //PyService.GetFileContentView($scope, $scope.fullFilePath);
           PyService.GetReportPDF($scope, $scope.fullFilePath);
       }
       $scope.$on("OnGetReportContentViewEvent", function (event, response, error_msg){
           var pdfFileName = response.result['download'];
           if(response != ""){
               var serverUrl = PyService.getServerRestAPI() + 'download_report_content?file=';
               $window.open(serverUrl + pdfFileName);
          }
       });

       
       $scope.printParent = function($event) {
           //$('#landing-file-container').css('display','none');
           $("#artifactsFeature").attr("data", "");
           var root = $scope;
           var currentScope = angular.element($event.target).scope();
           if (currentScope == null) {
        	   return;
           }
           $scope.rootPath = [];
           $scope.selectedFileName = currentScope.node['label'];
           currentScope = currentScope.$parent;
           
           while(currentScope.$id !== root.$id) {
               $scope.rootPath.push(currentScope.node['label']);
               currentScope = currentScope.$parent;
           }
           $scope.rootPath = $scope.rootPath.reverse().join("/");
           
          // var heightPanelbox = (windowHeight - (headerHeight + pageheaderHeight + footerHeight));
           //$('#rightPanel').css('height', heightPanelbox);
           
           $scope.selectedFileType = $scope.selectedFileName.split('.').pop();
           $scope.selectedFilePart = $scope.selectedFileName.split('-')[0];
           
           if($scope.selectedFileType == "html"){
               $scope.logData = '';
               $scope.selectedItemType = TYPE_FILE;
               $scope.fullFilePath = "../" +  AppConfig.pathToData + 'artifacts/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
               $scope.html = $scope.fullFilePath;
               angular.element('#artifactsFeature').on('load', event => adjustArtifacts());
               $("#artifactsFeature").attr("src", $scope.html);
               /*$timeout(function(){
               	adjustArtifacts();
               }, 300);*/
               
           }
           else if($scope.selectedFileType == "log" || $scope.selectedFileType == "csv"){
        	   $scope.selectedItemType = TYPE_FILE;
               $scope.fullFilePath = "../" + AppConfig.pathToData + 'artifacts/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
               if(angular.element($event.target).scope().$parent.node.label != undefined)
               {
                   $scope.parentLabel =angular.element($event.target).scope().$parent.node.label;
               }
               
               PyService.GetFileContentView($scope, $scope.fullFilePath, 'log').then(function(response){
            	//    console.log(response.data);
                   $scope.logData = response.data.result.content;
               });

               $scope.selectedLogName = $scope.selectedFileName;
               $scope.selectedLogExt = $scope.selectedLogName.slice($scope.selectedLogName.length-4);
               $scope.selectedLogFirstName = $scope.selectedLogName.slice(0, $scope.selectedLogName.length-4);
               
               $scope.selectedFileNameDownload = $scope.selectedLogFirstName+"_"+ $scope.parentLabel + $scope.selectedLogExt;
               $scope.downloadFileName = $scope.selectedFileName;
               
           }
           else if($scope.selectedFileType == "zip"){
        	   $scope.selectedItemType = TYPE_FILE;
               $scope.fullFilePath = "../" + AppConfig.pathToData+ 'artifacts/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
               $scope.logData = '';
               /*$('.downloadArtifactsFolder').css('display', 'none');
               $('#download-link').css('display', 'block');
               $('.downloadLogFile').css('display', 'none');
               $('#panel-title').html($scope.selectedFileName);*/
               $rootScope.selectedFile = "   >   " + $scope.selectedFileName;
           }
           else if($scope.selectedFileType == "pcap"){
        	   $scope.selectedItemType = TYPE_FILE;
               $scope.fullFilePath = "../" + AppConfig.pathToData+ 'artifacts/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
               $rootScope.selectedFile = "   >   " + $scope.selectedFileName;
           }
           else if($scope.selectedFilePart !== "report"){
        	   $scope.selectedFileType = 'html';
        	   $scope.selectedItemType = TYPE_FOLDER;
        	   $scope.fullFilePath = "../" + AppConfig.pathToData + "artifacts"+ $scope.rootPath +'/'+ $scope.selectedFileName + '/report-'+ $scope.selectedFileName + "/feature-overview.html";
        	   $scope.html = $scope.fullFilePath;
        	   angular.element('#artifactsFeature').on('load', event => adjustArtifacts());
               $("#artifactsFeature").attr("src", $scope.html);
               /*$timeout(function(){
               	adjustArtifacts();
               }, 400);*/
        	   
               $scope.selectedArtifactFolder = $scope.selectedFileName; 
               $scope.downloadFolderName = $scope.selectedFileName;
           }
           else if($scope.selectedFileName.split('-')[0] == "report"){
        	   $scope.selectedItemType = "";
               $scope.fullFilePath = "";
               $scope.html = "";
        	   return;
        	   $scope.selectedItemType = TYPE_FOLDER;
               $scope.fullFilePath = "../" + AppConfig.pathToData + 'artifacts/'+ $scope.rootPath +'/'+ $scope.selectedFileName + "/feature-overview.html";
               $scope.html = $scope.fullFilePath;
               angular.element('#artifactsFeature').on('load', event => adjustArtifacts());
               $("#artifactsFeature").attr("src", $scope.html);
               /*$timeout(function(){
               	adjustArtifacts();
               }, 400);*/
           }
           $scope.displayPath = $scope.fullFilePath.replace(AppConfig.pathToData, "/");
       }
       
       function adjustArtifacts(){
    	   $('#artifactsFeature').contents().find('#fullwidth_header').css('display', 'none');
    	   $('#artifactsFeature').contents().find('#fullwidth_gradient').css('margin-top', '0');
    	   $('#artifactsFeature').contents().find('.heading').css('margin-top', '0');
    	   $('#artifactsFeature').contents().find('.footer').css('display', 'none');
    	   $('#artifactsFeature').contents().find('.stats-table td').css({'word-wrap': 'break-word', 'word-break': 'break-all', 'white-space': 'normal'});
    	   $('#file-content-mask').css('display','none');
    	   $('#artifactsFeature').show();
    	   
    	   $("#artifactsFeature").load(function(){
        	   
        	   var baseuri = $("#artifactsFeature").contents()[0].baseURI;
            //    console.log("37-- Dont Delete --", baseuri);
               //console.log("42", baseuri.indexOf("feature-overview.html"));
               if((baseuri.indexOf("feature-overview.html")<0) && (baseuri.indexOf("tag-overview.html") <0))
               {
                   
                   var selectedReportName = baseuri.split("/");
                   $scope.selectedReportName = selectedReportName[selectedReportName.length-1];
                   
                                               
                   var featureValue = $scope.selectedReportName.split(".");
                   var reportName = featureValue.slice(0, featureValue.length - 2).join(".") + ".pdf";
                  
                   var tooltipVal = reportName
                   $scope.fullFilePath = baseuri;
                   setTimeout(function () {
                	   $scope.$apply(function () {
                		   $scope.selectedItemType = TYPE_REPORT;
                	   });
                   }, 200);
                   $scope.selectedItemType = TYPE_REPORT;
               }
    	   });
               
       };
       
       /*$("#artifactsFeature").load(function(){
    	   
    	   var baseuri = $("#artifactsFeature").contents()[0].baseURI;
           console.log("37-- Dont Delete --", baseuri);
           //console.log("42", baseuri.indexOf("feature-overview.html"));
           if((baseuri.indexOf("feature-overview.html")<0) && (baseuri.indexOf("tag-overview.html") <0))
           {
               
               var selectedReportName = baseuri.split("/");
               $scope.selectedReportName = selectedReportName[selectedReportName.length-1];
               
                                           
               var featureValue = $scope.selectedReportName.split(".");
               var reportName = featureValue.slice(0, featureValue.length - 2).join(".") + ".pdf";
              
               var tooltipVal = reportName
               $scope.fullFilePath = baseuri;
               setTimeout(function () {
            	   $scope.$apply(function () {
            		   $scope.selectedItemType = TYPE_REPORT;
            	   });
               }, 200);
               $scope.selectedItemType = TYPE_REPORT;
               alert($scope.fullFilePath);
           }
           //console.log('object');
           /*$('#fileObj').contents().find('#fullwidth_header').css('display', 'none');
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
           console.log("37-- Dont Delete --", baseuri);
           //console.log("42", baseuri.indexOf("feature-overview.html"));
           if((baseuri.indexOf("feature-overview.html")<0) && (baseuri.indexOf("tag-overview.html") <0))
           {
               console.log("41-- Dont Delete --");
               $('.downloadArtifactsFolder').css('display', 'none');
               $('.downloadReportFile').css('display', 'block');
               
               var selectedReportName = baseuri.split("/");
               selectedReportName = selectedReportName[selectedReportName.length-1];
               //console.log("46", selectedReportName);
               
                                           
               var featureValue = selectedReportName.split(".");
               //console.log("50", featureValue);
               var reportName = featureValue.slice(0, featureValue.length - 2).join(".") + ".pdf";
               //console.log("51", reportName);
              
               //scope.reportName = selectedReportName[selectedReportName.length-1];
               //$rootScope.reportName = selectedReportName[selectedReportName.length-1] ;
               var tooltipVal = reportName
               $("#download_btn").attr("title",tooltipVal);
               $(".downloadReportFile").css("cursor", "pointer");
               scope.fullFilePath = baseuri;
               
           }
           
       });*/


       
    };
    artifactsController.$inject = injectParams;
    app.controller('ArtifactsCtrl', artifactsController);
    
});
