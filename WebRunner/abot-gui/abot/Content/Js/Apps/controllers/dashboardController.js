/* 
 Created on : 14 Auguest, 2016, 5:31:40 PM
 Author     : Joydeep
 */
'use strict';

define(['app'], function (app) {

    var injectParams = ['$scope', '$state', '$rootScope', 'AppConfig', 'growl', '$sce', 'PyService', '$timeout'];
    var dashboardController = function ($scope, $state, $rootScope, AppConfig, growl, $sce, PyService, $timeout) {
        //$rootScope.ruleCreateIndex = -1;
    	$timeout(function(){
 			///----------- Adjusting Panel height -----------------------------
  			$("#dashboardFeatureContent").height($(window).height() - 170);
  			$("#dashboardFeatureFile").height($(window).height() - 170);
  			$("#dashboardFeature").height($(window).height() - 170);
  			$("#dashboardFeatureBody").height($(window).height() - 170);
    	},10);
    	
    	
    	$scope.init = function() {
    		//alert('dashboard init');
            $scope.defaultFile = '/feature-overview.html';
			$scope.subTitle = 'Feature Overview';
			PyService.getExecutionStatus().then(function(response){
				if(response.data['status']['executing'] === true) {
					$state.go("app.executionView");
					$timeout(function(){
						angular.element("#executionView").scope().updateExecutionStatus();
					}, 100);
				} else {
					PyService.GetLandingPageFile($scope, 'artifacts/').then(function(result){
						var response = result.data;
						// console.log(response);
						if(response != null){
							var data = response.artifact;
							
							var html = 'http://' + window.location.host + '/artifacts/' + data + '/report-' + data + $scope.defaultFile;
							
							$("#dashboardFeature").attr("src", html);
							angular.element('#dashboardFeature').on('load', event => adjustDashboardView());
							$timeout(function(){
								adjustDashboardView();
							}, 50);	
						}
					});
				}
			});
    	}
    	
    	function adjustDashboardView(){
    		$('#dashboardFeature').contents().find('#fullwidth_header').css('display', 'none');
    		$('#dashboardFeature').contents().find('#fullwidth_gradient').css('margin-top', '0');
    		$('#dashboardFeature').contents().find('.heading').css('margin-top', '0');
    		$('#dashboardFeature').contents().find('.footer').css('display', 'none');
    		$('#dashboardFeature').contents().find('.stats-table td').css({'word-wrap': 'break-word', 'word-break': 'break-all', 'white-space': 'normal'});
    		$('#file-content-mask').css('display','none');
    		$('#dashboardFeature').show();
    	}
        
    };
    dashboardController.$inject = injectParams;
    app.controller('DashboardCtrl', dashboardController);
});