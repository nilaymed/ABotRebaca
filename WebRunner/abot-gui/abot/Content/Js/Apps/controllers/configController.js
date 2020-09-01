/* 
 Created on : 14 March, 2017, 10:31:40 AM
 Author     : Joydeep
 */
'use strict';

define(['app'], function (app) {
	
    var injectParams = ['$scope', '$state', '$rootScope', '$timeout', 'AppConfig', 'PyService', 'growl'];
    var configController = function ($scope, $state, $rootScope, $timeout, AppConfig, PyService, growl) {
        $scope.treedata = [];
        $scope.selectedConfig = 'XXX';
        $scope.pageHeaderheading = "Config /";
        $scope.displayPath = "Not selected";
        $scope.tooltipText = "Config File Path";
        $scope.readOnlyMode = true;
        $scope.selectedFileName = "";
        var originalData = "";
        
        $timeout(function(){
    		$(".panel-left").resizable({
 			   handleSelector: ".splitter",
 			   resizeHeight: false
 			 });

 			 $(".panel-top").resizable({
 			   handleSelector: ".splitter-horizontal",
 			   resizeWidth: false
 			 });
 			 
 			///----------- Adjusting Panel height -----------------------------
   			$("#configLeftTree").height($(window).height() - 200);
   			$("#configSplitter").height($(window).height() - 165);
   			$("#configContent").height($(window).height() - 165);
               $("#configFileView").height($(window).height() - 165);
               $(window).trigger("resize");
    	},50);
        
    	$scope.init = function() {
     	  PyService.GetConfigView('static/config').then(function(response){
     		//  console.log(response);
     		 $scope.treedata = response.data.tree_list;
     	  });
        };
        
        $scope.printConfigParent = function($event) {
        	if ($scope.readOnlyMode==false) {
    			return;
    		}
        	 $scope.configData = "";
        	 var root = $scope;
             var currentScope = angular.element($event.target).scope();
             $scope.rootPath = [];
             $scope.selectedFileName = currentScope.node['label'];
             currentScope = currentScope.$parent;
             
             while(currentScope.$id !== root.$id) {
                 $scope.rootPath.push(currentScope.node['label']);
                 currentScope = currentScope.$parent;
             }
             $scope.rootPath = $scope.rootPath.reverse().join("/");
             $scope.selectedFolder = $scope.rootPath;
             $rootScope.selectedFile = " / " + $scope.selectedFileName;
             
             if(typeof $scope.rootPath != 'undefined' && $scope.rootPath != ""){
                 var pathArray = $scope.rootPath.split('/');
                 $scope.selectedFolder = '';
                 pathArray.forEach(function(current_value) {
                     $scope.selectedFolder = $scope.selectedFolder + " / " + current_value;
                 });
             }
             
            /* if($scope.rootPath != undefined && $scope.rootPath != ""){
                 var pathArray = $scope.rootPath.split('/');
                 $rootScope.selectedFolder = '';
                 pathArray.forEach(function(current_value) {
                     $rootScope.selectedFolder = $rootScope.selectedFolder + " / " + current_value;
                 });
             }*/
             
             
           /* 
            //var headerHeight = $('.header').height();
            //var pageheaderHeight = $('.page-header').height();
            //var contentbodypadding = 30;
            //var panelheadingHeight = 50;
            //var footerHeight = 30;
            //var windowHeight = $(window).height();
           */
            if($scope.selectedFileName.split('.').pop() == "properties" || $scope.selectedFileName.split('.').pop() == "template"){
                /*$scope.logData = '';
                $('.downloadLogFile').css('display', 'block');
                $('#download-link').css('display', "none");
                $('.downloadArtifactsFolder').css('display', "none");
                
                $('#logDataBox').css('display','none');
                $('#landing-file-container').css('display','block');*/
                
                $scope.fullFilePath = AppConfig.pathToData+ 'config'+ $scope.rootPath +'/'+ $scope.selectedFileName;
                //$('#download-link').css('display', 'none');
                PyService.GetFileContentView($scope, $scope.fullFilePath, 'properties').then(function(response){
                	// console.log('On Prop select', response.data);
                	$scope.configData = response.data.result.content;
                });
                $scope.downloadFileName = $scope.selectedFileName;
                /*$('#panel-title').html($scope.selectedFileName);
                $scope.downloadFileName = $scope.selectedFileName;
                $rootScope.selectedFile = "   >   " + $scope.selectedFileName;
                
                //var heightPanelbox = windowHeight - (headerHeight + panelheadingHeight + footerHeight)+'px';
                //$('.panel-body').css('height', heightPanelbox);
                $('.editFeatureFile').css('display', 'block');
                $rootScope.selectedFile = "   /   " + $scope.selectedFileName;*/
                /*var heightPanelbox = (windowHeight - (headerHeight + pageheaderHeight + footerHeight));
                var panelwidth = $('#rightPanel .panel-body').width();
                console.log("136", heightPanelbox, panelwidth);
                $('#configDataBox').css('height', heightPanelbox);
                $('#configDataBox').css('width', panelwidth);*/
            }

            $scope.displayPath = '';
            if($scope.selectedFolder != undefined && $scope.selectedFolder != null && $scope.selectedFolder != ''){
                $scope.displayPath = $scope.selectedFolder;
            }
            if($rootScope.selectedFile != undefined && $rootScope.selectedFile != null && $rootScope.selectedFile != ''){
                $scope.displayPath = $scope.displayPath + $rootScope.selectedFile;
            }

            //Replace multiple spaces with one space
            $scope.displayPath = $scope.displayPath.replace(/ +(?= )/g,'');
            $rootScope.tooltipText = _.cloneDeep($scope.displayPath);
            //Shorten Path if required
            if($scope.displayPath.length >= 65){
                pathArray = $scope.displayPath.split(" / ");
                var pathArrayLength = pathArray.length;
                for(var index=1;index<=pathArrayLength - 1;index++){
                    $scope.displayPath = '';
                    if(index == pathArrayLength-1){
                        var fileName = pathArray[pathArray.length-1];
                        if(fileName.length>65){
                            pathArray[pathArray.length-1] = "..." + fileName.slice((fileName.length-65),fileName.length);
                        }
                        $scope.displayPath = '';
                        pathArray.forEach(function(current_value){
                            $scope.displayPath = $scope.displayPath + " / " + current_value;
                        });
                        $scope.displayPath = $scope.displayPath.substring(2);
                        break;
                    }
                    if(index == 1){
                        pathArray[index]="...";
                    } else {
                        pathArray.splice(2, 1);
                    }
                    pathArray.forEach(function(current_value){
                        $scope.displayPath = $scope.displayPath + " / " + current_value;
                    });
                    $scope.displayPath = $scope.displayPath.substring(2);
                    if($scope.displayPath.length < 65){
                        break;
                    }
                }
            }
        }
        
        $scope.editConfig = function() {
        	$scope.readOnlyMode = false;
        	originalData = _.cloneDeep($scope.configData);
        };
        
        $scope.confirmChanges = function() {
        	$scope.readOnlyMode = true;
        	PyService.GetFileContentEdit($scope, $scope.fullFilePath, 'properties', $scope.configData).then(function(response){
        		// console.log("Response object ::", response);
        		growl.success("File saved successfully", {});
        		originalData = _.cloneDeep($scope.configData);
        	});
        };
        
        $scope.cancelChanges = function() {
        	$scope.readOnlyMode = true;
        	$scope.configData = originalData;
        };
        
    };
    configController.$inject = injectParams;
    app.controller('ConfigCtrl', configController);
    
});
