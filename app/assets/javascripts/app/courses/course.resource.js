(function() {

    angular
        .module(APP_NAME)
        .factory('Course', Course);

    Course.$inject = ['$resource', 'Upload'];

    function Course($resource, Upload) {
        var c = $resource('courses/:id.json', {id: '@id'}, {
        	update: { method: 'PUT' },
        	searchUsers: {
        		url: 'courses/:id/search_users',
        		method: 'GET',
        		isArray: true
        	},
            addParticipants: {
                url: 'courses/:id/add_participants',
                method: 'PUT'
            },
            removeParticipant: {
                url: 'courses/:id/remove_participant/:user_id',
                method: 'PUT'
            },
            showEverything: {
                url: 'courses/:id/show_everything',
                method: 'GET'
            },
            addLesson: {
                url: 'courses/:id/add_lesson',
                method: 'POST'
            },
            editLesson: {
                url: 'courses/:id/edit_lesson',
                method: 'PUT'
            },
            getLesson: {
                url: 'courses/:id/get_lesson/:lesson_id',
                method: 'GET'
            },
            deleteLesson: {
                url: 'courses/:id/delete_lesson',
                method: 'DELETE'
            },
            coursesForTest: {
                url: 'courses/courses_for_test',
                method: 'GET',
                isArray: true
            }
        });

        c.prototype.$save = function(success, error) {
            upload(this, 'courses/', 'POST', success, error);
        }

        c.prototype.$update = function(success, error) {
            upload(this, 'courses/' + this.id, 'PUT', success, error);
        }

        function upload(course, url, method, success, error) {
            Upload.upload({
                url: url,
                method: method,
                data: {
                    avatar: course.avatar,
                    category_id: course.field_id ? course.field_id : course.subject_id,
                    category_type: course.field_id ? "Field" : "Subject",
                    name: course.name,
                    description: course.description,
                }
            })
            .success(function(data) {
                if (success) success(data);
            })
            .error(function(data) {
                if (error) error(data);
            });
        }

        return c;
    }

})();