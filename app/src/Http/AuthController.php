<?php

namespace Http;

use Services\DatabaseConnector;

class AuthController {
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

    public function showLogin() {
        if (isset($_SESSION['user'])) {
            header('Location: /');
            exit();
        }
        $formError = isset($_SESSION['flash']['error']) ? $_SESSION['flash']['error'] : [];
        $email = isset($_SESSION['flash']['email']) ? $_SESSION['flash']['email'] : '';
        unset($_SESSION['flash']);

        echo $this->twig->render('pages/login.twig', ['email' => $email, 'error' => $formError, 'user' => [], 'categories' => $this->categories, 'pagetitle' => 'Login']);
    }

    public function login() {
        $email = isset($_POST['email']) ? trim($_POST['email']) : '';
        $password = isset($_POST['password']) ? trim($_POST['password']) : '';

        if (isset($_POST['moduleAction']) && ($_POST['moduleAction'] == 'login')) {
            $stmt = $this->db->prepare('SELECT * FROM authors WHERE email = ?');
            $stmt->execute([$email]);
            $user = $stmt->fetchAssociative();

            if (($user !== false) && (password_verify($password, $user['password']))) {
                $_SESSION['user'] = $user;
                header('Location: /');
                exit();
            } else {
                $formError = 'Invalid login credentials';
                $_SESSION['flash'] = ['error' => $formError, 'email' => $email];
            }
        }
        header('Location: /login');
        exit();
    }

    public function logout() {
        $_SESSION = [];
        if (ini_get("session.use_cookies")) {
            $params = session_get_cookie_params();
            setcookie(session_name(), '', time() - 42000,
                $params["path"], $params["domain"],
                $params["secure"], $params["httponly"]
            );
        }
        session_destroy();
        header('location: /');
        exit();
    }
}