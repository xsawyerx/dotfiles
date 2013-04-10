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

#function scp(){ if [[ "$@" =~ : ]];then /usr/bin/scp $@ ; else echo 'stupid colon...'; fi;} # Catch a common scp mistake.

function phplog() {
    perl -nle'$_=~ s/\\n/\n/g; $_=~ s/\\t/\t/g; print $_'
}

function calc() {
    awk "BEGIN{ print $* }"
}

complete -C perldoc-complete -o nospace -o default pod

function maxmem() {
    TR=`free|grep Mem:|awk '{print $2}'`
    /bin/ps axo rss,comm,pid|awk -v tr=$TR '{proc_list[$2]+=$1;} END {for (proc in proc_list) {proc_pct=(proc_list[proc]/tr)*100; printf("%d\t%-16s\t%0.2f%\n",proc_list[proc],proc,proc_pct);}}'|sort -n |tail -n 20|tac
}

function conns() {
    netstat -an | grep ESTABLISHED | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | awk '{ printf("%s\t%s\t",$2,$1); for (i = 0; i < $1; i++) {printf("*")}; print ""}' | sort -nk 2
}

function strace_read() {
    strace -ff -e write=1,2 -s 1024 -p $1  2>&1 | grep "^ |" | cut -c11-60 | sed -e 's/ //g' | xxd -r -p
}

function screencast() {
    ffmpeg -f alsa -ac 2 -i hw:0,0 -f x11grab -r 30 -s $(xwininfo -root | grep 'geometry' | awk '{print $2;}') -i :0.0 -acodec pcm_s16le -vcodec libx264 -vpre lossless_ultrafast -threads 0 -y $1
}

function tail_timestamp() { tail -f $* | while read line; do echo -n $(date -u -Ins); echo -e "\t$line"; done;  }

function fstrace() { strace -ff -e trace=file $1 2>&1 | perl -ne 's/^[^"]+"(([^\\"]|\\[\\"nt])*)".*/$1/ && print'; }

function mkpass() { perl -MCrypt::XkcdPassword -E'say Crypt::XkcdPassword->new(words=>"EN")->make_password(4)'; }

EDITOR='vim'

. ~/.git_term
. ~/.aliases

