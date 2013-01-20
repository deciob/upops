{
    mainConfigFile: '../js/app.js',
    baseUrl: '../js', 
    name: 'vendor/almond',
    include: [
        'd3',
        'projection',
        'topojson', 
        'moment',
        'jquery',
        'jquery_ui',
        'math',
        'backbone',
        'laconic',
        'text',
        // All other app dependencies are found from the following 2:
        'router',
        'main'
    ],
    insertRequire: ['main']
}