#!/usr/bin/perl -w
use strict;

# mkjdict.pl - Generate a vim dictionary from jar files (requires perl 5.005)
# usage: mkjdict.pl jarfile... > java.dict
# Originally 20001031 raf <raf@raf.org>
# Changed 20030630 advweb <mail@nanasi.jp>

# file.separator
# line.separator
# Windows
#my $FS = ";";
#my $LS = "\r\n";
# OSX
my $FS = ":";
my $LS = "\n";



die "usage: perl $0 jarfile...\n" if $#ARGV == -1;
my %names = ('null' => 1);

for (@ARGV)
{
	warn("$0: $_ not found\n"), next unless -f;
	my @classes = grep { /^[^\$]+\.class$/ } split /$LS/, `jar tf $_`;
	die "$0: jar not found\n" if $?;
	s/\.class$// for @classes;
	s,/,.,g for @classes;
	my $text = '';
	my $jarfile = $_;
	my $cpath = defined($ENV{"CLASSPATH"})?
		$ENV{"CLASSPATH"} . $FS . join($FS, @ARGV):
		join($FS, @ARGV);
	$text .= `javap -classpath '$cpath' $_` for @classes;
	$text =~ s/\W+/ /g;
	$names{$_} = 1 for split / +/, $text;
}

print $_, "\n" for sort keys %names;
