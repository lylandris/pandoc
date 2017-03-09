FROM haskell:8.0
MAINTAINER lylandris <lylandris.jiang@gmail.com>

RUN apt-get update -y \
    && apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
        texlive-latex-base \
        texlive-xetex latex-xcolor \
        texlive-math-extra \
        texlive-latex-extra \
        texlive-fonts-extra \
        texlive-bibtex-extra \
        fontconfig \
        lmodern \
        latex-cjk-all \
        texlive-lang-chinese \
        xfonts-wqy \
        ttf-wqy-microhei \
        ttf-wqy-zenhei \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ENV PANDOC_VERSION "1.19.2.1"

RUN cabal update && cabal install pandoc-${PANDOC_VERSION}

WORKDIR /source

ENTRYPOINT ["/root/.cabal/bin/pandoc"]

CMD ["--help"]
