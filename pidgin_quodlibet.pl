use Purple;

# based on flip.pl by sadrul
# copy to ~/.purple/plugins
# Usage: /ql l
# the 'l' can be anything-- it just needs an argument
# for reasons that escape me.

%PLUGIN_INFO = (
	perl_api_version => 2,
	name => "QuodLibet Now Playing",
	version => "0.1",
	summary =>     "show what is playing in Quod Libet",
	description => "show what is playing in QuodLibet",
	author => "Daniel Bolton <danielbarrrettbolton\@gmail.com>",
	url => "http://github.com/dbbolton",

	load => "plugin_load",
);

sub get_info
{
    my $file = "$ENV{HOME}/.quodlibet/current";
    my $np = "QuodLibet: ";

    unless ( -f $file ) {
        $np .= "not playing.";
        return $np;
    }
    open(my $in, "<", $file) 
        or die "Can't open ~/.quodlibet/current: $!";
    my $title;
    my $artist;
    my $album;
    while (<$in>) {
        if ( /^title/ ) {
           chomp( $title = (split '=', $_)[1] // '?' );
        }
        if ( /^artist/ ) {
            chomp( $artist = (split '=', $_)[1] // '?' );
        }
        if ( /^album/ ) {
            chomp( $album = (split '=', $_)[1] // '?' );
        }
    }
    $np .= "$title, by $artist, on $album.";
    return $np;
}
sub ql_cb
{
    my ($conv, $cmd, $plugin, @args) = @_;
    push @args, $plugin;
	Purple::Debug::fatal("XXX", "The message: " . "\n");
	my $msg = &get_info;
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

	Purple::Cmd::register($plugin, "ql", "s", Purple::Cmd::Priority::DEFAULT,
			Purple::Cmd::Flag::IM | Purple::Cmd::Flag::CHAT,
			0, \&ql_cb,
			"",
			$plugin);

}

