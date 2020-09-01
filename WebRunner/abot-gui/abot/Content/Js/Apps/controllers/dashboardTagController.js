/* 
 Created on : 14 Auguest, 2016, 5:31:40 PM
 Author     : Joydeep
 */
'use strict';

define(['app'], function (app) {

    var injectParams = ['$scope', '$state', '$rootScope', 'AppConfig', 'growl', '$sce', 'PyService', '$timeout'];
    var dashboardTagController = function ($scope, $state, $rootScope, AppConfig, growl, $sce, PyService, $timeout) {
        //$rootScope.ruleCreateIndex = -1;
        
    	$timeout(function(){
 			///----------- Adjusting Panel height -----------------------------
  			$("#dashboardTagContent").height($(window).height() - 170);
  			$("#dashboardTagFile").height($(window).height() - 170);
  			$("#dashboardTag").height($(window).height() - 170);
  			$("#dashboardTagBody").height($(window).height() - 170);
    	},10);
    	
    	$scope.init = function() {
            $scope.defaultFile = '/tag-overview.html';
            $scope.subTitle = 'Tag Overview';
    		PyService.GetLandingPageFile($scope, 'artifacts/').then(function(result){
    			var response = result.data;
    			// console.log(response);
    			if(response != null){
                    var data = response.artifact;
                    
                    var html = 'http://' + window.location.host + '/artifacts/' + data + '/report-' + data + $scope.defaultFile;
                    
                    angular.element('#dashboardTagFeature').on('load', event => adjustDashboardView());
                    $("#dashboardTagFeature").attr("data", html);
                    $timeout(function(){
                    	adjustDashboardView();
                    }, 50);
                }
    		});
    	}
    	
    	$scope.tagloaded = function() {
    		alert('Content loaded');
    	}
    	
    	function adjustDashboardView(){
    		$('#dashboardTagFeature').contents().find('#fullwidth_header').css('display', 'none');
    		$('#dashboardTagFeature').contents().find('#fullwidth_gradient').css('margin-top', '0');
    		$('#dashboardTagFeature').contents().find('.heading').css('margin-top', '0');
    		$('#dashboardTagFeature').contents().find('.footer').css('display', 'none');
    		$('#dashboardTagFeature').contents().find('.stats-table td').css({'word-wrap': 'break-word', 'word-break': 'break-all', 'white-space': 'normal'});
    		$('#file-content-mask').css('display','none');
    		$('#dashboardTagFeature').show();
    	}
        
    };
    dashboardTagController.$inject = injectParams;
    app.controller('DashboardTagCtrl', dashboardTagController);
});