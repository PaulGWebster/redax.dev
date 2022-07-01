FROM perlbase:stage3 AS stage4

# Why is this here again? I think its an sqlite requirement
RUN mkdir -p lemon-src                                  \
    && tar -xzf lemon*.tar.gz -C lemon-src/             \
    && cd lemon-src/lemon*                              \
    && mkdir build                                      \
    && cd build                                         \
    && cmake ..                                         \
    && make                                             \
    && make install

# Postgresql
RUN mkdir -p postgresql-src                             \
    && tar -xzf postgresql*.tar.gz -C postgresql-src/   \
    && cd postgresql-src/postgresql*                    \
    && ./configure                                      \
    && make -j4                                         \
    && make install

# MariaDB
RUN mkdir -p mariadb-src                                \
    && tar -xzf mariadb*.tar.gz -C mariadb-src/         \
    && cd mariadb-src/mariadb*                          \
    && cmake .                                          \
    && make install

# SQLite
RUN mkdir -p sqlite-src                                 \
    && tar -xzf sqlite*.tar.gz -C sqlite-src/           \
    && cd sqlite-src/sqlite*                            \
    && ./configure                                      \
    && make -j4                                         \
    && make install

# Redis
RUN mkdir -p redis-src                                  \
    && tar -xzf redis*.tar.gz -C redis-src/             \
    && cd redis-src/redis*                              \
    && make -j4 BUILD_TLS=yes                           \
    && make install

