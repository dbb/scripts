use Purple;

# based on flip.pl by sadrul
#
# copy to $HOME/.purple.plugins
#
# Usage: /perl <code>
# (no quotes necessary)
# where <code> is something you would use like
#     perl -e '<code>'

%PLUGIN_INFO = (
	perl_api_version => 2,
	name => "Perl evaluator",
	version => "0.1",
	summary =>     "evaluate Perl code",
	description => "evaluate Perl code, and say it along with its output in the conversation window",
	author => "Daniel Bolton <danielbarrrettbolton\@gmail.com>",
	url => "http://github.com/dbbolton",

	load => "plugin_load",
);

sub perl_string
{
    my ($code) = @_;
    my $string;
    if ( $code =~ /\bsystem\b/ or
         $code =~ /\bexec\b/ or
         $code =~ /\bfork\b/ ) {
        $string = $code . "\n(Not evaluating.)";
    }
    else {
        chomp( $string = "$code\n" . `perl -le \'$code\'` );
    }
    return $string;
}
sub perl_cb
{
	my ($conv, $cmd, $plugin, @args) = @_;
	Purple::Debug::fatal("XXX", "The message: " . $args[0] . "\n");
	my $msg = perl_string($args[0]);
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

	Purple::Cmd::register($plugin, "perl", "s", Purple::Cmd::Priority::DEFAULT,
			Purple::Cmd::Flag::IM | Purple::Cmd::Flag::CHAT,
			0, \&perl_cb,
			"",
			$plugin);

}

