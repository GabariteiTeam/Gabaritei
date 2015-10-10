// Services section

(function() {

    angular
        .module(APP_NAME)
        .factory('User', User);

    User.$inject = ['$resource', 'Upload'];

    function User($resource, Upload) {
        var u = $resource('users/:id.json', {id: '@id'});
        u.prototype.$save = function(success, error) {
            upload(this, 'users/', 'POST', success, error);
        }
        u.prototype.$update = function (success, error) {
            upload(this, 'users/' + this.id, 'PUT', success, error);
        }
        function upload(user, url, method, success, error) {
            Upload.upload({
                url: url,
                method: method,
                data: {
                    avatar: user.avatar,
                    role_id: user.role_id,
                    first_name: user.first_name,
                    last_name: user.last_name,
                    email: user.email,
                    birthdate: user.birthdate ? user.birthdate : undefined,
                    about: user.about
                }
            })
            .success(function(data) {
                if (success) success(data);
            })
            .error(function(data) {
                if (error) error(data);
            });
        }
        return u;
    }

})();
