#!/usr/bin/perl

use LWP::Simple qw($ua get);
#$ua->proxy('http','your_proxy');


use Irssi;
use Irssi::Irc;
use strict;
use warnings;
use vars qw($VERSION %IRSSI);
$VERSION="0.0.1";
%IRSSI = (
        authors => 'yoz-y',
        contact => 'yoz-y\@intarbutt.info',
        name    => 'lastfm',
        description     => 'writes the last played song on last.fm',
        license => 'GPL v2',
        url     => 'http://intarbutt.info'
);

sub cmd_lastfm {
  my ($data, $server, $witem) = @_;
  if (!$server || !$server->{connected}) {
    Irssi::print("Not connected to server");
    return;
  }
  
  my $song = get "http://ws.audioscrobbler.com/1.0/user/$data/recenttracks.txt";

  if ($data && $song) {
  	my @song = split /\n/,$song;
		$_ = $song[0];

		s/\n//g;
		/(\d+),(.*)–(.*)/;
		
# 		my $time = $1+3600;
		my $artist = $2;
		my $track = $3;
		
# 		$time = gmtime($time);
		
		my $text =  "$data last played >> $artist -- $track";

    $witem->command("/SAY $text");
  }
}


Irssi::command_bind('lastfm', 'cmd_lastfm');