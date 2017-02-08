# EC Standard Login Environment -*- sh -*-
# user customized .cshrc
# $Source: /usr/cvs/cvsrep/ec_environ-1.0/release/user/cshrc.user,v $
# $Revision: 1.34 $

# use this logfile for debugging
echo "I: (.cshrc.$USER) [entering] `/bin/date`" >> $ec_env_error_log

######################################################
#
# warning: do not place commands here if standard
#          output is produced; use the section for
#          LOGIN SHELLS guarded by a test for $prompt
#
######################################################

#
# System defaults have been set; commented
# examples show how you may wish to modify.
#

###
###-------->SHELL<--------
###

###-------->umask<--------
# The umask tells what permissions to
# REMOVE from newly created files.
# Information security requires the
# default to prevent world read/write.
# If you know none of your data is
# more/less confidential, you may
# want to change.
#
# umask 077	# prevent all group/world access
# umask 027	# default
# umask 022	# permit world read/search


###
###-------->ENVIRONMENT<--------
###
limit coredumpsize 0
setenv  LANG en_US.UTF-8
setenv  EDITOR  gvim
setenv  PAGER   less
#setenv  BLOCKSIZE       K
setenv  CLICOLOR
setenv  WWW_HOME "http://www.google.com/"
setenv	FTP_PASSIVE_MODE
setenv  LSCOLORS "ExGxFxdxCxegedabagExEx"
setenv  OS `uname`
setenv  GREP_COLOR '1;37;41'
setenv	HTTP_AUTH "'basic:*"


###-------->search path<--------

# append your personal bin - you may want to prepend
#  or place relative to other componts with -a/-b
#
modpath -q -f $HOME/bin

# force "." to be last always
# (in case site/project has inserted before user's paths)
#
#modpath -q -f -d .
#modpath -q -f .


###-------->cd path<--------
set cdpath = (\
        . \
        ~/ \
		)


# LPDEST is normally same as printer
if ($?PRINTER) then
  setenv LPDEST  "$PRINTER"
endif


set symlinks = chase


###
###-------->LOGIN SHELLS<--------
###
if ($?prompt) then
    ###
    ### This section runs for interactive shells only.
    ###


    ### advanced tcsh options; see tcsh(1) and uncomment the ones you like
    if ($?tcsh) then
		set prompt="[%B%m: %~%b] `date +%a` %t <\!>\n$ "
		set colorcat
		set ignoreeof
		set autoexpand
		set autocorrect
		set correct=cmd
		set rmstar
		set filec
		set history = 1000
		set savehist = 1000
		set mail = (/var/mail/$USER)
		set noclobber
		set autolist
		set correct = cmd
		set nobeep
		bindkey -v 
#		set watch = (0 any any)

		complete {,un}alias     'p/1/a/' 'p/2/c/'
		complete {c,push,pop}d  'C/*/d/'
		complete exec           'p/1/c/'
		complete man            'C/*/c/'
		complete {where,which}  'C/*/c/'
		complete {,un}set       'p/1/s/'
		complete {,un}setenv    'C/*/e/'
		complete printenv       'C/*/e/'
		complete bindkey        'p/1/b/'
		complete fg             'c/%/j/'
		complete kill           'c/%/j/' 'c/-/S/'
		complete chgrp          'p/1/g/'
		complete chown          'p/1/u/'
		complete limit          'C/*/l/'
		complete find           'p/1/d/' 'n/-user/u/' 'n/-group/g/' \
						'n@*@`\ls -1 /var/db/pkg | sed "s%/var/db/pkg/%%;s%^\(.*\)-[0-9].*%\1%"`@'
		complete pkg_delete	'n@*@`\ls -1 /var/db/pkg | sed "s%/var/db/pkg/%%"`@'
		complete portmaster	'n@*@`\ls -1 /var/db/pkg | sed "s%/var/db/pkg/%%;s%^\(.*\)-[0-9].*%\1%"`@'
		complete portsnap	'c/-/(I d f k p s)/' \
				'n/-d/d/' \
				'n/-p/d/' \
				'n/*/(fetch extract update)/'
		complete pkg_add 'n@-r@`awk -F\| \{sub\(/-\[0-9\]\.\*\/\,\"\"\,\$1\)\;print\ \$1\} /usr/ports/INDEX | sort -u`@'

	# key bindings may be placed in a separate file
	if (-e $HOME/.bindings) source $HOME/.bindings


#	# these next lines dynamically update the xterm title see xtset -h
#	setenv XTXTRA "since "`date "+%m/%d@%H:%M"`
#	alias res_t 'xtset -t %h:%d %e'	# reset titlebar
#	res_t			# reset title right now
#	# this is most efficient but loses when you exit a remote session
#	alias cwdcmd res_t
#	# this is less efficient because it runs too often, but it never fails
#	#alias precmd res_t

        #set   autocorrect  # tcsh command line spelling check/autocorrect
        #set   correct=cmd

    endif


endif

###
###-------->ALIASES<--------
###
# some sample aliases you may want to uncomment or supplement:
#
#alias cls     clear
#alias ll      ls -l
#alias lf      ls -F
#alias lr      ls -R
#alias h       history
alias cx	'chmod ugo+x'
alias ft	'find . -maxdepth 1 -type f -mtime -1'
alias fta	'find . -type f -mtime -1'
alias grep	'grep --color="auto"'
alias h		'history'
alias h25	'history 25'
alias hg 'history|grep'
alias j		'jobs -l'
alias la	'ls -a'
alias ll	'ls -lart'
alias yesterday	'date -v-1d +%d/%m/%Y'



#
# aliases may be kept in separate file if you wish
#
if ( -r $HOME/.aliases ) then
  source $HOME/.aliases
endif

echo "I: (.cshrc.$USER) [leaving] `/bin/date`" >> $ec_env_error_log
######################################################
#
# Caution: do not place commands here if standard
#          output is produced; use the section above
#          where LOGIN SHELLS are guarded by a test
#          for $prompt.
#
#          Also do not set the $prompt variable or
#          invoke aliases modifying $prompt except
#          within the section for LOGIN SHELLS above.
#
######################################################

