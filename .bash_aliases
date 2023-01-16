notify() {
    curl "https://api2.pushdeer.com/message/push?pushkey=PDU19399Td20CW0cajednaRzvtmLISIKfjKg4pvQ3&text=$1" > /dev/null 2>&1
}

# Something that is agressive
alias cd='pushd'
alias ..='cd ..'

# Basic aliases
alias netstat='netstat -tulpn'
alias lsof='lsof -i'
alias ps='ps aux'
alias df='df -h'
alias free='free -h'
alias du='du -h -d 1'
alias which='type -a'
alias l='ll -Al'

# Install aliases
alias apt-get='sudo apt-get'
alias yum='sudo yum'

# Ip aliases
# 本机 ip 地址
alias ipl='ipconfig getifaddr en0'
# 公网 ip 地址
alias ipp2='curl icanhazip.com'

# python aliases
alias py='python'
alias pi='pip install'