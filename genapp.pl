
use strict;
use warnings;

my $config_name = shift || die "Usage: genapp.pl <configname>\n";

my $repo_id = $ENV{REPO_ID} || "uk.me.mart";
my $repo_url = $ENV{REPO_URL} || "http://media.local/boxee";
my $logo_base_url = $ENV{LOGO_BASE_URL} || "$repo_url/thumbs";
my $version = $ENV{VERSION} || "1.1";

my $configs = {
    'bbcnews' => {
        name => "BBC News",
        description => "Live news broadcast with a British focus from the BBC.",
        stream_url => "http://akamedia2.lsops.net/live/bbcnews_en_high.sdp/playlist.m3u8",
    },
    'bbcworldnews' => {
        name => "BBC World News",
        description => "Live news broadcast from the BBC.",
        stream_url => "http://akamedia2.lsops.net/live/bbcworld1_en_high.sdp/playlist.m3u8",
    },
    'bbcparliament' => {
        name => "BBC Parliament",
        description => "British political coverage from the BBC.",
        stream_url => "http://akamedia2.lsops.net/live/bbcparli_en_high.sdp/playlist.m3u8",
    },
    'skynews' => {
        name => "Sky News",
        description => "Live news broadcast from Sky News.",
        stream_url => "http://akamedia2.lsops.net/live/skynewsi_en_high.sdp/playlist.m3u8",
    },
};

my $config = $configs->{$config_name} || die "Unrecognized config name '$config_name'\n";

my $app_id = $config->{id} = join('.', $repo_id, $config_name);
$config->{thumb_url} = join('/', $logo_base_url, "$config_name.png");
$config->{repository} = $repo_url;
$config->{version} = $version;

mkdir "work" unless -d "work";
mkdir "target" unless -d "target";

my $zip_name = "$app_id-$version.zip";
my $work_dir = "work/$app_id";
unless (-d $work_dir) {
    mkdir($work_dir) || die "Failed to mkdir $work_dir: $!\n";
}

foreach my $fn (qw(descriptor.xml start.py)) {
    open(TEMPLATE, '<', $fn) || die "Failed to open $fn for reading: $!\n";
    open(OUT, '>', "$work_dir/$fn") || die "Failed to open $work_dir/$fn for writing: $!\n";

    while (my $l = <TEMPLATE>) {
        foreach my $k (keys %$config) {
            my $v = $config->{$k};
            my $token = "__" . uc($k) . "__";
            $l =~ s/$token/$v/g;
        }
        print OUT $l;
    }

    close(TEMPLATE);
    close(OUT);
}

chdir "work" || die "Failed to chdir 'work': $!\n";
system('zip', '-r', "../target/$zip_name", "$app_id/");
