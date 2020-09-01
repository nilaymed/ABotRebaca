/* 
 Created on : 14 March, 2017, 10:31:40 AM
 Author     : Rebaca Inc
 */
'use strict';

define(['app'], function (app) {
	
    var injectParams = ['$scope', '$state', '$rootScope', '$timeout',  'AppConfig', 'PyService', 'Uploader', 'growl'];
    var graphController = function ($scope, $state, $rootScope, $timeout, AppConfig, PyService, Uploader, growl) {
        $scope.packetCountersGraphTimmer;
        $scope.transactionCountGraphTimmer;
        $scope.procedureCompletionsGraphTimmer;
        $scope.uplinkDownlinkBandwidthGraphTimmer;
        $scope.interval_in_ms = 1000;
        $scope.showing = false
        $scope.packet_counters = {
            label : [],
            data :  [],
            series : [],
            colors : ['#45b7cd', '#ff6384', '#ff8e72'],
            datasetOverride : [
                {
                    label: 'packet counters',
                    borderWidth: 0,
                    type: 'bar'
                }
            ],
            options : {
                title: {
                    display: true,
                    text: 'Packet Counters'
                },
                scaleStartValue : 0,
                maintainAspectRatio: false,
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero:true,
                            fontSize: 10
                        }
                    }],
                    xAxes: [{
                        ticks: {
                            fontSize: 10
                        }
                    }]
                }
            },            
            
        }

        $scope.transaction_count = {
            label : [],
            data :  [[], [], []],
            series : ['s1ap', 'gtpv1u', 'gtpv2c'],
            colors : ['#45b7cd', '#ff6384', '#ff8e72'],
            datasetOverride : [
                {
                    label: 'S1AP',
                    borderWidth: 0,
                    type: 'line'
                },
                {
                    label: 'GTPV1U',
                    borderWidth: 0,
                    type: 'line'
                },
                {
                    label: 'GTPV2C',
                    borderWidth: 0,
                    type: 'line'
                }
            ],
            options : {
                title: {
                    display: true,
                    text: 'Transactions per second'
                },
                animation : false,
                responsive : true,
                scaleStartValue : 0,
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero:true,
                            fontSize: 10
                        }
                    }],
                    xAxes: [{
                        ticks: {
                            fontSize: 10
                        }
                    }]/*,
                    xAxes: [{
                        type: 'time',
                        time: {
                            displayFormats: {
                                quarter: 'h:mm:ss'
                            }
                        },
                        distribution: 'linear'
                    }]*/
                }
            },                        
        }

        $scope.procedure_completions = {
            label : [],
            data :  [[]],
            series : [],
            colors : ['#45b7cd', '#ff6384', '#ff8e72'],
            datasetOverride : [
                {
                    label: 'Procedures per second',
                    borderWidth: 0,
                    type: 'line'
                }
            ],
            options : {
                title: {
                    display: true,
                    text: 'Procedures per second'
                },
                animation : false,
                responsive : true,
                scaleStartValue : 0,
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero:true,
                            fontSize: 10
                        }
                    }],
                    xAxes: [{
                        ticks: {
                            fontSize: 10
                        }
                    }]/*,
                    xAxes: [{
                        type: 'time',
                        time: {
                            displayFormats: {
                                quarter: 'h:mm:ss'
                            }
                        },
                        distribution: 'linear'
                    }]*/
                }
            },                        
        }

        $scope.uplink_downlink_bandwidth = {
            label : [],
            data :  [[], [], [], [], [], []],
            series : ['s1ap_uplink', 's1ap_downlink', 'gtpv1u_uplink', 'gtpv1u_downlink', 'gtpv2c_uplink', 'gtpv2c_downlink'],
            colors : ['#45b7cd', '#ff6384', '#ff8e72'],
            datasetOverride : [
                {
                    label: 'S1AP Uplink',
                    borderWidth: 0,
                    type: 'line'
                },
                {
                    label: 'S1AP Downlink',
                    borderWidth: 0,
                    type: 'line'
                },
                {
                    label: 'GTPV1U Uplink',
                    borderWidth: 0,
                    type: 'line'
                },
                {
                    label: 'GTPV1U Downlink',
                    borderWidth: 0,
                    type: 'line'
                },
                {
                    label: 'GTPV2C Uplink',
                    borderWidth: 0,
                    type: 'line'
                },
                {
                    label: 'GTPV2C Downlink',
                    borderWidth: 0,
                    type: 'line'
                }
            ],
            options : {
                title: {
                    display: true,
                    text: 'Uplink Downlink bandwidth (Bps)'
                },
                animation : false,
                responsive : true,
                scaleStartValue : 0,
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero:true,
                            fontSize: 10
                        }
                    }],
                    xAxes: [{
                        ticks: {
                            fontSize: 10
                        }
                    }]/*,
                    xAxes: [{
                        type: 'time',
                        time: {
                            displayFormats: {
                                quarter: 'h:mm:ss'
                            }
                        },
                        distribution: 'linear'
                    }]*/
                }
            },                        
        }

        function getPacketCounter() {
            PyService.getPacketCounters($scope.interval_in_ms).then(function(response) {
                if(typeof(response.data) != 'undefined' && response.data != null && typeof(response.data.messages) != 'undefined' && response.data.messages != null && response.data['messages'].length > 0 && response.data['counts'].length > 0) {
                    $scope.packet_counters.label = response.data['messages'];
                    $scope.packet_counters.data = response.data['counts'];
                }
            });  
        }

        function getTransactionCount() {
            PyService.getTransactionCounts($scope.interval_in_ms).then(function(response) {
                if($scope.transaction_count.data[0].length > 50) {
                    $scope.transaction_count.data[0].shift();
                    $scope.transaction_count.data[1].shift();
                    $scope.transaction_count.data[2].shift();
                    $scope.transaction_count.label.shift();
                }
                $scope.transaction_count.data[0].push(response.data['s1ap']);
                $scope.transaction_count.data[1].push(response.data['gtpv1u']);
                $scope.transaction_count.data[2].push(response.data['gtpv2c']);
                var d = new Date();
                var time = d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();                    
                $scope.transaction_count.label.push(time);
            });
        }

        function getProcedureCompletions() {
            PyService.getProcedureCompletions($scope.interval_in_ms).then(function(response) {
                if($scope.procedure_completions.data[0].length > 50) {
                    $scope.procedure_completions.data[0].shift();
                    $scope.procedure_completions.label.shift();
                }
                $scope.procedure_completions.data[0].push(response.data);
                var d = new Date();
                var time = d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();                    
                $scope.procedure_completions.label.push(time);
            });  
        }

        function getUplinkDownlinkBandwidth() {
            PyService.getUplinkDownlinkBandwidth($scope.interval_in_ms).then(function(response) {
                if($scope.uplink_downlink_bandwidth.data[0].length > 50) {
                    $scope.uplink_downlink_bandwidth.data[0].shift();
                    $scope.uplink_downlink_bandwidth.data[1].shift();
                    $scope.uplink_downlink_bandwidth.data[2].shift();
                    $scope.uplink_downlink_bandwidth.data[3].shift();
                    $scope.uplink_downlink_bandwidth.data[4].shift();
                    $scope.uplink_downlink_bandwidth.data[5].shift();
                    $scope.uplink_downlink_bandwidth.label.shift();
                }
                $scope.uplink_downlink_bandwidth.data[0].push(parseFloat(response.data['s1ap']['uplink']));
                $scope.uplink_downlink_bandwidth.data[1].push(parseFloat(response.data['s1ap']['downlink']));
                $scope.uplink_downlink_bandwidth.data[2].push(parseFloat(response.data['gtpv1u']['uplink']));
                $scope.uplink_downlink_bandwidth.data[3].push(parseFloat(response.data['gtpv1u']['downlink']));
                $scope.uplink_downlink_bandwidth.data[4].push(parseFloat(response.data['gtpv2c']['uplink']));
                $scope.uplink_downlink_bandwidth.data[5].push(parseFloat(response.data['gtpv2c']['downlink']));
                var d = new Date();
                var time = d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();                    
                $scope.uplink_downlink_bandwidth.label.push(time);
            });  
        }

        $scope.showAndSetGraphsTimer = function() {
            
        }

        $scope.hideOrResetTimerGraphs = function() {
            $scope.showing = false;
            clearInterval($scope.packetCountersGraphTimmer);
            clearInterval($scope.transactionCountGraphTimmer);
            clearInterval($scope.procedureCompletionsGraphTimmer);
            clearInterval($scope.uplinkDownlinkBandwidthGraphTimmer);
        }

        $rootScope.graphViewClicked = function() {
            if($rootScope.running === true && $scope.showing === false) {
                $scope.showing = true;
                $scope.packetCountersGraphTimmer = setInterval(getPacketCounter, $scope.interval_in_ms);
                $scope.transactionCountGraphTimmer = setInterval(getTransactionCount, $scope.interval_in_ms);
                $scope.procedureCompletionsGraphTimmer = setInterval(getProcedureCompletions, $scope.interval_in_ms);
                $scope.uplinkDownlinkBandwidthGraphTimmer = setInterval(getUplinkDownlinkBandwidth, $scope.interval_in_ms);
            }
        }

        // TODO: Only for testing. Comment for production
        // $scope.showAndSetGraphsTimer();
    }

    graphController.$inject = injectParams;
    app.controller('GraphCtrl', graphController);
});