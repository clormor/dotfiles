# .zshenv

# Startup timing for interactive shells. Each phase is marked with
# _startup_mark, and the first prompt appends one line to the log:
#   2026-10-15T09:12:03 total=112ms zprofile=3 bashrc=20 ... prompt=30 load=1.23
# The log rotates to a single .1 backup once it exceeds ZSH_STARTUP_LOG_MAX_BYTES.
if [[ -o interactive ]]; then
    zmodload zsh/datetime
    typeset -gF _startup_t0=$EPOCHREALTIME
    typeset -gF _startup_prev=$_startup_t0
    typeset -ga _startup_phases=()

    function _startup_mark {
        local ms
        printf -v ms '%.0f' $(( (EPOCHREALTIME - _startup_prev) * 1000 ))
        _startup_phases+=("$1=$ms")
        _startup_prev=$EPOCHREALTIME
    }

    function _startup_log {
        add-zsh-hook -d precmd _startup_log
        _startup_mark prompt

        local total line
        printf -v total '%.0f' $(( (EPOCHREALTIME - _startup_t0) * 1000 ))
        strftime -s line '%Y-%m-%dT%H:%M:%S' $EPOCHSECONDS
        line+=" total=${total}ms ${_startup_phases[*]} tty=${TTY#/dev/} term=${TERM_PROGRAM:-unknown}"
        unset _startup_t0 _startup_prev _startup_phases

        # Load average and file I/O run in the background so logging adds no
        # latency to the prompt.
        {
            local log=${ZSH_STARTUP_LOG:-${XDG_STATE_HOME:-$HOME/.local/state}/zsh/startup.log}
            local max=${ZSH_STARTUP_LOG_MAX_BYTES:-102400}
            [[ -d ${log:h} ]] || mkdir -p ${log:h}
            print -r -- "$line load=$(sysctl -n vm.loadavg 2>/dev/null | cut -d' ' -f2)" >>| $log
            zmodload -F zsh/stat b:zstat
            (( $(zstat +size $log) > max )) && mv -f $log $log.1
        } &!
    }
fi
