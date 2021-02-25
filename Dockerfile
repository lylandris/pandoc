FROM haskell:buster
LABEL maintainer="lylandris <lylandris.jiang@gmail.com>"

COPY *.ttf *.ttc /usr/share/fonts/truetype/win/

RUN apt-get update && apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
		biber \
		latexmk \
		texlive-full \
		xfonts-wqy \
		ttf-wqy-microhei \
		ttf-wqy-zenhei \
		inkscape \
	&& fc-cache -f -v \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ENV PANDOC_VERSION "2.10.1"
ENV PANDOC_CROSSREF_VERSION "-0.3.8.3"
ENV PANDOC_CITEPROC_VERSION "-0.17.0.2"

COPY config /root/.cabal/config
RUN cabal update && cabal install \
	pandoc${PANDOC_VERSION} \
	pandoc-crossref${PANDOC_CROSSREF_VERSION} \
	pandoc-citeproc${PANDOC_CITEPROC_VERSION}

WORKDIR /source

ENTRYPOINT ["/root/.cabal/bin/pandoc"]

CMD ["--help"]
