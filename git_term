#!/bin/bash
#
# PS1 magic
#
# Mostly copied from YUVAL KOGMAN's version, added my own __git_ps1 stuff
# Original: http://gist.github.com/621452
#
# See video demo of this at http://vimeo.com/15789794
#
# To enable save as .bash_prompt in $HOME and add to .bashrc:
#
# . ~/.bash_prompt
#
# Pedro Melo, <melo@simplicidade.org>
#
# - Added updating of terminal title
# Sawyer X, <xsawyerx@cpan.org>

_update_prompt () {
  ## Save $? early, we'll need it later
  local exit="$?"
  
  ## define some colors
  local red="31";
  local green="32";
  local yellow="33";
  local purple="35";
  local cyan="36";
  local white="37";

  local pre="\[\e[";
  local suf="\]";

  local e_green="${pre}0;${green}m$suf";
  local e_purple="${pre}0;${purple}m$suf";
  local e_cyan="${pre}0;${cyan}m$suf";
  local e_white="${pre}0;${white}m$suf";
  local e_bred="$pre$red;1m$suf";
  local e_byellow="$pre$yellow;1m$suf";

  local e_normal="\[\e[0;0m\]"

  ## Initial prompt
  _prompt="[$e_white\h$e_normal:$e_cyan\w$e_normal]";
  
  ## Color based on exit code
  local bul="\342\200\242" # bullet character
  case "$exit" in
    "0" ) ex="$e_green$bul$e_normal " ;;
    * ) ex="$e_bred$bul$e_normal " ;;
  esac

  ## Color current user
  local u;
  local p;
  if [ "$UID" = "0" ]; then
    u="$e_bred\u$e_normal";
    p="$e_bred#$e_normal";
  else
    u="$e_purple\u$e_normal";
    p="\$";
  fi

  ## Color git status if any
  branch=`__git_ps1 "(%s)"`
  if [ -n "$branch" ] ; then
    if [ -z "$_dumb_prompt" ]; then
      ## Assumes that untracked files are always listed after modified ones
      ## True for all git versions I could find
      git status --porcelain | perl -ne 'exit(1) if /^ /; exit(2) if /^[?]/'
      case "$?" in
        "0" ) branch=" $e_green$branch$e_normal" ;;
        "1" ) branch=" $e_bred$branch$e_normal" ;;
        "2" ) branch=" $e_byellow$branch$e_normal" ;;
        "130" ) branch=" $e_white$branch$e_normal" ; _dumb_prompt=1 ;;
      esac
    else
       branch=" $e_white$branch$e_normal"
    fi
  fi
  full_prompt="$ex$_prompt $u$branch $p";
  export PS1="\[\e]0;\u@\h:\w\\a\]$full_prompt ";
}

dumb_prompt () {
  _dumb_prompt=1
}

smart_prompt () {
  unset _dumb_prompt
}

if [ -n "$PS1" ] ; then
  PROMPT_COMMAND='_update_prompt'
  export PROMPT_COMMAND
fi
