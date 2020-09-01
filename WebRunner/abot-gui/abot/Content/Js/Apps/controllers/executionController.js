/* 
 Created on : 14 March, 2017, 10:31:40 AM
 Author     : Joydeep
 */
'use strict';

define(['app'], function (app) {

	var injectParams = ['$scope', '$state', '$rootScope', '$timeout', 'AppConfig', 'PyService'];
	var executionController = function ($scope, $state, $rootScope, $timeout, AppConfig, PyService) {
				
		$scope.isFeatureFileExecuted = false;
		$scope.isFeatureFileRunning = false;
		$scope.isExecutionDone = false;
		
		$rootScope.running = $scope.isFeatureFileRunning;
		
		$scope.tags = "";
		$scope.featureFileName = "";
		$scope.execution_src = '';

		$timeout(function(){
 			///----------- Adjusting Panel height -----------------------------
  			$("#executionContent").height($(window).height() - 170);
  			$("#executionFile").height($(window).height() - 170);
  			$("#featureFile").height($(window).height() - 170);
  			$("#executionBody").height($(window).height() - 170);
  			$(window).trigger("resize");
    	},10);
		
		$scope.init = function() {
			
		};
		
		$scope.executeFeatureAndLoadConsole = function(featureFile, tags) {
			if (tags == null) {
				return;
			}
			$scope.featureFile = featureFile;
			$scope.tags = tags;
			PyService.executeFeatureFile($scope.tags).then(function(response){
				$scope.updateExecutionStatus();
			});
		}

		$scope.updateExecutionSrc = function() {
			document.getElementById("featureFile").src = PyService.getServerRestAPI() + 'execute/logs';
		}

		$scope.updateExecutionStatus = function() {
			$scope.isFeatureFileRunning = true;
			$rootScope.running = true;
			$scope.isExecutionDone = false;
			$scope.updateExecutionSrc();
			angular.element('#featureFile').on('load', event => $scope.execCompleted());
			angular.element("#graphView").scope().showAndSetGraphsTimer();
		}
		
		$scope.execCompleted = function() {
			$timeout(function() {
				$scope.isFeatureFileExecuted = true;
				$scope.isFeatureFileRunning = false;
				$scope.isExecutionDone = true;
			}, 100);
			setTimeout(function () {
		        $scope.$apply(function () {
					$rootScope.running = !$scope.isExecutionDone;
					angular.element("#graphView").scope().hideOrResetTimerGraphs();
		        });
		    }, 200);
		}
	};
	executionController.$inject = injectParams;
	app.controller('ExecutionCtrl', executionController);

});
