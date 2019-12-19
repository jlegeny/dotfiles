# Swap between green and white format for public messages. I think this
# helps readability. Assumes you haven't changed message formats.
# for irssi 0.7.98 by Timo Sirainen

use Irssi;
use strict;
use vars qw($VERSION %IRSSI); 
$VERSION = "0.1";
%IRSSI = (
    authors	=> "Timo \'cras\' Sirainen",
    contact	=> "tss\@iki.fi",
    name	=> "colorswap",
    description	=> "Swap between green and white format for public messages. I think this helps readability. Assumes you haven't changed message formats.",
    license	=> "Public Domain",
    url		=> "http://irssi.org/",
    changed	=> "2002-03-04T22:47+0100"
);

my %setnext = {};

sub change_formats {
	my $target = lc shift;

	if ($setnext{$target}) {
		Irssi::command('^format pubmsg {pubmsgnick %w$2 {pubnick $nickcolor$[-9]0}}%w$1');
		Irssi::command('^format action_public {pubaction %g$0}%w$1');
	} else {
		Irssi::command('^format pubmsg {pubmsgnick %W$2 {pubnick $nickcolor$[-9]0}}%W$1');
		Irssi::command('^format action_public {pubaction %G$0}%W$1');
	}
	$setnext{$target} = !$setnext{$target};
}

sub sig_public {
	my ($server, $msg, $nick, $address, $target) = @_;

	change_formats($server->{tag}."/".$target);
}

sub sig_action_public {
	my ($server, $msg, $nick, $address, $target) = @_;

	change_formats($server->{tag}."/".$target);
}

sub sig_own_public {
	my ($server, $msg, $target) = @_;

	change_formats($server->{tag}."/".$target);
}

Irssi::signal_add('message public', 'sig_public');
Irssi::signal_add('message irc action', 'sig_action_public');
