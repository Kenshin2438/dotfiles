# toggle_proxy --set 127.0.0.1:7890
# toggle_proxy --unset

function toggle_proxy
    switch $argv[1]
        case --set
            set -Ux HTTP_PROXY  "http://$argv[2]"
            set -Ux HTTPS_PROXY "http://$argv[2]"
            set -Ux ALL_PROXY   "http://$argv[2]"
            set -Ux NO_PROXY    "localhost,127.0.0.1,localaddress,.localdomain.com,::1,10.*.*.*"
        case --unset
            set -Ue HTTP_PROXY HTTPS_PROXY ALL_PROXY NO_PROXY
    end
end
