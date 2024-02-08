# util-wptools

Utility for wordpress giving the following

- add wp-cli easily
- add wp-archive.sh for easy wp dumping

## More info

- wordpress is copied into a volume: /tmp/wordpress
- /tmp/backups as temp loc for archives before they get uploaded
- adds /tmp/.gitignore blocking git tracking of below
  - wordpress/wp-content/
  - backups/
  - we track /tmp folder
- we zip .htaccess, wp-config.php, wp-content, and /tmp/.git from above
- to retrieve, unpack, cd /tmp, then `git reset --hard commitHashHere`
- usage: 
    - `docker compose exec wptools wp --version`
    - `docker compose exec wptools wp-archive.sh`

- See sample usage below:

    ```yml
    wptools:
        build: ./_util/wptools
        depends_on: [fpm, mysql]
        networks: [net1]
        volumes:
        - ./_util/wptools/sbin:/usr/local/sbin
        - ./_util/wptools/wp.gitignore:/tmp/.gitignore
        - ./_util/wptools/backups:/tmp/backups
        - huenits-lara:${APP_DIR}
        command: sh -c "tail -f /dev/null"
        environment:
        - PAGER='busybox more'
        - WP_CLI_ALLOW_ROOT=1
        - WP_DIR=${WP_DIR:-/var/www/laravel/blog}
    ```