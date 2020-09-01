/*
 To change this license header, choose License Headers in Project Properties.
 To change this template file, choose Tools | Templates
 and open the template in the editor.
 */
/* 
 Created on : 10 June, 2016, 10:20:40 AM
 Author     : Joydeep
 */
'use strict';

define(['app'], function (app) {
    return app.config([
        '$stateProvider',
        '$urlRouterProvider',
        '$ocLazyLoadProvider',
        'IdleProvider',
        'AppConfig',
        function ($stateProvider, $urlRouterProvider, $ocLazyLoadProvider, IdleProvider, AppConfig) {

            // Configure Idle settings
            IdleProvider.idle(5); // in seconds
            IdleProvider.timeout(120); // in seconds
            $ocLazyLoadProvider.config({
                // Set to true if you want to see what and when is dynamically loaded
                debug: true,
                loadedModules: ['app']
            });

            $stateProvider

                    .state('login', {
                        url: "/login",
                        templateUrl: AppConfig.templatePath + "loginView.tpl.html?v=" + AppConfig.cacheBustSuffix,
                        controller: 'LoginCtrl',
                        data: {pageTitle: 'RCA Login'}
                    })

                    .state('app', {
                        url: "/app",
                        abstract: true,
                        templateUrl: AppConfig.templatePath + "dashboard.tpl.html?v=" + AppConfig.cacheBustSuffix,
                        controller: 'BaseCtrl'
                    })

                    .state('app.dashboardFeatureView', {
                        url: "/dashboardFeatureView",
                        controller: 'DashboardCtrl',
                        data: {pageTitle: 'Abot Dashboard'},
                        resolve: {
                            loadPlugin: function ($ocLazyLoad) {
                                return $ocLazyLoad.load([
                                ]);
                            }
                        }
                    })
                    
                    .state('app.dashboardTagView', {
                        url: "/dashboardTagView",
                        controller: 'DashboardCtrl',
                        data: {pageTitle: 'Abot Dashboard'},
                        resolve: {
                            loadPlugin: function ($ocLazyLoad) {
                                return $ocLazyLoad.load([
                                ]);
                            }
                        }
                    })
                    
                    .state('app.tagOverview', {
                        url: "/tagOverview",
                        controller: 'TagCtrl',
                        data: {pageTitle: 'Tag OverView'},
                        resolve: {
                            loadPlugin: function ($ocLazyLoad) {
                                return $ocLazyLoad.load([
                                ]);
                            }
                        }
                    })
                    .state('app.artifactsView', {
                        url: "/artifactsView",
                        controller: 'ArtifactsCtrl',
                        data: {pageTitle: 'Artifacts View'},
                        resolve: {
                            loadPlugin: function ($ocLazyLoad) {
                                return $ocLazyLoad.load([
                                ]);
                            }
                        }
                    })
                    .state('app.featureFileView', {
                        url: "/featureFileView",
                        controller: 'FeatureCtrl',
                        data: {pageTitle: 'Feature File View'},
                        resolve: {
                            loadPlugin: function ($ocLazyLoad) {
                                return $ocLazyLoad.load([
                                ]);
                            }
                        }
                    })
                    .state('app.configView', {
                        url: "/configView",
                        controller: 'ConfigCtrl',
                        data: {pageTitle: 'Configue View'},
                        resolve: {
                            loadPlugin: function ($ocLazyLoad) {
                                return $ocLazyLoad.load([
                                ]);
                            }
                        }
                    })
                    .state('app.executionView', {
                        url: "/executionView",
                        controller: 'ExecutionCtrl',
                        data: {pageTitle: 'Execution View'},
                        resolve: {
                            loadPlugin: function ($ocLazyLoad) {
                                return $ocLazyLoad.load([
                                ]);
                            }
                        }
                    })
                    .state('app.graphView', {
                        url: "/graphView",
                        controller: 'GraphCtrl',
                        data: {pageTitle: 'Graph View'},
                        resolve: {
                            loadPlugin: function ($ocLazyLoad) {
                                return $ocLazyLoad.load([
                                ]);
                            }
                        }
                    })

                    
                    ;
                    
                   
            // if none of the above states are matched, use this as the fallback
            //$urlRouterProvider.otherwise('/login');
            $urlRouterProvider.otherwise('/app/dashboardFeatureView');
        }
    ]);
});