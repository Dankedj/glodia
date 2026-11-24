-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Listage de la structure de table glodia. cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.cache : ~8 rows (environ)
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
	('laravel-cache-a75f3f172bfb296f2e10cbfc6dfc1883', 'i:3;', 1795167633),
	('laravel-cache-a75f3f172bfb296f2e10cbfc6dfc1883:timer', 'i:1795167633;', 1795167633),
	('laravel-cache-d2bfa8e8b749d2772a21edee7b70a2b3', 'i:2;', 1795166212),
	('laravel-cache-d2bfa8e8b749d2772a21edee7b70a2b3:timer', 'i:1795166212;', 1795166212),
	('laravel-cache-df21bfa12c4e294c70f64916c0fbc9a5', 'i:3;', 1795167532),
	('laravel-cache-df21bfa12c4e294c70f64916c0fbc9a5:timer', 'i:1795167532;', 1795167532),
	('laravel-cache-f1f70ec40aaa556905d4a030501c0ba4', 'i:6;', 1795167638),
	('laravel-cache-f1f70ec40aaa556905d4a030501c0ba4:timer', 'i:1795167638;', 1795167638);

-- Listage de la structure de table glodia. cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.cache_locks : ~0 rows (environ)

-- Listage de la structure de table glodia. carts
CREATE TABLE IF NOT EXISTS `carts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `items` json DEFAULT NULL,
  `total_items` int NOT NULL DEFAULT '0',
  `total_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CDF',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_user_id_foreign` (`user_id`),
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.carts : ~2 rows (environ)
INSERT INTO `carts` (`id`, `user_id`, `items`, `total_items`, `total_amount`, `currency`, `created_at`, `updated_at`) VALUES
	(1, 4, '[]', 0, 0.00, 'CDF', '2026-11-20 06:11:23', '2026-11-20 06:11:56'),
	(2, 1, '[]', 0, 0.00, 'CDF', '2026-11-20 07:20:45', '2026-11-20 07:39:49'),
	(3, 5, '[]', 0, 0.00, 'CDF', '2026-11-20 07:37:51', '2026-11-20 07:37:53');

-- Listage de la structure de table glodia. categorie
CREATE TABLE IF NOT EXISTS `categorie` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `couleur` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `statut` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.categorie : ~12 rows (environ)
INSERT INTO `categorie` (`id`, `name`, `description`, `couleur`, `statut`, `created_at`, `updated_at`) VALUES
	(5, 'Légumes', 'Variétés de légumes frais cultivés localement', '#22c55e', 1, '2026-04-01 10:48:31', '2026-04-01 10:48:31'),
	(6, 'Fruits', 'Fruits de saison et fruits exotiques', '#f59e0b', 1, '2026-04-01 10:48:31', '2026-04-01 10:48:31'),
	(7, 'Céréales', 'Blé, maïs, riz et autres céréales', '#eab308', 1, '2026-04-01 10:48:31', '2026-04-01 10:48:31'),
	(8, 'Produits Laitiers', 'Lait, fromage, beurre et yaourts', '#ffffff', 1, '2026-04-01 10:48:31', '2026-04-01 10:48:31'),
	(9, 'Viandes', 'Viandes bovines, porcines et volailles', '#dc2626', 1, '2026-04-01 10:48:31', '2026-04-01 10:48:31'),
	(10, 'Élevage', 'Animaux d\'élevage et produits dérivés', '#a855f7', 1, '2026-04-01 10:48:31', '2026-04-01 10:48:31'),
	(11, 'Miel et Produits Apicoles', 'Miel, pollen et produits de la ruche', '#fbbf24', 1, '2026-04-01 10:48:31', '2026-04-01 10:48:31'),
	(12, 'Huiles et Condiments', 'Huiles végétales et condiments naturels', '#84cc16', 1, '2026-04-01 10:48:31', '2026-04-01 10:48:31'),
	(13, 'Plantes Aromatiques', 'Herbes, épices et plantes médicinales', '#10b981', 1, '2026-04-01 10:48:31', '2026-04-01 10:48:31'),
	(14, 'Produits Transformés', 'Conserves, confitures et produits transformés', '#f97316', 1, '2026-04-01 10:48:31', '2026-04-01 10:48:31');

-- Listage de la structure de table glodia. categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.categories : ~5 rows (environ)
INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES
	(1, 'Légumes', 'legumes', 'Légumes frais de saison', '2026-11-20 06:07:48', '2026-11-20 06:07:48'),
	(2, 'Fruits', 'fruits', 'Fruits tropicaux', '2026-11-20 06:07:48', '2026-11-20 06:07:48'),
	(3, 'Produits laitiers', 'produits-laitiers', 'Lait, fromage, beurre', '2026-11-20 06:07:48', '2026-11-20 06:07:48'),
	(4, 'Viandes', 'viandes', 'Viandes fraîches', '2026-11-20 06:07:48', '2026-11-20 06:07:48'),
	(5, 'Céréales', 'cereales', 'Riz, maïs, etc.', '2026-11-20 06:07:48', '2026-11-20 06:07:48');

-- Listage de la structure de table glodia. commande
CREATE TABLE IF NOT EXISTS `commande` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `numero` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` int NOT NULL,
  `products` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.commande : ~6 rows (environ)
INSERT INTO `commande` (`id`, `numero`, `client_id`, `products`, `created_at`, `updated_at`) VALUES
	(1, 'CMD-20260331-7258', 1, '[{"id": 3, "qte": 1, "price": "100"}]', '2026-03-31 10:46:34', '2026-03-31 10:46:34'),
	(2, 'CMD-20260331-3243', 1, '[{"id": 3, "qte": 1, "price": "100"}]', '2026-03-31 10:47:29', '2026-03-31 10:47:29'),
	(3, 'CMD-20260331-4972', 1, '[{"id": 3, "qte": 2, "price": "100"}]', '2026-03-31 14:09:00', '2026-03-31 14:09:00'),
	(4, 'CMD-20260331-7803', 1, '[{"id": 3, "qte": 2, "price": "100"}]', '2026-03-31 14:16:17', '2026-03-31 14:16:17'),
	(5, 'CMD-20260418-0167', 2, '[{"id": 89, "qte": 1, "price": "6000"}]', '2026-04-18 18:21:14', '2026-04-18 18:21:14'),
	(6, 'CMD-20260418-5374', 2, '[{"id": 89, "qte": 1, "price": "6000"}]', '2026-04-18 18:54:52', '2026-04-18 18:54:52');

-- Listage de la structure de table glodia. failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.failed_jobs : ~0 rows (environ)

-- Listage de la structure de table glodia. jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.jobs : ~0 rows (environ)

-- Listage de la structure de table glodia. job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.job_batches : ~0 rows (environ)

-- Listage de la structure de table glodia. migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.migrations : ~14 rows (environ)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1),
	(4, '2026_03_26_135116_add_user_infos_table', 1),
	(5, '2026_03_26_151127_create_categorie_table', 2),
	(6, '2026_03_27_064531_create__product_table', 3),
	(7, '2026_03_31_114959_create_commande_table', 4),
	(8, '2026_03_31_124856_create_panier_table', 5),
	(9, '2026_03_21_143814_create_categories_table', 2),
	(10, '2026_03_21_143815_create_orders_table', 2),
	(11, '2026_03_21_143815_create_products_table', 2),
	(12, '2026_03_21_143816_create_order_items_table', 2),
	(13, '2026_03_21_143838_add_role_to_users_table', 2),
	(14, '2026_03_21_144823_create_carts_table', 6),
	(15, '2026_03_21_155334_create_personal_access_tokens_table', 6);

-- Listage de la structure de table glodia. orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CDF',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `shipping_address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `billing_address` text COLLATE utf8mb4_unicode_ci,
  `issued_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_order_number_unique` (`order_number`),
  KEY `orders_user_id_foreign` (`user_id`),
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.orders : ~2 rows (environ)
INSERT INTO `orders` (`id`, `order_number`, `user_id`, `total_amount`, `currency`, `status`, `shipping_address`, `billing_address`, `issued_date`, `created_at`, `updated_at`) VALUES
	(1, 'CMD2026110001', 4, 5000.00, 'CDF', 'delivered', 'Lubumbashi, RDC', 'Lubumbashi, RDC', '2026-11-20 06:11:56', '2026-11-20 06:11:56', '2026-11-20 06:53:14'),
	(2, 'CMD2026110002', 5, 5000.00, 'CDF', 'pending', '12 rue de la Ferme, Kinshasa', '12 rue de la Ferme, Kinshasa', '2026-11-20 07:37:53', '2026-11-20 07:37:53', '2026-11-20 07:37:53'),
	(3, 'CMD2026110003', 1, 3000.00, 'CDF', 'pending', '123 avenue de commerce', '123 avenue de commerce', '2026-11-20 07:39:49', '2026-11-20 07:39:49', '2026-11-20 07:39:49');

-- Listage de la structure de table glodia. order_items
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(12,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_product_id_foreign` (`product_id`),
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.order_items : ~2 rows (environ)
INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `total_price`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 2, 2500.00, 5000.00, '2026-11-20 06:11:56', '2026-11-20 06:11:56'),
	(2, 2, 1, 2, 2500.00, 5000.00, '2026-11-20 07:37:53', '2026-11-20 07:37:53'),
	(3, 3, 3, 1, 3000.00, 3000.00, '2026-11-20 07:39:49', '2026-11-20 07:39:49');

-- Listage de la structure de table glodia. panier
CREATE TABLE IF NOT EXISTS `panier` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.panier : ~0 rows (environ)

-- Listage de la structure de table glodia. password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.password_reset_tokens : ~0 rows (environ)

-- Listage de la structure de table glodia. personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.personal_access_tokens : ~11 rows (environ)
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
	(1, 'App\\Models\\User', 4, 'auth_token', '79d207634e01dac48dcb5650960d8599aef9cd7005378f91c58ee74f6d20c7ba', '["*"]', '2026-11-20 06:11:23', NULL, '2026-11-20 06:11:21', '2026-11-20 06:11:23'),
	(2, 'App\\Models\\User', 4, 'auth_token', '58562443172f022eaf6ccf513170ccef52bb81304084a51cffe5212b491f3ddf', '["*"]', '2026-11-20 06:11:58', NULL, '2026-11-20 06:11:54', '2026-11-20 06:11:58'),
	(3, 'App\\Models\\User', 3, 'auth_token', '3c3f344a5eee3d326351c2d7e572bd37917e70ecfb6ad3e0c28d3e71e5ffc142', '["*"]', '2026-11-20 06:13:05', NULL, '2026-11-20 06:13:05', '2026-11-20 06:13:05'),
	(4, 'App\\Models\\User', 1, 'auth_token', '36e2f4772ceb3c1ccd5c8c7ac511c1338565155ef5e1bfa99db883402564b7f6', '["*"]', '2026-11-20 07:40:22', NULL, '2026-11-20 06:51:48', '2026-11-20 07:40:22'),
	(5, 'App\\Models\\User', 3, 'auth_token', '846101b91ba15fb95514b74ce967ded9d44d1d8b0aa9487f706b34d0a1edbc6e', '["*"]', '2026-11-20 07:09:07', NULL, '2026-11-20 07:09:05', '2026-11-20 07:09:07'),
	(6, 'App\\Models\\User', 3, 'auth_token', '2f62049905fb2245eac4e45484bf45cea6a2021c289c8fea76eb0de9fc4c792e', '["*"]', NULL, NULL, '2026-11-20 07:10:01', '2026-11-20 07:10:01'),
	(7, 'App\\Models\\User', 3, 'auth_token', 'f06cfce90e0254c49b132ea697bdb20f7406de861ee4b09d67b38cabd3f592f4', '["*"]', NULL, NULL, '2026-11-20 07:11:15', '2026-11-20 07:11:15'),
	(8, 'App\\Models\\User', 3, 'auth_token', 'd7ecf0c15541e1d283dd923dfc79df055b3a1bc9eba746d6fd8de0fe5c52a64d', '["*"]', '2026-11-20 07:11:30', NULL, '2026-11-20 07:11:28', '2026-11-20 07:11:30'),
	(9, 'App\\Models\\User', 3, 'auth_token', '7e082816fd2dec480a042f95339e82118993e03e59cc8c2c4fca16a60cd8ff68', '["*"]', '2026-11-20 07:12:40', NULL, '2026-11-20 07:12:39', '2026-11-20 07:12:40'),
	(10, 'App\\Models\\User', 3, 'auth_token', '709f738171f570bb8fb2f2310ae7b9e034cb87606143581308e31e4d60ec10c6', '["*"]', '2026-11-20 07:14:13', NULL, '2026-11-20 07:14:12', '2026-11-20 07:14:13'),
	(11, 'App\\Models\\User', 3, 'auth_token', '7af6031859490f914f109f2e77d747f6bbdecf40dfa70aa91e1397809b4f0732', '["*"]', '2026-11-20 07:14:40', NULL, '2026-11-20 07:14:36', '2026-11-20 07:14:40'),
	(12, 'App\\Models\\User', 3, 'auth_token', '2f37451c179bf392ca279191a8df259a34ae2665b4bbe647d17755cf4a5514af', '["*"]', '2026-11-20 07:15:52', NULL, '2026-11-20 07:15:51', '2026-11-20 07:15:52'),
	(13, 'App\\Models\\User', 5, 'auth_token', 'd87097007d0177528de1af705ca0211f3043fcf34016af885961849696f50db9', '["*"]', '2026-11-20 07:37:53', NULL, '2026-11-20 07:37:51', '2026-11-20 07:37:53');

-- Listage de la structure de table glodia. product
CREATE TABLE IF NOT EXISTS `product` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `categorie_id` int NOT NULL,
  `statut` tinyint(1) NOT NULL DEFAULT '1',
  `data` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.product : ~117 rows (environ)
INSERT INTO `product` (`id`, `categorie_id`, `statut`, `data`, `created_at`, `updated_at`, `name`) VALUES
	(1, 5, 1, '{"qte": "50", "name": "Tomates Bio", "other": {"sku": "TOM001", "brand": "Ferme Bio", "weight": null}, "price": {"value": "1500", "currency": "cdf"}, "covers": ["products/twj41VmlnKshBTxgegvaJqQEe0kFdQiRvbR5Rg3q.jpg"], "description": "Tomates biologiques cultivées sans pesticides, riches en vitamines et saveur exceptionnelle."}', '2026-04-01 09:24:24', '2026-05-24 10:49:31', 'Tomates Bio'),
	(2, 5, 1, '{"qte": "30", "name": "Carottes Frais", "other": {"sku": "CAR001", "brand": "Légumes Frais", "weight": null}, "price": {"value": "1200", "currency": "cdf"}, "covers": ["products/1zVmQJonZ0fBzz3VoUT5YI8iMgeh9JURJ1TL7LKl.jpg"], "description": "Carottes croquantes et sucrées, parfaites pour les soupes et les plats cuisinés."}', '2026-04-01 09:24:24', '2026-05-24 10:49:34', 'Carottes Frais'),
	(3, 5, 1, '{"qte": "25", "name": "Épinards Tendres", "other": {"sku": "EPI001", "brand": "Bio Vert", "weight": null}, "price": {"value": "800", "currency": "cdf"}, "covers": ["products/j9VFlaspdDdhUyis24QqfhKvMBYNwsVAgyldQzfb.jpg"], "description": "Épinards frais cueillis, source de fer et de vitamines essentielles."}', '2026-04-01 09:24:24', '2026-04-01 15:02:02', 'Épinards Tendres'),
	(4, 5, 1, '{"qte": "20", "name": "Poivrons Colorés", "other": {"sku": "POI001", "brand": "Primeurs Plus", "weight": null}, "price": {"value": "2000", "currency": "cdf"}, "covers": ["products/usd7kbrm8TA2pcCrSRzRFWBGLsIKIZYJJaHFgxfX.jpg"], "description": "Assortiment de poivrons rouge, jaune et vert, croquants et savoureux."}', '2026-04-01 09:24:24', '2026-04-01 15:02:19', 'Poivrons Colorés'),
	(5, 5, 1, '{"qte": "35", "name": "Concombres Bio", "other": {"sku": "CON001", "brand": "Ferme Bio", "weight": null}, "price": {"value": "1000", "currency": "cdf"}, "covers": ["products/pOH8tkpPb8ABp6Vwlp3dkHkn5PdyKLy4TOxKkai2.jpg"], "description": "Concombres biologiques frais, idéals pour les salades estivales."}', '2026-04-01 09:24:24', '2026-04-01 15:02:42', 'Concombres Bio'),
	(6, 5, 1, '{"qte": "15", "name": "Aubergines Violettes", "other": {"sku": "AUB001", "brand": "Légumes Frais", "weight": null}, "price": {"value": "1800", "currency": "cdf"}, "covers": ["products/3QKITd54rJ6KjLZJQfDZB9OKJf9KzyzxXlC0S58K.jpg"], "description": "Aubergines fermes et charnues, parfaites pour la ratatouille et les grillades."}', '2026-04-01 09:24:24', '2026-04-01 15:03:16', 'Aubergines Violettes'),
	(7, 5, 1, '{"qte": "12", "name": "Brocolis Bio", "other": {"sku": "BRO001", "brand": "Bio Vert", "weight": null}, "price": {"value": "2200", "currency": "cdf"}, "covers": ["products/KnjmAhGw2RQVyhmxtfb4GkxzhKNXPK6QvHmDUIg5.jpg"], "description": "Brocolis biologiques riches en antioxydants et fibres alimentaires."}', '2026-04-01 09:24:24', '2026-04-01 15:04:21', 'Brocolis Bio'),
	(8, 5, 1, '{"qte": "18", "name": "Choux de Bruxelles", "other": {"sku": "CHB001", "brand": "Primeurs Plus", "weight": null}, "price": {"value": "1600", "currency": "cdf"}, "covers": ["products/RIltFwgUFLszSfvr40ulf3RXPi0hRxC3DKa0hXeJ.jpg"], "description": "Petits choux fermes et savoureux, cuits à la vapeur ou rôtis."}', '2026-04-01 09:24:24', '2026-04-01 15:04:43', 'Choux de Bruxelles'),
	(9, 5, 1, '{"qte": "40", "name": "Radis Roses", "other": {"sku": "RAD001", "brand": "Ferme Bio", "weight": null}, "price": {"value": "600", "currency": "cdf"}, "covers": ["products/pphmkRTsFykNfu65JHRkYHyK0ouylkzuRDqtBOQp.jpg"], "description": "Radis frais et piquants, parfaits pour les apéritifs et salades."}', '2026-04-01 09:24:24', '2026-04-01 15:04:55', 'Radis Roses'),
	(10, 5, 1, '{"qte": "22", "name": "Courgettes Vertes", "other": {"sku": "COU001", "brand": "Légumes Frais", "weight": null}, "price": {"value": "1400", "currency": "cdf"}, "covers": ["products/3rO4TrVE3Y6uY9XoaocWD0FFcMv4gzGsaJGgq1kq.jpg"], "description": "Courgettes tendres et savoureuses, polyvalentes en cuisine."}', '2026-04-01 09:24:24', '2026-04-01 15:05:17', 'Courgettes Vertes'),
	(11, 5, 1, '{"qte": "16", "name": "Haricots Verts Bio", "other": {"sku": "HAR001", "brand": "Bio Vert", "weight": null}, "price": {"value": "1900", "currency": "cdf"}, "covers": ["products/sJnwqe03sUtmPqQlAIjW7zSAsMi2H1i4ZoxKuQFQ.jpg"], "description": "Haricots verts biologiques fins et croquants."}', '2026-04-01 09:24:24', '2026-04-01 15:51:31', 'Haricots Verts Bio'),
	(12, 5, 1, '{"qte": "28", "name": "Poireaux Frais", "other": {"sku": "POI002", "brand": "Primeurs Plus", "weight": null}, "price": {"value": "1300", "currency": "cdf"}, "covers": ["products/ktrtHqWeQ0VNeFL7D14jMeOfaw5N4nVaHh2ZU2jS.jpg"], "description": "Poireaux blancs et tendres, essentiels pour les soupes et potages."}', '2026-04-01 09:24:24', '2026-04-01 15:51:10', 'Poireaux Frais'),
	(13, 5, 1, '{"qte": "32", "name": "Betteraves Rouges", "other": {"sku": "BET001", "brand": "Ferme Bio", "weight": null}, "price": {"value": "1100", "currency": "cdf"}, "covers": ["products/gIkEs7ZfWJipNzYTjrhoAddv5MXyms4RbRavkW08.jpg"], "description": "Betteraves sucrées et colorées, riches en nutriments."}', '2026-04-01 09:24:24', '2026-04-01 15:10:35', 'Betteraves Rouges'),
	(14, 5, 1, '{"qte": "38", "name": "Navets Blancs", "other": {"sku": "NAV001", "brand": "Légumes Frais", "weight": null}, "price": {"value": "900", "currency": "cdf"}, "covers": ["products/uQldqBsxDu5keVxb95sYfs1aiTbCdc5kzKOpeWHQ.jpg"], "description": "Navets doux et croquants, parfaits pour les potages d\'hiver."}', '2026-04-01 09:24:24', '2026-04-01 15:52:11', 'Navets Blancs'),
	(15, 5, 1, '{"qte": "14", "name": "Fenouil Bulbeux", "other": {"sku": "FEN001", "brand": "Bio Vert", "weight": null}, "price": {"value": "1700", "currency": "cdf"}, "covers": ["products/3S9Tc9O5ZKkTHjY3TRiDaqURxixpoBCAm9QvXNvz.jpg"], "description": "Bulbes de fenouil aromatiques, excellents crus ou cuits."}', '2026-04-01 09:24:24', '2026-04-01 15:52:55', 'Fenouil Bulbeux'),
	(16, 6, 1, '{"qte": "100", "name": "Bananes Bio", "other": {"sku": "BAN001", "brand": "Fruits Tropicaux", "weight": null}, "price": {"value": "800", "currency": "cdf"}, "covers": ["products/hMum4FYIjX5zAomwWh4RKsbZxRARYjNEOnsndgOG.jpg"], "description": "Bananes biologiques mûres à point, source d\'énergie naturelle."}', '2026-04-01 09:24:24', '2026-04-01 15:39:55', 'Bananes Bio'),
	(17, 6, 1, '{"qte": "80", "name": "Oranges Juteuses", "other": {"sku": "ORA001", "brand": "Agrumes Frais", "weight": null}, "price": {"value": "1200", "currency": "cdf"}, "covers": ["products/PELfTedeftkplQ9wB0lHNkvy7khPkCKEDEAuO764.jpg"], "description": "Oranges sucrées et riches en vitamine C, parfaites pour le jus frais."}', '2026-04-01 09:24:24', '2026-04-01 15:41:07', 'Oranges Juteuses'),
	(18, 6, 1, '{"qte": "60", "name": "Pommes Rouges", "other": {"sku": "POM001", "brand": "Verger Bio", "weight": null}, "price": {"value": "1500", "currency": "cdf"}, "covers": ["products/iOuottoOPiXwkfGxm5llTcfkoCGDtINsYBZAJUub.jpg"], "description": "Pommes croquantes et juteuses, idéales pour les desserts et collations."}', '2026-04-01 09:24:24', '2026-04-01 15:41:28', 'Pommes Rouges'),
	(19, 6, 1, '{"qte": "40", "name": "Mangues Sucrées", "other": {"sku": "MAN001", "brand": "Fruits Tropicaux", "weight": null}, "price": {"value": "2500", "currency": "cdf"}, "covers": ["products/dzxA1KKhYclbNQUZH0eNwht46MAv06Hrd7gmF7xZ.jpg"], "description": "Mangues exotiques juteuses et parfumées, riches en vitamines."}', '2026-04-01 09:24:24', '2026-04-01 15:41:44', 'Mangues Sucrées'),
	(20, 6, 1, '{"qte": "25", "name": "Ananas Frais", "other": {"sku": "ANA001", "brand": "Fruits Exotiques", "weight": null}, "price": {"value": "3000", "currency": "cdf"}, "covers": ["products/KGoq1wdkG9GuvWBcwc1FFUBeBgSfj65ZJ7WsZi0a.jpg"], "description": "Ananas dorés et sucrés, parfaits pour les salades de fruits."}', '2026-04-01 09:24:24', '2026-04-01 15:42:03', 'Ananas Frais'),
	(21, 6, 1, '{"qte": "45", "name": "Poires Williams", "other": {"sku": "POI003", "brand": "Verger Bio", "weight": null}, "price": {"value": "1800", "currency": "cdf"}, "covers": ["products/R99bOZOlO11EEDLhlqTgkBikGqn7jS9QHyAKsBdF.jpg"], "description": "Poires fondantes et sucrées, excellentes nature ou en compote."}', '2026-04-01 09:24:24', '2026-04-01 15:42:22', 'Poires Williams'),
	(22, 6, 1, '{"qte": "35", "name": "Kiwi Bio", "other": {"sku": "KIW001", "brand": "Fruits Tropicaux", "weight": null}, "price": {"value": "2200", "currency": "cdf"}, "covers": ["products/PQ7QS2LbjG5ftgJp1MQbcX9VNiSVNuohtVYtBjxW.jpg"], "description": "Kiwis biologiques riches en vitamine C et antioxydants."}', '2026-04-01 09:24:24', '2026-04-01 15:42:39', 'Kiwi Bio'),
	(23, 6, 1, '{"qte": "50", "name": "Raisin", "other": {"sku": "RAI001", "brand": "Vignoble Local", "weight": null}, "price": {"value": "1600", "currency": "cdf"}, "covers": ["products/0lGwLGL5RX199wU6OHswaaKVd7QeS4leCtSxbztr.jpg"], "description": "Raisins frais et croquants, parfaits pour les pique-niques."}', '2026-04-01 09:24:24', '2026-04-01 15:43:35', 'Raisin'),
	(24, 6, 1, '{"qte": "15", "name": "Pastèque", "other": {"sku": "PAS001", "brand": "Fruits de Saison", "weight": null}, "price": {"value": "3500", "currency": "cdf"}, "covers": ["products/VHMFFLgmBhYhItCbwpM4g4OSbw1IlEVg65cOluyK.jpg"], "description": "Pastèque juteuse et rafraîchissante, idéale pour l\'été."}', '2026-04-01 09:24:24', '2026-04-01 15:44:07', 'Pastèque'),
	(25, 6, 1, '{"qte": "70", "name": "Clémentines Bio", "other": {"sku": "CLE001", "brand": "Agrumes Frais", "weight": null}, "price": {"value": "1400", "currency": "cdf"}, "covers": ["products/nvUDwfDHOACbq0p3TSab7aI6oVPR5b2yNRTFq3wv.jpg"], "description": "Clémentines biologiques faciles à peler et très sucrées."}', '2026-04-01 09:24:24', '2026-04-01 15:44:56', 'Clémentines Bio'),
	(26, 6, 1, '{"qte": "20", "name": "Framboises Frais", "other": {"sku": "FRA001", "brand": "Baies Sauvages", "weight": null}, "price": {"value": "2800", "currency": "cdf"}, "covers": ["products/fNyBuCaasZf8FqPjMJ9aLgYX2n7MaxqspKyYOvaR.jpg"], "description": "Framboises délicates et parfumées, riches en antioxydants."}', '2026-04-01 09:24:24', '2026-04-01 15:39:29', 'Framboises Frais'),
	(27, 6, 1, '{"qte": "30", "name": "Melon Charentais", "other": {"sku": "MEL001", "brand": "Fruits de Saison", "weight": null}, "price": {"value": "2000", "currency": "cdf"}, "covers": ["products/S2k5wJoIjLuR1ji2fmp1FhEqnvLe9vblBo0uGNyc.jpg"], "description": "Melons sucrés et parfumés, parfaits pour les desserts d\'été."}', '2026-04-01 09:24:24', '2026-04-01 15:46:39', 'Melon Charentais'),
	(28, 6, 1, '{"qte": "18", "name": "Grenades Rouges", "other": {"sku": "GRE001", "brand": "Fruits Exotiques", "weight": null}, "price": {"value": "3200", "currency": "cdf"}, "covers": ["products/Loq5US5EvRRApYYmqaWmRtz4fZr3eSgPZIYOVroj.jpg"], "description": "Grenades juteuses riches en graines croquantes et savoureuses."}', '2026-04-01 09:24:24', '2026-04-01 15:47:00', 'Grenades Rouges'),
	(29, 6, 1, '{"qte": "22", "name": "Figues Violettes", "other": {"sku": "FIG001", "brand": "Verger Bio", "weight": null}, "price": {"value": "2400", "currency": "cdf"}, "covers": ["products/loV7K0E2h28BWfxWxIcayJjKxVAtjAiEl9Eek0Sf.jpg"], "description": "Figues mûres et sucrées, délicieuses nature ou en confiture."}', '2026-04-01 09:24:24', '2026-04-01 15:47:56', 'Figues Violettes'),
	(30, 6, 1, '{"qte": "28", "name": "Litchis Frais", "other": {"sku": "LIT001", "brand": "Fruits Tropicaux", "weight": null}, "price": {"value": "2600", "currency": "cdf"}, "covers": ["products/IYFrz993uRRTTyfoEQ4PINksX7MipYT13LbcPIb6.jpg"], "description": "Litchis exotiques à la chair blanche et juteuse."}', '2026-04-01 09:24:24', '2026-04-01 15:48:41', 'Litchis Frais'),
	(31, 7, 1, '{"qte": "200", "name": "Blé Dur Bio", "other": {"sku": "BLE001", "brand": "Céréales Bio", "weight": 2}, "price": {"value": "2500", "currency": "cdf"}, "covers": ["products/LC94FdbRtBaOQRlis3NFPguJFtF9vP0j5lffeKbu.jpg"], "description": "Blé dur biologique de qualité supérieure pour la fabrication de pâtes."}', '2026-04-01 09:24:24', '2026-04-09 11:11:58', 'Blé Dur Bio'),
	(32, 7, 1, '{"qte": "150", "name": "Maïs Jaune", "other": {"sku": "MAI001", "brand": "Grains Locaux", "weight": null}, "price": {"value": "1800", "currency": "cdf"}, "covers": ["products/xqc5DKJAUqeGJgvuV2B1QOqC8wucy3TuppKd0a8C.jpg"], "description": "Maïs jaune tendre, parfait pour la cuisine et l\'alimentation animale."}', '2026-04-01 09:24:24', '2026-04-01 15:54:32', 'Maïs Jaune'),
	(33, 7, 1, '{"qte": "120", "name": "Riz Blanc Long", "other": {"sku": "RIZ001", "brand": "Rizières Bio", "weight": null}, "price": {"value": "2200", "currency": "cdf"}, "covers": ["products/W9zBvALmossqmNMZmCf2vWHIv9GArxojSesRJR9Q.jpg"], "description": "Riz blanc de qualité premium, cuisson parfaite et saveur délicate."}', '2026-04-01 09:24:24', '2026-04-01 15:55:29', 'Riz Blanc Long'),
	(34, 7, 1, '{"qte": "80", "name": "Avoine Complète", "other": {"sku": "AVO001", "brand": "Céréales Bio", "weight": null}, "price": {"value": "1900", "currency": "cdf"}, "covers": ["products/hNVpbnEdsKdKijQZlYPF3pQj0ewlkOoekNONuPqD.jpg"], "description": "Avoine complète riche en fibres et nutriments essentiels."}', '2026-04-01 09:24:24', '2026-04-01 15:55:56', 'Avoine Complète'),
	(35, 7, 1, '{"qte": "50", "name": "Quinoa Bio", "other": {"sku": "QUI001", "brand": "Super Grains", "weight": null}, "price": {"value": "3500", "currency": "cdf"}, "covers": ["products/2gPXiVBnszd0VxUjrOzpAD3Ost4bQNQFBgbRQFlw.jpg"], "description": "Quinoa biologique, super-aliment complet et sans gluten."}', '2026-04-01 09:24:24', '2026-04-01 15:59:56', 'Quinoa Bio'),
	(36, 7, 1, '{"qte": "90", "name": "Orge Perlé", "other": {"sku": "ORG001", "brand": "Grains Locaux", "weight": null}, "price": {"value": "1600", "currency": "cdf"}, "covers": ["products/rkk7s6Ge2ufmrQVw4mHTcDfHbey60uE69EKet9Ar.jpg", "products/oPopHSP5KvZ3ZCu5pgQ8tBkg8lFEGEu2GQWlVdwB.jpg"], "description": "Orge perlé rapide à cuire, idéal pour soupes et pilafs."}', '2026-04-01 09:24:24', '2026-04-01 16:00:19', 'Orge Perlé'),
	(37, 7, 1, '{"qte": "60", "name": "Sarrasin Bio", "other": {"sku": "SAR001", "brand": "Céréales Bio", "weight": null}, "price": {"value": "2800", "currency": "cdf"}, "covers": ["products/XXj9IF1T1JgfCiGECznfLyxO5jMHMGU1tDzcAGN2.jpg"], "description": "Sarrasin biologique sans gluten, riche en protéines végétales."}', '2026-04-01 09:24:24', '2026-04-01 15:57:18', 'Sarrasin Bio'),
	(38, 7, 1, '{"qte": "70", "name": "Millet Jaune", "other": {"sku": "MIL001", "brand": "Grains Traditionnels", "weight": null}, "price": {"value": "2000", "currency": "cdf"}, "covers": ["products/6ywelxuxsITEWmYN4CZhKrirFUHf1gM1PHtsAjMn.jpg"], "description": "Millet doré nutritif, excellent pour les porridges et pains."}', '2026-04-01 09:24:24', '2026-04-01 15:58:26', 'Millet Jaune'),
	(39, 7, 1, '{"qte": "40", "name": "Épeautre Bio", "other": {"sku": "EPE001", "brand": "Blés Anciens", "weight": null}, "price": {"value": "3200", "currency": "cdf"}, "covers": ["products/AlV5VogaqzOyBjWCFfHgFXwW2Z31LA6uIkcUEa7X.jpg"], "description": "Épeautre ancien biologique, riche en nutriments et saveur unique."}', '2026-04-01 09:24:24', '2026-04-01 15:58:57', 'Épeautre Bio'),
	(40, 7, 1, '{"qte": "65", "name": "Seigle Complet", "other": {"sku": "SEI001", "brand": "Grains Locaux", "weight": null}, "price": {"value": "2100", "currency": "cdf"}, "covers": ["products/HdwjJLeqjiE7zGJNK4VF0kn1cIWAwNmveAOGAXsr.jpg"], "description": "Seigle complet pour pains rustiques et alimentation saine."}', '2026-04-01 09:24:24', '2026-04-18 17:31:30', 'Seigle Complet'),
	(41, 7, 1, '{"qte": "35", "name": "Amarante Bio", "other": {"sku": "AMA001", "brand": "Super Grains", "weight": null}, "price": {"value": "3800", "currency": "cdf"}, "covers": ["products/lDvsxDNeaQxEdNGQ1JqimEpOPNZLUdbZoivkaO9D.jpg"], "description": "Amarante biologique, super-aliment riche en protéines."}', '2026-04-01 09:24:24', '2026-04-18 17:32:39', 'Amarante Bio'),
	(42, 7, 1, '{"qte": "85", "name": "Sorgho Rouge", "other": {"sku": "SOR001", "brand": "Grains Traditionnels", "weight": null}, "price": {"value": "1700", "currency": "cdf"}, "covers": ["products/McjivupPWlxzYZ9eDmnF9t1ErtoeCH5XwyYzvirk.jpg"], "description": "Sorgho rouge traditionnel, résistant à la sécheresse."}', '2026-04-01 09:24:24', '2026-04-18 17:32:56', 'Sorgho Rouge'),
	(43, 7, 1, '{"qte": "25", "name": "Teff Bio", "other": {"sku": "TEF001", "brand": "Grains Exotiques", "weight": null}, "price": {"value": "4200", "currency": "cdf"}, "covers": ["products/dZiTIoOyD7vD8VKCwBI23Lejk07MFUB3ljtrZUM8.jpg"], "description": "Teff éthiopien biologique, petit grain aux grands nutriments."}', '2026-04-01 09:24:24', '2026-04-18 17:33:58', 'Teff Bio'),
	(44, 7, 1, '{"qte": "45", "name": "Fonio Blanc", "other": {"sku": "FON001", "brand": "Grains Traditionnels", "weight": null}, "price": {"value": "2900", "currency": "cdf"}, "covers": ["products/bpjA8jer9M1I7obU9SKJVhVz7xfnk0PzNRKp1jQU.jpg"], "description": "Fonio africain rapide à cuire, riche en minéraux."}', '2026-04-01 09:24:24', '2026-04-18 17:34:41', 'Fonio Blanc'),
	(45, 7, 1, '{"qte": "30", "name": "Blé Kamut", "other": {"sku": "KAM001", "brand": "Blés Anciens", "weight": null}, "price": {"value": "3600", "currency": "cdf"}, "covers": ["products/6kIqNfbFJrI8EiAlyF1N0gTadJVp4dn2xHs6EmgT.jpg"], "description": "Blé kamut ancien, plus digeste et nutritif que le blé moderne."}', '2026-04-01 09:24:24', '2026-04-18 17:35:11', 'Blé Kamut'),
	(46, 8, 1, '{"qte": "50", "name": "Lait de Vache Bio", "other": {"sku": "LAI001", "brand": "Ferme Bio", "weight": null}, "price": {"value": "2500", "currency": "cdf"}, "covers": ["products/gv970gLJErOeyChU1ltmvNHRwUSMkkvrqfKaxCkE.jpg"], "description": "Lait de vache biologique frais, riche en calcium et protéines."}', '2026-04-01 09:24:24', '2026-04-01 16:01:36', 'Lait de Vache Bio'),
	(47, 8, 1, '{"qte": "30", "name": "Fromage Blanc", "other": {"sku": "FRB001", "brand": "Laiterie Artisanale", "weight": null}, "price": {"value": "1800", "currency": "cdf"}, "covers": ["products/kcEI8AT0TbKMK6dkotnwxSTIplngD3Vyb3ZbX3s2.jpg"], "description": "Fromage blanc frais et crémeux, parfait pour les desserts."}', '2026-04-01 09:24:24', '2026-04-01 16:02:54', 'Fromage Blanc'),
	(48, 8, 1, '{"qte": "25", "name": "Beurre Bio", "other": {"sku": "BEU001", "brand": "Beurrier Bio", "weight": null}, "price": {"value": "3200", "currency": "cdf"}, "covers": ["products/6aGLrFIJmLL8aYmdFE9ZPj9kH3RVuXOUKUgmLZYG.jpg"], "description": "Beurre biologique onctueux, fabriqué avec du lait de qualité."}', '2026-04-01 09:24:24', '2026-04-01 16:03:33', 'Beurre Bio'),
	(49, 8, 1, '{"qte": "40", "name": "Yaourt Nature", "other": {"sku": "YAO001", "brand": "Ferme Bio", "weight": "500g"}, "price": {"value": 1200, "currency": "cdf"}, "covers": [], "description": "Yaourt nature fermenté naturellement, riche en probiotiques."}', '2026-04-01 09:24:24', '2026-04-01 09:24:24', 'Yaourt Nature'),
	(50, 8, 1, '{"qte": "20", "name": "Crème Fraîche", "other": {"sku": "CRE001", "brand": "Laiterie Artisanale", "weight": "200ml"}, "price": {"value": 2200, "currency": "cdf"}, "covers": [], "description": "Crème fraîche épaisse et savoureuse pour vos sauces et desserts."}', '2026-04-01 09:24:24', '2026-04-01 09:24:24', 'Crème Fraîche'),
	(51, 8, 1, '{"qte": "15", "name": "Lait de Chèvre", "other": {"sku": "LCH001", "brand": "Élevage Caprin", "weight": "1L"}, "price": {"value": 2800, "currency": "cdf"}, "covers": [], "description": "Lait de chèvre frais et crémeux, plus digeste pour certains."}', '2026-04-01 09:24:24', '2026-04-01 09:24:24', 'Lait de Chèvre'),
	(52, 8, 1, '{"qte": "12", "name": "Fromage de Chèvre", "other": {"sku": "FCH001", "brand": "Fromagerie Artisanale", "weight": "200g"}, "price": {"value": 3500, "currency": "cdf"}, "covers": [], "description": "Fromage de chèvre affiné, saveur unique et texture fondante."}', '2026-04-01 09:24:24', '2026-04-01 09:24:24', 'Fromage de Chèvre'),
	(53, 8, 1, '{"qte": "35", "name": "Petit-Suisse", "other": {"sku": "PSU001", "brand": "Laiterie Artisanale", "weight": "500g"}, "price": {"value": 1500, "currency": "cdf"}, "covers": [], "description": "Petits-suisses frais et légers, riches en protéines."}', '2026-04-01 09:24:24', '2026-04-01 09:24:24', 'Petit-Suisse'),
	(54, 8, 1, '{"qte": "28", "name": "Lait Concentré", "other": {"sku": "LCO001", "brand": "Produits Laitiers", "weight": "400g"}, "price": {"value": 1900, "currency": "cdf"}, "covers": [], "description": "Lait concentré sucré, idéal pour les desserts et pâtisseries."}', '2026-04-01 09:24:24', '2026-04-01 09:24:24', 'Lait Concentré'),
	(55, 8, 1, '{"qte": "18", "name": "Ricotta Fraîche", "other": {"sku": "RIC001", "brand": "Fromagerie Artisanale", "weight": "250g"}, "price": {"value": 2400, "currency": "cdf"}, "covers": [], "description": "Ricotta fraîche et légère, parfaite pour les plats italiens."}', '2026-04-01 09:24:24', '2026-04-01 09:24:24', 'Ricotta Fraîche'),
	(56, 8, 1, '{"qte": "22", "name": "Kéfir Nature", "other": {"sku": "KEF001", "brand": "Ferme Bio", "weight": "500ml"}, "price": {"value": 2100, "currency": "cdf"}, "covers": [], "description": "Kéfir fermenté naturellement, boisson probiotique ancestrale."}', '2026-04-01 09:24:24', '2026-04-01 09:24:24', 'Kéfir Nature'),
	(57, 8, 1, '{"qte": "10", "name": "Mascarpone", "other": {"sku": "MAS001", "brand": "Fromagerie Italienne", "weight": "250g"}, "price": {"value": 3800, "currency": "cdf"}, "covers": [], "description": "Mascarpone crémeux et riche, essentiel pour le tiramisu."}', '2026-04-01 09:24:24', '2026-04-01 09:24:24', 'Mascarpone'),
	(58, 8, 1, '{"qte": "16", "name": "Lait d\'Amande", "other": {"sku": "LAM001", "brand": "Laits Végétaux", "weight": "1L"}, "price": {"value": 2600, "currency": "cdf"}, "covers": [], "description": "Lait végétal d\'amande, alternative sans lactose."}', '2026-04-01 09:24:24', '2026-04-01 09:24:24', 'Lait d\'Amande'),
	(59, 8, 1, '{"qte": "32", "name": "Fromage Frais", "other": {"sku": "FFR001", "brand": "Laiterie Artisanale", "weight": "200g"}, "price": {"value": 1700, "currency": "cdf"}, "covers": [], "description": "Fromage frais léger et onctueux, base parfaite pour les herbes."}', '2026-04-01 09:24:24', '2026-04-01 09:24:24', 'Fromage Frais'),
	(60, 8, 1, '{"qte": "14", "name": "Crème Chantilly", "other": {"sku": "CCH001", "brand": "Pâtisserie Maison", "weight": "250ml"}, "price": {"value": 2900, "currency": "cdf"}, "covers": [], "description": "Crème chantilly maison, légère et aérienne."}', '2026-04-01 09:24:24', '2026-04-01 09:24:24', 'Crème Chantilly'),
	(61, 9, 1, '{"qte": "20", "name": "Bœuf Haché Bio", "other": {"sku": "BOH001", "brand": "Élevage Bio", "weight": null}, "price": {"value": "8500", "currency": "cdf"}, "covers": ["products/FBuePFPjJFiba3xI2zUjpsKHy7BRPzE7dxD7w0mm.jpg"], "description": "Viande de bœuf hachée biologique, tendre et savoureuse."}', '2026-04-01 09:24:24', '2026-04-18 18:00:24', 'Bœuf Haché Bio'),
	(62, 9, 1, '{"qte": "25", "name": "Poulet Fermier", "other": {"sku": "POU001", "brand": "Volailles Locales", "weight": null}, "price": {"value": "6500", "currency": "cdf"}, "covers": ["products/JhKGgPZ8s09ZEf424INDVLR7cWpdO14cT7Mcn1bj.jpg"], "description": "Poulet fermier élevé en liberté, chair tendre et goûteuse."}', '2026-04-01 09:24:24', '2026-04-18 18:00:46', 'Poulet Fermier'),
	(63, 9, 1, '{"qte": "15", "name": "Côtes de Porc", "other": {"sku": "COP001", "brand": "Élevage Traditionnel", "weight": null}, "price": {"value": "7200", "currency": "cdf"}, "covers": ["products/hKngNkGX6IjapgJLolYdclngaCMrsJ0ehIaHBP2H.jpg"], "description": "Côtes de porc charnues, parfaites pour les grillades."}', '2026-04-01 09:24:24', '2026-04-18 18:01:05', 'Côtes de Porc'),
	(64, 9, 1, '{"qte": "12", "name": "Agneau Bio", "other": {"sku": "AGN001", "brand": "Élevage Bio", "weight": null}, "price": {"value": "9500", "currency": "cdf"}, "covers": ["products/buFyelzFzG6YScTNuU7bLHLepV23kX2VowyEyP5G.jpg"], "description": "Viande d\'agneau biologique tendre et savoureuse."}', '2026-04-01 09:24:24', '2026-04-18 18:01:47', 'Agneau Bio'),
	(65, 9, 1, '{"qte": "8", "name": "Filet de Saumon", "other": {"sku": "SAU001", "brand": "Pêche Durable", "weight": null}, "price": {"value": "12000", "currency": "cdf"}, "covers": ["products/CGc5mdtx9r5rsSuW0mYKwAWUlm0Qv6I6nQsXQ58k.jpg"], "description": "Filet de saumon frais, riche en oméga-3."}', '2026-04-01 09:24:24', '2026-04-18 18:02:04', 'Filet de Saumon'),
	(66, 9, 1, '{"qte": "18", "name": "Dinde Entière", "other": {"sku": "DIN001", "brand": "Volailles Locales", "weight": null}, "price": {"value": "5800", "currency": "cdf"}, "covers": ["products/8n0Kd0vXzLGo1ItjJ8Rubp1EQnI1GqGcTVqswWlM.jpg"], "description": "Dinde entière fermière, parfaite pour les repas de fête."}', '2026-04-01 09:24:24', '2026-04-18 18:02:19', 'Dinde Entière'),
	(67, 9, 1, '{"qte": "10", "name": "Steak de Bœuf", "other": {"sku": "STB001", "brand": "Boucherie Artisanale", "weight": null}, "price": {"value": "11000", "currency": "cdf"}, "covers": ["products/aXzpQyMBy9lRY4H9WB0aNbmJwMzGkD4fcjGGfyW9.jpg"], "description": "Steak de bœuf de qualité supérieure, juteux et tendre."}', '2026-04-01 09:24:24', '2026-04-18 18:02:33', 'Steak de Bœuf'),
	(68, 9, 1, '{"qte": "22", "name": "Cuisse de Lapin", "other": {"sku": "LAP001", "brand": "Élevage Cuniculture", "weight": null}, "price": {"value": "4200", "currency": "cdf"}, "covers": ["products/95oWD99ttZN66SnDnLZtxM1ICdjilNUfiy8m3Ecw.jpg"], "description": "Cuisses de lapin fermier, viande maigre et délicate."}', '2026-04-01 09:24:24', '2026-04-18 18:02:47', 'Cuisse de Lapin'),
	(69, 9, 1, '{"qte": "16", "name": "Jambon Blanc", "other": {"sku": "JAM001", "brand": "Charcuterie Maison", "weight": null}, "price": {"value": "6800", "currency": "cdf"}, "covers": ["products/OyO4wzWe097X6zHd67Zr6rpemdIOlaScTe1hRL8a.jpg"], "description": "Jambon blanc artisanal, tranché finement."}', '2026-04-01 09:24:24', '2026-04-18 18:02:58', 'Jambon Blanc'),
	(70, 9, 1, '{"qte": "14", "name": "Foie de Veau", "other": {"sku": "FVE001", "brand": "Boucherie Artisanale", "weight": null}, "price": {"value": "5500", "currency": "cdf"}, "covers": ["products/D37DTwPOHgr6RDPDlQQWiH6AyoqrMEU2bSJas2Qq.jpg"], "description": "Foie de veau frais, riche en nutriments essentiels."}', '2026-04-01 09:24:24', '2026-04-18 18:03:11', 'Foie de Veau'),
	(71, 9, 1, '{"qte": "30", "name": "Saucisses Bio", "other": {"sku": "SAU002", "brand": "Charcuterie Bio", "weight": null}, "price": {"value": "4800", "currency": "cdf"}, "covers": ["products/nGcX3zephEzYqRa6dhnFlW7KKV6pDxawdD9fJuqc.jpg"], "description": "Saucisses biologiques faites maison, saveur authentique."}', '2026-04-01 09:24:24', '2026-04-18 18:03:26', 'Saucisses Bio'),
	(72, 9, 1, '{"qte": "11", "name": "Côtelette d\'Agneau", "other": {"sku": "CAG001", "brand": "Élevage Traditionnel", "weight": null}, "price": {"value": "8800", "currency": "cdf"}, "covers": ["products/a3Elvo5FOOZkaLOH9NAtgs6oYWxFF0zNSQQwMG4w.webp"], "description": "Côtelettes d\'agneau tendres et savoureuses."}', '2026-04-01 09:24:24', '2026-04-18 18:03:39', 'Côtelette d\'Agneau'),
	(73, 9, 1, '{"qte": "19", "name": "Blanc de Poulet", "other": {"sku": "BPO001", "brand": "Volailles Locales", "weight": null}, "price": {"value": "5900", "currency": "cdf"}, "covers": ["products/Gw0PnPrKLnpKZvrZsztbw6vFF6fewoWwSoUHdBgo.jpg"], "description": "Filets de poulet fermier, viande blanche maigre."}', '2026-04-01 09:24:24', '2026-04-18 18:03:51', 'Blanc de Poulet'),
	(74, 9, 1, '{"qte": "13", "name": "Rôti de Porc", "other": {"sku": "RPO001", "brand": "Élevage Traditionnel", "weight": null}, "price": {"value": "7600", "currency": "cdf"}, "covers": ["products/MoFcUCS0GbeJz59WyTfWNTMtt122Qlwc6EyVzSCl.jpg"], "description": "Rôti de porc prêt à cuire, juteux et parfumé."}', '2026-04-01 09:24:24', '2026-04-18 18:04:03', 'Rôti de Porc'),
	(75, 9, 1, '{"qte": "9", "name": "Canard Fermier", "other": {"sku": "CAN001", "brand": "Volailles Spécialisées", "weight": null}, "price": {"value": "8200", "currency": "cdf"}, "covers": ["products/LXhP7JPeE5g9ri4uaPBsE22g5Ay9YtGRmtO1PqCu.webp"], "description": "Canard fermier entier, chair goûteuse et peau croustillante."}', '2026-04-01 09:24:24', '2026-04-18 18:04:15', 'Canard Fermier'),
	(76, 10, 1, '{"qte": "50", "name": "Poulets Vivants", "other": {"sku": "POV001", "brand": "Élevage Local", "weight": null}, "price": {"value": "12000", "currency": "cdf"}, "covers": ["products/MHmAwznE7CKKUcIlzXvErT6fNKQjnRexkislW8jn.jpg"], "description": "Poulets vivants élevés en liberté, race locale résistante."}', '2026-04-01 09:24:24', '2026-04-18 18:04:48', 'Poulets Vivants'),
	(77, 10, 1, '{"qte": "8", "name": "Chèvres Laitières", "other": {"sku": "CHL001", "brand": "Élevage Caprin", "weight": null}, "price": {"value": "45000", "currency": "cdf"}, "covers": ["products/sUU6Gs0cUz0QmgnuXDUWQagdmc96bSw6XnaGvNLz.jpg"], "description": "Chèvres laitières de race alpine, productrices de lait de qualité."}', '2026-04-01 09:24:24', '2026-04-18 18:04:59', 'Chèvres Laitières'),
	(78, 10, 1, '{"qte": "5", "name": "Veaux de Boucherie", "other": {"sku": "VEB001", "brand": "Élevage Bovin", "weight": null}, "price": {"value": "85000", "currency": "cdf"}, "covers": ["products/4nblFwKhKhveelCVtCdGMMVO5TeHqDFuf2jglV5Q.jpg"], "description": "Veaux de race locale, élevés pour la production de viande de qualité."}', '2026-04-01 09:24:24', '2026-04-18 18:05:13', 'Veaux de Boucherie'),
	(79, 10, 1, '{"qte": "30", "name": "Lapins Vivants", "other": {"sku": "LAP002", "brand": "Élevage Cuniculture", "weight": null}, "price": {"value": "8000", "currency": "cdf"}, "covers": ["products/z9QiXwCE8QRd85BAtGuRKonO9pFEezhciFqNGPX4.jpg"], "description": "Lapins vivants de race californienne, prolifiques et résistants."}', '2026-04-01 09:24:25', '2026-04-18 18:05:27', 'Lapins Vivants'),
	(80, 10, 1, '{"qte": "15", "name": "Canards de Barbarie", "other": {"sku": "CDB001", "brand": "Élevage Avicole", "weight": null}, "price": {"value": "15000", "currency": "cdf"}, "covers": ["products/aCBVjAVu72gY085sDjhtr6nPzxo0qIKSqUndKGcH.jpg"], "description": "Canards de barbarie, race rustique adaptée au climat local."}', '2026-04-01 09:24:25', '2026-04-18 18:05:38', 'Canards de Barbarie'),
	(81, 10, 1, '{"qte": "6", "name": "Moutons Mérinos", "other": {"sku": "MOM001", "brand": "Élevage Ovin", "weight": null}, "price": {"value": "55000", "currency": "cdf"}, "covers": ["products/9mCqnhfOkhWAhIEKidZnmTChSlJOwrT5wn4FaRkr.jpg"], "description": "Moutons mérinos, producteurs de laine fine et de viande de qualité."}', '2026-04-01 09:24:25', '2026-04-18 18:05:48', 'Moutons Mérinos'),
	(82, 10, 1, '{"qte": "25", "name": "Pintades Vivantes", "other": {"sku": "PIN001", "brand": "Élevage Avicole", "weight": null}, "price": {"value": "10000", "currency": "cdf"}, "covers": ["products/gMvEU8n0pwZvI7maYziCeFe8q0FhaYk35xwYBQhJ.jpg"], "description": "Pintades vivantes, volailles rustiques et savoureuses."}', '2026-04-01 09:24:25', '2026-04-18 18:06:06', 'Pintades Vivantes'),
	(83, 10, 1, '{"qte": "3", "name": "Vaches Laitières", "other": {"sku": "VAL001", "brand": "Élevage Bovin", "weight": null}, "price": {"value": "120000", "currency": "cdf"}, "covers": ["products/29k5nhjdFKVnVBNOdGSokMLqbzsdv552y5J9L8pC.jpg"], "description": "Vaches laitières de race holstein, hautes productrices de lait."}', '2026-04-01 09:24:25', '2026-04-18 18:06:20', 'Vaches Laitières'),
	(84, 10, 1, '{"qte": "12", "name": "Dindes Vivantes", "other": {"sku": "DIV001", "brand": "Élevage Avicole", "weight": null}, "price": {"value": "18000", "currency": "cdf"}, "covers": ["products/KtkLNClHpc8rMPQAwdnq6VitmFIio6r8zfCR5Dx3.jpg"], "description": "Dindes vivantes de race locale, parfaites pour l\'élevage familial."}', '2026-04-01 09:24:25', '2026-04-18 18:06:32', 'Dindes Vivantes'),
	(86, 10, 1, '{"qte": "18", "name": "Oies Grises", "other": {"sku": "OIG001", "brand": "Élevage Avicole", "weight": null}, "price": {"value": "14000", "currency": "cdf"}, "covers": ["products/5Ol7lKbotcKWpBvIrYlIONMfnmXEXarDo13qJVjU.jpg"], "description": "Oies grises vivantes, productrices de foie gras et de plumes."}', '2026-04-01 09:24:25', '2026-04-18 18:06:45', 'Oies Grises'),
	(87, 10, 1, '{"qte": "7", "name": "Boucs Reproducteurs", "other": {"sku": "BOR001", "brand": "Élevage Caprin", "weight": null}, "price": {"value": "35000", "currency": "cdf"}, "covers": ["products/FMGDuwJueKgLFDCYex0KXDuyPaVvi6aN3Z8r0xvu.jpg"], "description": "Boucs reproducteurs de race locale, pour l\'amélioration génétique."}', '2026-04-01 09:24:25', '2026-04-18 18:07:01', 'Boucs Reproducteurs'),
	(88, 10, 1, '{"qte": "4", "name": "Porcs Blancs", "other": {"sku": "POB001", "brand": "Élevage Porcin", "weight": null}, "price": {"value": "65000", "currency": "cdf"}, "covers": ["products/evE8AuvJNHKWE3VoBI7Hnh8yWitwn51wrdbPsGeC.jpg"], "description": "Porcs blancs de race large white, élevés pour la production porcine."}', '2026-04-01 09:24:25', '2026-04-18 18:07:14', 'Porcs Blancs'),
	(89, 10, 1, '{"qte": "40", "name": "Poules Pondeuses", "other": {"sku": "POP001", "brand": "Élevage Avicole", "weight": null}, "price": {"value": "6000", "currency": "cdf"}, "covers": ["products/0wVATAayylmibnBj1QvbxsSp5Q44a7yzG0yZOdqY.jpg"], "description": "Poules pondeuses de race leghorn, excellentes productrices d\'œufs."}', '2026-04-01 09:24:25', '2026-04-18 18:07:28', 'Poules Pondeuses'),
	(91, 11, 1, '{"qte": "30", "name": "Miel d\'Acacia", "other": {"sku": "MAC001", "brand": "Rucher Bio", "weight": "500g"}, "price": {"value": 4500, "currency": "cdf"}, "covers": [], "description": "Miel d\'acacia liquide et cristallin, saveur douce et florale."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Miel d\'Acacia'),
	(92, 11, 1, '{"qte": "20", "name": "Pollen d\'Abeille", "other": {"sku": "POL001", "brand": "Apiculture Naturelle", "weight": "100g"}, "price": {"value": 3200, "currency": "cdf"}, "covers": [], "description": "Pollen frais collecté par les abeilles, concentré nutritionnel."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Pollen d\'Abeille'),
	(93, 11, 1, '{"qte": "15", "name": "Gelée Royale", "other": {"sku": "GEL001", "brand": "Apiculture Royale", "weight": "10g"}, "price": {"value": 8500, "currency": "cdf"}, "covers": [], "description": "Gelée royale pure, super-aliment aux propriétés exceptionnelles."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Gelée Royale'),
	(94, 11, 1, '{"qte": "25", "name": "Propolis Pure", "other": {"sku": "PRO001", "brand": "Rucher Traditionnel", "weight": "50g"}, "price": {"value": 2800, "currency": "cdf"}, "covers": [], "description": "Propolis brute récoltée naturellement, propriétés antimicrobiennes."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Propolis Pure'),
	(95, 11, 1, '{"qte": "22", "name": "Miel de Lavande", "other": {"sku": "MLA001", "brand": "Rucher des Alpes", "weight": "500g"}, "price": {"value": 5200, "currency": "cdf"}, "covers": [], "description": "Miel de lavande parfumé, saveur intense et relaxante."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Miel de Lavande'),
	(96, 11, 1, '{"qte": "18", "name": "Cire d\'Abeille", "other": {"sku": "CIR001", "brand": "Apiculture Naturelle", "weight": "200g"}, "price": {"value": 3800, "currency": "cdf"}, "covers": [], "description": "Cire d\'abeille pure, pour fabrications artisanales et cosmétiques."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Cire d\'Abeille'),
	(97, 11, 1, '{"qte": "16", "name": "Miel de Châtaignier", "other": {"sku": "MCH001", "brand": "Rucher Forestier", "weight": "500g"}, "price": {"value": 4800, "currency": "cdf"}, "covers": [], "description": "Miel de châtaignier ambré, saveur forte et distinctive."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Miel de Châtaignier'),
	(98, 11, 1, '{"qte": "12", "name": "Pain d\'Abeille", "other": {"sku": "PAN001", "brand": "Apiculture Royale", "weight": "300g"}, "price": {"value": 6500, "currency": "cdf"}, "covers": [], "description": "Pain d\'abeille naturel, mélange de pollen et de miel."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Pain d\'Abeille'),
	(99, 11, 1, '{"qte": "14", "name": "Miel de Sarrasin", "other": {"sku": "MSA001", "brand": "Rucher Traditionnel", "weight": "500g"}, "price": {"value": 5500, "currency": "cdf"}, "covers": [], "description": "Miel de sarrasin foncé, riche en minéraux et saveur robuste."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Miel de Sarrasin'),
	(100, 11, 1, '{"qte": "19", "name": "Huile de Propolis", "other": {"sku": "HPR001", "brand": "Apiculture Naturelle", "weight": "30ml"}, "price": {"value": 4200, "currency": "cdf"}, "covers": [], "description": "Huile de propolis extraite naturellement, pour usage cutané."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Huile de Propolis'),
	(101, 11, 1, '{"qte": "21", "name": "Miel de Thym", "other": {"sku": "MTH001", "brand": "Rucher Médicinal", "weight": "500g"}, "price": {"value": 4900, "currency": "cdf"}, "covers": [], "description": "Miel de thym aromatique, propriétés médicinales reconnues."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Miel de Thym'),
	(102, 11, 1, '{"qte": "17", "name": "Nectar d\'Abeille", "other": {"sku": "NEC001", "brand": "Apiculture Naturelle", "weight": "250g"}, "price": {"value": 3600, "currency": "cdf"}, "covers": [], "description": "Nectar d\'abeille concentré, base pour la production de miel."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Nectar d\'Abeille'),
	(103, 11, 1, '{"qte": "23", "name": "Miel de Colza", "other": {"sku": "MCO001", "brand": "Rucher des Champs", "weight": "500g"}, "price": {"value": 4100, "currency": "cdf"}, "covers": [], "description": "Miel de colza clair et doux, cristallisation lente."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Miel de Colza'),
	(104, 11, 1, '{"qte": "11", "name": "Capsules de Gelée Royale", "other": {"sku": "CGR001", "brand": "Apiculture Royale", "weight": "60 capsules"}, "price": {"value": 7200, "currency": "cdf"}, "covers": [], "description": "Gelée royale lyophilisée en capsules, facilité de consommation."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Capsules de Gelée Royale'),
	(105, 11, 1, '{"qte": "13", "name": "Miel de Romarin", "other": {"sku": "MRO001", "brand": "Rucher Médicinal", "weight": "500g"}, "price": {"value": 5300, "currency": "cdf"}, "covers": [], "description": "Miel de romarin parfumé, saveur herbacée distinctive."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Miel de Romarin'),
	(106, 12, 1, '{"qte": "25", "name": "Huile d\'Olive Extra Vierge", "other": {"sku": "HOL001", "brand": "Oliviers Bio", "weight": "500ml"}, "price": {"value": 6500, "currency": "cdf"}, "covers": [], "description": "Huile d\'olive extra vierge de première pression, saveur fruitée."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Huile d\'Olive Extra Vierge'),
	(107, 12, 1, '{"qte": "40", "name": "Huile de Tournesol", "other": {"sku": "HTO001", "brand": "Huiles Végétales", "weight": "1L"}, "price": {"value": 2800, "currency": "cdf"}, "covers": [], "description": "Huile de tournesol raffinée, neutre et polyvalente en cuisine."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Huile de Tournesol'),
	(108, 12, 1, '{"qte": "35", "name": "Vinaigre de Cidre", "other": {"sku": "VCI001", "brand": "Fermentation Naturelle", "weight": "500ml"}, "price": {"value": 2200, "currency": "cdf"}, "covers": [], "description": "Vinaigre de cidre brut non filtré, propriétés santé reconnues."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Vinaigre de Cidre'),
	(109, 12, 1, '{"qte": "20", "name": "Huile de Coco Vierge", "other": {"sku": "HCO001", "brand": "Coco Tropical", "weight": "500ml"}, "price": {"value": 4200, "currency": "cdf"}, "covers": [], "description": "Huile de coco extra vierge, solide à température ambiante."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Huile de Coco Vierge'),
	(110, 12, 1, '{"qte": "30", "name": "Sauce Soja Bio", "other": {"sku": "SSO001", "brand": "Fermentation Asiatique", "weight": "250ml"}, "price": {"value": 1800, "currency": "cdf"}, "covers": [], "description": "Sauce soja biologique fermentée naturellement, saveur umami."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Sauce Soja Bio'),
	(111, 12, 1, '{"qte": "28", "name": "Huile d\'Arachide", "other": {"sku": "HAR001", "brand": "Huiles Végétales", "weight": "1L"}, "price": {"value": 3200, "currency": "cdf"}, "covers": [], "description": "Huile d\'arachide raffinée, idéale pour la friture."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Huile d\'Arachide'),
	(112, 12, 1, '{"qte": "45", "name": "Moutarde à l\'Ancienne", "other": {"sku": "MAN001", "brand": "Condiments Maison", "weight": "200g"}, "price": {"value": 1500, "currency": "cdf"}, "covers": [], "description": "Moutarde à l\'ancienne, graines entières et saveur piquante."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Moutarde à l\'Ancienne'),
	(113, 12, 1, '{"qte": "18", "name": "Huile de Sésame Toasté", "other": {"sku": "HSE001", "brand": "Huiles Spécialisées", "weight": "250ml"}, "price": {"value": 3800, "currency": "cdf"}, "covers": [], "description": "Huile de sésame torréfiée, arôme puissant pour l\'asiatique."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Huile de Sésame Toasté'),
	(114, 12, 1, '{"qte": "15", "name": "Vinaigre Balsamique", "other": {"sku": "VBA001", "brand": "Vinaigriers Italiens", "weight": "250ml"}, "price": {"value": 5500, "currency": "cdf"}, "covers": [], "description": "Vinaigre balsamique traditionnel, doux et fruité."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Vinaigre Balsamique'),
	(115, 12, 1, '{"qte": "32", "name": "Huile de Colza", "other": {"sku": "HCO002", "brand": "Huiles Végétales", "weight": "1L"}, "price": {"value": 2600, "currency": "cdf"}, "covers": [], "description": "Huile de colza raffinée, riche en oméga-3."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Huile de Colza'),
	(116, 12, 1, '{"qte": "22", "name": "Sauce Worcestershire", "other": {"sku": "SWO001", "brand": "Condiments Anglais", "weight": "150ml"}, "price": {"value": 2400, "currency": "cdf"}, "covers": [], "description": "Sauce Worcestershire fermentée, indispensable en cuisine."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Sauce Worcestershire'),
	(117, 12, 1, '{"qte": "12", "name": "Huile de Noix", "other": {"sku": "HNO001", "brand": "Huiles Spécialisées", "weight": "250ml"}, "price": {"value": 7200, "currency": "cdf"}, "covers": [], "description": "Huile de noix extra vierge, saveur intense pour les salades."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Huile de Noix'),
	(118, 12, 1, '{"qte": "27", "name": "Vinaigre de Vin Rouge", "other": {"sku": "VVR001", "brand": "Vinaigriers Locaux", "weight": "500ml"}, "price": {"value": 1900, "currency": "cdf"}, "covers": [], "description": "Vinaigre de vin rouge artisanal, acidité équilibrée."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Vinaigre de Vin Rouge'),
	(119, 12, 1, '{"qte": "14", "name": "Huile d\'Avocat", "other": {"sku": "HAV001", "brand": "Huiles Exotiques", "weight": "250ml"}, "price": {"value": 6800, "currency": "cdf"}, "covers": [], "description": "Huile d\'avocat extra vierge, riche en nutriments."}', '2026-04-01 09:24:25', '2026-04-01 09:24:25', 'Huile d\'Avocat');

-- Listage de la structure de table glodia. products
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CDF',
  `quantity` int NOT NULL DEFAULT '0',
  `category_id` bigint unsigned DEFAULT NULL,
  `images` json DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_slug_unique` (`slug`),
  KEY `products_category_id_foreign` (`category_id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.products : ~5 rows (environ)
INSERT INTO `products` (`id`, `name`, `slug`, `description`, `price`, `currency`, `quantity`, `category_id`, `images`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 'Tomates fraîches', 'tomates-fraiches', 'Tomates rouges et juteuses, cultivées sans pesticides', 2500.00, 'CDF', 96, 1, '["/images/products/tomates-1.svg"]', 1, '2026-11-20 06:07:48', '2026-11-20 07:37:53'),
	(2, 'Bananes plantain', 'bananes-plantain', 'Bananes plantain mûres, idéales pour la cuisson', 1500.00, 'CDF', 200, 2, '["/images/products/bananes-1.svg"]', 1, '2026-11-20 06:07:48', '2026-11-20 06:07:48'),
	(3, 'Lait frais', 'lait-frais', 'Lait frais pasteurisé, 1 litre', 3000.00, 'CDF', 49, 3, '["/images/products/lait-1.svg"]', 1, '2026-11-20 06:07:48', '2026-11-20 07:39:49'),
	(4, 'Poulet fermier', 'poulet-fermier', 'Poulet élevé en plein air', 15.00, 'USD', 30, 4, '["/images/products/poulet-1.svg"]', 1, '2026-11-20 06:07:48', '2026-11-20 06:07:48'),
	(5, 'Riz local', 'riz-local', 'Riz blanc de qualité supérieure, 5kg', 10000.00, 'CDF', 80, 5, '["/images/products/riz-1.svg"]', 1, '2026-11-20 06:07:48', '2026-11-20 06:07:48');

-- Listage de la structure de table glodia. sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.sessions : ~17 rows (environ)
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
	('0OP2vjcUuO4YoiFd4Z589cyqDe3Zj4lvJZJFNyuI', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:160.0) Gecko/20100101 Firefox/160.0', 'eyJfdG9rZW4iOiI0a2JyT0wyRG8xUTRlc3pwTUR0eml6Vk1FTU9wU0w2dWpoZUNYdlRZIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795167624),
	('6T53YkivTrAAAhWhwVFZMTRSxSES0UpA7ooK7gVj', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJhN3lnQ2lsZ2xOQURJaDhGUFF2ZjQ3VGpkV2FWZktHdGhVTTlsaGRkIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9hZG1pblwvZGFzaGJvYXJkIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795165276),
	('7NINGKBpJjUlyUVmW8IxLsnILeMSrTdpFGzJ7QZW', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJTMFpLcU5lYXJJNXlYSmVXMzZlRWVnREV4bzJuUDNXanZNcng2SkdJIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795164278),
	('8Kl8vU07zS71wIGMRoIePKtx7CO5B8tbJgoSQE9c', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJ6dVlqU1hqTzFqejI3SldqdDZXY2tqUzJzTnB2RGoyRVlJV1BTZnpGIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795164270),
	('Bs24rlUgkrJ91zgWOPSMOBCabSMSQM8bXPfM7Fab', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiIwSmJ2UGhiaW1YYkgyUWhaQkRqVW1lS3MyS216bndNSlpsd0VhMTlPIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795164300),
	('Bvf8huU31uinCiIToMF30U0mhS7MuNvh98iBIHBm', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJxTTVnOEI1azgyZzI4dW1WcHlOdDhIRWVWVG51ajdVSE1QT29EWUEzIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795162223),
	('Cvf8GuUBfoGklcj34UYKkaOFOl7Lclwmgy5zSshb', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJJTVNVSDBqc1VueEY1ZTdGbEdNRHJOdWpMZjY0N1gwbXpPaGl5cTNtIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9wcm9kdWN0cyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1795164532),
	('f66DOJ244Uzp9uss8Cek6FWp0tY0LcqTrBoXtdzL', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJyN2pDUmRRaFB5OVgwTjJHY1JlaUw3bEUxQXZXb1d0bUx3WnFZOE85IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795164531),
	('HWohkmMpuRp6cCY3ewULoTshgaJl7P1wvtgsVaed', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJzazhqdHhjWDI5SXVsTm9oN2JmODNFdWcwWXNSRnlLa1VYMHJROGRyIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795164280),
	('jdjRms0kawP2JE3NYC6lAmtbtmDYIFY5bfh6pw67', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJvZ3pxc3hHZHJvNHZLQUZHUk1nSDJwWGZmaEVPd2kzTU1ldTVubXVUIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795164434),
	('ln0Ok29nwyWOfrHP9hWe2NDjvBA1YrBAFKxnyQyQ', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJEbGRWSDdiTFdRbTlLZnNoSnI3NFVVYUVuSGNhYnVzQWxBTXBLYlU0IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795164434),
	('nGyn0WniDFLyzTsDiqBHVlQKOh4Q4Qz2ZECUm8JB', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJVenNLVDg3emRncjBCbFVtTkZWbDJ0VlBjNEhib25WZkU4Y09qS0d4IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795164303),
	('tGry6JkN3tIFfuWpcB1USWxZ4vAaz6wZEpoZqOQm', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJlVG1LOXptRFpPOE1LV25MT29neHhZMzNPa1Q3UkIxbkJ4TTlGUENRIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9wcm9kdWN0cyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1795162224),
	('UixrQq731fvGGEp9gibCRtdLSlVoBUzqqulJNzZI', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJKTWZqWHVkYVBSdlN6UUxzSDZqMUtPM1ppaW1FYXYwYnIzQXJlY2JNIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9jYXRlZ29yeVwvbGVndW1lcyIsInJvdXRlIjpudWxsfSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==', 1795164533),
	('v1jUAkX6rWifUyVyUcMKxH4le8Ij64AyVLgUpIXZ', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJhQ21obmo5U1JscEVrTm1SQjRPcU1XczBZRGdRbzlUd1FhS2xidjg5IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795163144),
	('V2VApW1iYSFA5L4cdbwNrmvoOPtlOmVjFVikirFe', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Devin/1.141.2 Chrome/150.0.7871.250 Electron/43.8.8 Safari/537.36', 'eyJfdG9rZW4iOiJlMlBvT1VEa1NXSUo1b2x3c21sVmF2QVJ3RXR4UExRSW5JMDB5MWNVIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795165281),
	('Yl4niNUhXPHPxgTv9hoGuBtOHlVPU9ixLckBjuoX', NULL, '127.0.0.1', 'curl/8.16.0', 'eyJfdG9rZW4iOiJtb1UxWThQVzA2NFRJUjhoZFNvcEJScVBhZWMzMWptU3pGNVk0WXllIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwXC9yZWNlaXB0XC8yIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1795167511);

-- Listage de la structure de table glodia. users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `role` enum('admin','client') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'client',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_index` (`role`),
  KEY `users_phone_index` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table glodia.users : ~4 rows (environ)
INSERT INTO `users` (`id`, `name`, `email`, `phone`, `address`, `city`, `country`, `postal_code`, `latitude`, `longitude`, `role`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'admin@glodia.com', '+243 821884421', '123 avenue de commerce', 'Lubumbashi', 'RDC', '12345', NULL, NULL, 'admin', '2026-03-26 12:43:10', '$2y$12$uSq1S8s.9ORGOOgtBk6DZ.j.feZBLuvfOjurkBqD9IdGMtY8cpfnS', 'GG0hiA7S5Qn3zYaHwlpHC3rcnQTEqC1lt3MmhrRgkpoMjDOtxyuOjVxffaIk', '2026-03-26 12:43:11', '2026-04-09 15:03:31'),
	(2, 'denny', 'denkedj18@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'client', NULL, '$2y$12$gsGowpM8F4Bym2Jl1.aMSeIJ/l78R20UlVEYxWVQTC1utD9GkU.FG', 'KJsL0gcIHNxgxK2LHx6uUfpVLGNDtSghzcvZfPO3NxDeI3GL9AaagIU5VQgv', '2026-03-26 12:44:26', '2026-03-26 12:44:26'),
	(3, 'Administrateur', 'admin@fermier.com', '+243123456789', 'Kinshasa, RDC', NULL, NULL, NULL, NULL, NULL, 'admin', NULL, '$2y$12$WSH/bX2IpkoTufHPeoXth.g7C4hKAQUk0X9DodKmyahda7311d8MS', NULL, '2026-11-20 06:07:48', '2026-11-20 06:07:48'),
	(4, 'Client Test', 'client@test.com', '+243987654321', 'Lubumbashi, RDC', NULL, NULL, NULL, NULL, NULL, 'client', NULL, '$2y$12$LEGfuyYdeoPA6iczAIuwQ.WagdV4BNR6PPBweS4qEXwqBobSeQp.C', NULL, '2026-11-20 06:07:48', '2026-11-20 06:07:48'),
	(5, 'Client Test', 'client.test@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'client', NULL, '$2y$12$ONWXPySzPmKCjRguucoSOeii/BezNzR8dFxwpDh9FwmhD7zbkQGTm', NULL, '2026-11-20 07:37:51', '2026-11-20 07:37:51');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
