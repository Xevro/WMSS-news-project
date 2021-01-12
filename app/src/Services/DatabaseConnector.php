<?php


namespace Services;
require_once (__DIR__ . '/../../config/database.php');

class DatabaseConnector
{


    static function getConnection() : \Doctrine\DBAL\Connection {
        $connectionParams = [
            'url' => 'mysql://' . DB_USER . ':' . DB_PASS . '@' . DB_HOST . '/' . DB_NAME
        ];

        $connection = \Doctrine\DBAL\DriverManager::getConnection($connectionParams);

        try {
            $connection->connect();
        } catch (\Doctrine\DBAL\Exception\ConnectionException $e) {
            echo($e->getMessage());
            exit();
        }
        return $connection;
    }
}