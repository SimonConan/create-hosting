# Function to add the current version of Wordpress
addWP()
{
    if [ ! -f /var/sftp/${USER}/live/wp-config.php ]
    then
        KEY1=`openssl rand -base64 60 | tr -d '\n'`
        KEY2=`openssl rand -base64 60 | tr -d '\n'`
        KEY3=`openssl rand -base64 60 | tr -d '\n'`
        KEY4=`openssl rand -base64 60 | tr -d '\n'`
        KEY5=`openssl rand -base64 60 | tr -d '\n'`
        KEY6=`openssl rand -base64 60 | tr -d '\n'`
        KEY7=`openssl rand -base64 60 | tr -d '\n'`
        KEY8=`openssl rand -base64 60 | tr -d '\n'`
        echo ""
        echo -e "\xf0\x9f\x8c\x8e \033[33mAdd WP sources\033[0m"
        echo ""
        wp core download --path="/var/sftp/${USER}/live/" --locale="fr_FR" --allow-root
        echo ""
        echo -e "       \xF0\x9F\x8E\xAF \033[33mCreation of the wp-config file\033[0m"
        cat <<EOF > /var/sftp/${USER}/live/wp-config.php
<?php
// ** Réglages MySQL ** //
/** Nom de la base de données de WordPress. */
define('DB_NAME', '${USER}');
/** Utilisateur de la base de données MySQL. */
define('DB_USER', '${USER}');
/** Mot de passe de la base de données MySQL. */
define('DB_PASSWORD', '${SQLPASS}');
/** Adresse de l’hébergement MySQL. */
define('DB_HOST', '127.0.0.1');
/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
define('DB_CHARSET', 'utf8');
/** Préfixe de base de données pour les tables de WordPress. */
\$table_prefix = 'wp_';

/** Type de collation de la base de données.
  * N’y touchez que si vous savez ce que vous faites.
  */
define('DB_COLLATE', '');

/**#@+
 * Clés uniques d’authentification et salage.
 */
define('AUTH_KEY',         '${KEY1}');
define('SECURE_AUTH_KEY',  '${KEY2}');
define('LOGGED_IN_KEY',    '${KEY3}');
define('NONCE_KEY',        '${KEY4}');
define('AUTH_SALT',        '${KEY5}');
define('SECURE_AUTH_SALT', '${KEY6}');
define('LOGGED_IN_SALT',   '${KEY7}');
define('NONCE_SALT',       '${KEY8}');
/**#@-*/

/**
 * Pour les développeurs : le mode déboguage de WordPress.
 */
define('WP_DEBUG', false);
define('FS_METHOD', 'direct');
define('DISALLOW_FILE_EDIT', true);

/** Chemin absolu vers le dossier de WordPress. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once(ABSPATH . 'wp-settings.php');
EOF
        echo -e "       \xF0\x9F\x94\x8F \033[33mSet the good WP permissions\033[0m"
        echo ""
        chown -R ${USER}:sftp /var/sftp/${USER}/live
        chmod -R 755 /var/sftp/${USER}/live
        find /var/sftp/${USER}/live/ -type d -exec chmod 755 {} \;
        find /var/sftp/${USER}/live/ -type f -exec chmod 744 {} \;
        chown -R www-data:sftp /var/sftp/${USER}/live/wp-content/
        chmod -R 775 /var/sftp/${USER}/live/wp-content/

    fi
}