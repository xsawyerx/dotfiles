# filename: .bashrc

# tab completion from SSH's known_hosts
#complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
#complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" sshr

function sshdel () {
    perl -i -n -e "print unless (\$. == $1)" ~/.ssh/known_hosts;
}

function google () {
    u=`perl -MURI::Escape -wle 'print "http://google.com/search?q=".
    uri_escape(join " ",  @ARGV)' $@`
    w3m -no-mouse -F $u
}

function scpan () {
    u=`perl -MURI::Escape -wle 'print "http://search.cpan.org/search?query=".
        uri_escape(join " ",  @ARGV) ."&mode=module&n=100"' $@`

    w3m -no-mouse -F $u
}

function hostip () {
    grep $1 /etc/hosts | awk '{print $1}'
}

function cp_p() {
   strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
        count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }

         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

function phplog() {
    perl -nle'$_=~ s/\\n/\n/g; $_=~ s/\\t/\t/g; print $_'
}

complete -C perldoc-complete -o nospace -o default pod

EDITOR='vim'

. ~/.git_term
. ~/.aliases

