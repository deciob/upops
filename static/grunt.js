// example
module.exports = function (grunt) {
    grunt.initConfig({

        /*
        The following will compile all .coffee files in the src directory
        and place the corresponding .js files in the dest directory.
        The directory hierarchy will be maintained.
        */
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
        },

    });

    grunt.loadNpmTasks('grunt-hustler');

};