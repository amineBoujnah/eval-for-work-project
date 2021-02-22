<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress');

/** MySQL database username */
define( 'DB_USER', 'dbmaxuser');

/** MySQL database password */
define( 'DB_PASSWORD', 'j5Yh84u8ByAgc75Yh84');

/** MySQL hostname */
define( 'DB_HOST', 'eval-database.coxnolpt0kjh.eu-west-3.rds.amazonaws.com');

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '546cba73f4467925e94f633ec9a33dc1f9b8192c');
define( 'SECURE_AUTH_KEY',  '951681f13f98fadf4767b449aabf73b9ca1424a3');
define( 'LOGGED_IN_KEY',    '68c36863e60692bb6a094619d7f4006e33862ed3');
define( 'NONCE_KEY',        '5fb76e7cfb465f12122b24ea570a80b7b67aa328');
define( 'AUTH_SALT',        'e8f633ffe0be773e0e9649b2dfaa508f638e5033');
define( 'SECURE_AUTH_SALT', 'ff62eb1f7e1503770950e9b1c6d72da604fbab09');
define( 'LOGGED_IN_SALT',   '54f98e1641a6e1055e39d512fd81d6dcf4f3d237');
define( 'NONCE_SALT',       '58d9f1b17f61fb26894e1377a038148710d9655a');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

// If we're behind a proxy server and using HTTPS, we need to alert WordPress of that fact
// see also http://codex.wordpress.org/Administration_Over_SSL#Using_a_Reverse_Proxy
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
	$_SERVER['HTTPS'] = 'on';
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
