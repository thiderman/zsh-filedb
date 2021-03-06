function __zsys-config()
{
    reply=()
    for s in ${(k)CONF_GLOBAL}; do
        for f in ${(s: :)CONF_GLOBAL[$s]}; do
            if [[ -f $f ]]; then
                reply+=($s)
            fi
        done
    done

    for s in ${(k)CONF_LOCAL}; do
        for f in ${(s: :)CONF_LOCAL[$s]}; do
            if [[ -f $f ]]; then
                reply+=($s)
            fi
        done
    done
     _describe 'configuration files' reply
}

function __zsys-log()
{
    reply=()
    for s in ${(k)LOG_GLOBAL}; do
        for f in ${(s: :)LOG_GLOBAL[$s]}; do
            if [[ -f $f ]]; then
                reply+=($s)
            fi
        done
    done

     _describe 'log files' reply
}

function _zsys()
{
    if (( CURRENT == 2 )); then
        _values 'core command' \
            'config[edit configuration files]' \
            'log[read log files]' \
            'tail[tail log files]' \
            'add[add conf/log files to local file db]' \
            'commit[commit unsaved changes to local file db]' \
            && return
    fi

    if (( CURRENT == 3 )); then
        case $words[2] in
            config)
                _arguments '*:cfg files:__zsys-config' && return
            ;;
            "log" | "tail")
                _arguments '*:log files:__zsys-log' && return
            ;;
        esac
    fi

    case $words[2] in
        config)
            _zsys-parse_config_filearg
        ;;
        "log" | "tail")
            _arguments '*:log files:__zsys-log' && return
        ;;
    esac
}

compdef _zsys zsys
