package CarBot;
use strictures 2;
#no warnings 'experimental::signatures';
no warnings 'experimental';
use feature 'signatures';
use feature 'say';
use Data::Dumper;

use Mojo::Base 'Telegram::Bot::Brain';
use Config::General;

has _token => undef;
has token => sub {
    my ($self) = @_;
    if (!$self->_token) {
	my %conf = Config::General->new("$ENV{BOT_HOME}/keys.conf")->getall();
	$self->_token($conf{'Telegram::Bot'}{'api'});
    };
    return $self->_token();
};
has message => '';
has daemon  => 0;
has car_chat_id => -610392065;

sub init ($self) {
    if (!$self->message) {
	die "no message";
    }
    if (!$self->car_chat_id) {
	die "no chat id";
    }
    if($self->message && $self->car_chat_id) {
	say "Sending msg :" . $self->message;
	my $msg = $self->sendMessage({
	    chat_id => $self->car_chat_id,
	    text    => $self->message
				     });
	say Data::Dumper::Dumper($msg);
    }
    if(!$self->daemon) {
	exit;
    }
    $self->add_listener(\&read_message);
}

sub read_message ($self, $message) {
    if ((ref $message) eq 'Telegram::Bot::Object::Message') {
	say $message->text;
	say "Chat: " . $message->chat->id;
    }
}

1;
