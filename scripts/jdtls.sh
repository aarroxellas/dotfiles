#!/bin/env sh

JDTLS_ROOT=$HOME/.local/bin/jdtls
JDTLS_BIN=/usr/local/bin/jdtls
JDTLS_WORKSPACE="${XDG_CACHE_HOME:-$HOME/.cache}/jdtls-workspace"

[ ! -d "$JDTLS_ROOT" ] && mkdir -p "$JDTLS_ROOT"

jdtls_download () {
    LATEST=$(curl -Ls 'http://download.eclipse.org/jdtls/snapshots/latest.txt')
    JDTLS_EQUINOX_LAUNCHER=$(find "$JDTLS_ROOT/plugins" -type f -name 'org.eclipse.equinox.launcher_*' 2> /dev/null)

    if [ ! -d "$JDTLS_ROOT/plugins" ]; then
        echo "Downloading JDTLS - ${LATEST%.tar.gz}"

        cd "$JDTLS_ROOT"
        curl -L "http://download.eclipse.org/jdtls/snapshots/$LATEST" --output "$LATEST" --progress-bar

        tar -xf "$LATEST" --overwrite
        rm "$LATEST"
    fi
}

lombok_download () {
    LOMBOK="$JDTLS_ROOT/plugins/lombok.jar"

    [ -f "$LOMBOK" ] && \
        curl "https://projectlombok.org/downloads/lombok.jar" --output "$LOMBOK" --progress-bar
}

make_exec () {
    ENV_FILE=$HOME/.zshenv

    case "$(uname)" in
        [Ll]inux) # Linux and WSL
            CONFIG="$JDTLS_ROOT/config_linux"
            ;;
        [Dd]arwin) # MacOS
            CONFIG="$JDTLS_ROOT/config_mac"
            ;;
    esac

    echo '#!/bin/env sh' > /tmp/jdtls
    echo "$JDTLS_ROOT/bin/jdtls \"\$\@\"" >> /tmp/jdtls
    chmod +x /tmp/jdtls

    echo "moving wrapper to $JDTLS_BIN"
    sudo mv /tmp/jdtls $JDTLS_BIN

    LOMBOK="$JDTLS_ROOT/plugins/lombok.jar"

    # Use Jdtls Wrapper
    if [ -x "$(command -v python3)" ]; then
        RUNNABLE=$(echo "$JDTLS_BIN" \
            "-configuration ${CONFIG}" \
            "-data $JDTLS_WORKSPACE")
    else
        # JAVA config otherwise
        RUNNABLE=$(echo "java" \
            "-Declipse.application=org.eclipse.jdt.ls.core.id1" \
            "-Dosgi.bundles.defaultStartLevel=4" \
            "-Declipse.product=org.eclipse.jdt.ls.core.product" \
            "-Dlog.level=ALL" \
            "-Xmx1G" \
            "-javaagent:$LOMBOK" \
            "-jar $JDTLS_EQUINOX_LAUNCHER" \
            "-configuration $CONFIG" \
            "-data $JDTLS_WORKSPACE" \
            "--add-modules=ALL-SYSTEM" \
            "--add-opens java.base/java.util=ALL-UNNAMED" \
            "--add-opens java.base/java.lang=ALL-UNNAMED")
    fi

    grep -q "alias.*jdtls" "$ENV_FILE" || echo "alias 'jdtls=$RUNNABLE'" >> "$ENV_FILE"
}

jdtls_download
lombok_download
make_exec

