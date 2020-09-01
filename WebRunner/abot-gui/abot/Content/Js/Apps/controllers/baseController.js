/* 
 Created on : 14 Auguest, 2016, 5:31:40 PM
 Author     : Koushik
 */
'use strict';

define(['app'], function (app) {

    var injectParams = ['$scope', '$state', '$rootScope', 'AppConfig', '$timeout'];
    var baseController = function ($scope, $state, $rootScope, AppConfig, $timeout) {
        var present_state = "";
        $scope.left_bar_state = "dashboardFeatureView";
        $rootScope.running = false;
        
        $timeout(function(){
        	$(".content-wrapper").css('min-height','0px');
        }, 1500);
        
        
        $rootScope
                .$on('$stateChangeSuccess',
                        function (event, toState, toParams, fromState, fromParams) {
                            state_init(toState, toParams, fromState);
                        });
        
        $scope.init = function () {
            state_init($state.current, $state.params, null);
        };

        var state_init = function (currentstate, params, fromState) {
            //
            if ((present_state == currentstate.name)) //&& (current_state != 'app.casefolder')
                return;
            present_state = currentstate.name;
            //
            switch (present_state) {
                case "app.dashboardFeatureView":
                    $scope.dash_state = "dashboardFeatureView";
                    $scope.left_bar_state = "dashboardFeatureView";
                    _loaddashboard();
                    break;
                case "app.dashboardTagView":
                    $scope.dash_state = "dashboardTagView";
                    $scope.left_bar_state = "dashboardTagView";
                    _loadrca();
                    break;
                case "app.tagOverview":
                    $scope.dash_state = "tagOverview";
                    $scope.left_bar_state = "tagOverview";
                    _loadrca();
                    break;
                case "app.artifactsView":
                    $scope.dash_state = "artifactsView";
                    $scope.left_bar_state = "artifactsView";
                    _loaddashboard();
                    break;
                case "app.featureFileView":
                    $scope.dash_state = "featureFileView";
                    $scope.left_bar_state = "featureFileView";
                    _loadrca();
                    break;
                case "app.configView":
                    $scope.dash_state = "configView";
                    $scope.left_bar_state = "configView";
                    _loadrca();
                    break;
                case "app.executionView":
                    $scope.dash_state = "executionView";
                    $scope.left_bar_state = "executionView";
                    if ($scope.left_bar_state == 'executionView') {
                    	$timeout(function(){
                    		$("#executionContent").height($(window).height() - 160);
                  			$("#executionFile").height($(window).height() - 160);
                  			$("#featureFile").height($(window).height() - 160);
                  			$("#executionBody").height($(window).height() - 160);
                        	//alert('Execution State');
                        	$("#executionContent").height($(window).height() - 170);
                  			$("#executionFile").height($(window).height() - 170);
                  			$("#featureFile").height($(window).height() - 170);
                  			$("#executionBody").height($(window).height() - 170);
                  			$(window).trigger("resize");
                    	}, 200)
                    }
                    _loadrca();
                    break;
                case "app.graphView":
                    $scope.dash_state = "graphView";
                    $scope.left_bar_state = "graphView";
                    _loadrca();
                    break;
                default:
            }
        };

        
        var _loaddashboard = function () {
            //console.log("_loaddashboard");
        };
        
        var _loadrca = function () {
            //console.log("_loadrca");
        };

    };
    baseController.$inject = injectParams;
    app.controller('BaseCtrl', baseController);
});