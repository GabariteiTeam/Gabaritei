module.exports = function(config){
  config.set({

    basePath : '../',

    plugins : [
            'karma-chrome-launcher',
            'karma-firefox-launcher',
            'karma-phantomjs-launcher',
            'karma-jasmine',
            'karma-nested-reporter',
            'karma-coverage',
            'karma-htmlfile-reporter',
            'karma-spec-reporter',
            'karma-ng-html2js-preprocessor'
            ],
      reporters: ['nested', 'coverage', 'spec'],
      
    
    coverageReporter: {
      type : 'html',
      dir : 'coverage/'
    },

    preprocessors: {
      'app/assets/javascripts/app/**/*.js': ['coverage'],
      'app/views/templates/**/*.html': ['ng-html2js']
    },

    ngHtml2JsPreprocessor: {
      // strip this from the file path
      stripPrefix: 'app/views/',
      moduleName: 'htmltemplates'
    },

    files : [
      'vendor/assets/bower_components/angular/angular.js',
      'vendor/assets/bower_components/angular-route/angular-route.js',
      'vendor/assets/bower_components/angular-resource/angular-resource.js',
      'vendor/assets/bower_components/angular-mocks/angular-mocks.js',
      'vendor/assets/bower_components/angular-animate/angular-animate.js',
      'vendor/assets/bower_components/angular-strap/dist/angular-strap.js',
      'vendor/assets/bower_components/ng-file-upload/ng-file-upload.js',
      'vendor/assets/bower_components/ng-tags-input/ng-tags-input.js',
      'vendor/assets/bower_components/angular-translate/angular-translate.js',
      'vendor/assets/bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files.js',
      'vendor/assets/bower_components/angular-paginate-anything/dist/paginate-anything-tpls.js',
      'vendor/assets/bower_components/ngActivityIndicator/ngActivityIndicator.js',
      'app/assets/javascripts/app/**/*.js',
      'app/views/templates/**/*.html',
      'test-angular/spec_helper.js'
    ],


    autoWatch : false,
    singleRun : true,

    frameworks: ['jasmine'],

    browsers : ['PhantomJS'],

    junitReporter : {
      outputFile: 'test_out/unit.xml',
      suite: 'unit'
    }

  });
};