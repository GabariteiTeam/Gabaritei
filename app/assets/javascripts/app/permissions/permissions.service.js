(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .factory('PermissionsService', PermissionsService);

    PermissionsService.$inject = ['$http', 'Auth', 'Permission'];

    function PermissionsService($http, Auth, Permission) {
    	
    	function verifyPermissions(permissions, success, error) {
    		Auth.currentUser().then(function(user) {
    			$http.post('users/verify_permissions', {
    				id: user.id,
    				permissions: permissions
    			}).then(function(data) {
    				success(data.data);
    			}, function(error) {
    				error(data.data);
    			});
    		}, function(data) {
    			error(data.data);
    		});
    	}

    	return {
    		verifyPermissions: verifyPermissions
    	}
        
    }

})();