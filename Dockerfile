FROM debian:bookworm-20240130-slim as builder

RUN apt-get update && apt-get install -y make

COPY . /usr/src/build/

WORKDIR /usr/src/build/

RUN make -C fks-scripts install DESTDIR=/usr/src/dist/
RUN make -C fks-templates install DESTDIR=/usr/src/dist/
RUN make -C fks-texmf install DESTDIR=/usr/src/dist/

# Apply patches
COPY ./patches/gloss-czech.ldf /usr/src/dist/usr/share/texmf/tex/latex/polyglossia/gloss-czech.ldf
COPY --chmod=777 ./patches/pdfbook /usr/src/dist/usr/local/bin/pdfbook
COPY ./patches/ImageMagick-policy.xml /usr/src/dist/etc/ImageMagick-6/policy.xml

# Keep the static version to not trigger cache invalidations
FROM debian:bookworm-20240130-slim

# Install LaTeX
RUN apt-get update && apt-get install -y \
    texlive-base \
    texlive-binaries \
    texlive-extra-utils \
    texlive-font-utils \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-lang-czechslovak \
    texlive-lang-greek \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    #texlive-math-extra \
    texlive-metapost \
    texlive-pictures \
    texlive-pstricks \
    texlive-science \
    texlive-xetex \
    #texlive-full \
&& rm -rf /var/lib/apt/lists/*

# Install static files
RUN apt-get update && apt-get install -y \
    bash \
    bc\
    fonts-liberation \
    fonts-sil-doulos \
    git \
    gnuplot \
    imagemagick \
    inkscape \
    ipe \
    libc-bin \
    lmodern \
    make \
    #pdfjam \
    perl \
    #pgf \
    poppler-utils \
    python3 \
    sed \
    wget \
    xsltproc \
&& rm -rf /var/lib/apt/lists/*

# generate font cache and make it writable
RUN fc-cache -f -v && chmod -R 777 /var/cache/fontconfig/

COPY --from=builder /usr/src/dist/ /

RUN mktexlsr

WORKDIR /usr/src/local
