#!/usr/bin/perl

use strict;
use Fcntl;
use Getopt::Long ();

use constant GETOPT_OPTS =>
  qw(auto_abbrev no_getopt_compat require_order bundling);

use vars qw(%OPT *DIR);

sub getopts  (\%@);
sub traverse ($);

use constant GETOPT_SPEC => ( 'ext:s', 'dir:s' );

Getopt::Long::Configure(GETOPT_OPTS);

MAIN:
{
    getopts  (%OPT, GETOPT_SPEC);
    traverse ( $OPT{dir} );
};

sub traverse ($)
{
    use Cwd ();

    my $dent;
    my $dir = $_[0];
    my @mp3 = ();
    my $owd = Cwd::cwd();
    my $pwd;
    my $m3u = join( '.', $dir, $OPT{ext} );
    $m3u =~ s/[^\w\.\-\_]/_/g;

    local(*DIR);

    chdir  ( $dir )     || die("chdir  ($dir): $!\n");
    opendir( DIR, '.' ) || die("opendir($dir): $!\n");

    if( ($pwd  = Cwd::cwd() ) =~ /\/(.*?)$/ ) { $pwd = $1 }

    while( $dent = readdir(DIR) )
    {
        ( $dent =~ /^\.\.?$/ ) && next;

        if   ( -d( $dent ) )                { eval { traverse($dent) } }
        elsif( $dent =~ /\.(?:mp3|ogg)$/i ) { push( @mp3, $dent )      }
        if( $@ ) { warn($@) }
    }

    closedir( DIR );

    if( @mp3 )
    {
        sysopen( M3U, $m3u, O_WRONLY|O_CREAT|O_TRUNC, 0644 )
          || die("Argh! open($dir/$m3u) failed: $!\n");
        print( M3U join("\n",@mp3), "\n" );
        close( M3U );
    }

    chdir( $owd );
}

sub getopts (\%@)
{
    my $opt = shift(@_);
    grep { s/^--?no-/--no/ } @ARGV;
    Getopt::Long::GetOptions($opt, @_);

    $opt->{ext} ||= 'm3u';
    $opt->{dir} ||= '.';

    -d( $opt->{dir} ) || die("--dir '$opt->{dir}': invalid directory name\n");
}


