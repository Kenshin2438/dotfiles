function set_proxy
    set -l type $argv[1]
    set -l host $argv[2]
    set -l port $argv[3]

    if not string length --quiet $type
        set type http
    end

    if not string length --quiet $host
        set host '127.0.0.1'
    end

    if not string length --quiet $port
        set port 2080
    end

    set -l proxy "$type://$host:$port"
    echo $proxy


    set --global -x HTTP_PROXY $proxy
    set --global -x HTTPS_PROXY $proxy
    set --global -x http_proxy $proxy
    set --global -x https_proxy $proxy
end
