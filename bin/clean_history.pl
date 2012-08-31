#!/usr/bin/perl

use 5.014;
use warnings;
use autodie;
use utf8::all;
use IO::All;

die 'No input file specified.' if ( $#ARGV == -1 );

my @patterns = map {qr/^$_/xms} @{
    [   '(?:mk|rm)dir\ ',
        '(?:acroread|epdfview)\ ',
        'ls$',
        'cd$',
        'exit$',
        'clear$',
        'df$',
        'pwd$',
        'su$',
        'du$',
        'ls[ao]$',
        'dus$',
        'firefox$',
        'cal$',
        ';$',
        'blender$',
        '[.]/blender$',
        'date$',
        'export$',
        'htop$',
        'lpstat$',
        'ps$',
        'firefox\ &',
        'gimp-2\.6\ \&',
        'ls\ ',
        ';s',
        'cd\ ',
        'rm\ ',
        'tar\ ',
        'df\ ',
        'df\ \.',
        'du\ ',
        'wget',
        'mv\ ',
        'file\ ',
        'source\ ',
        'gv\ ',
        'm\ ',
        'pc[ ]?',
        'unzip',
        'geeqie',
        'man\ ',
        'scite',
        'chmod\ ',
        'pgrep\ ',
        'pkill\ ',
        'slocate\ ',
        '7z\ ',
        'cal\ ',
        'cat\ ',
        'cp\ ',
        'eject\ ',
        'touch\ ',
        'which\ ',
        'nano\ ',
        'mediainfo\ ',
        'opera\ ',
        'sftp\ ',
        'xterm$',
        'google\-chrome',
        'uname\ -a',

        # dev stuff
        'git[ ](?:status|commit|log|diff|fetch|checkout|init|pull|push)$',
        'git[ ](?:diff|blame)[ ]',
        'cover[ ]-(?:test|delete)$',
        'cover[ ]--(?:test|delete|help)$',
        'git\ add\ \.$',
        'make$',
        'make\ test$',
        'prove$',
        'cmake$',
        'cover$',
        'cpan$',
        'perl\ Makefile[.]PL',
        'corelist\ ',
        '[.]/configure\s*$',
        'make[ ]clean$',
        'cvs\ status$',
        're[.]pl$',
        'diff\ ',
        '[.]/perltest[.]pl',
        'perltest.pl',
        'perl\ --version',

        #misc
        'vlc\ ',
        'vlc$',
        'mplayer\ ',
        # I trimmed the rest out because they were too specific
    ]
    };

foreach my $fname (@ARGV) {
    my @content = io($fname)->slurp;
    foreach (@content) { s/^\s+//xms; s/[ ]+$//xms; }

    open my $fh, '>', $fname . '_clean';
    open my $junk, '>', $fname . '_junked.log';

LINE: foreach my $line (@content) {
        foreach my $re (@patterns) {
            if ( $line =~ $re ) {
                print {$junk} $line;
                next LINE;
            }
        }
        print {$fh} $line;
    }

    close $fh;
    close $junk;
}
