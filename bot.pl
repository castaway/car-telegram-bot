use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use lib "$ENV{BOT_HOME}/lib";
use CarBot;

my $message = '';
my $daemon = 0;

GetOptions ("message=s" => \$message,
	    "daemon"    => \$daemon)
    or die "Usage: --message / --daemon";

my $bot = CarBot->new(
    message => $message,
    daemon  => $daemon
    );
$bot->think();
