use Purple;

# based on flip.pl by sadrul

%PLUGIN_INFO = (
	perl_api_version => 2,
	name => "Eval",
	version => "0.1",
	summary =>     "evaluate command",
	description => "evaluate a command, and say it and its output in the convo",
	author => "Daniel Bolton <danielbarrrettbolton\@gmail.com>",
	url => "http://github.com/dbbolton",

	load => "plugin_load",
);

sub eval_string
{
    my ($code) = @_;
    my $string;
    if ( $code =~ /[>]/ or
         $code =~ /\bmv\b/ or
         $code =~ /\brm\b/ or
         $code =~ /\bsu\b/ or
         $code =~ /\bsudo\b/ ) {
        $string = $code . "\n(Not evaluating.)";
    }
    else {
        chomp( $string = "$code\n" . `$code` );
    }
    return $string;
}
sub eval_cb
{
	my ($conv, $cmd, $plugin, @args) = @_;
	Purple::Debug::fatal("XXX", "The message: " . $args[0] . "\n");
	my $msg = eval_string($args[0]);
#   my $msg = $args[0] . "\n" . `$args[0]` . "";
	if ($conv->do_command("say " . $msg, "", 0)) {
		return Purple::Cmd::Ret::OK;
	} else {
		return Purple::Cmd::Return::FAILED;
	}
}

sub plugin_load
{
	my $plugin = shift;
	my $conv = Purple::Conversations::get_handle();

	Purple::Cmd::register($plugin, "eval", "s", Purple::Cmd::Priority::DEFAULT,
			Purple::Cmd::Flag::IM | Purple::Cmd::Flag::CHAT,
			0, \&eval_cb,
			"",
			$plugin);

}

