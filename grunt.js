module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    coffee: {
      app: {
        src: ['*.coffee'],
        dest: ''
      },
	  controllers: {
	    src: ['controllers/*.coffee']
	  },
	  libs: {
	    src: ['libs/*.coffee']
	  },
	  models: {
	    src: ['models/*.coffee']
	  },
	  shared: {
	    src: ['shared/*.coffee']
	  }
    },
	coffeelint: {
		app: ['bin/nekyll', './**/*.coffee']
	},
	coffeelintOptions: {
		"no_tabs": {
			"level": "error"
		},
	    "indentation" : {
		    "value" : 4,
		    "level" : "error"
	    },
		"max_line_length" : {
			"level" : "ignore"
		}
	},
	rm: {
		all: [
			'run.js',
			'router.js',
			'app.js',
			'config.js',
			'controllers/**/*.js',
			'libs/**/*.js',
			'models/**/*.js',
			'shared/**/*.js'
		]
		//foo: 'js/*/**',
		/*
		bar: [
			'css/reset.css',
			'css/style.css'
		],
		someDir: {
			dir: 'css/images/'
		}
		*/
	},
    jshint: {
      options: {
        browser: true,
		node: true
      }
    }
  });

  // Load tasks from "grunt-sample" grunt plugin installed via Npm.
  //grunt.loadNpmTasks('grunt-sample');
  grunt.loadNpmTasks('grunt-coffee');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-rm');
  // Default task.
  //coffee rm coffeelint
  grunt.registerTask('default', 'coffeelint');

};