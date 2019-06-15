FROM [ORG/IMAGE:TAG]

## Set up the CMD as well as the pre and post hooks.
COPY go-init /bin/go-init
COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY exitpoint.sh /usr/bin/exitpoint.sh

ENTRYPOINT ["go-init"]
CMD ["-pre", "/usr/bin/entrypoint.sh", "-main", "[YOUR COMMAND HERE]", "-post", "/usr/bin/exitpoint.sh"]
