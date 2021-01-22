<?php

namespace Http;

use Services\DatabaseConnector;

class NewsController {
    protected \Doctrine\DBAL\Connection $db;
    protected \Twig\Environment $twig;
    protected array $categories;

    public function __construct() {
        // bootstrap Twig
        $loader = new \Twig\Loader\FilesystemLoader(__DIR__ . '/../../resources/templates');
        $this->twig = new \Twig\Environment($loader);
        //Database connection
        $this->db = DatabaseConnector::getConnection();
        $this->categories = $this->db->fetchAllAssociative('SELECT * FROM categories ORDER BY id', []);
    }

    public function home() {
        $articles = $this->db->fetchAllAssociative('SELECT n.id, n.title, LEFT(n.message, 250) as message, n.pubdate, n.alt, n.popularity, a.firstname as author FROM `newsmessages` as n LEFT JOIN authors as a on n.author_id = a.id ORDER BY popularity DESC LIMIT 3;', []);
        $latestArticle = $this->db->fetchAssociative('SELECT n.id, n.title,LEFT(n.message, 250) as message, n.pubdate, n.alt, n.popularity, a.firstname as author FROM `newsmessages` as n LEFT JOIN authors as a on n.author_id = a.id ORDER BY `pubdate` DESC LIMIT 1;', []);
        echo $this->twig->render('pages/home.twig', ['articles' => $articles, 'latest' => $latestArticle, 'categories' => $this->categories]);
    }
}