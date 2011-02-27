# dbbolton's scripts
<https://github.com/dbbolton/scripts>

This repository is an eclectic collection of scripts that typically populate  
my ~/bin. Most are written in Perl, but there are some Shell and Vim scripts  
in the mix as well (I try to make a point to include file extensions for  
those who care what they are).  

* **apin.pl** avoids pitfalls in running aptitude through **su -c**.  

* **apt-carbon.pl** generates a shell script to duplicate a Debian system  
easily.

* **cpu-gov.pl** decides which CPU governor and implements it based on power  
source.  

* **dwn-status.pl** provides several functions for displaying system info  
in the dwm "status bar"; add this script to your  
**~/.xinitrc** before dwm.  
  
* **file-rename.pl** sensibly renames files with problematic characters.  
  
* **forkbomb.pl** is an example of obfuscated perl code. Doesn't work.  

* **ipad.pl** shows your interface's IP address and your external address.  

* **kernel-deb.sh** saves typing durning the kernel build process.

* **ladj.pl** helps in generating Wiktionary entries for first declension  
Latin adjectives.  

* **media-sync.pl** eases my rsync procedure.

* **nvidia-installer.pl** offers choice of available versions and automates  
installation of **nvidia** Xorg drivers from the Debian repos; also offers  
choice of available Nvidia binary installers and can store default args.

* **pct-err.pl** calculates percent error.

* **perlcalc.pl** acts as a command-line calculator; uses **eval**, and
only includes a really basic safety net.

* **rmrf.pl** is another example of obfuscated Perl. It probably doesn't  
work; I haven't tried it.  

* **rua.pl** see **apin.pl**.  

* **std-dev.pl** calculates standard deviation from user input.  

* **systats.pl** provides easy access to system information like active  
memory, battery charge, CPU temperature, etc.  

* **thunar-edit.pl** is useful as a custom action in Thunar for opening  
different types of files in their respective editors based on file  
extensions.  

* **tidy-diff.vim** is a simple Vim script that runs **perltidy** on the  
current file, splits the current window in diff mode, and highlights the  
differences between your file and perltidy's output. Run :diffoff to exit  
diff mode.

* **tint2theme.pl** is a theme switcher for **tint2**; assumes you have all  
theme files is one directory ( easily configurable ).  

* **urxvt-icon-updater.sh** is a shell script that replaces URxvt's joke of  
an icon with a more recognizable terminal icon from the Oxygen theme ( you  
could easily modify this to Gnome/Tango or something else ); requires  
**convert** from **imagemagick**.

* **wifi-switch.pl** allows you to switch easily between two frequently used  
wireless networks if you configure your connection through **interfaces(5)**.

* **xdeftheme.pl** swaps pre-defined Xdefaults themes.  

