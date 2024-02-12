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
    build: .dev/wptools
    depends_on: [wordpress, mysql]
    volumes:
      - ./.dev/wptools/sbin:/usr/local/sbin
      - ${NICK}-wp_backups:/tmp/backups
      - ${NICK}-wordpress:/tmp/wordpress
      - ./.dev/wptools/wp.gitignore:/tmp/.gitignore
    command: sh -c "tail -f /dev/null"
    environment:
      - PAGER='busybox more'
      - WP_CLI_ALLOW_ROOT=1
```