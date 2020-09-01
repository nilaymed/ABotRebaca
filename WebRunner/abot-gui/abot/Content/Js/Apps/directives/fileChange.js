'use strict';

define(['app'], function (app) {
    app.directive('fileChange', function() {
        return {
        restrict: 'A',
        link: function(scope, element, attrs) {
            element.bind('change', function() {
                scope.$apply(function() {
                  scope[attrs['fileChange']](element[0].files);
                });
            });
        }
       };
    });

});
