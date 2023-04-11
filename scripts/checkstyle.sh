#!/usr/bin/env sh

CHECKSTYLE_CONFIG=$HOME/.config/checkstyle
CHECKSTYLE_ROOT=$HOME/.local/share/checkstyle
CHECKSTYLE_BIN=/usr/local/bin/checkstyle

[ ! -d "$CHECKSTYLE_ROOT" ] && mkdir -p "$CHECKSTYLE_ROOT"

download_checkstyle () {
    echo "DOWNLOAD CHEKSTYLE"
    [ -x "$(command -v jq)" ] && \
        CHECKSTYLE_VERSION=$(curl -sL https://api.github.com/repos/checkstyle/checkstyle/releases/latest | jq -r ".tag_name") || \
        CHECKSTYLE_VERSION=$(curl -sL https://api.github.com/repos/checkstyle/checkstyle/releases/latest | grep "tag_name" | grep -oE "checkstyle-[0-9.]+")
        curl \
            -sL "https://github.com/checkstyle/checkstyle/releases/download/$CHECKSTYLE_VERSION/$CHECKSTYLE_VERSION-all.jar" \
            -o "$CHECKSTYLE_ROOT/checkstyle.jar"
}

make_exec () {
    echo "MAKE CHEKSTYLE WRAPPER"
    if [ ! -f $CHECKSTYLE_BIN ]; then
        echo '#!/bin/env sh' > /tmp/checkstyle
        echo "$1 \"\$\@\"" >> /tmp/checkstyle
        chmod +x /tmp/checkstyle
        sudo mv /tmp/checkstyle $CHECKSTYLE_BIN
    fi
}

STYLE_XML=google_checks.xml
[ ! -f "$CHECKSTYLE_CONFIG/$STYLE_XML" ] && \
    echo "DOWNLOAD CHEKSTYLE GOOGLE" && \
    wget https://raw.githubusercontent.com/checkstyle/checkstyle/master/src/main/resources/$STYLE_XML -P "$CHECKSTYLE_CONFIG"

[ ! -f "$CHECKSTYLE_ROOT/checkstyle.jar" ] && \
    download_checkstyle && \
    make_exec "java -jar $CHECKSTYLE_ROOT/checkstyle.jar"

ENV_FILE=~/.zshenv
grep -q "alias checkstyle=.*" $ENV_FILE || \
    echo "alias 'checkstyle=checkstyle -c $CHECKSTYLE_CONFIG/$STYLE_XML' " >> $ENV_FILE

