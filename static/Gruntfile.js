module.exports = function (grunt) {
    var myjs;

    myjs = grunt.file.expand(['js/**/*.js', '!js/vendor/**'])

    grunt.initConfig({

        complexity: {
            generic: {
                src: myjs,
                options: {
                    cyclomatic: 5,
                    halstead: 15,
                    maintainability: 100
                }
            }
        },

        coffeelint: {
            app: ['coffee/**/*.coffee']
        },

        coffee: {
            dist: {
                src: './coffee/',
                dest: './js/',
                bare: true
            }
        },
        watch: {
          files: ['./coffee/**/*.coffee'],
          tasks: 'coffee'
        }

    });


    grunt.loadNpmTasks('grunt-complexity');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-coffeelint');

    // the default task can be run just by typing "grunt" on the command line
    grunt.registerTask('default', []);

};