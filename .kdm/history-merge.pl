#!/usr/bin/env perl

# Perl history merge
#
# Preserves the order of lines with the same timestamp, ehile removing lines where the commands (even with different timestamps) are the same.
#
# It also optionally cleans out things I do not want saved in my history generally as they are ultra simplistic or cryptograpic commands.

while (<>) {
	# remove end of history entry marker
	s/\0//;

	next unless length;

	my ($time, $command) = split("\n", $_, 2);

	$time =~ s/^#(\d+).*/$1/g; # extract the timestamp (and nothing else)
	$command =~ s/^\s+//;      # ignore spaces at start and end
	$command =~ s/\s+$//;      # not intervening lines (quoted indentation) - Note: commands may be multiple-lines!

	next unless length($command); # blank command

	# Remove any duplicate commands found (if timestamp is older)
	if ($old = $time{$command}) {
		if ($time > $old) {
			# newer command has an older duplicate - remove it
			@{ $history{$old} } = grep { $_ ne $command } @{ $history{$old} }
		}
		else {
			# command is older than command already seen - ignore
			next;
		}
	}

	push @{ $history{$time} }, $command;  # push line into timestamp
	$time{$command} = $time;              # where to find duplicate commands
}

# Output the merged history in timestamp, then command, order
foreach $time (sort {$a<=>$b} keys %history) {
	foreach $command (@{ $history{$time} }) {
		print "#$time\n";
		print "$command\n";
	}
}


# vim: set filetype=perl ts=2 sw=2 tw=0 noet :
