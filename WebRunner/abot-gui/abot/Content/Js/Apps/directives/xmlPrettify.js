'use strict';

define(['app'], function (app) {

    app.directive('prettyprint', function() {
        return {
            restrict: 'C',
            link: function postLink(scope, element, attrs) {
                  element.text(vkbeautify.xml(scope.dom, 4));
            }
        };
    });

});

