<?php

namespace Http;

use Services\DatabaseConnector;

class NewsController {
    protected \Doctrine\DBAL\Connection $db;
    protected \Twig\Environment $twig;

    public function __construct() {
        // bootstrap Twig
        $loader = new \Twig\Loader\FilesystemLoader(__DIR__ . '/../../resources/templates');
        $this->twig = new \Twig\Environment($loader);
        //Database connection
        $this->db = DatabaseConnector::getConnection();
    }

    public function home() {
        echo $this->twig->render('pages/home.twig', []);
    }
}