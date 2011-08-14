#!/usr/bin/perl -w
#
# script to get all the mp3 URL's from a html document
#v2
#added inteligence to get only mp3 links
#v1 initial version
#
#TODO build code to read url directly

#declare modules
use HTML::LinkExtor;
use strict;



## Code begins here

#check command line arguments

unless (@ARGV) 
{
	die "Useage: $0 htmlfile\n";
}

#create the parser
my $p = HTML::LinkExtor->new(\&cb);
#create the subroutine that does that actual reporting
 sub cb {
 	 #get the tag type and anonymous array of links from the program
     my($tag, %links) = @_;
     #print the second item in the array; the 1st URL
     if ( ${[%links]}[1] =~ m/\.mp3/) { print "${[%links]}[1]\n"; }
     #print "${[%links]}[1]\n";
 }
 $p->parse_file("$ARGV[0]");


=pod
=head1 mp3grep.pl

useage: B<mp3grep.pl> I<filename>

Scans a filename (or STDIN if piped) for html links to files ending in .mp3

Written by john@kript.net.  Licensed under the GPL.

Check for updates at http://cgi.kript.net/blosxom.cgi/code/

Download the latest version; http://www.kript.net/perl/mp3grep.pl

=cut