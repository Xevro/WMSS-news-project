<?php

namespace Http;

use DateTime;
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
        echo $this->twig->render('pages/home.twig', ['articles' => $articles, 'latest' => $latestArticle, 'categories' => $this->categories,
        'user' => isset($_SESSION['user']) ? $_SESSION['user'] : []]);
    }

    public function results() {
        $category = isset($_GET['category'])? (int) $_GET['category']: 0;
        $error = false;
        if($category === 0) {
            $error = true;
        }
        $articles = $this->db->fetchAllAssociative('SELECT n.id, n.title, LEFT(n.message, 250) as message, n.pubdate, n.alt, n.popularity, a.firstname as author FROM `newsmessages` as n LEFT JOIN authors as a on n.author_id = a.id WHERE n.category_id = ? ORDER BY popularity DESC;', [$category]);
        echo $this->twig->render('pages/results.twig', ['articles' => $articles,'error' => $error, 'categories' => $this->categories,
            'user' => isset($_SESSION['user']) ? $_SESSION['user'] : []]);
    }
    public function showArticle($articleId) {
        $articlesIncremented = isset($_SESSION['articles']) ? $_SESSION['articles'] : [];
        if (isset($_SESSION['user']) && !in_array($articleId, $articlesIncremented)) {
            $stmt = $this->db->prepare('UPDATE newsmessages SET popularity = popularity + 1 WHERE id = ?');
            $stmt->execute([$articleId]);
            $_SESSION['articles'][$articleId] = $articleId;
        }
    }

    public function add() {
        if (!isset($_SESSION['user'])) {
            header('Location: /login');
            exit();
        }
        $title = isset($_POST['title']) ? (string)$_POST['title'] : '';
        $message = isset($_POST['message']) ? (string)$_POST['message'] : '';
        $alt = isset($_POST['alt']) ? (string)$_POST['alt'] : '';
        $category = isset($_POST['category']) ? (int)$_POST['category'] : 0;
        $errors = [];

        if (isset($_POST['moduleAction']) && ($_POST['moduleAction'] == 'add')) {
            $allOk = true;
            if ($title === '' || $message === '') {
                $errors[] = 'Gelieve een nieuwsbericht in te voeren';
                $allOk = false;
            }
            if ($category == 0) {
                $errors[] = 'Gelieve een geldige categorie te selecteren';
                $allOk = false;
            }
            if ($alt == '') {
                $errors[] = 'Gelieve een alt voor de foto op te geven';
                $allOk = false;
            }
            $lastId = $this->db->fetchAssociative('SELECT id FROM newsmessages WHERE id = (SELECT MAX(id) FROM newsmessages)', []);

            $fileTmpName = $_FILES['photo']['tmp_name'];
            $array = explode('.', $_FILES['photo']['name']);
            $fileExtension = strtolower(end($array));
            $imageDirectory = "/files/newsimages/news" . ($lastId['id'] + 1) . '.' . $fileExtension;
            $uploadDirectory = getcwd() . $imageDirectory;
            $fileExtensionsAllowed = ['jpg'];

            // Enkel een bepaald formaat toestaan
            if (!in_array($fileExtension, $fileExtensionsAllowed)) {
                $errors['file'] = "Gelieve een foto up te loaden, enkel .JPG toegestaan";
                $allOk = false;
            }

            if ($allOk) {
                if (move_uploaded_file($fileTmpName, $uploadDirectory)) {
                    $stmt = $this->db->prepare('INSERT INTO newsmessages(title, message, alt, pubdate, category_id, author_id, popularity) VALUES (?,?,?,?,?,?,?)');
                    $stmt->execute([$title, $message, $alt, (new DateTime())->format('Y-m-d H:i:s'), $category, $_SESSION['user']['id'], 0]);
                    header('Location: /');
                    exit();
                }
            }
        }
        echo $this->twig->render('pages/add.twig', ['title' => $title, 'alt' => $alt, 'message' => $message, 'selectedCategoryId' => $category, 'categories' => $this->categories, 'errors' => $errors,
            'user' => isset($_SESSION['user']) ? $_SESSION['user'] : []]);
    }

    public function generateSitemap() {
        Header();
        echo "qsd";
    }
}