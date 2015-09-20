(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .directive('toggleSwitch', ToggleSwitch);

    function ToggleSwitch() {
        return {
            restrict: 'A',
            require: 'ngModel',
            link: function(scope, elem, attrs, ngModel) {
                elem.bootstrapToggle(attrs);
                ngModel.$render = function() {
                    elem.bootstrapToggle(ngModel.$modelValue ? "on" : "off");
                }
                elem.change(function() {
                    ngModel.$setViewValue(elem[0].checked);
                });
            }
        }
    }

})();
