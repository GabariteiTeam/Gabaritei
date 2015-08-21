// grunt ngdocs
// creates client-side documentation

module.exports = function (grunt) {

  // grunt-ngdocs: generates AngularJS documentation
  grunt.loadNpmTasks('grunt-ngdocs');

  // grunt-contrib-jsbeautifier: makes JS, CSS and HTML files more beautiful
  grunt.loadNpmTasks('grunt-jsbeautifier');

  // grunt-contrib-jshint: validates JS files
  grunt.loadNpmTasks('grunt-contrib-jshint');

  // grunt-todos: find to-dos and fix-mes in code
  grunt.loadNpmTasks('grunt-todos');
  
  grunt.initConfig({
    ngdocs: {
       	options: {
       		dest: 'docs/client',
       		title: 'Gabaritei Client Documentation',
       		html5Mode: false,
       		scripts: [
           		'vendor/assets/bower_components/angular/angular.js',
           		'vendor/assets/bower_components/angular-animate/angular-animate.js'
       		]
   		},
   		api: {
       		src: ['app/assets/javascripts/app/**/*.js'],
       		title: 'Docs'
   		}
    },
    jsbeautifier: {
      files: [
        'app/assets/javascripts/app/**/*.js'
      ]
    },
    jshint: {
        all: ['app/assets/javascripts/app/**/*.js', '!app/assets/javascripts/app/**/*.spec.js']
    },
    todos: {
      options: {
        verbose: false
      },
      all: {
        files: [{
          src: 'app/assets/javascripts/app/**/*.js'
        }, {
          src: 'app/**/*.rb'
        }]
      } 
    }
  });

  grunt.registerTask('docs', ['ngdocs']);
  grunt.registerTask('js', ['jsbeautifier', 'jshint']);

};