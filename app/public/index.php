<?php

require __DIR__ . '/../vendor/autoload.php';
$router = new \Bramus\Router\Router();

$router->setNamespace('\Http');

$router->before('GET|POST', '/.*', function () {
    session_start();
});

// Define routes
$router->get('/', 'NewsController@home');
$router->get('/results', 'NewsController@results');
$router->get('/articles/(\d+)', 'NewsController@showArticle');
$router->get('/articles/add', 'NewsController@add');
$router->post('/articles/add', 'NewsController@add');

$router->get('/login', 'AuthController@showLogin');
$router->post('/login', 'AuthController@login');
$router->get('/logout', 'AuthController@logout');

$router->get('/sitemap.xml', 'NewsController@generateSitemap');

// Run it!
$router->run();