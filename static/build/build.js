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
        // All other app dependencies are traced down from the following 2:
        'router',
        'main'
    ],
    insertRequire: ['main']
}