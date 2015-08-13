module.exports = function (grunt) {

  grunt.loadNpmTasks('grunt-ngdocs');
  
  grunt.initConfig({
    ngdocs: {
       	options: {
       		dest: 'docs',
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
    }
  });

  grunt.registerTask('default', ['ngdocs']);

};