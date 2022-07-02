FROM paulgwebster/perlbase:stage8 AS release

RUN useradd -rm perl
USER perl
WORKDIR /home/perl

RUN perl -MCPAN -Mlocal::lib -e 'CPAN::install(LWP)'
RUN echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"' >>~/.bashrc
